FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apt-get update && \
    apt-get install -y \
    zip \
    unzip \
    p7zip-full \
    git \
    bind9 \
    php8.1 \
    php8.1-curl \
    curl


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./app /app

WORKDIR /app

RUN composer install

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose DNS port
EXPOSE 53

# Copy configuration files
COPY named.conf /etc/bind/named.conf
COPY db.domain.com /etc/bind/db.domain.com

RUN sed -i 's/ns-sub/sub-d/g' /etc/bind/db.domain.com
RUN sed -i 's/ip-server/ip-sv/g' /etc/bind/db.domain.com
RUN sed -i 's/my-domain/my-dd/g' /etc/bind/named.conf
RUN sed -i 's/my-domain/my-dd/g' /etc/bind/db.domain.com
RUN mkdir /var/log/named
RUN touch /var/log/named/named.log
RUN chown bind /var/log/named


# Start named service
CMD /bin/bash -c "named & tail -n 0 -f \"/var/log/named/named.log\" | while read line; do q=\$(echo \$line | grep -ioE '\(.*?\.my-d-es\):' | sed 's/[\(\):]//g'); echo \$q | php /app/index.php; done"
