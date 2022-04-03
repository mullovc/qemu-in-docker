#!/bin/bash
set -eu

kernel=/tmp/tmp.*/boot/vmlinuz
#initrd=/tmp/tmp.*/boot/initrd.img
#root="LABEL=vmroot"
root="/dev/vda"
cmdline="console=ttyS0 panic=1 root=$root" # rdinit=/bin/sh"
image="/vmimage.qcow2"
memory=${MEMORY:-4096}

qemu-system-x86_64 \
    -machine accel=kvm -cpu host \
    -m "$memory" \
    -nographic -serial mon:stdio -no-reboot \
    -kernel $kernel -append "$cmdline" \
    -nic user,model=virtio-net-pci \
    -drive if=virtio,file="$image"
