mkdir /mnt/work
mkdir /mnt/share
mkdir /mnt/temp
echo "
/etc/fsstab
share                /mnt/share           vboxsf     rw,umask=0022,noauto,uid=1000,gid=100              0 0
work                 /mnt/work            vboxsf     rw,umask=0022,noauto,uid=1000,gid=100              0 0
temp                 /mnt/temp            vboxsf     rw,umask=0022,noauto,uid=1000,gid=100              0 0
"
sudo mount /mnt/work
sudo mount /mnt/share
sudo mount /mnt/temp

