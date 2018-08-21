mount -o loop /ubuntu-14.10-server-amd64.iso /mnt/
#cp -fr /mnt/install/netboot/* /var/lib/tftpboot
mkdir /var/www/html/ubuntu
cp -fr /mnt/* /var/www/html/ubuntu/
umount /mnt
cp -fr /var/www/html/ubuntu/install/netboot/ubuntu-installer /var/lib/tftpboot

