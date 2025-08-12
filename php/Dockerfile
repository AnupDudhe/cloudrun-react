FROM php:8.2-apache
WORKDIR /var/www/html

# Pull sample PHP repo
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/heroku/php-getting-started.git php-source
COPY php-source/. .

# Change Apache to use port 8080 for Cloud Run
RUN sed -i 's/80/8080/' /etc/apache2/sites-available/000-default.conf \
    && sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
EXPOSE 8080
CMD ["apache2-foreground"]
