#!/bin/sh

do_test() {
# $1: block count limit
	cp /home/manfred/git/manfred/nbd-xsmall/V02/image.initial data-$1.img
	chmod 664 data-$1.img
	nbd-trplay -vvvvvv -i data-$1.img -m $1 -l /home/manfred/git/manfred/nbd-xsmall/V02/output.tr -b 512
	md5sum data-$1.img
}

for i in "$@";do
	do_test $i > imagegen-log-$i.txt 2>&1
done
