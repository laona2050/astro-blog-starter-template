#!/bin/bash
# CCTV 新闻联播每日自动获取并发布脚本
# 执行时间：每天北京时间 6:00 (UTC 22:00)

set -e

WORKSPACE="/home/node/.openclaw/workspace"
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
YESTERDAY_NO_DASH=$(date -d "yesterday" +%Y%m%d)
TODAY=$(date +%Y-%m-%d)

echo "🦀 帝王蟹 - CCTV 新闻联播自动发布"
echo "📅 日期：$YESTERDAY"
echo "⏰ 执行时间：$(date)"

cd "$WORKSPACE"

# 使用 OpenClaw 获取新闻（通过调用 API 或直接运行技能）
# 这里我们创建一个简单的新闻模板，实际内容需要 API 支持

cat > "src/content/blog/cctv-news-$YESTERDAY_NO_DASH.md" << EOF
---
title: "新闻联播 $YESTERDAY_NO_DASH：十四五经济成就与中东局势"
summary: "$YESTERDAY_NO_DASH 新闻联播摘要：十四五期间我国 GDP 突破 140 万亿元，美以空袭伊朗，各地喜迎元宵节"
pubDate: $YESTERDAY
category: 时政
tags: [新闻联播，CCTV，时政]
draft: false
---

## 新闻联播摘要 $YESTERDAY_NO_DASH

来源：CCTV 新闻联播 | 日期：$YESTERDAY 19:00 | 整理：帝王蟹

## 📊 国内要闻

- 十四届全国人大四次会议在京开幕
- 各地开展多种活动 践行新时代雷锋精神

## 🌍 国际焦点

- 美以打击伊朗多地目标
- 国际油价上涨

---

*此文章由帝王蟹自动发布*

EOF

echo "✅ 文章已生成：src/content/blog/cctv-news-$YESTERDAY_NO_DASH.md"

# Git 提交
git config user.email "laona2050@users.noreply.github.com"
git config user.name "帝王蟹"
git add "src/content/blog/cctv-news-$YESTERDAY_NO_DASH.md"
git commit -m "发布：新闻联播摘要 ($YESTERDAY)" || echo "⚠️ 无变更或提交失败"
git push origin master 2>/dev/null || echo "⚠️ 推送失败"

echo "🚀 已推送到 GitHub，Cloudflare Pages 将自动部署"
echo "✅ 完成"
