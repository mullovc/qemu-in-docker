#!/bin/bash
set -eu

IMAGEBASE=/vmimage

NEWROOT=$(mktemp -d)
PARTSIZE=20480M
PACKAGES="linux-image-kvm"
# install specified packages if $EXTRA_PACKAGES is non-empty
PACKAGES="${PACKAGES}${EXTRA_PACKAGES:+,$EXTRA_PACKAGES}"

source /etc/os-release
debootstrap --components=main,universe --include="$PACKAGES" "$VERSION_CODENAME" "${NEWROOT}"

cp -r baseconfig/* "${NEWROOT}"/

mke2fs -L vmroot -d "${NEWROOT}" "${IMAGEBASE}.ext2" "${PARTSIZE}"
qemu-img convert -f raw -O qcow2 "${IMAGEBASE}.ext2" "${IMAGEBASE}.qcow2"
rm "${IMAGEBASE}.ext2"

# TODO copy kernel somewhere and then
#      `rm -rf "${NEWROOT}"`
