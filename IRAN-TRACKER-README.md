# 🇮🇷 伊朗局势自动追踪系统

## 概述

自动化伊朗局势新闻追踪系统，每小时更新一次，连续追踪 30 天。

## 功能

- 🔍 **多源搜索**: 使用 multi-search-engine (17 个搜索引擎) + Tavily (AI 深度搜索)
- 📊 **分类监测**: 政治、经济、军事三大领域
- ⏰ **每小时更新**: GitHub Actions 定时触发
- 📝 **自动发布**: 生成新闻报告并发布到博客
- 📅 **30 天计划**: 每天一篇新文章，每小时更新内容

## 文件结构

```
/home/node/.openclaw/workspace/
├── iran-tracker-auto.py          # 主脚本
├── iran-tracker-state.json       # 状态文件 (自动生成)
└── astro-blog/
    └── .github/workflows/
        └── iran-tracker-hourly.yml  # GitHub Actions 工作流
```

## 搜索关键词

### 政治
- 伊朗局势、伊朗最高领袖、伊朗政府、伊朗外交部、联合国伊朗

### 经济
- 伊朗经济、伊朗石油、霍尔木兹海峡、伊朗制裁、伊朗货币

### 军事
- 伊朗军事、伊朗革命卫队、伊朗导弹、伊朗无人机、中东局势

## 使用方法

### 手动运行

```bash
cd /home/node/.openclaw/workspace
python3 iran-tracker-auto.py
```

### 自动运行

GitHub Actions 每小时自动执行（每小时的第 0 分钟）

### 手动触发

1. 访问：https://github.com/laona2050/astro-blog-starter-template/actions
2. 选择 "🇮🇷 伊朗局势每小时追踪"
3. 点击 "Run workflow"
4. 可选：设置 `force_new_day: true` 强制开始新的一天

## 配置

### GitHub Secrets

需要在 GitHub 仓库配置以下 Secret：

| 名称 | 值 |
|------|-----|
| `TAVILY_API_KEY` | `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` |

### 状态文件

`iran-tracker-state.json` 记录追踪进度：

```json
{
  "current_day": 1,
  "last_update": "2026-03-03T12:00:00",
  "articles": ["iran-tracker-day1-20260303.md"]
}
```

## 输出文章

### 文件命名

```
iran-tracker-day{天数}-{日期}.md
示例：iran-tracker-day1-20260303.md
```

### 文章结构

```markdown
---
title: '伊朗局势追踪 Day1: 2026-03-03'
description: '伊朗局势 24 小时实时更新：政治、经济、军事全方位监测'
pubDate: 2026-03-03
category: '国际时政'
tags: ['伊朗局势', '中东', '国际时政', '实时追踪', 'Day1']
---

# 伊朗局势追踪 | Day 1

## 📈 今日概览
## 🏛️ 政治动态
## 💰 经济动态
## ⚔️ 军事动态
## 📊 趋势分析
## 🛠️ 数据来源
## 📅 追踪计划
```

## 追踪计划

| 阶段 | 时间 | 天数 |
|------|------|------|
| 第 1 周 | Day 1-7 | 初始监测 |
| 第 2 周 | Day 8-14 | 持续追踪 |
| 第 3 周 | Day 15-21 | 深度分析 |
| 第 4 周 | Day 22-28 | 趋势总结 |
| 第 5 周 | Day 29-30 | 最终报告 |

## 日志查看

GitHub Actions 执行日志：
https://github.com/laona2050/astro-blog-starter-template/actions

## 博客文章

发布后的文章地址：
```
https://homesh.top/blog/iran-tracker-day{天数}-{日期}/
```

## 注意事项

1. **API 限制**: Tavily 免费版有查询限制，注意监控使用量
2. **Git 冲突**: 每小时更新可能产生冲突，建议监控 Actions 日志
3. **内容审核**: 自动生成的内容建议定期人工审核
4. **30 天后**: 系统会自动停止，需要手动重置状态文件

## 故障排查

### 问题 1: GitHub Actions 失败

检查：
- TAVILY_API_KEY 是否正确配置
- 网络连接是否正常
- 查看 Actions 日志详情

### 问题 2: 文章没有更新

检查：
- 状态文件 `iran-tracker-state.json` 是否存在
- Git 提交是否有冲突
- 查看 Actions 日志中的 "没有变更需要提交"

### 问题 3: 搜索结果为空

可能原因：
- 网络连接问题
- 搜索引擎限流
- 关键词需要调整

## 扩展功能

### 添加更多搜索引擎

编辑 `SEARCH_ENGINES` 列表：

```python
SEARCH_ENGINES = [
    "https://www.google.com/search?q={}",
    "https://cn.bing.com/search?q={}",
    "https://duckduckgo.com/html/?q={}",
    "https://www.baidu.com/s?wd={}",
    "https://www.so.com/s?q={}",  # 360 搜索
    "https://sogou.com/web?query={}",  # 搜狗
]
```

### 调整更新频率

编辑 `.github/workflows/iran-tracker-hourly.yml`：

```yaml
# 每 30 分钟
- cron: '0,30 * * * *'

# 每 2 小时
- cron: '0 */2 * * *'
```

### 添加更多分类

编辑 `SEARCH_TOPICS`：

```python
SEARCH_TOPICS = {
    "政治": [...],
    "经济": [...],
    "军事": [...],
    "外交": [...]  # 新增
}
```

---

**🦀 由帝王蟹开发** | **📧 联系**: contact@homesh.top
