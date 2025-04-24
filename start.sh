#!/bin/sh
: ${MTR_TARGET:=8.8.8.8}

while true; do
	mtr ${MTR_TARGET} --no-dns --gracetime 1 --report --csv -c 10 | grep -v "Mtr_Version,"
done
