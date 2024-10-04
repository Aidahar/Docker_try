FROM ubuntu/nginx

USER root

COPY ./server/nginx.conf /etc/nginx/nginx.conf

COPY ./server/my_server.c /home/my_server.c

COPY ./server/my_server.h /home/my_server.h

COPY ./run.sh /home/run.sh

RUN apt-get update && apt-get install -y gcc spawn-fcgi libfcgi-dev \ 
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /home/run.sh \
    && chown -R nginx:nginx /var/log/nginx/ \
    && chown -R nginx:nginx /var/lib/nginx/ \
    && chown -R nginx:nginx /home/ \
    && chown -R nginx:nginx /var/run/ \ 
    && chown -R nginx:nginx /home/run.sh \
    && chmod u-s /usr/bin/chfn \
    && chmod g-s /usr/bin/wall \
    && chmod u-s /bin/mount \
    && chmod u-s /usr/bin/chsh \
    && chmod g-s /usr/bin/chage \
    && chmod u-s /bin/umount \
    && chmod u-s /bin/su \
    && chmod u-s /usr/bin/newgrp \
    && chmod g-s /usr/bin/expiry \
    && chmod g-s /sbin/unix_chkpwd \
    && chmod u-s /usr/bin/gpasswd \
    && chmod u-s /usr/bin/passwd \
    && chmod g-s /usr/sbin/pam_extrausers_chkpwd

USER nginx

WORKDIR /home/

CMD [ "/home/run.sh" ]
CMD [ "export DOCKER_CONTENT_TRUST=1" ]

HEALTHCHECK CMD curl --fail http://localhost:81/status || exit 1
