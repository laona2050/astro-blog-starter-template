#!/bin/bash
# Cloudflare 博客管理工具
# 用于管理部署在 Cloudflare Pages 上的 Astro 博客

set -e

# 配置
REPO_URL="https://github.com/laona2050/astro-blog-starter-template"
BLOG_DIR="./astro-blog-starter-template"
CONTENT_DIR="$BLOG_DIR/src/content/blog"
PUBLIC_DIR="$BLOG_DIR/public"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查 Git Token
check_git_token() {
    if [ -z "$GITHUB_TOKEN" ]; then
        print_error "请设置 GITHUB_TOKEN 环境变量"
        echo "使用方法：export GITHUB_TOKEN='ghp_xxxxxxxxxxxx'"
        exit 1
    fi
}

# 克隆或更新仓库
clone_or_update_repo() {
    if [ -d "$BLOG_DIR" ]; then
        print_info "更新仓库..."
        cd "$BLOG_DIR"
        git pull origin main
        cd - > /dev/null
    else
        print_info "克隆仓库..."
        git clone "https://${GITHUB_TOKEN}@github.com/laona2050/astro-blog-starter-template.git" "$BLOG_DIR"
    fi
}

# 创建新文章
create_post() {
    local title="$1"
    local content="$2"
    local date="${3:-$(date +%Y-%m-%d)}"
    local description="$4"
    
    # 生成文件名（将标题转换为英文文件名）
    local filename=$(echo "$title" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')
    filename="${filename}.md"
    
    print_info "创建文章：$title"
    
    # 创建 Markdown 文件
    cat > "$CONTENT_DIR/$filename" << EOF
---
title: '$title'
description: '$description'
pubDate: '$date'
---

$content

EOF
    
    print_success "文章文件已创建：$CONTENT_DIR/$filename"
}

# 修复 MDX 语法问题
fix_mdx_issues() {
    local file="$1"
    
    print_info "检查并修复 MDX 语法问题..."
    
    # 修复 < 符号后跟数字的问题
    if grep -q "<[0-9]" "$file"; then
        print_warning "发现 < 符号后跟数字，正在修复..."
        sed -i 's/<\([0-9]\)/小于\1/g' "$file"
    fi
    
    # 修复 HTML 注释
    if grep -q "<!--" "$file"; then
        print_warning "发现 HTML 注释，正在转换为 JSX 格式..."
        sed -i 's/<!-- /{/* /g; s/ -->/ *}/g' "$file"
        # 修复可能的格式问题
        sed -i 's/ \*}/ *}/g' "$file"
    fi
    
    print_success "MDX 语法检查完成"
}

# 提交并推送
commit_and_push() {
    local message="$1"
    
    cd "$BLOG_DIR"
    
    git config user.name "laona2050"
    git config user.email "laona2050@users.noreply.github.com"
    
    git add -A
    git commit -m "$message"
    
    print_info "推送到 GitHub..."
    git push origin main
    
    cd - > /dev/null
    
    print_success "推送成功！Cloudflare Pages 将自动部署"
    print_info "大约 2-5 分钟后可以在 https://homesh.top/ 查看更新"
}

# 上传图片
upload_image() {
    local image_path="$1"
    local image_name=$(basename "$image_path")
    
    print_info "上传图片：$image_name"
    
    cp "$image_path" "$PUBLIC_DIR/$image_name"
    
    print_success "图片已上传：$PUBLIC_DIR/$image_name"
    print_info "在文章中使用：![](/$image_name)"
}

# 显示帮助
show_help() {
    echo "Cloudflare 博客管理工具"
    echo ""
    echo "使用方法:"
    echo "  $0 <命令> [参数]"
    echo ""
    echo "命令:"
    echo "  post <标题> <描述> <内容文件>   创建新文章"
    echo "  image <图片路径>                上传图片"
    echo "  fix <文件路径>                  修复 MDX 语法问题"
    echo "  deploy <提交信息>               提交并推送更改"
    echo "  update                          更新本地仓库"
    echo "  help                            显示此帮助信息"
    echo ""
    echo "环境变量:"
    echo "  GITHUB_TOKEN    GitHub Personal Access Token (必需)"
    echo ""
    echo "示例:"
    echo "  export GITHUB_TOKEN='ghp_xxxxxxxxxxxx'"
    echo "  $0 post \"我的文章\" \"文章描述\" content.md"
    echo "  $0 image ./photo.jpg"
    echo "  $0 deploy \"发布新文章\""
}

# 主函数
main() {
    if [ $# -eq 0 ]; then
        show_help
        exit 0
    fi
    
    local command="$1"
    shift
    
    case "$command" in
        post)
            check_git_token
            clone_or_update_repo
            if [ $# -lt 3 ]; then
                print_error "用法：$0 post <标题> <描述> <内容文件>"
                exit 1
            fi
            local title="$1"
            local description="$2"
            local content_file="$3"
            local content=$(cat "$content_file")
            create_post "$title" "$content" "$(date +%Y-%m-%d)" "$description"
            fix_mdx_issues "$CONTENT_DIR/$(echo "$title" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]').md"
            commit_and_push "📝 新增：$title"
            ;;
        image)
            check_git_token
            clone_or_update_repo
            if [ $# -lt 1 ]; then
                print_error "用法：$0 image <图片路径>"
                exit 1
            fi
            upload_image "$1"
            commit_and_push "🖼️ 上传图片：$(basename "$1")"
            ;;
        fix)
            check_git_token
            if [ $# -lt 1 ]; then
                print_error "用法：$0 fix <文件路径>"
                exit 1
            fi
            fix_mdx_issues "$1"
            ;;
        deploy)
            check_git_token
            if [ $# -lt 1 ]; then
                print_error "用法：$0 deploy <提交信息>"
                exit 1
            fi
            commit_and_push "$1"
            ;;
        update)
            check_git_token
            clone_or_update_repo
            print_success "仓库已更新"
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "未知命令：$command"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
