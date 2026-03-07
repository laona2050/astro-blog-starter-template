#!/usr/bin/env python3
"""Halo 2.x 文章创建工具 - 完整流程（含 draft snapshot）"""

import json
import sys
import os
import urllib.request
import urllib.error

# 加载认证
cred_file = os.path.join(os.path.dirname(__file__), '../../.credentials/halo-homesh.txt')
config = {}
if os.path.exists(cred_file):
    with open(cred_file) as f:
        for line in f:
            if '=' in line and not line.strip().startswith('#'):
                key, value = line.strip().split('=', 1)
                config[key] = value

HALO_URL = config.get('Halo_URL', 'http://192.168.0.5:8090')
HALO_PAT = config.get('Halo_PAT', '')
HALO_OWNER = config.get('Halo_OWNER', 'hitere')

if not HALO_PAT:
    print("ERROR: 请配置 Halo_PAT")
    sys.exit(1)

def api_request(method, path, data=None):
    """发送 API 请求"""
    url = f"{HALO_URL}{path}"
    headers = {
        'Authorization': f'Bearer {HALO_PAT}',
        'Content-Type': 'application/json'
    }
    
    body = json.dumps(data).encode('utf-8') if data else None
    req = urllib.request.Request(url, data=body, headers=headers, method=method)
    
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read().decode('utf-8'))
    except urllib.error.HTTPError as e:
        print(f"HTTP Error {e.code}: {e.read().decode('utf-8')}")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None

def create_post(title, content, slug=None):
    """创建文章并创建 draft snapshot"""
    
    # 1. 创建 Post 元数据
    print(f"📝 创建文章：{title}")
    
    post_data = {
        "apiVersion": "content.halo.run/v1alpha1",
        "kind": "Post",
        "metadata": {"generateName": "post-"},
        "spec": {
            "title": title,
            "slug": slug or f"post-{title[:20]}",
            "deleted": False,
            "publish": False,
            "pinned": False,
            "priority": 0,
            "allowComment": True,
            "visible": "PUBLIC",
            "owner": HALO_OWNER,
            "excerpt": {"autoGenerate": True},
            "categories": [],
            "tags": []
        }
    }
    
    post = api_request('POST', '/apis/content.halo.run/v1alpha1/posts', post_data)
    
    if not post:
        print("❌ 创建失败")
        return None
    
    post_name = post['metadata']['name']
    print(f"✅ 文章元数据创建成功：{post_name}")
    
    # 2. 创建 draft snapshot
    print("📄 创建草稿内容...")
    
    draft_data = {
        "content": {
            "raw": content,
            "content": f"<p>{content[:200]}</p>",
            "rawType": "markdown"
        }
    }
    
    draft = api_request('PUT', f'/apis/content.halo.run/v1alpha1/posts/{post_name}/draft', draft_data)
    
    if draft:
        head_snapshot = draft.get('status', {}).get('headSnapshot', '')
        print(f"✅ 草稿创建成功：{head_snapshot}")
        print(f"🔗 编辑链接：{HALO_URL}/console/posts/editor?name={post_name}")
    else:
        print(f"⚠️  创建草稿失败")
        print(f"🔗 请在 Halo 后台编辑：{HALO_URL}/console/posts/editor?name={post_name}")
    
    print(f"\n📄 文章 ID: {post_name}")
    print(f"📝 标题：{title}")
    print(f"🔗 预览：{HALO_URL}/archives/{slug}")
    
    return post_name

def publish_post(post_name):
    """发布文章"""
    print(f"🚀 发布文章：{post_name}")
    
    result = api_request('PUT', f'/apis/content.halo.run/v1alpha1/posts/{post_name}/publish', {})
    
    if result:
        print("✅ 发布成功")
        permalink = result.get('status', {}).get('permalink', '')
        if permalink:
            print(f"🔗 链接：{HALO_URL}{permalink}")
    else:
        print("❌ 发布失败")

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("用法：python3 create_post.py <title> [content_file] [slug]")
        print("      python3 create_post.py --publish <post_name>")
        sys.exit(1)
    
    if sys.argv[1] == '--publish':
        if len(sys.argv) < 3:
            print("ERROR: 请提供文章 ID")
            sys.exit(1)
        publish_post(sys.argv[2])
    else:
        title = sys.argv[1]
        content_file = sys.argv[2] if len(sys.argv) > 2 else None
        slug = sys.argv[3] if len(sys.argv) > 3 else None
        
        if content_file and os.path.exists(content_file):
            with open(content_file) as f:
                content = f.read()
        else:
            content = f"# {title}"
        
        create_post(title, content, slug)
