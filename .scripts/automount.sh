#!/bin/env bash
# For some reason, KDE does not mount my external SSD on login despite the setting being correct
# So this script just does that
# Also for some reason is destroys the /dev block if dolphin unmounts all partition of the disk
# meaning I have to use the terminal

#@TODO: udisk has stated their api with udiskctl is not stable and shouldn't be used
# in scripts, BUT I'm just trying to get something to work. In the future to use dbus-send,
# but this isn't a production app, it's a script where I hardcode the uuid 

# by main SSD partition
udisksctl mount -t ext4 -b /dev/disk/by-uuid/6432552d-bebc-4d85-8d58-f5a719a08b7c --no-user-interaction
# A partition I use to put games on
udisksctl mount -t ext4 -b /dev/disk/by-uuid/f599f69a-6980-4f3f-90a6-02fda70ad01f --no-user-interaction

# The reason I don't use mount is cause I want it to be in the proper /run/media/$USER/<label>
# (altho I have a symlink link /mnt/b to my main SSD but that's cause I'm stubborn on a habit)

# exit explicitly as it may not be plugged in
exit 0