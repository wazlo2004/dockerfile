FROM ubuntu:14.04

MAINTAINER wazlo200444@gmail.com 

RUN apt-get update
RUN apt-get upgrade -y

# nginx 1.8.1 php5

RUN  apt-get install software-properties-common python-software-properties  -y
RUN  apt-get install python-software-properties
RUN  add-apt-repository ppa:nginx/stable
RUN  apt-get update
RUN  apt-get upgrade -y
RUN  apt-get install nginx  -y
RUN  apt-get install php5-fpm -y
RUN  apt-get install php5-mysql -y
RUN  apt-get install php5-gd -y
RUN  apt-get install php5-cli -y

RUN apt-get install nano wget  git -y
RUN  mkdir -p /usr/share/nginx/www


# drush
RUN wget http://files.drush.org/drush.phar
RUN php drush.phar core-status
RUN chmod +x drush.phar
RUN sudo mv drush.phar /usr/local/bin/drush
RUN drush init -y



# mysql

 RUN apt-get update \
    && apt-get install -y debconf-utils \
    && echo mysql-server mysql-server/root_password password  YOURPASSWORD | debconf-set-selections \
    && echo mysql-server mysql-server/root_password_again password YOURPASSWORD | debconf-set-selections \
    && apt-get install -y mysql-server 
 
EXPOSE 80

#啟動檔設定檔
ADD  www.conf  /etc/php5/fpm/pool.d/www.conf
ADD  php.ini    /etc/php5/fpm/php.ini
ADD  default   /etc/nginx/sites-available/default
ADD  my.cnf    /etc/mysql/my.cnf
ADD  bash.bashrc  /etc/bash.bashrc
ADD  1.sh  /

