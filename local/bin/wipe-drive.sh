#!/usr/bin/env bash
set -x
set -e

device=$1
tmpname=$(tempfile)
mappername=${tmpname//\//}

echo "Mapper /dev/mapper/$mappername"

cryptsetup luksFormat "$device"
cryptsetup luksOpen "$device" "$mappername"

num_bytes=$(blockdev --getsize64 /dev/sdc)
pv --size $num_bytes --stop-at-size \
	< /dev/zero \
	> "/dev/mapper/$mappername"

cryptsetup luksClose "/dev/mapper/$mappername"
dd if=/dev/urandom of=$device bs=512 count=2056

echo "Done."
