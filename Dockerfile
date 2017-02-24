# https://hub.docker.com/_/centos/
#
FROM	centos:6

MAINTAINER	"luongle96/centos6-nginx-php7-laravel-phpmyadmin" <luongle96@gmail.com>


# command line install cac goi cai dat
RUN		yum clean all && \
			yum -y install epel-release && \
			yum -y install nginx
RUN		rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
RUN		rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN		yum install -y php70w php70w-opcache php70w-fpm php70w-cli php70w-pear php70w-pdo php70w-mysqlnd php70w-pgsql php70w-gd php70w-mbstring php70w-mcrypt php70w-xml; yum clean all
RUN		yum install -y mysql-server mysql phpmyadmin;	yum clean all
RUN		yum install -y nano supervisor;	yum clean all

RUN		mv /usr/share/phpMyAdmin /usr/share/nginx/html/phpmyadmin
RUN		rm -f /etc/php-fpm.d/www.conf
RUN		rm -f /etc/php.ini
RUN		rm -f /etc/nginx/conf.d/default.conf
ADD		php.ini /etc/
ADD		www.conf /etc/php-fpm.d/
ADD		default.conf /etc/nginx/conf.d/
ADD	 	my.cnf /etc/mysql/

# thong tin db
ENV 	MYSQL_ROOT_PASS=root
ENV		MYSQL_DATABASE=laravel

# add file config vao trong docker
ADD 	./start.sh /start.sh
ADD 	./config_mysql.sh /config_mysql.sh
ADD 	./supervisord.conf /etc/supervisord.conf
RUN chmod 755 /start.sh
RUN chmod 755 /config_mysql.sh

RUN sed -i 's/MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /config_mysql.sh && \
    sed -i 's/MYSQL_ROOT_PASS/'$MYSQL_ROOT_PASS'/g' /config_mysql.sh

# chay config
RUN /config_mysql.sh

# thu muc lam viec khi exec container
WORKDIR	/usr/share/nginx/html/public_html

EXPOSE  80 9999

CMD ["/bin/bash", "/start.sh"]

ENTRYPOINT service nginx start && service mysqld start && service php-fpm start && bash

RUN echo "finish build docker: MYSQL_DATABASE: $MYSQL_DATABASE, MYSQL pass ROOT: $MYSQL_ROOT_PASS"
