# CCTV 新闻联播抓取技能

✅ 已安装并测试成功！

## 📍 安装位置

```
/home/node/.openclaw/workspace/skills/cctv-news-fetcher/
```

## 🚀 使用方法

### 命令行使用

```bash
# 抓取指定日期的新闻（格式：YYYYMMDD）
node scripts/news_crawler.js 20260302

# 抓取今天的新闻（自动计算日期）
node scripts/news_crawler.js
```

### 在对话中使用

你可以这样要求我：

- "抓取今天的新闻联播"
- "获取 2026 年 3 月 2 日的 CCTV 新闻"
- "昨天的新闻联播有哪些内容？"

## 📋 输出格式

技能会返回 JSON 格式的新闻列表，包含：

```json
[
  {
    "date": "20260302",
    "title": "[视频] 新闻标题",
    "content": "新闻详细内容..."
  }
]
```

## 🔧 依赖

- Node.js
- node-html-parser (已安装)

## 📝 工作原理

1. 访问 CCTV 官网新闻联播页面
2. 解析 HTML 提取新闻标题和内容
3. 支持三种不同的 URL 格式（适应不同时期的网站改版）
4. 返回结构化的新闻数据

## 🌐 数据源

- https://tv.cctv.com/lm/xwlb/
- https://cctv.cntv.cn/lm/xinwenlianbo/

---

**安装日期**: 2026-03-03  
**技能来源**: https://github.com/openclaw/skills/tree/main/skills/yuhangch/cctv-news-fetcher
