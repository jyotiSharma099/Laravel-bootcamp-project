FROM php:8.3-cli

# Install system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    nodejs \
    npm \
    libsqlite3-dev \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    && docker-php-ext-install \
        pdo \
        pdo_sqlite \
        mbstring \
        zip \
        intl \
        bcmath \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Create SQLite database
RUN mkdir -p database && \
    touch database/database.sqlite

# Install dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Install frontend dependencies and build assets
RUN npm install && npm run build

# Set permissions
RUN chmod -R 775 storage bootstrap/cache database

# Generate APP_KEY if not already present
RUN if grep -q "^APP_KEY=$" .env; then php artisan key:generate --force; fi

# Run migrations
RUN php artisan migrate --force

# Expose Laravel port
EXPOSE 8000

# Start Laravel development server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
