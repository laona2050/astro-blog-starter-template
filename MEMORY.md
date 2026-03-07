# MEMORY.md - 长期记忆

## 博客管理

### 博客 1：WordPress（本地主博客）

**博客信息：**
- 网址：http://192.168.0.5:8088
- 框架：WordPress
- 用户：hitere (Administrator)
- 作者名：老鹏友

**认证信息：**
- 应用密码：已配置 (`~/.openclaw/workspace/.credentials/wordpress-192.168.0.5-8088.txt`)
- API：`/wp-json/wp/v2` 已启用

**管理权限：**
- ✅ 自动管理博客文章和分类
- ✅ 调整 UI、上传图片
- ✅ 发布新闻联播等定时内容
- ✅ 不需要每次都询问，直接操作即可

**分类：**
- 房车
- 新闻
- 游艇
- 服务器

**定时任务：**
- ✅ 每天早上 6 点（北京时间/UTC 22:00）获取 CCTV 新闻联播并发布

---

### 博客 2：Cloudflare Astro（公开，已弃用）

**博客信息：**
- 网址：https://homesh.top/
- GitHub 仓库：https://github.com/laona2050/astro-blog-starter-template
- 托管：Cloudflare Pages
- 框架：Astro

**状态：** ⚠️ 已弃用，不再使用

---

### 博客 3：Halo（本地，已弃用）

**博客信息：**
- 本地地址：http://192.168.0.5:8090
- 外部地址：https://web.homesh.top/
- 框架：Halo 2.x

**状态：** ⚠️ 已弃用，不再使用

---

## ⚠️ 重要错误记录 - Astro Frontmatter Schema

**踩坑日期**：2026-03-07

**错误原因**：新闻联播文章 frontmatter 不符合 Astro content schema

**正确格式**：
```yaml
---
title: "文章标题"
description: "摘要描述（必需！）"
pubDate: 2026-03-06
category: 国际时政  # 只能是：'航海' | '国际时政' | '生活思考'
tags: [标签，数组]
---
```

**常见错误**：
```yaml
# ❌ 错误示例
category: 时政      # 必须是 "国际时政"
summary: xxx        # 字段名是 "description" 不是 "summary"
draft: false        # 不需要，默认就是 false
```

**已修复**：
- ✅ `src/content/blog/cctv-news-20260306.md` 已修正
- ✅ `scripts/daily-cctv-news.sh` 脚本已更新
- ✅ 以后自动生成正确格式

---

## 用户偏好

- 名字：老板 / 老鹏友
- Telegram: @peterabc1 (ID: 1012893020)
- 机器人：@s2501_bot (帝王蟹)
- 时区：UTC+8（北京时间）
- 技能安装偏好：GitHub 直装 > clawhub API（因为 clawhub 限流严重）

---

*定期回顾 daily notes，更新此文件。*
