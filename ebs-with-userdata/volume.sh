<<<<<<< HEAD
#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sleep 30
sudo mkdir -p  /data
sleep 30
sudo mkfs.ext4 ${device_name}
sudo mount ${device_name} /data
=======
#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sleep 30
sudo mkdir -p  /data
sleep 30
sudo mkfs.ext4 /dev/xvdh
sudo mount /dev/xvdh /data
>>>>>>> 59a40dfafde6bc01cab380fc5f663dc7852dee9a
