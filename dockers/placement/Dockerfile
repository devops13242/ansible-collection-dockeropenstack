FROM alpine:3.19.1

RUN apk add gcc git linux-headers musl-dev python3 python3-dev py3-pip

WORKDIR /opt
RUN git clone https://github.com/openstack/placement.git
WORKDIR /opt/placement
RUN git checkout 11.0.0
RUN pip3 install -r requirements.txt --break-system-packages
RUN pip3 install PyMySQL uwsgi --break-system-packages
RUN python3 setup.py install

RUN addgroup placement
RUN adduser -S -s /sbin/nologin -G placement placement

RUN mkdir /etc/placement
RUN chown -R placement.placement /etc/placement

COPY docker-entrypoint.sh /

USER placement
CMD ash -x /docker-entrypoint.sh