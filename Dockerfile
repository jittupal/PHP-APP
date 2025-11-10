# Use official PHP Apache image
FROM php:8.1-apache

# Copy project files
COPY . /var/www/html/

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
