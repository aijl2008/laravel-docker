#!/usr/bin/php
<?php
if (php_sapi_name() != 'cli') {
    exit();
}
if (!isset($_SERVER["argv"][1])) {
    help();
}
if (!isset($_SERVER["argv"][2])) {
    help();
}
function help()
{
    echo "Usage: " . __FILE__ . " <sub-command> <domain>" . PHP_EOL;
    echo " sub-command laravel|CodeIgniter|default" . PHP_EOL;
    echo " domain ex:passport.artron.net" . PHP_EOL;
}

$template = file_get_contents('/etc/nginx/conf.d/default.conf');
$replace = [
    'listen       80 default_server;' ,
    'server_name  _;',
    'root         /data/webroot;',
    'autoindex on;'

];
$search = [
    'listen       80;',
    'server_name  _;',
    'root         /data/webroot/'.$_SERVER["argv"][2].'/public',
    'autoindex on;'
];
file_put_contents('/etc/nginx/conf.d/' . $_SERVER["argv"][2] . '.conf', str_replace($search, $replace, $template));
exec("/usr/sbin/nginx -s reload");
