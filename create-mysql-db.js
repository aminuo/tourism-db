const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const config = {
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: 'Admin123@',
  database: 'tourism_db'
};

function runMySQLCommand(sql, callback) {
  const escapedPassword = config.password ? `-p"${config.password}"` : '';
  const command = `"C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -h ${config.host} -P ${config.port} -u ${config.user} ${escapedPassword} -e "${sql}"`;
  
  exec(command, { windowsHide: true }, (error, stdout, stderr) => {
    if (error) {
      callback(error, stderr);
    } else {
      callback(null, stdout.trim());
    }
  });
}

function importSQLFile(filePath, callback) {
  const escapedPassword = config.password ? `-p"${config.password}"` : '';
  const command = `"C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -h ${config.host} -P ${config.port} -u ${config.user} ${escapedPassword} ${config.database} < "${filePath}"`;
  
  exec(command, { windowsHide: true }, (error, stdout, stderr) => {
    if (error) {
      callback(error, stderr);
    } else {
      callback(null, stdout.trim());
    }
  });
}

console.log('=== MySQL 数据库创建和数据导入 ===');
console.log('');
console.log('提示: 如果密码不正确，请修改脚本中的 password 变量');
console.log('');
console.log('配置信息:');
console.log(`  主机: ${config.host}`);
console.log(`  端口: ${config.port}`);
console.log(`  用户: ${config.user}`);
console.log(`  数据库: ${config.database}`);
console.log('');

runMySQLCommand(`DROP DATABASE IF EXISTS ${config.database}; CREATE DATABASE IF NOT EXISTS ${config.database} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`, (err, stderr) => {
  if (err) {
    console.error('❌ 创建数据库失败');
    console.error('错误信息:', stderr || err.message);
    console.log('');
    console.log('请手动执行以下 SQL 命令:');
    console.log('');
    console.log('1. 登录 MySQL:');
    console.log(`   "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -h ${config.host} -P ${config.port} -u ${config.user} -p`);
    console.log('');
    console.log('2. 创建数据库:');
    console.log(`   CREATE DATABASE IF NOT EXISTS ${config.database} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`);
    console.log('');
    console.log('3. 使用数据库:');
    console.log(`   USE ${config.database};`);
    console.log('');
    console.log('4. 导入数据:');
    console.log(`   source ${path.join(__dirname, 'tourism_data_mysql.sql').replace(/\\/g, '/')};`);
    process.exit(1);
  }
  
  console.log('✅ 数据库创建成功');
  
  const sqlFilePath = path.join(__dirname, 'tourism_data_mysql.sql');
  
  if (!fs.existsSync(sqlFilePath)) {
    console.error('❌ SQL 文件不存在:', sqlFilePath);
    process.exit(1);
  }
  
  importSQLFile(sqlFilePath, (err, stderr) => {
    if (err) {
      console.error('❌ 导入数据失败');
      console.error('错误信息:', stderr || err.message);
      console.log('');
      console.log('请手动执行以下 SQL 命令导入数据:');
      console.log(`   source ${path.join(__dirname, 'tourism_data_mysql.sql').replace(/\\/g, '/')};`);
      process.exit(1);
    }
    
    console.log('✅ 数据导入成功');
    console.log('');
    console.log('=== 数据库创建完成 ===');
    console.log('数据库连接信息:');
    console.log(`  Host: ${config.host}`);
    console.log(`  Port: ${config.port}`);
    console.log(`  Database: ${config.database}`);
    console.log(`  Username: ${config.user}`);
  });
});