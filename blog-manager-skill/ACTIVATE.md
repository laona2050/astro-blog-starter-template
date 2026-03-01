# Cloudflare 博客管理技能 - 激活说明

## 📦 技能文件

本技能包含以下文件：

```
cloudflare_blog_manager/
├── SKILL.md              # 技能核心说明（必需）
├── README.md             # 完整文档
├── QUICKSTART.md         # 快速入门
├── post-template.md      # 文章模板
├── blog-manager.sh       # 命令行工具
└── ACTIVATE.md           # 本文件
```

## 🎯 触发条件

当用户提到以下关键词时，系统会自动调用此技能：

### 主要触发词
- "发布博客"
- "写文章"
- "上传文章"
- "管理博客"
- "更新博客"
- "添加文章"
- "新建文章"
- "编辑文章"
- "修改博客"

### 特定触发词
- 博客地址：homesh.top
- 仓库名：astro-blog-starter-template
- GitHub 用户名：laona2050
- Cloudflare Pages

### 上下文触发
当用户已经提供过 GitHub Token，并提到：
- "发布..."
- "上传..."
- "修改..."
- "删除..."
- "更新..."

## 🔑 必需配置

### 1. GitHub Token
用户必须提供有效的 GitHub Personal Access Token：
- 权限：`repo`（完全控制私有仓库）
- 格式：以 `ghp_` 开头
- 有效期：建议 90 天

### 2. Token 存储
Token 仅在会话期间有效，不会永久存储。

## 📝 使用示例

### 示例 1：发布文章
```
用户：我想发布一篇新文章
助手：好的，我来帮您发布博客文章。首先，我需要您的 GitHub Token...

用户：我的 Token 是 ghp_xxxxx
助手：收到！请告诉我文章的标题和内容...

用户：标题是《我的航海日记》，内容是...
助手：正在创建文章... ✅ 完成！
```

### 示例 2：上传图片
```
用户：帮我上传一张图片到博客
助手：好的，请提供图片文件路径或 URL...

用户：/path/to/photo.jpg
助手：正在上传... ✅ 完成！图片路径：/photo.jpg
```

### 示例 3：修改样式
```
用户：把博客的 logo 改成圆形
助手：好的，我来修改 Header、Footer 和 About 页面的 logo 样式...

助手：✅ 完成！已推送到 GitHub，Cloudflare 正在部署...
```

## 🔄 自动处理流程

### 文章发布流程
1. **接收内容** → 获取标题、描述、正文
2. **创建文件** → 生成 Markdown/MDX 文件
3. **语法检查** → 检测并修复 MDX 问题
4. **Git 操作** → add → commit → push
5. **自动部署** → Cloudflare Pages 触发构建
6. **验证上线** → 2-5 分钟后生效

### 错误处理
- MDX 语法错误 → 自动修复
- 构建失败 → 查看日志并修复
- Token 无效 → 提示重新提供
- 网络问题 → 重试机制

## 🛠️ 高级功能

### 批量操作
```
用户：帮我发布这 5 篇文章
助手：好的，我将依次发布...
```

### 定时发布
```
用户：这篇文章明天早上 8 点发布
助手：好的，我会设置定时任务...（需要 cron 技能配合）
```

### 内容同步
```
用户：把这篇文章同步到知乎/掘金
助手：好的，我来帮您...（需要额外配置）
```

## 📊 技能状态

### 已激活功能
- ✅ 发布 Markdown 文章
- ✅ 发布 MDX 文章
- ✅ 上传图片
- ✅ 修改样式
- ✅ 编辑现有文章
- ✅ 自动修复 MDX 错误
- ✅ Git 提交和推送
- ✅ Cloudflare 部署监控

### 计划功能
- 🔄 批量发布
- 🔄 定时发布
- 🔄 内容同步
- 🔄 SEO 优化建议
- 🔄 自动标签生成
- 🔄 文章统计分析

## 🎓 学习资源

### 新手必读
1. `QUICKSTART.md` - 5 分钟快速入门
2. `post-template.md` - 文章格式模板
3. `SKILL.md` - 技能详细说明

### 进阶指南
1. `README.md` - 完整功能文档
2. `blog-manager.sh` - 命令行工具
3. Astro 官方文档

## ⚠️ 安全提示

### Token 安全
- ⚠️ 不要公开分享 Token
- ⚠️ 定期更换 Token
- ⚠️ 设置合理的过期时间
- ✅ 仅在当前会话使用

### 内容安全
- ✅ 发布前检查内容
- ✅ 遵守法律法规
- ✅ 尊重版权
- ✅ 不发布敏感信息

## 📞 获取帮助

### 问题排查
1. 查看 `QUICKSTART.md` 的常见问题部分
2. 检查 Cloudflare 构建日志
3. 验证 GitHub Token 权限
4. 询问助手获取帮助

### 技术支持
- GitHub Issues: https://github.com/laona2050/astro-blog-starter-template/issues
- Cloudflare 支持：https://support.cloudflare.com

---

**技能版本**: v1.0  
**激活状态**: ✅ 已激活  
**最后更新**: 2026-03-01
