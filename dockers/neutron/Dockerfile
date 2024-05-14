FROM alpine:3.19.1

RUN apk add gcc git linux-headers musl-dev python3 python3-dev py3-pip

WORKDIR /opt
RUN git clone https://github.com/openstack/neutron.git
WORKDIR /opt/neutron
RUN git checkout 24.0.0
RUN pip3 install -r requirements.txt --break-system-packages
RUN pip3 install PyMySQL --break-system-packages
RUN python3 setup.py install

RUN addgroup neutron
RUN adduser -S -s /sbin/nologin -G neutron neutron

RUN mkdir /etc/neutron
RUN chown -R neutron.neutron /etc/neutron

RUN mkdir /var/lib/neutron
RUN chown -R neutron.neutron /var/lib/neutron

USER neutron