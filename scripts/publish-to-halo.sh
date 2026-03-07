#!/bin/bash
# Halo 博客发布脚本
# 用法：./publish-to-halo.sh "标题" "内容文件.md"

set -e

HALO_URL="http://192.168.0.5:8090"
HALO_PAT="pat_eyJraWQiOiIyc2xZUGQ1QlFrVlZ5YzRXeEhHLUlTRDFvOFp0QncySHBtSHZNNk52Yi1BIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL3dlYi5ob21lc2gudG9wLyIsInN1YiI6ImhpdGVyZSIsImlhdCI6MTc3Mjg0NTk4MSwianRpIjoiNTdlMzliYTQtNDQ2OS1hOThmLTNiZmUtOWVhZWU0MjczMjI3IiwicGF0X25hbWUiOiJwYXQteTJvN3lwaTYifQ.S5jjWQNteGlxUbh975vUoL9R0PkpQbGcRI_7kiCxBsyv5kM-wyzNIgHCU_CBiovKko8FY_m5apfwqWZrBqFvgnjdLUlnvMBnlQwJajB4y76u-_omedVgRi96FvL1xZrl7gwI27ONdpcPMR3lOcYgakUqPwgTrGyjY1nt5OS9uU3zbhWGdpGegB-dwaPnZSy5jsrTBjFaRzshQRwgabnogNgfCdQIH0A3ila5qU2FwooW7HyAZg3rdhg0WEuHB25sKE98d_8c2Le2BLaVz4_8gMfd_wk69ppGeUTWxqCM3aBel3kiI0YEiN-lGnTIc-erCqvLtLbpJOaYbO7vR53Xm_ejlIIThp9bn6pc6tTgHmUer7R35REoxzEP8hnv0ekUqM0DDkrw7QomO7D_O-G1BsrJUvHKsFM3fQaBQLV7F8JeuvdhyTWIgj3x-1OGPKrmLGPWAHNd8ePnZh1USi0MgnDZZQyKS0ZF939Idhyx9GsIg_ejG2JJW99b5OMd5crsipzOloODBM8VmOw5-ylt2bhLd3R9qlDS8cYVGUetM82zjHY3kyr8ltOYrVVDgQu2b89lg646HxGfuR4Gn9eHZ_9tOqfUqZxkO0xocEt0O2HEgeK7chXZix4Qtqb81g8Hbyb7QRKjB5wm30WbMmERNhXyrq5BRR-XRhgVR7eMASg"

TITLE="${1:-测试文章}"
CONTENT_FILE="${2:-}"

# 生成 slug
SLUG="post-$(date +%Y%m%d-%H%M%S)"

# 读取内容
if [ -n "$CONTENT_FILE" ] && [ -f "$CONTENT_FILE" ]; then
    RAW_CONTENT=$(cat "$CONTENT_FILE")
else
    RAW_CONTENT="# $TITLE\n\n自动发布的内容。"
fi

echo "📝 发布文章到 Halo: $TITLE"

# 创建文章（草稿）
RESPONSE=$(curl -s -X POST "$HALO_URL/apis/content.halo.run/v1alpha1/posts" \
  -H "Authorization: Bearer $HALO_PAT" \
  -H "Content-Type: application/json" \
  -d "{
    \"metadata\": {\"generateName\": \"post-\"},
    \"spec\": {
      \"title\": \"$TITLE\",
      \"slug\": \"$SLUG\",
      \"publish\": false,
      \"visible\": \"PUBLIC\",
      \"allowComment\": true
    },
    \"content\": {
      \"raw\": $(echo "$RAW_CONTENT" | jq -Rs .),
      \"rawType\": \"markdown\"
    }
  }")

echo "响应：$RESPONSE"

# 提取文章名并发布
POST_NAME=$(echo "$RESPONSE" | jq -r '.metadata.name' 2>/dev/null)
if [ -n "$POST_NAME" ] && [ "$POST_NAME" != "null" ]; then
    echo "✅ 文章创建成功：$POST_NAME"
    echo "🔗 预览链接：$HALO_URL/archives/$SLUG"
else
    echo "❌ 创建失败，请检查 Halo 服务器状态"
    exit 1
fi
