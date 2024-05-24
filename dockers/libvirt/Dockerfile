FROM alpine:3.19.1

RUN apk add libvirt libvirt-daemon qemu-system-x86_64 dbus-openrc openrc dbus

RUN rc-update add dbus
RUN rc-update add virtqemud
RUN rc-update add virtnetworkd

RUN addgroup -g 1000 virt
RUN adduser -S -s /sbin/nologin -G libvirt libvirt

CMD init
