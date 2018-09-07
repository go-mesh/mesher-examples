FROM php:5.6-apache
COPY ./api.php  /var/www/html
COPY ./data.php /var/www/html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
