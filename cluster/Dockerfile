FROM redis:7.0

COPY redis-cluster.tmpl /usr/local/etc/redis/redis-cluster.tmpl

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 6379 16379

ENTRYPOINT ["entrypoint.sh"]
