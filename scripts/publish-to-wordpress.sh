#!/bin/bash
# publish-to-wordpress.sh
# 发布文章到 WordPress 博客 (http://192.168.0.5:8088)

set -e

# 配置
WP_URL="http://192.168.0.5:8088"
WP_USER="hitere"
WP_APP_PASSWORD="eLci wFQ4 JIE6 yfil weuC FsA3"
WP_API_ENDPOINT="${WP_URL}/wp-json/wp/v2"

# 参数检查
if [ $# -lt 2 ]; then
    echo "用法：$0 <markdown_file> [title]"
    echo "  markdown_file: Markdown 文件路径"
    echo "  title: 文章标题（可选，默认使用文件名）"
    exit 1
fi

MARKDOWN_FILE="$1"
CUSTOM_TITLE="${2:-}"

# 检查文件是否存在
if [ ! -f "$MARKDOWN_FILE" ]; then
    echo "错误：文件不存在 - $MARKDOWN_FILE"
    exit 1
fi

# 提取标题（如果没有提供）
if [ -z "$CUSTOM_TITLE" ]; then
    # 尝试从 frontmatter 提取 title
    TITLE=$(grep -m1 "^title:" "$MARKDOWN_FILE" | sed 's/^title:[[:space:]]*//' | tr -d '"' || true)
    if [ -z "$TITLE" ]; then
        # 使用文件名作为标题
        TITLE=$(basename "$MARKDOWN_FILE" .md)
    fi
fi

# 提取内容（跳过 frontmatter）
CONTENT=$(sed -n '/^---$/,/^---$/p' "$MARKDOWN_FILE" | tail -n +2 | head -n -1 || cat "$MARKDOWN_FILE")

# 转换为 HTML（简单处理，实际可能需要 pandoc）
# 这里直接使用 Markdown 内容，WordPress 会自动处理
HTML_CONTENT="$CONTENT"

echo "发布文章到 WordPress..."
echo "  标题：$TITLE"
echo "  文件：$MARKDOWN_FILE"

# 创建文章
RESPONSE=$(curl -s -X POST "${WP_API_ENDPOINT}/posts" \
    -u "${WP_USER}:${WP_APP_PASSWORD}" \
    -H "Content-Type: application/json" \
    -d "{
        \"title\": \"${TITLE}\",
        \"content\": ${HTML_CONTENT@Q},
        \"status\": \"publish\"
    }")

# 检查响应
if echo "$RESPONSE" | grep -q '"id"'; then
    POST_ID=$(echo "$RESPONSE" | grep -o '"id":[0-9]*' | cut -d: -f2)
    POST_LINK=$(echo "$RESPONSE" | grep -o '"link":"[^"]*"' | cut -d'"' -f4)
    echo "✅ 发布成功！"
    echo "  文章 ID: $POST_ID"
    echo "  链接：$POST_LINK"
else
    echo "❌ 发布失败"
    echo "响应：$RESPONSE"
    exit 1
fi
