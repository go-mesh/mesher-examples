FROM php:5.6-apache
COPY ./consumer.php  /var/www/html

ENV Item pen

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
