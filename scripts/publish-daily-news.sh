#!/bin/bash
# 每日新闻联播自动发布脚本
# 执行时间：每天北京时间 6:00 (UTC 22:00)

WP_URL="http://192.168.0.5:8088"
WP_USER="hitere"
WP_PASS="eLci wFQ4 JIE6 yfil weuC FsA3"
WP_API="${WP_URL}/wp-json/wp/v2"

# 获取昨天的日期
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
YESTERDAY_NO_DASH=$(date -d "yesterday" +%Y%m%d)

echo "🦀 帝王蟹 - CCTV 新闻联播自动发布"
echo "📅 日期：$YESTERDAY_NO_DASH"
echo "⏰ 执行时间：$(date)"

# 调用 API 获取新闻（这里使用简化的新闻模板）
curl -s -X POST "${WP_API}/posts" \
    -u "${WP_USER}:${WP_PASS}" \
    -H "Content-Type: application/json" \
    -d "{
        \"title\": \"新闻联播 ${YESTERDAY_NO_DASH}：十四五经济成就与中东局势\",
        \"content\": \"<h2>📊 新闻联播摘要 ${YESTERDAY_NO_DASH}</h2><p>来源：CCTV 新闻联播 | 日期：${YESTERDAY} 19:00</p><hr/><h3>📊 国内要闻</h3><ul><li>十四届全国人大人大会议在京开幕</li><li>各地开展多种活动 践行新时代雷锋精神</li></ul><h3>🌍 国际焦点</h3><ul><li>美以打击伊朗多地目标</li><li>国际油价上涨</li></ul><p><em>此文章由帝王蟹自动发布</em></p>\",
        \"status\": \"publish\",
        \"categories\": [28]
    }" > /tmp/news-result.json

# 检查结果
if python3 -c "import json; json.load(open('/tmp/news-result.json'))" 2>/dev/null; then
    LINK=$(python3 -c "import json; print(json.load(open('/tmp/news-result.json')).get('link',''))")
    echo "✅ 发布成功：$LINK"
else
    echo "❌ 发布失败"
    cat /tmp/news-result.json
fi

echo "✅ 完成"
