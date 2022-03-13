#!/bin/sh

do_test() {
# $1: block count limit
	dmesg --clear
	cp /home/manfred/git/manfred/nbd-xsmall/V02/image.initial /tmp/data-$$.img
	chmod 664 /tmp/data-$$.img
	nbd-trplay -vvvvvv -i /tmp/data-$$.img -m $1 -l /home/manfred/git/manfred/nbd-xsmall/V02/output.tr -b 512
	md5sum /tmp/data-$$.img
	mkdir -p x
	losetup --all
	losetup /dev/loop0 /tmp/data-$$.img
	losetup --all
	mount -t auto /dev/loop0 x
	sync
	sleep 3;
	sync;
	umount x
	sync
	sleep 1;
	xfs_repair -v -n /dev/loop0
	mount -t auto /dev/loop0 x
	mkdir x/linux-2.2.26/abc x/abc/def -p
	find x
	rm x/linux-2.26/kernel -Rf
	chmod 555 x/linux-2.2.26/*/*
	umount x
	sleep 1;
	xfs_repair -v -n /dev/loop0
	sleep 1;
	losetup -d /dev/loop0
	losetup --all
	rm /tmp/data-$$.img
	dmesg
}

for i in "$@";do
	do_test $i > log-$i.txt 2>&1
done
