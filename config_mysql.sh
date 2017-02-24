__mysql_config() {
echo "Running the mysql_config function."
mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe &
sleep 10
}

__start_mysql() {
echo "Running the start_mysql function."
mysqladmin -u root password 'MYSQL_ROOT_PASS'
echo "Set pass admin : MYSQL_ROOT_PASS"
mysql -uroot -pMYSQL_ROOT_PASS -e "CREATE DATABASE MYSQL_DATABASE"
echo "create db: MYSQL_DATABASE"
killall mysqld
sleep 10
}

# Call all functions
__mysql_config
__start_mysql
