#!/bin/bash
# migrate-blog.sh - 迁移旧博客文章到 WordPress

set -e

WP_URL="http://192.168.0.5:8088"
WP_USER="hitere"
WP_APP_PASSWORD="eLci wFQ4 JIE6 yfil weuC FsA3"
WP_API_ENDPOINT="${WP_URL}/wp-json/wp/v2"

# 文章列表（从 homesh.top 获取）
ARTICLES=(
"global-power-catamaran-guide-2025"  # 已迁移，跳过
"cctv-news-20260305"
"ai-art-cat-space"
"space-radar-nuclear-power-report"
"yacht-life-escape-30days"
"cctv-news-20260304"
"aquila-46-yacht-review"
"archipelago-47-explorer-powercat-review"
"dalio-world-order-collapse-2026"
"fountaine-pajot-power-67-review"
"leopard-46-powercat-review"
"safehaven-t2000-voyager-review"
"silent-yachts-60-electric-review"
"vandal-explorer-46-review"
"aquila-50-powercat-review"
"aquila-70-yacht-review"
"aquila-54-powercat-review"
"greenline-42-full"
"horizon-pc60-portuguese-deck-review"
"iliad-53s-power-catamaran-review"
"lagoon-sixty-7-review"
"moon-60-power-review"
"prestige-m48-power-catamaran-review"
"sunreef-80-eco-power-review"
"sunreef-power-60-eco"
"sunreef-power-70-full"
"sunreef-ultima-55-review"
"xquisite-60-solar-power-review"
"azimut-78-full"
"aquila-47-molokai-full"
"cranchi-60-full"
"horizon-fd85-full"
"lagoon-seventy8-full"
"leopard-53pc-full"
"leopard-40"
"princess-y85-full"
"sunreef-70-full"
"sunseeker-65-full"
"wright-46s-powercat"
"robot-stocks-analysis"
"news-2026-02-24"
"solar-panels-full"
"tianhangzhe-s60e-full"
"tianhangzhe-s60e"
"yacht-2026-02-24"
"youtube-yacht-creators"
"australia-immigration"
"horizon-pc68"
"boat-life-worth-it"
"moon-60-cat"
"news-2026-02-23"
"sv-delos-aluminum-catamaran"
"two-oceans-555-detailed"
"two-oceans-555-hull2"
)

echo "开始迁移 ${#ARTICLES[@]} 篇文章到 WordPress..."

for slug in "${ARTICLES[@]}"; do
    echo ""
    echo "========================================"
    echo "处理：$slug"
    echo "========================================"
    
    # 检查是否已存在
    existing=$(curl -s "$WP_API_ENDPOINT/posts?slug=$slug" | grep -c '"id"' || echo "0")
    if [ "$existing" -gt "0" ]; then
        echo "⚠️  文章已存在，跳过：$slug"
        continue
    fi
    
    # 获取文章内容
    url="https://homesh.top/blog/$slug/"
    echo "📥 获取：$url"
    
    # 使用 curl 获取原始 HTML
    html=$(curl -sL "$url")
    
    if [ -z "$html" ]; then
        echo "❌ 无法获取文章：$slug"
        continue
    fi
    
    echo "✅ 获取成功"
    
    # 保存到临时文件（用于调试）
    echo "$html" > "/tmp/blog-migrate/$slug.html"
    
done

echo ""
echo "========================================"
echo "迁移完成！"
echo "========================================"
