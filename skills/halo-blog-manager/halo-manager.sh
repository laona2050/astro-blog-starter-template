#!/bin/bash
# Halo 2.x 博客管理工具 - 完整版
# 支持创建文章、创建 snapshot、发布

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CREDENTIALS_FILE="$SCRIPT_DIR/../../.credentials/halo-homesh.txt"

# 加载认证
if [ -f "$CREDENTIALS_FILE" ]; then
    source "$CREDENTIALS_FILE"
else
    echo "ERROR: 认证文件不存在：$CREDENTIALS_FILE" >&2
    exit 1
fi

if [ -z "$Halo_URL" ] || [ -z "$Halo_PAT" ]; then
    echo "ERROR: 请配置 Halo_URL 和 Halo_PAT" >&2
    exit 1
fi

Halo_OWNER="${Halo_OWNER:-hitere}"

ACTION="${1:-help}"
shift || true

case "$ACTION" in
    create)
        TITLE="$1"
        CONTENT_FILE="$2"
        SLUG="${3:-post-$(date +%Y%m%d-%H%M%S)}"
        
        if [ -z "$TITLE" ]; then
            echo "ERROR: 请提供文章标题" >&2
            exit 1
        fi
        
        # 读取内容
        if [ -n "$CONTENT_FILE" ] && [ -f "$CONTENT_FILE" ]; then
            RAW_CONTENT=$(cat "$CONTENT_FILE")
        else
            RAW_CONTENT="# $TITLE"
        fi
        
        # 创建文章元数据
        echo "📝 创建文章：$TITLE"
        
        # 生成临时 JSON 文件
        cat > /tmp/halo-post-$$.json << EOFJSON
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
    "publish": false,
    "pinned": false,
    "priority": 0,
    "allowComment": true,
    "visible": "PUBLIC",
    "owner": "$Halo_OWNER",
    "excerpt": {
      "autoGenerate": true
    },
    "categories": [],
    "tags": []
  }
}
EOFJSON
        
        POST_RESPONSE=$(curl -s -X POST "$Halo_URL/apis/content.halo.run/v1alpha1/posts" \
          -H "Authorization: Bearer $Halo_PAT" \
          -H "Content-Type: application/json" \
          -d @/tmp/halo-post-$$.json)
        
        rm -f /tmp/halo-post-$$.json
        
        POST_NAME=$(echo "$POST_RESPONSE" | grep -o '"name":"[^"]*"' | head -1 | cut -d'"' -f4)
        
        if [ -z "$POST_NAME" ] || [ "$POST_NAME" = "null" ]; then
            echo "❌ 创建失败：$POST_RESPONSE"
            exit 1
        fi
        
        echo "✅ 文章元数据创建成功：$POST_NAME"
        
        # 创建草稿 snapshot
        echo "📄 创建草稿内容..."
        
        # 生成内容 JSON
        cat > /tmp/halo-content-$$.json << EOFJSON
{
  "content": {
    "raw": "$(cat $CONTENT_FILE | sed 's/\/\\/g; s/"/\"/g')",
    "content": "<p>内容</p>",
    "rawType": "markdown"
  }
}
EOFJSON
        
        DRAFT_RESPONSE=$(curl -s -X PUT "$Halo_URL/apis/content.halo.run/v1alpha1/posts/$POST_NAME/draft" \
          -H "Authorization: Bearer $Halo_PAT" \
          -H "Content-Type: application/json" \
          -d @/tmp/halo-content-$$.json)
        
        rm -f /tmp/halo-content-$$.json
        
        HEAD_SNAPSHOT=$(echo "$DRAFT_RESPONSE" | grep -o '"headSnapshot":"[^"]*"' | head -1 | cut -d'"' -f4)
        
        if [ -z "$HEAD_SNAPSHOT" ]; then
            echo "⚠️  创建草稿失败，但文章已创建"
            echo "🔗 请在 Halo 后台编辑：$Halo_URL/console/posts/editor?name=$POST_NAME"
        else
            echo "✅ 草稿创建成功：$HEAD_SNAPSHOT"
            echo "🔗 编辑链接：$Halo_URL/console/posts/editor?name=$POST_NAME"
        fi
        
        echo ""
        echo "📄 文章 ID: $POST_NAME"
        echo "📝 标题：$TITLE"
        echo "🔗 预览：$Halo_URL/archives/$SLUG"
        ;;
    
    publish)
        POST_NAME="$1"
        if [ -z "$POST_NAME" ]; then
            echo "ERROR: 请提供文章 ID" >&2
            exit 1
        fi
        
        echo "🚀 发布文章：$POST_NAME"
        
        # 发布
        RESPONSE=$(curl -s -X PUT "$Halo_URL/apis/content.halo.run/v1alpha1/posts/$POST_NAME/publish" \
          -H "Authorization: Bearer $Halo_PAT" \
          -H "Content-Type: application/json" \
          -d '{}')
        
        echo "✅ 发布成功"
        echo "$RESPONSE" | grep -o '"permalink":"[^"]*"' | cut -d'"' -f4 || true
        ;;
    
    list)
        echo "📋 文章列表："
        curl -s "$Halo_URL/apis/content.halo.run/v1alpha1/posts" \
          -H "Authorization: Bearer $Halo_PAT" | \
          grep -oE '"title":"[^"]*"|"name":"[^"]*"|"phase":"[^"]*"' | \
          paste - - - | sed 's/"name":"//g; s/"title":"//g; s/"phase":"//g; s/"//g'
        ;;
    
    get)
        POST_NAME="$1"
        if [ -z "$POST_NAME" ]; then
            echo "ERROR: 请提供文章 ID" >&2
            exit 1
        fi
        curl -s "$Halo_URL/apis/content.halo.run/v1alpha1/posts/$POST_NAME" \
          -H "Authorization: Bearer $Halo_PAT"
        ;;
    
    delete)
        POST_NAME="$1"
        if [ -z "$POST_NAME" ]; then
            echo "ERROR: 请提供文章 ID" >&2
            exit 1
        fi
        curl -s -X DELETE "$Halo_URL/apis/content.halo.run/v1alpha1/posts/$POST_NAME" \
          -H "Authorization: Bearer $Halo_PAT"
        echo "✅ 已删除：$POST_NAME"
        ;;
    
    *)
        echo "Halo 博客管理工具"
        echo ""
        echo "用法：$0 <action> [args...]"
        echo ""
        echo "动作:"
        echo "  create <title> [content_file] [slug]  - 创建文章（含草稿）"
        echo "  publish <post_name>                    - 发布文章"
        echo "  list                                   - 列出所有文章"
        echo "  get <post_name>                        - 获取文章详情"
        echo "  delete <post_name>                     - 删除文章"
        echo ""
        echo "示例:"
        echo "  $0 create \"我的文章\" content.md my-slug"
        echo "  $0 publish post-abc123"
        echo "  $0 list"
        ;;
esac
