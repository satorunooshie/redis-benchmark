FROM redis:7.0

COPY redis.conf /usr/local/etc/redis/redis.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 6379 6380

ENTRYPOINT ["entrypoint.sh"]
