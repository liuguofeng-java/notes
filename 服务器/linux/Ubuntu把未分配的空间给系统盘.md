## Ubuntu把未分配的空间给系统盘

##### 1.查看卷组的状态和配置信息，以及可用的空间和已分配的空间

> 其中`Alloc PE / Size`:已分配，`Free  PE / Size`:未分配

```sh
root@k8s-master:~# sudo vgdisplay ubuntu-vg
  --- Volume group ---
  VG Name               ubuntu-vg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <38.00 GiB
  PE Size               4.00 MiB
  Total PE              9727
  Alloc PE / Size       4863 / <19.00 GiB
  Free  PE / Size       4864 / 19.00 GiB
  VG UUID               aA0Zcj-S2r8-MMg9-P3uc-J7RW-h2Z0-xEnbsn

```

##### 2.查看已分配空间

> 其中 `/dev/mapper/ubuntu--vg-ubuntu--lv` 是已分配总空间

```sh
root@k8s-master:~# df -lh
Filesystem                         Size  Used Avail Use% Mounted on
tmpfs                              388M  3.2M  385M   1% /run
/dev/mapper/ubuntu--vg-ubuntu--lv   19G   17G  874M  96% /
tmpfs                              1.9G     0  1.9G   0% /dev/shm
tmpfs                              5.0M     0  5.0M   0% /run/lock
/dev/sda2                          2.0G  251M  1.6G  14% /boot
tmpfs                              388M  4.0K  388M   1% /run/user/0
```

##### 3.分配剩余空间

> - lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv：这个命令会将所有未分配的空间 添加到你的逻辑卷/dev/mapper/ubuntu--vg-ubuntu--lv中。
>
> - resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv：这个命令会调整文件系统的大小以适应新的逻辑卷大小。
>
> 执行完这两个命令后，你可以再次使用sudo df -lh命令来查看硬盘的情况，应该可以看到硬盘大小已经增加了。
>

```sh
root@k8s-master:~#  lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
  Size of logical volume ubuntu-vg/ubuntu-lv changed from <19.00 GiB (4863 extents) to <38.00 GiB (9727 extents).
  Logical volume ubuntu-vg/ubuntu-lv successfully resized.

root@k8s-master:~# resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/mapper/ubuntu--vg-ubuntu--lv is mounted on /; on-line resizing required
old_desc_blocks = 3, new_desc_blocks = 5
The filesystem on /dev/mapper/ubuntu--vg-ubuntu--lv is now 9960448 (4k) blocks long.
```

