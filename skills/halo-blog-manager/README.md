# Halo Blog Manager Skill

Halo 2.x 博客管理工具

## 配置

在 `~/.openclaw/workspace/.credentials/halo-homesh.txt` 中保存：

```bash
Halo_URL=http://192.168.0.5:8090
Halo_PAT=pat_xxx
Halo_OWNER=hitere
```

## 使用方法

### 1. 通过对话（推荐）

直接告诉帝王蟹：
- "发布一篇文章到 Halo，标题是 xxx，内容是..."
- "列出 Halo 博客的所有文章"

### 2. 通过脚本

```bash
cd skills/halo-blog-manager

# 创建文章（元数据）
python3 create_post.py "文章标题" content.md slug-name

# 发布文章
python3 create_post.py --publish post-abc123

# 列出文章
./halo-manager.sh list
```

## 注意事项

### ⚠️ Halo 2.x API 限制

目前通过 API 创建文章时：
1. ✅ 可以创建文章元数据
2. ⚠️ Draft snapshot 创建需要额外权限
3. ✅ 可以通过 Halo 后台手动发布

**推荐流程**：
1. 通过 API 或对话创建文章元数据
2. 在 Halo 后台编辑内容并发布

### 手动发布步骤

1. 登录 Halo 后台：http://192.168.0.5:8090/console
2. 进入 文章 → 草稿箱
3. 找到对应的文章
4. 编辑内容并点击发布

## 已知问题

- Draft snapshot API 返回 403（权限问题）
- 需要 Halo 后台手动完成内容编辑

## 许可证

MIT
