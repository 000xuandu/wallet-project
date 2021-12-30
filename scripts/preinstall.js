#!/usr/bin/env node
const childProcess = require('child_process');
const commands = ['kill -9 $(lsof -ti:8081)'];

async function runPreInstall() {
  if (commands.length > 0) {
    try {
      commands.forEach(command => {
        childProcess.execSync(command, {
          stdio: 'inherit',
        });
      });
    } catch (err) {
      process.exit(err);
    }
  }
}
runPreInstall();
