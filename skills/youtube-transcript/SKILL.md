---
name: youtube-transcript
description: Fetch and extract English transcripts from YouTube videos using yt-dlp. Use this skill when you need to read, summarize, or extract text from a YouTube video URL.
metadata:
  openclaw:
    emoji: "🎥"
    requires:
      bins: ["node", "yt-dlp"]
    install:
      - id: download-script
        kind: exec
        command: "curl -sL https://raw.githubusercontent.com/ryanmcc09-dot/openclaw-youtube-transcript/master/fetch-transcript.js -o {baseDir}/fetch-transcript.js"
---

# YouTube Transcript Skill

This skill allows you to extract the English transcript (auto-generated or manual) from a YouTube video. It relies on the `yt-dlp` executable.

## Requirements
- Node.js (`node`)
- `yt-dlp` installed on the host machine and accessible in the PATH.

## Usage

Use the `exec` tool to run the extraction script:

```bash
node {baseDir}/fetch-transcript.js "<youtube-url>"
```

### Handling Long Transcripts

If the video is long, the transcript could be massive. It is safer to pipe the output to a temporary file, then use the `read` tool:

```bash
node {baseDir}/fetch-transcript.js "<youtube-url>" > /tmp/transcript.txt
```
