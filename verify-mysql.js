const { exec } = require('child_process');

const config = {
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: 'Admin123@',
  database: 'tourism_db'
};

const commands = [
  'SELECT COUNT(*) as scenic_count FROM scenic_spots',
  'SELECT COUNT(*) as user_count FROM users',
  'SELECT COUNT(*) as comment_count FROM scenic_comment',
  'SELECT COUNT(*) as tag_count FROM tag_category1',
  'SELECT title, view_count FROM scenic_spots LIMIT 3'
];

commands.forEach(sql => {
  const escapedPassword = config.password ? `-p"${config.password}"` : '';
  const command = `"C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysql.exe" -h ${config.host} -P ${config.port} -u ${config.user} ${escapedPassword} ${config.database} -e "${sql}"`;
  
  exec(command, { windowsHide: true }, (error, stdout) => {
    if (error) {
      console.error(`❌ 执行失败: ${sql}`);
    } else {
      console.log(`\n📊 ${sql}`);
      console.log('----------------------------------------');
      console.log(stdout.trim());
    }
  });
});