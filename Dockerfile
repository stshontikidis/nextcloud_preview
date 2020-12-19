FROM nextcloud:stable

RUN apt-get update; \
    apt-get instal -y ffmpeg imagemagick ghostscript;

RUN touch /var/log/preview.log; \
    chown www-data:www-data /var/log/preview.log;

RUN echo '*/10 * * * * /usr/local/bin/php /var/www/html/occ preview:pre-generate -vvv >> /var/log/preview.log 2>&1' >> /var/spool/cron/crontabs/www-data