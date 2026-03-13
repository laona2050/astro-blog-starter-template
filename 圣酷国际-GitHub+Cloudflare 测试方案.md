# 圣酷国际 - GitHub + Cloudflare 测试方案

> 使用 homesh.top 二级域名测试，验证通过后再购买独立域名

**生成日期：** 2026-03-11  
**测试域名：** shengcool.homesh.top（可调整）

---

## 📊 方案概览

| 项目 | 配置 | 费用 |
|------|------|------|
| 域名 | shengcool.homesh.top | ¥0 元（二级域名） |
| 代码托管 | GitHub | ¥0 元 |
| 网站部署 | Cloudflare Pages | ¥0 元 |
| CDN 加速 | Cloudflare | ¥0 元 |
| SSL 证书 | Cloudflare 自动提供 | ¥0 元 |
| **合计** | | **¥0 元** |

---

## 📋 实施步骤

### 第 1 步：确认 homesh.top 的 Cloudflare 托管

**检查事项：**
- [ ] homesh.top 是否已托管在 Cloudflare？
- [ ] 你有 Cloudflare 账号和管理权限？

**如未托管：**
1. 注册 Cloudflare 账号（用你的谷歌账号）
2. 添加站点 homesh.top
3. 修改域名 DNS 服务器为 Cloudflare 提供的地址

---

### 第 2 步：创建 GitHub 仓库

**步骤：**

1. 登录 GitHub（用你的谷歌账号）
   - 网址：https://github.com

2. 创建新仓库
   - 仓库名：`shengcool-website`
   - 可见性：**Public**（公开，免费）
   - 初始化：勾选 "Add a README file"

3. 上传网站文件
   - 点击 "Add file" → "Upload files"
   - 上传 `index.html`（我提供的测试页面）
   - 点击 "Commit changes"

---

### 第 3 步：Cloudflare Pages 部署

**步骤：**

1. 登录 Cloudflare
   - 网址：https://dash.cloudflare.com

2. 进入 Pages
   - 左侧菜单 → **Workers & Pages** → **Pages**
   - 点击 **"Create a project"**

3. 连接 GitHub
   - 选择 **"Connect to Git"**
   - 授权 Cloudflare 访问 GitHub
   - 选择仓库：`shengcool-website`

4. 配置构建
   - **Framework preset:** `None`（纯 HTML）
   - **Build command:** 留空
   - **Build output directory:** `/`（根目录）

5. 点击 **"Save and Deploy"**

**等待部署完成（约 1-2 分钟）**

**测试访问：** `https://shengcool-website.pages.dev`

---

### 第 4 步：添加自定义域名（二级域名）

**步骤：**

1. 在 Pages 项目页面
   - 点击 **"Custom domains"**
   - 点击 **"Add a custom domain"**

2. 输入自定义域名
   - 域名：`shengcool.homesh.top`
   - 点击 **"Add domain"**

3. Cloudflare 会自动添加 DNS 记录
   - 类型：CNAME
   - 名称：shengcool
   - 目标：shengcool-website.pages.dev

4. 等待 DNS 生效（通常 5-10 分钟）

**测试访问：** `https://shengcool.homesh.top`

---

### 第 5 步：验证 HTTPS

Cloudflare 会自动提供 SSL 证书，无需手动配置。

**检查：**
- 浏览器地址栏显示 🔒 锁标志
- URL 以 `https://` 开头
- 证书有效期：自动续期

---

## 📁 网站文件结构

```
shengcool-website/
├── index.html          # 首页（我提供的测试页面）
├── about.html          # 关于我们（可选）
├── products.html       # 产品中心（可选）
├── contact.html        # 联系我们（可选）
└── assets/             # 静态资源（可选）
    ├── css/
    ├── js/
    └── images/
```

---

## 🎨 后续优化建议

### 1. 内容完善

| 页面 | 内容 | 优先级 |
|------|------|--------|
| 首页 | 公司形象 + 核心优势 | P0 |
| 关于我们 | 公司简介 + 企业文化 | P0 |
| 产品中心 | 产品分类 + 详情 | P0 |
| 联系我们 | 地址 + 电话 + 邮箱 + 地图 | P0 |
| 新闻动态 | 公司动态 + 行业资讯 | P1 |

### 2. 设计优化

- 使用专业企业主题（Hugo/Astro）
- 添加公司 Logo
- 优化配色方案
- 添加产品图片

### 3. 功能增强

- 联系表单（Formspree 免费版）
- 多语言切换（中/英）
- 在线客服（Tidio 免费版）
- 访问统计（Cloudflare Analytics）

---

## ⚠️ 注意事项

### 二级域名限制

1. **依赖 homesh.top** - 如果主域名失效，二级域名也失效
2. **品牌认知** - 客户可能记不住二级域名
3. **SEO 影响** - 搜索引擎权重不如独立域名

### 建议

- **测试周期：** 1-2 周
- **测试通过后：** 立即购买独立域名（shengcool.com）
- **迁移成本：** 很低（只需改 DNS 记录）

---

## 🔄 迁移到独立域名（测试通过后）

### 步骤

1. 购买新域名（如 shengcool.com）
2. 在 Cloudflare 添加新域名
3. Pages 项目绑定新域名
4. 修改 DNS 记录
5. 旧域名 301 重定向到新域名

**整个过程：** 约 30 分钟

---

## 📞 遇到问题？

### 常见故障排查

| 问题 | 可能原因 | 解决方法 |
|------|----------|----------|
| 404 错误 | 文件未上传 | 检查 index.html 是否在根目录 |
| DNS 未生效 | 记录未同步 | 等待 10-30 分钟 |
| SSL 证书错误 | 证书未签发 | 等待 Cloudflare 自动签发（5-10 分钟） |
| 页面不更新 | 缓存问题 | Cloudflare 控制台 → Purge Cache |

---

## 📋 检查清单

### 部署前

- [ ] 确认 homesh.top 托管在 Cloudflare
- [ ] 准备 GitHub 账号
- [ ] 准备 index.html 文件

### 部署后

- [ ] 访问 https://shengcool.homesh.top 正常
- [ ] HTTPS 证书有效（🔒）
- [ ] 页面内容显示正确
- [ ] 移动端显示正常

### 测试通过后

- [ ] 购买独立域名（shengcool.com）
- [ ] 绑定新域名到 Pages
- [ ] 配置 301 重定向

---

**方案制定：** 浪浪海 🦀  
**生成时间：** 2026-03-11  
**版本：** v1.0

---

*祝测试顺利！🌊*
