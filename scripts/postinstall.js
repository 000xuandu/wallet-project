#!/usr/bin/env node
const childProcess = require('child_process');
const commands = ['bundle install', 'npx pod-install', 'npx react-native link'];

async function runPostInstall() {
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
runPostInstall();
