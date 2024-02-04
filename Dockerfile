# Use the official MariaDB image
FROM mariadb:10.5

# Set environment variables for MariaDB
ENV MYSQL_DATABASE=panel \
    MYSQL_USER=pterodactyl \
    MYSQL_PASSWORD=CHANGE_ME \
    MYSQL_ROOT_PASSWORD=CHANGE_ME_TOO

# Create volume for MariaDB data
VOLUME /var/lib/mysql

# Use the official Redis image for cache
FROM redis:alpine

# Use the official Pterodactyl Panel image
FROM ghcr.io/pterodactyl/panel:latest

# Set environment variables for the Panel
ENV APP_URL=https://pterodactyl.example.com \
    APP_TIMEZONE=UTC \
    APP_SERVICE_AUTHOR=noreply@example.com \
    TRUSTED_PROXIES=* \
    LE_EMAIL="" \
    DB_PASSWORD=CHANGE_ME \
    APP_ENV=production \
    APP_ENVIRONMENT_ONLY=false \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    QUEUE_DRIVER=redis \
    REDIS_HOST=cache \
    DB_HOST=database \
    DB_PORT=3306 \
    MAIL_FROM=noreply@example.com \
    MAIL_DRIVER=smtp \
    MAIL_HOST=mail \
    MAIL_PORT=1025 \
    MAIL_USERNAME="" \
    MAIL_PASSWORD="" \
    MAIL_ENCRYPTION=true

# Expose ports for the Panel
EXPOSE 80 443

# Create volumes for Panel data
VOLUME /app/var/ /etc/nginx/http.d/ /etc/letsencrypt/ /app/storage/logs

# Start the services
CMD ["./entrypoint.sh"]
