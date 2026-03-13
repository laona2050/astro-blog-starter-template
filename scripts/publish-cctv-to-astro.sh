#!/bin/bash
# CCTV 新闻联播发布到 Astro 博客 (homesh.top)
# 用法：./publish-cctv-to-astro.sh YYYY-MM-DD

set -e

WORKSPACE="/home/node/.openclaw/workspace"
GITHUB_TOKEN=$(cat "$WORKSPACE/.credentials/github-homesh.txt" 2>/dev/null)
REPO="laona2050/astro-blog-starter-template"
BRANCH="main"

DATE_FORMATTED="$1"
DATE=$(echo "$1" | tr -d '-')

if [ -z "$DATE_FORMATTED" ]; then
    echo "用法：$0 YYYY-MM-DD"
    exit 1
fi

echo "🦀 帝王蟹 - 发布 CCTV 新闻联播到 Astro 博客"
echo "📅 日期：$DATE_FORMATTED"
echo "⏰ 执行时间：$(date)"

cd "$WORKSPACE"

# Step 1: 获取新闻
echo "📺 正在获取 CCTV 新闻联播..."
node skills/cctv-news-fetcher/scripts/news_crawler.js "$DATE" > /tmp/cctv-astro-$DATE.json 2>/dev/null

# Step 2: 生成 Markdown 文件
echo "📝 正在生成 Markdown 文件..."

DATE_VAR="$DATE"
DATE_FORMATTED_VAR="$DATE_FORMATTED"

python3 << PYTHON_SCRIPT
import json
import os

DATE = os.environ.get('DATE_VAR', '20260312')
DATE_FORMATTED = os.environ.get('DATE_FORMATTED_VAR', '2026-03-12')

with open(f'/tmp/cctv-astro-{DATE}.json', 'r') as f:
    news_list = json.load(f)

# 获取标题
title = "新闻联播"
if news_list and len(news_list) > 0:
    first_title = news_list[0].get('title', '')
    if first_title.startswith('《'):
        title = first_title.replace('《', '').replace('》', '').strip()

# 生成新闻列表 HTML
news_html = ""
seen_titles = set()
for item in news_list[:10]:
    n_title = item.get('title', '')
    n_content = item.get('content', '')
    # 跳过空标题和重复标题
    if not n_title or n_title.startswith('《') or n_title in seen_titles:
        continue
    seen_titles.add(n_title)
    summary = n_content[:200] + '...' if len(n_content) > 200 else n_content
    news_html += f'<li><strong>{n_title}</strong><br/><small>{summary}</small></li>\n'

if not news_html:
    news_html = '<li>暂无详细内容</li>'

# 生成 frontmatter
category = "国际时政"
md_content = f'''---
title: "新闻联播 {DATE}"
description: "CCTV 新闻联播每日摘要 - {DATE_FORMATTED}"
pubDate: {DATE_FORMATTED}
category: '{category}'
tags: ["新闻联播", "CCTV", "时政"]
---

## 📺 CCTV 新闻联播

**来源：** CCTV 新闻联播 | **日期：** {DATE_FORMATTED} 19:00

---

### 📰 主要新闻

<ul>
{news_html}
</ul>

---

*此文章由帝王蟹🦀自动抓取并发布*
'''

with open(f'/tmp/cctv-astro-{DATE}.md', 'w', encoding='utf-8') as f:
    f.write(md_content)

print(f"✅ Markdown 文件已生成：/tmp/cctv-astro-{DATE}.md")
PYTHON_SCRIPT

# Step 3: 推送到 GitHub
echo "🚀 正在推送到 GitHub..."

FILE_PATH="src/content/blog/cctv-news-$DATE_FORMATTED.md"

# 读取文件内容并 base64 编码
CONTENT=$(cat "/tmp/cctv-astro-${DATE}.md" | base64 -w 0)

# 检查文件是否已存在
SHA=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    "https://api.github.com/repos/$REPO/contents/$FILE_PATH" 2>/dev/null | \
    python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('sha',''))" 2>/dev/null || echo "")

if [ -n "$SHA" ]; then
    # 更新文件
    RESPONSE=$(curl -s -X PUT "https://api.github.com/repos/$REPO/contents/$FILE_PATH" \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -d "{
            \"message\": \"📺 新闻联播 $DATE (自动发布)\",
            \"content\": \"$CONTENT\",
            \"sha\": \"$SHA\",
            \"branch\": \"$BRANCH\"
        }")
else
    # 创建文件
    RESPONSE=$(curl -s -X PUT "https://api.github.com/repos/$REPO/contents/$FILE_PATH" \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -d "{
            \"message\": \"📺 新闻联播 $DATE (自动发布)\",
            \"content\": \"$CONTENT\",
            \"branch\": \"$BRANCH\"
        }")
fi

# 检查结果
if echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('commit',{}).get('sha',''))" 2>/dev/null | grep -q "."; then
    COMMIT_SHA=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('commit',{}).get('sha',''))")
    echo "✅ 推送成功！"
    echo "📝 Commit: $COMMIT_SHA"
    echo "🔗 文件：$FILE_PATH"
    echo "🌐 网站：https://homesh.top/blog/cctv-news-$DATE_FORMATTED/"
else
    echo "❌ 推送失败"
    echo "$RESPONSE"
    exit 1
fi

echo "✅ 完成"
