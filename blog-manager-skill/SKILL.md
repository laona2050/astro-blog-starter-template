# Cloudflare 博客管理技能

## 技能描述
管理部署在 Cloudflare Pages 上的 Astro 博客网站，支持发布文章、上传图片、修改样式等功能。

## 触发条件
当用户提到以下关键词时触发此技能：
- "发布博客"、"写文章"、"上传文章"
- "管理博客"、"更新博客"
- "添加文章"、"新建文章"
- "修改博客"、"编辑文章"
- 提到博客地址 (homesh.top) 或 GitHub 仓库 (astro-blog-starter-template)

## 前置要求
1. 用户必须提供 GitHub Personal Access Token（以 `ghp_` 开头）
2. Token 需要具有 `repo` 权限（完全控制私有仓库）

## 使用方法

### 1. 首次使用 - 配置 Token
用户需要提供 GitHub Token：
```
我的 GitHub Token 是：ghp_xxxxxxxxxxxx
```

### 2. 发布新文章
```
发布一篇新文章，标题是《XXX》，内容是...
```

技能会：
1. 克隆/更新本地仓库
2. 创建新的 Markdown/MDX 文件到 `src/content/blog/` 目录
3. 自动修复常见的 MDX 语法问题（如 `<` 符号、HTML 注释等）
4. 提交并推送到 GitHub
5. Cloudflare Pages 自动部署

### 3. 上传图片
```
上传一张图片到博客
```

技能会：
1. 将图片文件保存到 `public/` 目录
2. 返回图片路径供文章使用

### 4. 修改样式/UI
```
修改博客的配色方案
调整 logo 显示为圆形
```

技能会：
1. 定位相关样式文件
2. 修改 CSS/样式代码
3. 提交并推送更改

### 5. 编辑现有文章
```
修改 XXX.md 这篇文章，添加一些内容...
```

技能会：
1. 找到指定文章
2. 按用户要求修改内容
3. 提交并推送更改

## 工作流程

### 发布文章标准流程
1. **检查 Token** - 确认 GitHub Token 有效且具有正确权限
2. **克隆仓库** - 克隆或更新本地仓库副本
3. **创建文章** - 在 `src/content/blog/` 创建 `.md` 或 `.mdx` 文件
4. **内容检查** - 自动检查并修复 MDX 语法问题：
   - 将 `<` 符号（后跟数字）改为中文"小于"
   - 将 HTML 注释 `<!-- -->` 改为 JSX 注释 `{/* */}`
5. **Git 提交** - 添加文件、提交更改
6. **推送部署** - 推送到 GitHub，触发 Cloudflare Pages 自动部署
7. **验证构建** - 检查构建是否成功

### 文章格式要求
```markdown
---
title: '文章标题'
description: '文章描述，用于 SEO 和列表页显示'
pubDate: '2026-03-01'  # 发布日期（YYYY-MM-DD）
heroImage: '/image.jpg'  # 可选，封面图片路径
---

> 可选的引言或摘要

## 章节标题

正文内容...

- 列表项
- 列表项

### 子标题

更多内容...
```

## 常见问题修复

### MDX 语法错误
1. **`<` 符号问题**：`<2g/m²` → `小于 2g/m²`
2. **HTML 注释**：`<!-- 注释 -->` → `{/* 注释 */}`
3. **JSX 标签未闭合**：检查所有 `<div>`、`<section>` 等标签

### 构建失败处理
1. 查看 Cloudflare Pages 构建日志
2. 定位错误文件和行号
3. 修复语法问题
4. 重新提交推送

## 仓库信息
- **GitHub**: https://github.com/laona2050/astro-blog-starter-template
- **博客地址**: https://homesh.top/
- **框架**: Astro + Cloudflare Pages
- **内容目录**: `src/content/blog/`
- **静态资源**: `public/`

## 配置文件
- `astro.config.mjs` - Astro 配置
- `wrangler.json` - Cloudflare Workers 配置
- `src/consts.ts` - 网站标题、描述等常量
- `src/content.config.ts` - 内容集合配置
- `src/styles/global.css` - 全局样式

## 注意事项
1. Token 是敏感信息，仅在当前会话使用
2. 每次发布文章后，Cloudflare Pages 需要 2-5 分钟自动部署
3. MDX 文件需要特别注意语法格式
4. 图片文件应放在 `public/` 目录，文章中用 `/image.jpg` 引用

## 示例对话

**用户**: 发布一篇新文章，标题是《我的航海日记》，内容是今天去看了游艇...

**助手**: 好的，我来帮您发布这篇博客文章。首先，我需要您的 GitHub Personal Access Token 来提交代码到您的仓库。

**用户**: 我的 Token 是 ghp_xxxxx

**助手**: 收到！正在创建文章《我的航海日记》...
- ✅ 创建文件：src/content/blog/my-sailing-diary.md
- ✅ 检查 MDX 语法
- ✅ 提交到 GitHub
- ✅ 推送到远程仓库

文章已成功发布！Cloudflare Pages 正在自动部署，大约 2-5 分钟后您可以在 https://homesh.top/ 看到新文章。

---

## 技能版本
v1.0 - 初始版本
- 支持发布 Markdown/MDX 文章
- 自动修复常见 MDX 语法错误
- 支持样式修改
- 支持图片上传
