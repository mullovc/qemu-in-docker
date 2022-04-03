FROM ubuntu:21.10

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y --no-install-recommends \
    linux-image-kvm qemu-system-x86 qemu-utils \
    debootstrap ca-certificates gnupg

COPY mkimage.sh mkimage.sh
COPY baseconfig baseconfig

ARG EXTRA_PACKAGES
RUN EXTRA_PACKAGES="$EXTRA_PACKAGES" ./mkimage.sh

COPY start.sh start.sh
CMD ./start.sh
