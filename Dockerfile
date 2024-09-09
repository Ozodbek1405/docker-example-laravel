# 1. Use a base image with PHP
FROM php:8.1-fpm

# 2. Set working directory
WORKDIR /var/www/example

# 3. Install system dependencies and Redis extension
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && pecl install redis \
    && docker-php-ext-enable redis

# 4. Install PHP extensions required by Laravel
RUN docker-php-ext-install pdo pdo_mysql gd zip exif pcntl

# 5. Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 6. Copy the application code to the container
COPY . /var/www/example

# 7. Install Composer dependencies
RUN composer update

# 8. Expose the application port (for Nginx to use)
EXPOSE 9000

# 9. Specify the command to run when the container starts
CMD ["php-fpm"]
