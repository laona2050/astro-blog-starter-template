#!/bin/bash
# Halo 博客发布脚本
# 用法：./publish-to-halo.sh "文章标题" "内容文件.md"

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
CREDENTIALS_FILE="$SKILL_DIR/../../.credentials/halo-homesh.txt"

# 加载认证信息
if [ -f "$CREDENTIALS_FILE" ]; then
    source "$CREDENTIALS_FILE"
else
    echo "❌ 认证文件不存在：$CREDENTIALS_FILE"
    exit 1
fi

if [ -z "$Halo_URL" ] || [ -z "$Halo_PAT" ]; then
    echo "❌ 请在 $CREDENTIALS_FILE 中配置 Halo_URL 和 Halo_PAT"
    exit 1
fi

TITLE="${1:-测试文章}"
CONTENT_FILE="${2:-}"

# 生成 slug
SLUG="post-$(date +%Y%m%d-%H%M%S)"

# 读取内容
if [ -n "$CONTENT_FILE" ] && [ -f "$CONTENT_FILE" ]; then
    RAW_CONTENT=$(cat "$CONTENT_FILE")
else
    RAW_CONTENT="# $TITLE

自动发布的内容。"
fi

# 简单的 Markdown 转 HTML（基础转换）
HTML_CONTENT=$(echo "$RAW_CONTENT" | sed 's/^# \(.*\)$/<h1>\1<\/h1>/g' | \
               sed 's/^## \(.*\)$/<h2>\1<\/h2>/g' | \
               sed 's/^### \(.*\)$/<h3>\1<\/h3>/g' | \
               sed 's/^\- \(.*\)$/<li>\1<\/li>/g' | \
               sed 's/^1\. \(.*\)$/<li>\1<\/li>/g' | \
               sed 's/\*\*\([^*]*\)\*\*/<strong>\1<\/strong>/g' | \
               sed 's/\*\([^*]*\)\*/<em>\1<\/em>/g')

echo "📝 发布文章到 Halo: $TITLE"

# 创建文章 JSON
cat > /tmp/halo-post-$$.json << EOF
{
  "apiVersion": "content.halo.run/v1alpha1",
  "kind": "Post",
  "metadata": {
    "generateName": "post-"
  },
  "spec": {
    "title": "$TITLE",
    "slug": "$SLUG",
    "deleted": false,
    "publish": true,
    "pinned": false,
    "priority": 0,
    "allowComment": true,
    "visible": "PUBLIC",
    "owner": "hitere",
    "excerpt": {
      "autoGenerate": true,
      "raw": "${RAW_CONTENT:0:200}"
    },
    "categories": [],
    "tags": []
  },
  "content": {
    "raw": $(echo "$RAW_CONTENT" | jq -Rs .),
    "content": "$HTML_CONTENT",
    "rawType": "markdown"
  }
}
EOF

# 创建文章
RESPONSE=$(curl -s -X POST "$Halo_URL/apis/content.halo.run/v1alpha1/posts" \
  -H "Authorization: Bearer $Halo_PAT" \
  -H "Content-Type: application/json" \
  -d @/tmp/halo-post-$$.json)

# 清理临时文件
rm -f /tmp/halo-post-$$.json

# 检查响应
POST_NAME=$(echo "$RESPONSE" | grep -o '"name":"[^"]*"' | head -1 | cut -d'"' -f4)

if [ -n "$POST_NAME" ] && [ "$POST_NAME" != "null" ]; then
    echo "✅ 文章创建成功！"
    echo "📄 文章 ID: $POST_NAME"
    echo "🔗 预览链接：$Halo_URL/archives/$SLUG"
    echo ""
    echo "⚠️  文章当前为草稿状态，需在 Halo 后台发布"
else
    echo "❌ 创建失败"
    echo "响应：$RESPONSE"
    exit 1
fi
