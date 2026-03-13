const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// Ensure local bin is in PATH for yt-dlp
process.env.PATH = process.env.PATH + ':/home/ryanmccormick/.local/bin';

const url = process.argv[2];
if (!url) {
    console.error("Usage: node fetch-transcript.js <youtube-url>");
    process.exit(1);
}

const tmpDir = fs.mkdtempSync('/tmp/yt-dlp-');
try {
    // Run yt-dlp to get English subs (auto or manual) in json3 format
    execSync(`yt-dlp --write-auto-subs --write-subs --sub-langs en --skip-download --sub-format json3 -o "${tmpDir}/transcript" "${url}"`, { stdio: 'pipe' });

    const files = fs.readdirSync(tmpDir);
    const jsonFile = files.find(f => f.endsWith('.json3'));

    if (!jsonFile) {
        console.error("No transcript found.");
        process.exit(1);
    }

    const data = JSON.parse(fs.readFileSync(path.join(tmpDir, jsonFile), 'utf8'));
    let text = '';
    if (data.events) {
        data.events.forEach(e => {
            if (e.segs) {
                e.segs.forEach(s => {
                    if (s.utf8 && s.utf8 !== '\n') text += s.utf8;
                });
            }
            text += ' ';
        });
    }
    
    console.log(text.replace(/\s+/g, ' ').trim());
} catch (err) {
    console.error("Error fetching transcript:", err.message);
} finally {
    fs.rmSync(tmpDir, { recursive: true, force: true });
}
