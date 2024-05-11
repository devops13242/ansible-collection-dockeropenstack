FROM alpine:3.19.1

RUN apk add git gcc linux-headers musl-dev python3 python3-dev py3-pip

WORKDIR /opt
RUN git clone https://github.com/openstack/glance.git
WORKDIR /opt/glance
RUN git checkout 28.0.1
RUN pip3 install -r requirements.txt --break-system-packages
RUN pip3 install PyMySQL --break-system-packages
RUN python3 setup.py install

RUN addgroup glance
RUN adduser -S -s /sbin/nologin -G glance glance

RUN mkdir /etc/glance
RUN cp /opt/glance/etc/glance-api-paste.ini /etc/glance
RUN chown -R glance.glance /etc/glance

COPY docker-entrypoint.sh /

WORKDIR /

CMD ash -x /docker-entrypoint.sh