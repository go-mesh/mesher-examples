FROM php:5.6-apache
COPY ./client.php  /var/www/html

ENV Item pen

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
