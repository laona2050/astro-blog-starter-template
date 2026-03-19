# whisper.cpp 技能

## 描述

使用 OpenAI Whisper 进行语音识别（STT），支持多语言转录、音频转文字。

## 安装说明

由于系统限制，需要手动安装：

### 方法一：使用 Python（推荐）

```bash
# 安装 Python 和 pip（需要管理员权限）
apt-get install -y python3 python3-pip

# 安装 whisper
pip3 install openai-whisper

# 使用
whisper audio.wav --model base
```

### 方法二：使用预编译二进制

```bash
# 下载预编译版本
cd /home/node/.openclaw/workspace/skills
wget https://github.com/ggerganov/whisper.cpp/releases/download/binaries/whisper-bin-x64.zip
unzip whisper-bin-x64.zip
cd whisper.cpp
```

### 方法三：使用 Docker

```bash
docker run -it --rm -v $(pwd):/work ghcr.io/ggerganov/whisper.cpp:main
```

## 使用方法

### Python 版本

```bash
# 基本转录
whisper audio.wav --model base

# 指定语言
whisper audio.wav --model base --language zh

# 输出 SRT 字幕
whisper audio.wav --model base --output_format srt

# 输出多种格式
whisper audio.wav --model base --output_format srt,txt,vtt
```

### C++ 版本

```bash
# 转录音频
./main -m models/ggml-base.bin -f audio.wav

# 输出 SRT
./main -m models/ggml-base.bin -f audio.wav -osrt
```

## 模型选择

| 模型 | 大小 | 速度 | 准确率 | 适用场景 |
|------|------|------|--------|----------|
| tiny | 75 MB | 最快 | 一般 | 快速测试 |
| base | 142 MB | 快 | 较好 | 日常使用 |
| small | 466 MB | 中等 | 好 | 高质量需求 |
| medium | 1.5 GB | 慢 | 很好 | 专业转录 |
| large | 3 GB | 最慢 | 最佳 | 最高质量 |

## 支持语言

支持 99 种语言，包括：
- 中文（zh）
- 英语（en）
- 日语（ja）
- 韩语（ko）
- 法语（fr）
- 德语（de）
- 西班牙语（es）
- 等...

## 与 yt-dlp 配合使用

```bash
# 下载 YouTube 视频并转录
yt-dlp -x --audio-format wav <URL> -o temp.wav
whisper temp.wav --model base
rm temp.wav

# 一键处理
yt-dlp -x --audio-format wav <URL> -o temp.wav && \
  whisper temp.wav --model base --language zh && \
  rm temp.wav
```

## 注意事项

1. 首次使用需要下载模型（自动）
2. 模型越大准确率越高但速度越慢
3. 长音频建议分段处理
4. 需要较多内存（large 模型需要 8GB+）
5. 支持 GPU 加速（NVIDIA CUDA）

## 替代方案

如果无法安装 whisper.cpp，可使用：

1. **OpenAI API**：`pip install openai`
2. **Google Speech-to-Text**
3. **Azure Speech Service**
4. **在线服务**：如讯飞听见、网易见外等
