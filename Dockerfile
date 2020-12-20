FROM nextcloud:stable

RUN apt-get update; \
    apt-get install -y cron ffmpeg imagemagick ghostscript;

RUN update-rc.d cron defaults;

RUN crontab -u www-data -l > tmptab; \
    echo '*/10 * * * * /usr/local/bin/php -f /var/www/html/occ preview:pre-generate -vvv >> /var/log/preview.log 2>&1' >> tmptab; \
    crontab -u www-data tmptab; \
    rm tmptab;

RUN touch /var/log/preview.log; \
    chown www-data:www-data /var/log/preview.log;
