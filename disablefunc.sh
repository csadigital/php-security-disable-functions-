
echo "Php Güvenlik Ayarları Yapılıyor"

php_ini_settings=(
  "memory_limit = 1024M"
  "enable_dl = Off"
  "expose_php = Off"
  "register_globals = Off"
  "magic_quotes_gpc = Off"
  "disable_functions = shell_exec,symlink,restore_ini,hopenbasedir,f_open,system,dl,passthru,cat exec,popen,proc_close,proc_get_status,proc_nice,proc_open,escapeshellcmd,escapeshellarg,show_source,posix_mkfifo,mysql_list_dbs,get_current_user,getmyuid,pconnect,link,symlink,pcntl_exec,leak,apache_child_terminate,posix_kill,posix_setpgid,posix_setsid,posix_setuid,proc_terminate,syslog,fpassthru,socket_select,socket_create,socket_create_listen,socket_create_pair,socket_listen,socket_accept,socket_bind,foreach,socket_strerror,pcntl_fork,pcntl_signal,pcntl_waitpid,pcntl_wexitstatus,pcntl_wifexited,pcntl_wifsignaled,pcntl_wifstopped,pcntl_wstopsig,pcntl_wtermsig,openlog,apache_get_modules,apache_get_version,apache_getenv,apache_note,apache_setenv,virtual,mail,phpmaildisable_functions = shell_exec,symlink,restore_ini,hopenbasedir,f_open,system,dl,passthru,cat exec,popen,proc_close,proc_get_status,proc_nice,proc_open,escapeshellcmd,escapeshellarg,show_source,posix_mkfifo,mysql_list_dbs,get_current_user,getmyuid,pconnect,link,symlink,pcntl_exec,leak,apache_child_terminate,posix_kill,posix_setpgid,posix_setsid,posix_setuid,proc_terminate,syslog,fpassthru,socket_select,socket_create,socket_create_listen,socket_create_pair,socket_listen,socket_accept,socket_bind,foreach,socket_strerror,pcntl_fork,pcntl_signal,pcntl_waitpid,pcntl_wexitstatus,pcntl_wifexited,pcntl_wifsignaled,pcntl_wifstopped,pcntl_wstopsig,pcntl_wtermsig,openlog,apache_get_modules,apache_get_version,apache_getenv,apache_note,apache_setenv,virtual,mail,phpmail"
  "upload_max_filesize = 900M"
  "post_max_size = 128M"
  "date.timezone = \"America/Argentina/Buenos_Aires\""
  "allow_url_fopen = Off"
  "max_execution_time = 200"
  "max_input_time = -1"
  "max_input_vars = 3000"
  "default_charset = \"UTF-8\""
  "display_errors = Off"
  "track_errors = Off"
  "html_errors = Off"
  "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT"
  "session.cookie_httponly = 1"
  "session.cookie_secure = 1"
  "session.use_strict_mode = 1"
  "session.use_only_cookies = 1"
  "session.cookie_samesite = \"Strict\""
  "open_basedir = \"/var/www/:/tmp/:/usr/share/php/:/usr/share/pear/:/var/lib/php/:/usr/bin/\""
)

for setting in "${php_ini_settings[@]}"; do
  escaped_setting=$(echo "$setting" | sed 's/[\/&]/\\&/g')
  find /opt/ \( -name "php.ini" -o -name "local.ini" \) -exec sed -i "s/^\(${setting%%=*}.*\)/${escaped_setting}/g" {} \;
done

echo "Setting default PHP-FPM values..."

mkdir -p /var/cpanel/ApachePHPFPM
cat > /var/cpanel/ApachePHPFPM/system_pool_defaults.yaml << EOF
---
pm_max_children: 20
pm_max_requests: 40
php_admin_value_disable_functions : { present_ifdefault: 0 }
EOF

echo "disable_functions = shell_exec,symlink,restore_ini,hopenbasedir,f_open,system,dl,passthru,cat,exec,popen,proc_close,proc_get_status,proc_nice,proc_open,escapeshellcmd,escapeshellarg,show_source,posix_mkfifo,mysql_list_dbs,get_current_user,getmyuid,pconnect,link,symlink,pcntl_exec,leak,apache_child_terminate,posix_kill,posix_setpgid,posix_setsid,posix_setuid,proc_terminate,syslog,fpassthru,socket_select,socket_create,socket_create_listen,socket_create_pair,socket_listen,socket_accept,socket_bind,foreach,socket_strerror,pcntl_fork,pcntl_signal,pcntl_waitpid,pcntl_wexitstatus,pcntl_wifexited,pcntl_wifsignaled,pcntl_wifstopped,pcntl_wstopsig,openlog,apache_get_modules,apache_get_version,apache_getenv,apache_note,apache_setenv,virtual,mail,phpmail" >> /var/cpanel/ApachePHPFPM/system_pool_defaults.yaml

echo "Php Güvenlik Ayarları Yapıldı - CSA Digital"
