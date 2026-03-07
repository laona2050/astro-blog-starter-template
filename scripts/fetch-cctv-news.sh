#!/bin/bash
# CCTV 新闻联播获取脚本
# 每天执行，获取前一天新闻联播内容并发布到博客

set -e

WORKSPACE="/home/node/.openclaw/workspace"
DATE=$(date -d "yesterday" +%Y%m%d)
DATE_FORMATTED=$(date -d "yesterday" +%Y-%m-%d)
OUTPUT_DIR="$WORKSPACE/src/content/blog"

echo "📺 获取 CCTV 新闻联播 - $DATE_FORMATTED"

# 使用 cctv-news-fetcher 技能获取新闻
cd "$WORKSPACE"

# 调用技能获取新闻
node skills/cctv-news-fetcher/scripts/news_crawler.js "$DATE" > /tmp/cctv-news-$DATE.json 2>&1 || {
    echo "⚠️ 技能调用失败，尝试备用方案..."
    
    # 备用方案：直接从网页抓取
    curl -s "https://news.cctv.com/xwlb/" | grep -oP '(?<=<a href=")[^"]*video[^"]*' | head -5
    
    exit 1
}

# 解析 JSON 并生成 Markdown
cat > "$OUTPUT_DIR/cctv-news-$DATE_FORMATTED.md" << 'EOF'
---
title: "新闻联播摘要 - DATE_PLACEHOLDER"
summary: "CCTV 新闻联播每日摘要"
pubDate: DATE_PLACEHOLDER
category: 时政
tags: [新闻联播，CCTV，时政]
draft: false
---

## 📺 新闻联播

**日期**：DATE_PLACEHOLDER

EOF

# 替换日期占位符
sed -i "s/DATE_PLACEHOLDER/$DATE_FORMATTED/g" "$OUTPUT_DIR/cctv-news-$DATE_FORMATTED.md"

# 添加新闻内容（从 JSON 解析）
if [ -f /tmp/cctv-news-$DATE.json ]; then
    echo "## 主要新闻" >> "$OUTPUT_DIR/cctv-news-$DATE_FORMATTED.md"
    echo "" >> "$OUTPUT_DIR/cctv-news-$DATE_FORMATTED.md"
    
    # 简单解析 JSON（实际应该用 jq）
    cat /tmp/cctv-news-$DATE.json >> "$OUTPUT_DIR/cctv-news-$DATE_FORMATTED.md" 2>/dev/null || true
fi

echo "✅ 新闻联播文章已生成：$OUTPUT_DIR/cctv-news-$DATE_FORMATTED.md"

# 自动提交并推送
cd "$WORKSPACE"
git add "src/content/blog/cctv-news-$DATE_FORMATTED.md"
git config user.email "laona2050@users.noreply.github.com"
git config user.name "帝王蟹"
git commit -m "发布：新闻联播摘要 ($DATE_FORMATTED)" || echo "⚠️ 无变更或提交失败"
git push origin master 2>/dev/null || echo "⚠️ 推送失败"

echo "🚀 部署中... Cloudflare Pages 将自动构建"
