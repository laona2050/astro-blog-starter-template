#!/usr/bin/env python3
"""
博客迁移脚本 - 从 homesh.top 迁移文章到 WordPress (使用标准库)
"""

import urllib.request
import urllib.parse
import re
import json
import base64
import os
import time
import ssl

# 忽略 SSL 证书验证
ssl_context = ssl.create_default_context()
ssl_context.check_hostname = False
ssl_context.verify_mode = ssl.CERT_NONE

# 配置
OLD_BLOG_URL = "https://homesh.top/blog"
WP_URL = "http://192.168.0.5:8088"
WP_USER = "hitere"
WP_PASSWORD = "eLci wFQ4 JIE6 yfil weuC FsA3"
WP_API = f"{WP_URL}/wp-json/wp/v2"

# 认证头
auth_str = f"{WP_USER}:{WP_PASSWORD}"
auth_b64 = base64.b64encode(auth_str.encode()).decode()
auth_header = f"Basic {auth_b64}"

# 文章 slug 列表（排除已迁移的）
ARTICLES = [
    "cctv-news-20260305",
    "ai-art-cat-space",
    "space-radar-nuclear-power-report",
    "yacht-life-escape-30days",
    "cctv-news-20260304",
    "aquila-46-yacht-review",
    "archipelago-47-explorer-powercat-review",
    "dalio-world-order-collapse-2026",
    "fountaine-pajot-power-67-review",
    "leopard-46-powercat-review",
    "safehaven-t2000-voyager-review",
    "silent-yachts-60-electric-review",
    "vandal-explorer-46-review",
    "aquila-50-powercat-review",
    "aquila-70-yacht-review",
    "aquila-54-powercat-review",
    "greenline-42-full",
    "horizon-pc60-portuguese-deck-review",
    "iliad-53s-power-catamaran-review",
    "lagoon-sixty-7-review",
    "moon-60-power-review",
    "prestige-m48-power-catamaran-review",
    "sunreef-80-eco-power-review",
    "sunreef-power-60-eco",
    "sunreef-power-70-full",
    "sunreef-ultima-55-review",
    "xquisite-60-solar-power-review",
    "azimut-78-full",
    "aquila-47-molokai-full",
    "cranchi-60-full",
    "horizon-fd85-full",
    "lagoon-seventy8-full",
    "leopard-53pc-full",
    "leopard-40",
    "princess-y85-full",
    "sunreef-70-full",
    "sunseeker-65-full",
    "wright-46s-powercat",
    "robot-stocks-analysis",
    "news-2026-02-24",
    "solar-panels-full",
    "tianhangzhe-s60e-full",
    "tianhangzhe-s60e",
    "yacht-2026-02-24",
    "youtube-yacht-creators",
    "australia-immigration",
    "horizon-pc68",
    "boat-life-worth-it",
    "moon-60-cat",
    "news-2026-02-23",
    "sv-delos-aluminum-catamaran",
    "two-oceans-555-detailed",
    "two-oceans-555-hull2",
]

def fetch_url(url, timeout=30):
    """获取 URL 内容"""
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=timeout, context=ssl_context) as resp:
            return resp.read().decode('utf-8')
    except Exception as e:
        print(f"❌ 获取失败：{e}")
        return None

def post_json(url, data, auth_header):
    """POST JSON 数据"""
    try:
        json_data = json.dumps(data).encode('utf-8')
        req = urllib.request.Request(url, data=json_data, method='POST')
        req.add_header('Content-Type', 'application/json')
        req.add_header('Authorization', auth_header)
        
        with urllib.request.urlopen(req, timeout=60, context=ssl_context) as resp:
            return json.loads(resp.read().decode('utf-8'))
    except Exception as e:
        print(f"❌ POST 失败：{e}")
        return None

def upload_file(url, file_path, filename, auth_header):
    """上传文件"""
    try:
        with open(file_path, 'rb') as f:
            file_data = f.read()
        
        req = urllib.request.Request(url, data=file_data, method='POST')
        req.add_header('Content-Type', 'image/jpeg')
        req.add_header('Content-Disposition', f'attachment; filename={filename}')
        req.add_header('Authorization', auth_header)
        
        with urllib.request.urlopen(req, timeout=60, context=ssl_context) as resp:
            return json.loads(resp.read().decode('utf-8'))
    except Exception as e:
        print(f"❌ 上传失败：{e}")
        return None

def extract_images(content, base_url):
    """提取并下载图片"""
    images = re.findall(r'<img[^>]*src=["\']([^"\']+)["\'][^>]*>', content)
    image_map = {}
    
    os.makedirs("/tmp/blog-images", exist_ok=True)
    
    for img_url in images[:10]:
        if img_url.startswith('/'):
            img_url = base_url.rstrip('/') + img_url
        
        print(f"  🖼️  下载：{img_url}")
        img_data = fetch_url(img_url)
        if img_data:
            img_name = os.path.basename(img_url.split('?')[0])
            img_path = f"/tmp/blog-images/{img_name}"
            
            # 处理 webp 格式
            if img_name.endswith('.webp'):
                img_name = img_name.replace('.webp', '.jpg')
                img_path = img_path.replace('.webp', '.jpg')
            
            with open(img_path, 'wb') as f:
                f.write(img_data.encode('latin-1') if isinstance(img_data, str) else img_data)
            
            image_map[img_url] = img_path
            print(f"     ✅ 保存：{img_path}")
    
    return image_map

def main():
    print(f"🚀 开始迁移 {len(ARTICLES)} 篇文章到 WordPress")
    print(f"📍 目标：{WP_URL}")
    print("=" * 60)
    
    migrated = 0
    skipped = 0
    failed = 0
    os.makedirs("/tmp/blog-migrate", exist_ok=True)
    
    for i, slug in enumerate(ARTICLES, 1):
        print(f"\n[{i}/{len(ARTICLES)}] 处理：{slug}")
        print("-" * 40)
        
        # 检查是否已存在
        check_url = f"{WP_API}/posts?slug={slug}"
        check_result = fetch_url(check_url)
        if check_result and '"id"' in check_result:
            posts = json.loads(check_result)
            if len(posts) > 0:
                print(f"⚠️  文章已存在，跳过")
                skipped += 1
                continue
        
        # 获取文章
        url = f"{OLD_BLOG_URL}/{slug}/"
        print(f"📥 获取：{url}")
        html = fetch_url(url)
        if not html:
            failed += 1
            continue
        
        # 提取标题
        title_match = re.search(r'<h1[^>]*>(.*?)</h1>', html, re.DOTALL)
        title = title_match.group(1).strip() if title_match else slug
        title = re.sub(r'<[^>]+>', '', title)
        
        # 提取内容
        content_match = re.search(r'<article[^>]*>(.*?)</article>', html, re.DOTALL)
        if not content_match:
            content_match = re.search(r'<main[^>]*>(.*?)</main>', html, re.DOTALL)
        content = content_match.group(1) if content_match else html
        
        print(f"📝 标题：{title[:50]}...")
        
        # 提取并下载图片
        images = extract_images(content, url)
        print(f"🖼️  图片：{len(images)} 张")
        
        # 上传图片并替换 URL
        for old_url, img_path in images.items():
            filename = os.path.basename(img_path)
            media = upload_file(f"{WP_API}/media", img_path, filename, auth_header)
            if media and 'source_url' in media:
                new_url = media['source_url']
                content = content.replace(old_url, new_url)
                print(f"     ✅ 已替换：{new_url}")
        
        # 发布文章
        post_data = {
            "title": title,
            "content": content,
            "status": "publish",
            "categories": [6]  # 游艇分类
        }
        
        post = post_json(f"{WP_API}/posts", post_data, auth_header)
        if post and 'id' in post:
            print(f"✅ 发布成功：{post.get('link', 'N/A')}")
            migrated += 1
        else:
            failed += 1
        
        # 保存备份
        with open(f"/tmp/blog-migrate/{slug}.html", 'w') as f:
            f.write(html)
        
        # 限速
        time.sleep(3)
    
    print("\n" + "=" * 60)
    print("🎉 迁移完成！")
    print(f"✅ 成功：{migrated} 篇")
    print(f"⚠️  跳过：{skipped} 篇")
    print(f"❌ 失败：{failed} 篇")
    print("=" * 60)

if __name__ == "__main__":
    main()
