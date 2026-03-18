# yt-dlp 技能

## 描述

使用 yt-dlp 下载和转换 YouTube、Bilibili 等视频网站的视频和音频。

## 安装

```bash
# 安装 yt-dlp
npm install -g yt-dlp

# 或下载二进制文件
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
chmod a+rx /usr/local/bin/yt-dlp
```

## 使用方法

### 下载视频

```bash
# 下载视频（最佳质量）
yt-dlp <URL>

# 下载视频（指定格式）
yt-dlp -f bestvideo+bestaudio <URL>

# 下载到指定目录
yt-dlp -o "~/Videos/%(title)s.%(ext)s" <URL>
```

### 下载音频

```bash
# 提取音频（MP3）
yt-dlp -x --audio-format mp3 <URL>

# 提取音频（指定质量）
yt-dlp -x --audio-format mp3 --audio-quality 192K <URL>
```

### 常用参数

| 参数 | 说明 |
|------|------|
| `-f` | 选择格式 |
| `-x` | 提取音频 |
| `--audio-format` | 音频格式（mp3/m4a/opus 等） |
| `-o` | 输出文件名模板 |
| `--sub-lang` | 字幕语言 |
| `--write-sub` | 下载字幕 |
| `--embed-subs` | 嵌入字幕 |
| `-I` | 下载指定集数 |

## 支持网站

- YouTube
- Bilibili
- 抖音
- 快手
- 推特
- Instagram
- Facebook
- Vimeo
- 等 1000+ 网站

完整列表：https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md

## 示例

```bash
# 下载 YouTube 视频
yt-dlp https://www.youtube.com/watch?v=VIDEO_ID

# 下载 B 站视频
yt-dlp https://www.bilibili.com/video/BV1xx411c7mD

# 下载播放列表
yt-dlp https://www.youtube.com/playlist?list=PLAYLIST_ID

# 下载最高画质
yt-dlp -f bestvideo+bestaudio https://www.youtube.com/watch?v=VIDEO_ID

# 转换为 MP3
yt-dlp -x --audio-format mp3 https://www.youtube.com/watch?v=VIDEO_ID
```

## 注意事项

1. 请遵守各网站的版权和使用条款
2. 仅下载个人使用或授权的内容
3. 某些视频可能需要登录或付费
4. 下载大量内容时注意速率限制
