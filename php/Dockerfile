FROM rafikfarhad/php:1.0.0

# Configure Environmental variable
ARG SOURCE_PATH
ENV SOURCE_PATH ${SOURCE_PATH}

# Copy composer.lock and composer.json
COPY $SOURCE_PATH/composer.lock $SOURCE_PATH/composer.json /var/www/___/

# Copy existing application directory contents
# COPY $SOURCE_PATH /var/www/___

# Copy existing application directory permissions
COPY --chown=www:www $SOURCE_PATH /var/www/___

