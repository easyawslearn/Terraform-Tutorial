#! /bin/bash
sudo mkdir /data
sudo mkfs.ext4 ${device_name}
mount ${device_name} /data
