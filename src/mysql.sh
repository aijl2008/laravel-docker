#!/bin/sh 
        files=\`ls /mysql\` 
        if [ -z \"\$files\" ];then 
            if [ ! \${MYSQL_PASSWORD} ]; then 
                MYSQL_PASSWORD='123456' 
            fi 
            /usr/sbin/mysqld --initialize 
            MYSQLOLDPASSWORD=\`awk -F \"localhost: \" '/A temporary/{print \$2}' /var/log/mysql/mysqld.log\` 
            /usr/sbin/mysqld & 
            echo -e \"[client] \\\n  password=\"\${MYSQLOLDPASSWORD}\" \\\n user=root\" > ~/.my.cnf 
            sleep 5s 
            /usr/bin/mysql --connect-expired-password -e \"set password=password('\$MYSQL_PASSWORD');update mysql.user set host='%' where user='root' && host='localhost';flush privileges;\" 
            echo -e \"[client] \\\n  password=\"\${MYSQL_PASSWORD}\" \\\n user=root\" > ~/.my.cnf 
        else 
            rm -rf /var/lib/mysql/mysql.sock.lock 
            /usr/sbin/mysqld 
        fi