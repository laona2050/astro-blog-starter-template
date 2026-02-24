# TOOLS.md - Tool Configuration & Notes

> Document tool-specific configurations, gotchas, and credentials here.

---

## Credentials Location

All credentials stored in `.credentials/` (gitignored):
- `example-api.txt` — Example API key

---

## [Tool Name]

**Status:** ✅ Working | ⚠️ Issues | ❌ Not configured

**Configuration:**
```
Key details about how this tool is configured
```

**Gotchas:**
- Things that don't work as expected
- Workarounds discovered

**Common Operations:**
```bash
# Example command
tool-name --common-flag
```

---

## Tavily Search

**状态:** ✅ 已配置

**配置:**
```
环境变量: TAVILY_API_KEY
```

**使用方法:**
```bash
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "查询内容"
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "查询" -n 10
node ~/.opencloak/workspace/skills/tavily-search/scripts/search.mjs "查询" --deep
```

**常用参数:**
- `-n <数量>`: 结果数量 (默认5，最多20)
- `--deep`: 深度搜索
- `--topic news`: 新闻搜索

**提取网页内容:**
```bash
node ~/.openclaw/workspace/skills/tavily-search/scripts/extract.mjs "URL"
```

[Document any preferences about writing style, voice, etc.]

---

## 博客 (homesh.top)

**状态:** ✅ 已配置

**配置:**
- GitHub: laona2050/astro-blog-starter-template
- Token: 已保存至 `.credentials/github-homesh.txt`
- 博客路径: `src/content/blog/`
- 部署: Cloudflare Pages

**发布流程:**
1. 创建 markdown 文件到 `src/content/blog/`
2. GitHub Actions 自动部署到 Cloudflare Pages
3. 访问 https://homesh.top 查看

---

## What Goes Here

- Tool configurations and settings
- Credential locations (not the credentials themselves!)
- Gotchas and workarounds discovered
- Common commands and patterns
- Integration notes

## Why Separate?

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

---

*Add whatever helps you do your job. This is your cheat sheet.*
