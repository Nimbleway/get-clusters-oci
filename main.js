// Spawns a child process and runs main.sh inside it

const spawnSync = require('child_process').spawnSync;
const path = require("path");

const excludeFile = path.join(__dirname, 'excluded_cluster_list.txt');
const script = path.join(__dirname, 'entrypoint.sh');

const proc = spawnSync('bash', [script, excludeFile], {stdio: 'inherit'});
process.exit(proc.status);
