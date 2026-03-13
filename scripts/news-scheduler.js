#!/usr/bin/env node
/**
 * CCTV 新闻联播定时任务调度器
 * 每天北京时间 6:00 (UTC 22:00) 执行
 */

const cron = require('node-cron');
const { exec } = require('child_process');
const path = require('path');

const WORKSPACE = process.env.HOME + '/.openclaw/workspace';
const SCRIPT = path.join(WORKSPACE, 'scripts/publish-cctv-wordpress.sh');

console.log('🦀 新闻联播调度器已启动');
console.log('⏰ 定时：每天 UTC 22:00 (北京时间 6:00)');

// UTC 22:00 = 北京时间 6:00
// cron 格式：秒 分 时 日 月 周
const task = cron.schedule('0 22 * * *', () => {
    console.log('\n📺 开始执行新闻联播任务...');
    console.log('📅 日期:', new Date().toISOString());
    
    exec(`bash ${SCRIPT}`, (error, stdout, stderr) => {
        if (error) {
            console.error('❌ 执行失败:', error.message);
            console.error(stderr);
            return;
        }
        console.log('✅ 执行完成');
        console.log(stdout);
    });
}, {
    timezone: 'UTC',
    scheduled: true
});

task.start();
console.log('✅ 调度器运行中，按 Ctrl+C 停止');

// 保持进程运行
process.on('SIGINT', () => {
    console.log('\n👋 调度器停止');
    task.stop();
    process.exit(0);
});
