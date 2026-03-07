# MEMORY.md - 长期记忆

## 博客管理

**博客信息：**
- 网址：https://homesh.top/
- GitHub 仓库：https://github.com/laona2050/astro-blog-starter-template
- 托管：Cloudflare Pages
- 框架：Astro

**认证信息：**
- GitHub Token: 已配置 (ghp_*)
- Git 用户：帝王蟹 <laona2050@users.noreply.github.com>

**管理权限：**
- ✅ 自动管理博客文章和分类
- ✅ 调整 UI、上传图片
- ✅ 发布新闻联播等定时内容
- ✅ 不需要每次都询问，直接操作即可

**目录结构：**
- 文章：`src/content/blog/` (.md 或 .mdx)
- 图片：`public/` 或 `src/assets/`
- 部署：Git push 后 Cloudflare 自动部署

**定时任务：**
- ✅ 每天早上 6 点（北京时间/UTC 22:00）获取 CCTV 新闻联播并发布
- 脚本：`/home/node/.openclaw/workspace/scripts/daily-cctv-news.sh`

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
