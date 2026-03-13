# TOOLS.md - Tool Configuration & Notes

> Document tool-specific configurations, gotchas, and credentials here.

---

## Credentials Location

All credentials stored in `.credentials/` (gitignored):
- `wordpress-192.168.0.5-8088.txt` — WordPress 应用密码
- `github-homesh.txt` — GitHub Token (已弃用)

---

## 博客 (192.168.0.5:8088 - WordPress)

**状态:** ✅ 已配置（主博客）

**配置:**
- URL: http://192.168.0.5:8088
- 平台：WordPress
- 用户：hitere (Administrator)
- 应用密码：已保存至 `.credentials/wordpress-192.168.0.5-8088.txt`
- API: `/wp-json/wp/v2`

**发布流程:**
```bash
# 发布单篇文章
./scripts/publish-to-wordpress.sh article.md "文章标题"

# 或使用 curl 直接发布
curl -u "hitere:应用密码" \
  -X POST "http://192.168.0.5:8088/wp-json/wp/v2/posts" \
  -H "Content-Type: application/json" \
  -d '{"title":"标题","content":"内容","status":"publish"}'
```

**分类:**
- 房车
- 新闻
- 游艇
- 服务器

**定时任务:**
- 每天早上 6 点（北京时间 UTC 22:00）发布 CCTV 新闻联播

---

## 博客 (homesh.top - Astro, 已弃用)

**状态:** ⚠️ 已弃用，不再使用

**配置:**
- GitHub: laona2050/astro-blog-starter-template
- 托管：Cloudflare Pages
- 框架：Astro

---

## Tavily Search

**状态:** ✅ 已配置

**配置:**
```
环境变量：TAVILY_API_KEY
位置：~/.openclaw/workspace/.env
API Key: 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 (已配置)
```

**使用方法:**
```bash
# 使用 web_search 工具（推荐）
web_search(query="查询内容")

# 或使用技能脚本
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "查询内容"
node ~/.openclaw/workspace/skills/tavily-search/scripts/search.mjs "查询" -n 10
```

**常用参数:**
- `-n <数量>`: 结果数量 (默认 5，最多 20)
- `--deep`: 深度搜索
- `--topic news`: 新闻搜索

**测试:** ✅ API 验证通过 (2026-03-10)

---

*Add whatever helps you do your job. This is your cheat sheet.*
