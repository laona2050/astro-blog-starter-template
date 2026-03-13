#!/bin/bash
# 圣酷国际网站自动化部署脚本
# 用法：bash deploy-shengcool.sh

set -e

# 配置
GITHUB_TOKEN="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"
GITHUB_USER="laona2050"
REPO_NAME="shengcool-website"
REPO_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo "🦀 圣酷国际网站自动化部署"
echo "================================"

# 检查 Git 是否安装
if ! command -v git &> /dev/null; then
    echo "❌ 错误：Git 未安装，请先安装 Git"
    exit 1
fi

# 检查 Node.js 是否安装（可选）
if command -v node &> /dev/null; then
    echo "✅ Node.js 已安装：$(node -v)"
else
    echo "⚠️  Node.js 未安装（不影响部署）"
fi

# 创建临时目录
TEMP_DIR=$(mktemp -d)
echo "📁 创建临时目录：$TEMP_DIR"
cd "$TEMP_DIR"

# 创建仓库（通过 GitHub API）
echo "🔨 创建 GitHub 仓库..."
RESPONSE=$(curl -s -X POST "https://api.github.com/user/repos" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{\"name\":\"${REPO_NAME}\",\"description\":\"圣酷国际贸易（上海）有限公司官网\",\"private\":false,\"auto_init\":true}")

if echo "$RESPONSE" | grep -q '"full_name"'; then
    echo "✅ 仓库创建成功：${REPO_URL}"
elif echo "$RESPONSE" | grep -q '"message":"Already created"'; then
    echo "⚠️  仓库已存在，继续使用"
else
    echo "❌ 创建仓库失败：$RESPONSE"
    exit 1
fi

# 创建网站文件
echo "📝 创建网站文件..."

# 创建 index.html
cat > index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>圣酷国际贸易（上海）有限公司 - SaintCool International</title>
    <meta name="description" content="圣酷国际贸易（上海）有限公司是一家专业的国际贸易公司，致力于为全球客户提供优质的产品和服务">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; line-height: 1.6; color: #333; background: #f8f9fa; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        
        /* Header */
        header { background: linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%); color: white; padding: 1rem 0; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        header .container { display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 1.5rem; font-weight: bold; }
        .logo span { opacity: 0.9; font-size: 0.9rem; display: block; }
        nav ul { list-style: none; display: flex; gap: 2rem; }
        nav a { color: white; text-decoration: none; opacity: 0.9; transition: opacity 0.3s; }
        nav a:hover { opacity: 1; }
        
        /* Hero */
        .hero { background: linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%); color: white; padding: 6rem 0; text-align: center; }
        .hero h1 { font-size: 3rem; margin-bottom: 1rem; }
        .hero p { font-size: 1.3rem; opacity: 0.95; margin-bottom: 2rem; }
        .btn { display: inline-block; background: #F97316; color: white; padding: 1rem 2rem; border-radius: 6px; text-decoration: none; font-weight: bold; transition: transform 0.3s, box-shadow 0.3s; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(249,115,22,0.4); }
        
        /* Section */
        .section { padding: 5rem 0; background: white; }
        .section:nth-child(even) { background: #f8f9fa; }
        .section h2 { color: #1E3A8A; font-size: 2.2rem; margin-bottom: 3rem; text-align: center; }
        
        /* Grid */
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; }
        .card { background: white; border-radius: 10px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.08); transition: transform 0.3s, box-shadow 0.3s; border: 1px solid #e5e7eb; }
        .card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0,0,0,0.12); }
        .card h3 { color: #1E3A8A; margin-bottom: 1rem; font-size: 1.4rem; }
        .card p { color: #6B7280; line-height: 1.8; }
        .card-icon { font-size: 2.5rem; margin-bottom: 1rem; }
        
        /* About */
        .about-content { display: grid; grid-template-columns: 1fr 1fr; gap: 3rem; align-items: center; }
        .about-text h3 { color: #1E3A8A; margin-bottom: 1rem; }
        .about-stats { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1.5rem; }
        .stat { background: linear-gradient(135deg, #1E3A8A, #3B82F6); color: white; padding: 1.5rem; border-radius: 8px; text-align: center; }
        .stat-number { font-size: 2.5rem; font-weight: bold; }
        .stat-label { opacity: 0.9; font-size: 0.9rem; }
        
        /* Contact */
        .contact-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem; }
        .contact-item { text-align: center; padding: 2rem; }
        .contact-icon { font-size: 2.5rem; margin-bottom: 1rem; }
        .contact-item h4 { color: #1E3A8A; margin-bottom: 0.5rem; }
        .contact-item p { color: #6B7280; }
        
        /* Footer */
        footer { background: #1F2937; color: white; text-align: center; padding: 3rem 0; }
        footer p { opacity: 0.8; margin-bottom: 0.5rem; }
        footer a { color: #3B82F6; text-decoration: none; }
        
        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 { font-size: 2rem; }
            nav ul { gap: 1rem; }
            .about-content { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container">
            <div class="logo">
                圣酷国际
                <span>SaintCool International</span>
            </div>
            <nav>
                <ul>
                    <li><a href="#home">首页</a></li>
                    <li><a href="#about">关于我们</a></li>
                    <li><a href="#services">业务领域</a></li>
                    <li><a href="#contact">联系我们</a></li>
                </ul>
            </nav>
        </div>
    </header>
    
    <!-- Hero -->
    <section class="hero" id="home">
        <div class="container">
            <h1>专业 · 诚信 · 共赢</h1>
            <p>致力于为全球客户提供优质的国际贸易服务</p>
            <a href="#contact" class="btn">立即咨询</a>
        </div>
    </section>
    
    <!-- About -->
    <section class="section" id="about">
        <div class="container">
            <h2>关于我们</h2>
            <div class="about-content">
                <div class="about-text">
                    <h3>圣酷国际贸易（上海）有限公司</h3>
                    <p>圣酷国际贸易（上海）有限公司是一家专业的国际贸易公司，总部位于中国上海。我们致力于为全球客户提供优质的产品和服务，业务范围涵盖进出口贸易、供应链管理、国际物流等多个领域。</p>
                    <p style="margin-top: 1rem;">公司秉承"专业、诚信、共赢"的经营理念，与全球多个国家和地区的合作伙伴建立了长期稳定的合作关系，为客户提供高效、可靠的国际贸易解决方案。</p>
                </div>
                <div class="about-stats">
                    <div class="stat">
                        <div class="stat-number">10+</div>
                        <div class="stat-label">年行业经验</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">合作国家</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">服务客户</div>
                    </div>
                    <div class="stat">
                        <div class="stat-number">98%</div>
                        <div class="stat-label">客户满意度</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Services -->
    <section class="section" id="services">
        <div class="container">
            <h2>业务领域</h2>
            <div class="grid">
                <div class="card">
                    <div class="card-icon">🌍</div>
                    <h3>进出口贸易</h3>
                    <p>专业的进出口代理服务，涵盖报关、报检、物流等全流程，确保货物安全、快速通关。</p>
                </div>
                <div class="card">
                    <div class="card-icon">📦</div>
                    <h3>供应链管理</h3>
                    <p>优化供应链流程，降低采购成本，提高供应链效率，为企业创造更大价值。</p>
                </div>
                <div class="card">
                    <div class="card-icon">🚢</div>
                    <h3>国际物流</h3>
                    <p>海运、空运、铁路多式联运，全球主要港口全覆盖，提供门到门的物流解决方案。</p>
                </div>
                <div class="card">
                    <div class="card-icon">💼</div>
                    <h3>商务咨询</h3>
                    <p>提供国际市场开拓、贸易合规、风险评估等专业咨询服务，助力企业全球化发展。</p>
                </div>
                <div class="card">
                    <div class="card-icon">🏭</div>
                    <h3>产品采购</h3>
                    <p>依托丰富的供应商资源，为客户提供优质、高性价比的产品采购服务。</p>
                </div>
                <div class="card">
                    <div class="card-icon">🤝</div>
                    <h3>合作伙伴</h3>
                    <p>与全球 50+ 国家和地区的合作伙伴建立长期稳定关系，共享资源，互利共赢。</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Why Choose Us -->
    <section class="section">
        <div class="container">
            <h2>为什么选择我们</h2>
            <div class="grid">
                <div class="card">
                    <div class="card-icon">✅</div>
                    <h3>专业团队</h3>
                    <p>拥有 10 年以上国际贸易经验的专业团队，熟悉各国贸易政策和流程。</p>
                </div>
                <div class="card">
                    <div class="card-icon">💰</div>
                    <h3>价格优势</h3>
                    <p>直接对接厂家和供应商，减少中间环节，为客户提供最具竞争力的价格。</p>
                </div>
                <div class="card">
                    <div class="card-icon">⏰</div>
                    <h3>交货及时</h3>
                    <p>完善的供应链管理和物流网络，确保货物按时交付。</p>
                </div>
                <div class="card">
                    <div class="card-icon">🛡️</div>
                    <h3>售后保障</h3>
                    <p>提供完善的售后服务，快速响应客户需求，解决后顾之忧。</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Contact -->
    <section class="section" id="contact" style="background: linear-gradient(135deg, #1E3A8A 0%, #3B82F6 100%); color: white;">
        <div class="container">
            <h2 style="color: white;">联系我们</h2>
            <div class="contact-grid">
                <div class="contact-item">
                    <div class="contact-icon">📍</div>
                    <h4>公司地址</h4>
                    <p>上海市 XXX 区 XXX 路 XXX 号</p>
                </div>
                <div class="contact-item">
                    <div class="contact-icon">📞</div>
                    <h4>联系电话</h4>
                    <p>+86-21-XXXXXXXX</p>
                </div>
                <div class="contact-item">
                    <div class="contact-icon">📧</div>
                    <h4>电子邮箱</h4>
                    <p>info@shengcool.com</p>
                </div>
                <div class="contact-item">
                    <div class="contact-icon">🕐</div>
                    <h4>工作时间</h4>
                    <p>周一至周五 9:00-18:00</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <p>&copy; 2026 圣酷国际贸易（上海）有限公司 版权所有</p>
            <p>本网站为测试站点 - <a href="https://homesh.top">homesh.top</a></p>
        </div>
    </footer>
</body>
</html>
HTMLEOF

# 创建 README
cat > README.md << 'READMEEOF'
# 圣酷国际贸易（上海）有限公司官网

> SaintCool International Trading (Shanghai) Co., Ltd.

## 网站部署

本网站使用 Cloudflare Pages 部署。

### 访问地址

- 测试域名：https://sk.homesh.top
- Pages 域名：https://shengcool-website.pages.dev

## 技术栈

- 纯 HTML/CSS/JavaScript
- Cloudflare Pages 托管
- Cloudflare CDN 加速

## 更新网站

1. 修改 `index.html`
2. 提交更改到 GitHub
3. Cloudflare Pages 自动部署

## 联系方式

- 地址：上海市 XXX 区 XXX 路 XXX 号
- 电话：+86-21-XXXXXXXX
- 邮箱：info@shengcool.com

---

© 2026 圣酷国际贸易（上海）有限公司
READMEEOF

# 创建 .gitignore
cat > .gitignore << 'GITIGNOREEOF'
.DS_Store
*.log
node_modules/
.env
GITIGNOREEOF

echo "✅ 网站文件创建完成"

# 初始化 Git 仓库
echo "🔧 初始化 Git 仓库..."
git init
git config user.email "bot@openclaw.ai"
git config user.name "OpenClaw Bot"
git add .
git commit -m "Initial commit: 圣酷国际官网 v1.0"

# 推送到 GitHub
echo "🚀 推送到 GitHub..."
git remote add origin "$REPO_URL"
git branch -M main
git push -u origin main

echo ""
echo "================================"
echo "✅ 部署完成！"
echo ""
echo "📦 GitHub 仓库：${REPO_URL}"
echo ""
echo "🔗 下一步操作："
echo "1. 访问 Cloudflare Dashboard"
echo "2. 进入 Pages → Create a project"
echo "3. 连接 GitHub 仓库：${REPO_NAME}"
echo "4. 添加自定义域名：sk.homesh.top"
echo ""
echo "🎉 预计 5-10 分钟后访问：https://sk.homesh.top"
echo ""

# 清理
cd - > /dev/null
rm -rf "$TEMP_DIR"
