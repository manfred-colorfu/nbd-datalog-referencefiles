#!/bin/bash

echo "run_disc.sh <image file>"

if [ $# -ne 1 ]; then
	exit 1;
fi

cp $1 /tmp/run_disc-$$.img

qemu-system-x86_64 -s -serial stdio -m 1400 -snapshot -append "console=ttyS0 security=selinux ipcmni_extend" -net user -net nic,model=rtl8139 -kernel ~/git/linux/arch/x86/boot/bzImage -initrd ~/git/ramfs/ramfs -hda /tmp/run_disc-$$.img

rm -f /tmp/run_disc-$$.img
