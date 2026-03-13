#!/bin/bash
# CCTV 新闻联播自动发布到 WordPress
# 每天执行，获取前一天新闻联播内容并发布到 WordPress 博客

set -e

WORKSPACE="/home/node/.openclaw/workspace"
WP_URL="http://192.168.0.5:8088"
WP_USER="hitere"
WP_PASS="eLci wFQ4 JIE6 yfil weuC FsA3"
WP_API="${WP_URL}/wp-json/wp/v2"

# 获取昨天的日期
DATE=$(date -d "yesterday" +%Y%m%d)
DATE_FORMATTED=$(date -d "yesterday" +%Y-%m-%d)

# Allow override via argument
if [ -n "$1" ]; then
    DATE_FORMATTED="$1"
    DATE=$(echo "$1" | tr -d '-')
fi

echo "🦀 帝王蟹 - CCTV 新闻联播自动发布"
echo "📅 日期：$DATE"
echo "⏰ 执行时间：$(date)"

cd "$WORKSPACE"

# Step 1: 使用 cctv-news-fetcher 技能获取新闻
echo "📺 正在获取 CCTV 新闻联播..."
node skills/cctv-news-fetcher/scripts/news_crawler.js "$DATE" > /tmp/cctv-news-$DATE.json || {
    echo "⚠️ 技能调用失败，使用备用模板..."
    echo '{"title":"新闻联播","items":[]}' > /tmp/cctv-news-$DATE.json
}

# Step 2: 解析 JSON 并构建 HTML 内容
echo "📝 正在生成文章内容..."

# 读取新闻数据
# 新闻抓取脚本返回数组格式：[{"date":..., "title":..., "content":...}, ...]
NEWS_TITLE=$(cat /tmp/cctv-news-$DATE.json | python3 -c "
import sys,json
d = json.load(sys.stdin)
if isinstance(d, list) and len(d) > 0:
    print(d[0].get('title', '新闻联播').replace('《', '').replace('》', '').strip())
elif isinstance(d, dict):
    print(d.get('title', '新闻联播'))
else:
    print('新闻联播')
" 2>/dev/null || echo "新闻联播")

NEWS_ITEMS=$(cat /tmp/cctv-news-$DATE.json | python3 -c "
import sys, json
d = json.load(sys.stdin)
# 支持数组格式和对象格式
if isinstance(d, list):
    items = d
elif isinstance(d, dict):
    items = d.get('items', []) or d.get('news', [])
else:
    items = []
html = ''
for item in items[:10]:  # 最多 10 条
    title = item.get('title', '无标题')
    # 数组格式用 content 字段，对象格式用 summary 字段
    summary = item.get('content', '') or item.get('summary', '')
    if title and not title.startswith('《'):
        html += f'<li><strong>{title}</strong>'
        if summary and len(summary) > 10:
            html += f'<br/><small>{summary[:200]}...</small>'
        html += '</li>'
if not html:
    html = '<li>暂无详细内容</li>'
print(html)
" 2>/dev/null || echo "<li>暂无详细内容</li>")

# Step 3: 发布到 WordPress
echo "🚀 正在发布到 WordPress..."

CONTENT="<h2>📺 CCTV 新闻联播 ${DATE}</h2>
<p><strong>来源：</strong>CCTV 新闻联播 | <strong>日期：</strong>${DATE_FORMATTED} 19:00</p>
<hr/>
<h3>📰 主要新闻</h3>
<ul>
${NEWS_ITEMS}
</ul>
<p><em>此文章由帝王蟹🦀自动抓取并发布</em></p>
"

RESPONSE=$(curl -s -X POST "${WP_API}/posts" \
    -u "${WP_USER}:${WP_PASS}" \
    -H "Content-Type: application/json" \
    -d "{
        \"title\": \"新闻联播 ${DATE}：${NEWS_TITLE}\",
        \"content\": $(echo "$CONTENT" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read()))'),
        \"status\": \"publish\",
        \"categories\": [28]
    }")

# Step 4: 检查结果
if echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('link',''))" 2>/dev/null; then
    LINK=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('link',''))")
    echo "✅ 发布成功：$LINK"
    
    # 同时保存 markdown 到本地
    cat > "$WORKSPACE/src/content/blog/cctv-news-$DATE_FORMATTED.md" << EOF
---
title: "新闻联播 ${DATE}"
description: "CCTV 新闻联播每日摘要 - ${DATE_FORMATTED}"
pubDate: ${DATE_FORMATTED}
category: 时政
tags: [新闻联播，CCTV, 时政]
---

## 📺 CCTV 新闻联播

**日期**：${DATE_FORMATTED}

${CONTENT}
EOF
    echo "📁 本地存档：src/content/blog/cctv-news-$DATE_FORMATTED.md"
else
    echo "❌ 发布失败"
    echo "$RESPONSE"
    exit 1
fi

echo "✅ 完成"
