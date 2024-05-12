FROM alpine:3.19.1

RUN apk add gcc git linux-headers musl-dev python3 python3-dev py3-pip

WORKDIR /opt
RUN git clone https://github.com/openstack/nova.git
WORKDIR /opt/nova
RUN git checkout 26.3.0
RUN echo 'sqlalchemy<2.0' >>/opt/nova/requirements.txt
RUN pip3 install -r requirements.txt --break-system-packages
RUN pip3 install PyMySQL uwsgi --break-system-packages
RUN python3 setup.py install

RUN addgroup nova
RUN adduser -S -s /sbin/nologin -G nova nova

RUN mkdir /etc/nova
RUN chown -R nova.nova /etc/nova

USER nova

RUN cp /opt/nova/etc/nova/api-paste.ini /etc/nova/
