# MEMORY.md - 长期记忆

## 博客管理

### 主博客：Cloudflare Astro（homesh.top）

**博客信息：**
- 网址：**https://homesh.top/**
- GitHub 仓库：https://github.com/laona2050/astro-blog-starter-template
- 托管：Cloudflare Pages
- 框架：Astro
- 主题：航海家深色主题（深海蓝 + 金色罗盘点缀）

**发布流程：**
1. 文章保存到 `src/content/blog/xxx.md`
2. 执行 `npm run build` 构建
3. Git 推送到 GitHub main 分支
4. Cloudflare Pages 自动部署（2-5 分钟）

**分类：**
- 航海（游艇、双体船、帆船）
- 国际时政（新闻联播、时政分析）
- 生活思考（航海生活、个人成长）
- 科技（AI、数字化、技术调研）

**定时任务：**
- ✅ 每天早上 6 点（北京时间/UTC 22:00）获取 CCTV 新闻联播并发布

---

### 博客 1：WordPress（本地，已弃用）

**博客信息：**
- 网址：http://192.168.0.5:8088
- 框架：WordPress
- 用户：hitere (Administrator)

**状态：** ⚠️ **已弃用，不再使用**（2026-03-14 起）

**说明：** 用户明确要求只发布到 homesh.top，不再管理本地 WordPress 博客。

---

### 博客 2：Halo（本地，已弃用）

**博客信息：**
- 本地地址：http://192.168.0.5:8090
- 外部地址：https://web.homesh.top/
- 框架：Halo 2.x

**状态：** ⚠️ 已弃用，不再使用

---

## ⚠️ 重要错误记录 - Astro Frontmatter Schema（多次踩坑！）

**踩坑日期**：2026-03-07、**2026-03-13（再次犯错！）**

**🔴 严重性**：已犯多次，必须每次检查！

**错误原因**：新闻联播文章 frontmatter 不符合 Astro content schema

**✅ 正确格式（必须严格遵守）**：
```yaml
---
title: "新闻联播 20260313"           # 必需！双引号包裹
description: "CCTV 新闻联播每日摘要 - 2026-03-13"  # 必需！不能用 summary
pubDate: 2026-03-13                  # 必需！YYYY-MM-DD 格式
category: '国际时政'                  # 只能是：'航海' | '国际时政' | '生活思考'
tags: ['新闻联播', 'CCTV', '时政']    # 数组格式，字符串用引号
---
```

**❌ 常见错误（每次都要检查！）**：
```yaml
# 错误 1：category 值不对
category: 时政      # ❌ 必须是 "国际时政"

# 错误 2：字段名错误
summary: xxx        # ❌ 字段名是 "description" 不是 "summary"

# 错误 3：不需要 draft
draft: false        # ❌ 不需要，默认就是 false

# 错误 4：tags 格式不对
tags: [新闻联播，CCTV, 时政]  # ❌ 应该用引号：['新闻联播', 'CCTV', '时政']
```

**✅ 修复记录**：
- 2026-03-07: `cctv-news-20260306.md` 已修正
- 2026-03-13: `cctv-news-2026-03-07.md`、`cctv-news-2026-03-08.md` 已修正

**📋 检查清单（每次生成新闻文章前必须核对）**：
- [ ] `title` 字段存在且用双引号
- [ ] `description` 字段存在（不是 `summary`）
- [ ] `pubDate` 是 YYYY-MM-DD 格式
- [ ] `category` 是 `'航海'`、`'国际时政'` 或 `'生活思考'`
- [ ] `tags` 是数组且字符串用引号包裹

---

## ⚠️ 重要改进记录 - 新闻联播内容质量（2026-03-13）

**反馈日期：** 2026-03-13  
**反馈来源：** 用户（老鹏友）

**问题：** 新闻联播文章内容过于简单

**改进要求：**
- ✅ 内容要更详尽、更丰富
- ✅ 每条新闻要有详细内容摘要，不只是标题列表
- ✅ 增加关键数据、人物、地点等细节
- ✅ 适当引用原文关键语句
- ✅ 增加新闻背景和分析（如适用）
- ✅ 文章长度建议：1500-3000 字（之前可能仅 500-800 字）

**改进措施：**
1. 抓取新闻时保留更多详细内容
2. 每条新闻增加 100-300 字摘要
3. 重要新闻单独分段，增加细节
4. 增加"新闻要点"或"关键数据"小节
5. 适当增加新闻背景和影响分析

**示例对比：**

**❌ 之前（过于简单）：**
```markdown
### 国内要闻
- 十四五期间我国 GDP 突破 140 万亿元
- 全国中小学开学
- 各地喜迎元宵节
```

**✅ 改进后（详尽）：**
```markdown
### 国内要闻

**1. 十四五期间我国 GDP 突破 140 万亿元**

国家统计局今日发布数据显示，十四五期间（2021-2025 年），我国国内生产总值（GDP）突破 140 万亿元大关，年均增长率达到 5.2%，高于全球平均水平。

**关键数据：**
- GDP 总量：140.19 万亿元（2025 年）
- 年均增长率：5.2%
- 研发投入占 GDP 比重：2.80%
- 全球创新指数排名：第 10 位

**专家分析：** 这一成就标志着我国经济...

**2. 全国中小学开学**

...
```

**后续执行：**
- 每次生成新闻联播文章时，必须遵循详尽原则
- 内容质量优先于发布速度
- 定期检查已发布文章，持续改进

---

## ⚠️ 重要错误记录 - Cloudflare Pages 部署问题（2026-03-13）

**踩坑日期**：2026-03-13

**🔴 问题 1：GitHub 分支错误**

**症状**：本地构建成功，推送到 GitHub 后 Cloudflare Pages 不部署

**根因**：
- GitHub 仓库默认分支：`main`
- 本地推送分支：`master`
- Cloudflare Pages 监听：`main` 分支

**✅ 解决方案**：
```bash
# 推送到正确的分支
git checkout master
git branch -D main          # 删除旧的 main 分支
git branch -m main          # master 重命名为 main
git push -f origin main     # 强制推送到 main
```

**检查清单**：
- [ ] 确认 GitHub 默认分支：`curl -s "https://api.github.com/repos/laona2050/astro-blog-starter-template" | grep '"default_branch"'`
- [ ] 确认 Cloudflare Pages 监听分支：Cloudflare Dashboard → Pages → homesh.top → Settings → Git → Production branch
- [ ] 推送前确认本地分支：`git branch`

---

**🔴 问题 2：Git Submodules 导致构建失败**

**症状**：Cloudflare Pages 构建日志显示 `error occurred while updating repository submodules`

**根因**：
- skills 目录下 14 个技能是独立的 git 仓库（git submodule，160000 模式）
- Cloudflare Pages 不支持 git submodules

**受影响的技能**：
```
skills/agent-reach, skills/find-skills, skills/github, skills/gog,
skills/healthcheck, skills/polymarket, skills/self-improving-agent,
skills/summarize, skills/tech-news-digest, skills/weather,
skills/wechat-publisher, skills/x-reader, skills/youtube-transcript,
skills/zhihu-post
```

**✅ 解决方案**：
```bash
# 移除子模块索引，改为普通目录
git rm --cached skills/agent-reach skills/find-skills ... (所有子模块)
git add -A
git commit -m "fix: 移除 skills 子模块，改为普通目录"
git push
```

**预防措施**：
- 不要将 skills 目录作为 git submodule 添加到博客仓库
- 如果 skills 需要独立版本控制，使用 git subtree 或单独仓库

---

**🔴 问题 3：Cloudflare Pages 构建延迟**

**症状**：推送后超过 30 分钟仍未部署

**可能原因**：
1. 构建队列延迟（Cloudflare 免费账户有队列限制）
2. 构建失败但未通知
3. 分支配置错误

**✅ 排查步骤**：
1. 登录 Cloudflare Dashboard → Pages → homesh.top
2. 查看 "Deployments" 标签页
3. 点击最新部署查看构建日志
4. 如失败，点击 "Retry deployment"

**构建配置检查**：
- **Build command:** `npm run build`
- **Build output directory:** `dist`
- **Production branch:** `main`

---

## 用户偏好

- 名字：老板 / 老鹏友
- Telegram: @peterabc1 (ID: 1012893020)
- 机器人：@s2501_bot (帝王蟹)
- 时区：UTC+8（北京时间）— 永远按这个时区判断早晚
- 技能安装偏好：GitHub 直装 > clawhub API（因为 clawhub 限流严重）
- **博客发布：只发布到 homesh.top（Cloudflare Astro），不再管理本地 WordPress 博客**（2026-03-14 起）

---

*定期回顾 daily notes，更新此文件。*
