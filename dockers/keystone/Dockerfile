FROM alpine:3.19.1

RUN apk add apache2 apache2-mod-wsgi git gcc linux-headers musl-dev python3 python3-dev py3-pip

WORKDIR /opt
RUN git clone https://github.com/openstack/keystone.git
WORKDIR /opt/keystone
RUN git checkout 25.0.0
RUN pip3 install -r requirements.txt --break-system-packages
RUN pip3 install PyMySQL --break-system-packages
RUN python3 setup.py install

RUN addgroup keystone
RUN adduser -S -s /sbin/nologin -G keystone keystone 

RUN  echo "ServerName keystone" >> /etc/apache2/httpd.conf

RUN mkdir /etc/keystone
RUN chown -R keystone.keystone /etc/keystone

COPY wsgi-keystone.conf /etc/apache2/conf.d/
COPY docker-entrypoint.sh /

WORKDIR /

CMD ash -x /docker-entrypoint.sh