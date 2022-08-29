FROM nextcloud:23.0

RUN apt-get update && \
    apt-get install -y cron ffmpeg imagemagick ghostscript;

RUN sed '/domain="coder" rights="none" pattern="PDF"/ s/none/read|write/' /etc/ImageMagick-6/policy.xml > /tmp/policy.xml \
    && mv /tmp/policy.xml /etc/ImageMagick-6/policy.xml

RUN apt-get install -y supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

RUN crontab -u www-data -l > tmptab; \
    echo '*/10 * * * * /usr/local/bin/php -f /var/www/html/occ preview:pre-generate -vvv >> /var/log/preview.log 2>&1' >> tmptab; \
    crontab -u www-data tmptab; \
    rm tmptab;

RUN touch /var/log/preview.log && \
    chown www-data:www-data /var/log/preview.log;

ENV NEXTCLOUD_UPDATE=1

COPY sudo_env /etc/sudoers.d/
COPY supervisord.conf /

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
