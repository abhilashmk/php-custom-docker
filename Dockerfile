FROM php:7.2-apache
COPY . /var/www/html
COPY init_container.sh /bin
RUN chmod 755 /bin/init_container.sh
RUN chmod 777 /var/www/html

ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
		&& apt-get install -y --no-install-recommends dialog \
        && apt-get update \
	&& apt-get install -y --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd

COPY sshd_config /etc/ssh/

EXPOSE 80 2222
ENTRYPOINT ["/bin/init_container.sh"]