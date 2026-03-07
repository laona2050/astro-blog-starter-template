# Halo 博客管理

管理本地 Halo 2.x 博客，支持完整的文章创建、编辑、发布流程。

## 配置

在 `~/.openclaw/workspace/.credentials/halo-homesh.txt` 中保存：

```bash
Halo_URL=http://192.168.0.5:8090
Halo_PAT=pat_xxx
Halo_OWNER=hitere
```

## 功能

- ✅ 创建文章（自动创建草稿 snapshot）
- ✅ 发布文章
- ✅ 列出所有文章
- ✅ 获取文章详情
- ✅ 删除文章

## 使用方式

### 通过脚本

```bash
cd skills/halo-blog-manager

# 创建文章（含草稿）
./halo-manager.sh create "文章标题" content.md slug-name

# 发布文章
./halo-manager.sh publish post-abc123

# 列出文章
./halo-manager.sh list

# 获取详情
./halo-manager.sh get post-abc123

# 删除文章
./halo-manager.sh delete post-abc123
```

### 通过对话

直接告诉帝王蟹：

- "发布一篇文章到 Halo，标题是 xxx，内容是..."
- "列出 Halo 博客的所有文章"
- "删除 Halo 文章 xxx"
- "查看 Halo 文章 xxx 的详情"

## API 流程

Halo 2.x 文章创建需要两步：

1. **创建 Post 元数据**
   ```bash
   POST /apis/content.halo.run/v1alpha1/posts
   ```

2. **创建草稿 Snapshot**
   ```bash
   PUT /apis/content.halo.run/v1alpha1/posts/{name}/draft
   {
     "content": {
       "raw": "Markdown 内容",
       "content": "HTML 内容",
       "rawType": "markdown"
     }
   }
   ```

3. **发布文章**
   ```bash
   PUT /apis/content.halo.run/v1alpha1/posts/{name}/publish
   ```

## 必填字段

创建文章时必需：

```json
{
  "apiVersion": "content.halo.run/v1alpha1",
  "kind": "Post",
  "metadata": {"generateName": "post-"},
  "spec": {
    "title": "标题",
    "slug": "别名",
    "deleted": false,
    "publish": false,
    "pinned": false,
    "priority": 0,
    "owner": "用户名"
  }
}
```

## 注意事项

1. **必须创建 draft snapshot**：否则后台编辑器看不到内容
2. **发布流程**：创建草稿 → 发布（自动创建 release snapshot）
3. **Slug 唯一**：文章别名不能重复
4. **Owner 必需**：必须是已存在的用户名

## 故障排查

### 后台编辑器空白

原因：没有创建 draft snapshot

解决：
```bash
curl -X PUT "$Halo_URL/apis/content.halo.run/v1alpha1/posts/{name}/draft" \
  -H "Authorization: Bearer $Halo_PAT" \
  -H "Content-Type: application/json" \
  -d '{"content": {"raw": "内容", "rawType": "markdown"}}'
```

### 发布失败

检查：
1. 文章是否存在
2. 是否有 draft snapshot
3. 用户权限是否正确

## 日志位置

```bash
docker logs 1Panel-halo-ezpr -f
```
