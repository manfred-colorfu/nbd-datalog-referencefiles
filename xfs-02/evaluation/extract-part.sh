#!/bin/bash

echo "extrace-part.sh <start> <len> [image-files]"

if [ $# -le 2 ]; then
	exit 1;
fi

do_file() {
# $1: start offset
# $2: len
# $3: input file
	offset=$(echo $1 | awk '{printf("%x", $1);}')
	dd if=$3 of=$3-$offset.bin bs=1 skip=$1 count=$2
	hexdump -C < $3-$offset.bin > $3-$offset.txt
}

start=$1
shift 1
len=$1
shift 1
for i in "$@";do
	do_file $start $len "$i";
done
