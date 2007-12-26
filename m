From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: Fwd: -rt and PowerPC
Date: Wed, 26 Dec 2007 09:53:25 +0530
Message-ID: <20071226042325.GA23220@hells-kitchen.in.ibm.com>
References: <200712241140.00738.sripathik@in.ibm.com> <562556514-1198501255-cardhu_decombobulator_blackberry.rim.net-1487612076-@bxe137.bisx.prod.on.blackberry>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sripathi Kodi <sripathik@in.ibm.com>,
	linux-rt-users@vger.kernel.org
To: sven@thebigcorporation.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP02.au.ibm.com ([202.81.18.163]:33973 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbXLZJ3x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Dec 2007 04:29:53 -0500
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id lBQ8EpnN021164
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Dec 2007 19:14:51 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lBQ8IHUk160594
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Dec 2007 19:18:17 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lBQ8Eekr020029
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Dec 2007 19:14:40 +1100
Received: from hells-kitchen ([9.124.217.105])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id lBQ8EbB0019997
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Dec 2007 19:14:38 +1100
Content-Disposition: inline
In-Reply-To: <562556514-1198501255-cardhu_decombobulator_blackberry.rim.net-1487612076-@bxe137.bisx.prod.on.blackberry>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* sven@thebigcorporation.com <sven@thebigcorporation.com> [2007-12-24 1=
3:00:30]:

Hi,
> Do you have DEBUG and LOCKDEP configured?
CONFIG_PREEMPT_DEBUG is enabled
but LOCKDEP is not.
> Sven
> Sent via BlackBerry by AT&T
>=20
> -----Original Message-----
> From:	Sripathi Kodi <sripathik@in.ibm.com>
>=20
> Date:	Mon, 24 Dec 2007 11:40:00=20
> To:linux-rt-users@vger.kernel.org
> Cc:Chirag Jog <chirag@linux.vnet.ibm.com>
> Subject: Fwd: -rt and PowerPC
>=20
>=20
> Hi,
>=20
> Chirag sent the following mail 3 times to linux-rt-users, but it does=
n't seem=20
> to be working. Hence trying from my id.
>=20
> Thanks,
> Sripathi.
>=20
> ----------  Forwarded Message  ----------
>=20
> Subject: -rt and PowerPC
> Date: Monday 24 December 2007 10:30
> From: Chirag Jog <chirag@linux.vnet.ibm.com>
> To: linux-rt-users <linux-rt-users@vger.kernel.org>
> Cc: Sripathi Kodi <sripathik@in.ibm.com>, Dinakar Guniguntala=20
> <dino@in.ibm.com>
>=20
> Hi,
>     We are trying to get a ppc64 box booted with the -rt kernel.
>=20
>     Tried the latest 2.6.24-rc5-rt1 kernel.
>=20
>     Everything goes well [ kernel boots up etc] until the services
>     start coming up.
>     It takes a lot of time at Starting udev.
>     After which either services take too long to start or we get
>     SEGFAULT.
>=20
>     This is easily reproducible. Also if we get a chance to login;
>     simple commands like ls, vi etc take either too long or get
>     SEGFAULT.
>=20
>     Booting the kernel with maxcpus=3D1 or turning off SMP, doesn't
>     solve the problem.
>=20
>     Here is logs from one of the booting sequences:
>=20
> Linux version 2.6.24-rc5-rt1 (root@llm29) (gcc version 4.1.0 (SUSE Li=
nux)) #1
>  SMP PREEMPT RT Thu Dec 20 13:41:45 IST 2007 [boot]0012 Setup Arch
> PPC64 nvram contains 16384 bytes
> Zone PFN ranges:
>   DMA             0 ->  1024000
>   Normal    1024000 ->  1024000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0:        0 ->  1024000
> [boot]0015 Setup Done
> Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
> Built 1 zonelists in Node order, mobility grouping on.  Total pages: =
1000000
> Policy zone: DMA
> Kernel command line: root=3D/dev/hda2  quiet sysrq=3D1 askmethod
> Starting udevd
> Creating devices
> Waiting for device /dev/hda2 to appear:  ok
> rootfs: major=3D3 minor=3D2 devn=3D770
> fsck 1.38 (30-Jun-2005)
> [/bin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/hda2
> /dev/hda2: clean, 249426/1311552 files, 1860112/2622611 blocks
> fsck succeeded. Mounting root device read-write.
> Mounting root /dev/hda2
> INIT: version 2.86 booting
> System Boot Control: Running /etc/init.d/boot
> Mounting procfs at /proc                                             =
 done
> Mounting sysfs at /sys                                               =
 done
> Mounting debugfs at /sys/kernel/debug                                =
 done
> Initializing /dev                                                    =
 done
> Mounting devpts at /dev/pts                                          =
 done
> Activating swap-devices in /etc/fstab...                             =
 done
> showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
> Starting udevd udevd-event[2463]: run_program: '/bin/sh' abnormal exi=
t
> udevd-event[2474]: run_program: '/sbin/vol_id' abnormal exit
> udevd-event[2477]: run_program: '/sbin/vol_id' abnormal exit
> udevd-event[2455]: run_program: '/sbin/ifup' abnormal exit
> udevd-event[2477]: run_program: '/lib/udev/mount.sh' abnormal exit
>=20
>=20
>=20
>=20
>                                                                      =
 failed
> Loading required kernel modules                                      =
 done
> Activating device mapper...
> FATAL: Module dm_mod not found.
>                                                                      =
 failed
> Starting MD Raid                                                     =
 done
> Waiting for udev to settle...
> Scanning for LVM volume groups...
>   Reading all physical volumes.  This may take a while...
>   No volume groups found
>   No volume groups found
> Activating LVM volume groups...
>   No volume groups found
>                                                                      =
 done
> showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
> Checking file systems...
> fsck 1.38 (30-Jun-2005)
> Checking all file systems.
> [/sbin/fsck.ext3 (1) -- /home] fsck.ext3 -a /dev/hda5
> /dev/hda5: clean, 460612/1836928 files, 2774880/3670844 blocks
> [/sbin/fsck.ext3 (1) -- /home/mohan/mnt] fsck.ext3 -a /dev/hda3
> /dev/hda3: clean, 362719/1311552 files, 1651440/2622611 blocks
> *** glibc detected *** /bin/sh: free(): invalid pointer: 0x100a5170 *=
**
> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
> /lib/power4/libc.so.6[0xfde4be4]
> /lib/p/lib/apparmor/rc.apparmor.functions: line 87:  2603 Segmentatio=
n fault=20
>      grep -q securityfs /proc/filesystems
>  /lib/apparmor/rc.apparmor.functions: line 355:  2606 Aborted        =
       =20
>  grep -qE "^(subdomain|apparmor)[[:space:]]" /proc/modules
>  /lib/apparmor/rc.apparmor.functions: line 318:  2610 Segmentation fa=
ult    =20
>  modinfo -F filename subdomain >/dev/null 2>&1
>  /lib/apparmor/rc.apparmor.functions: line 318:  2613 Segmentation fa=
ult    =20
>  grep -qE "^(subdomain|apparmor)[[:space:]]" /proc/modules FATAL: Mod=
ule
>  apparmor not found.
> Loading AppArmor module failed
> - could not start AppArmorfailed
> /etc/init.d/boot.cleanup: line 23:  2601 Segmentation fault      rm -=
f
>  /var/lib/rpm/__db* /etc/init.d/boot.cleanup: line 23:  2602 Segmenta=
tion
>  fault      rm -rf /tmp/screens /tmp/uscreens /var/run/screens
>  /var/run/uscreens 2>/dev/null /etc/init.d/boot.cleanup: line 23:  26=
05
>  Segmentation fault      rm -f /tmp/.X*lock /var/spool/uucp/LCK*
>  /var/log/sa/sadc.LOCK /fsck_corrected_errors 2>/dev/null
>  /etc/init.d/boot.cleanup: line 23:  2608 Segmentation fault      fin=
d
>  /tmp/ssh-* -type s -name "*agent*" -maxdepth 1 -print0 2>/dev/null 2=
609    =20
>                   | xargs -0 -r rm -f
> /etc/init.d/boot.cleanup: line 23:  2611 Segmentation fault      find
>  /var/run /var/lock -type f -print0 2612                       | xarg=
s -0 -r
>  rm -f 2>/dev/null
> /etc/init.d/boot.cleanup: line 23:  2615 Segmentation fault      chmo=
d 664
>  /var/run/utmp /etc/init.d/boot.cleanup: line 23:  2616 Segmentation =
fault  =20
>    chown root:tty /var/run/utmp /etc/init.d/boot.cleanup: line 23:  2=
617
>  Segmentation fault      ls /etc/resolv.conf.saved.by.* >&/dev/null
>  /etc/init.d/boot.cleanup: line 75:  2618 Segmentation fault      cho=
wn
>  root:root $CURDIR /etc/init.d/boot^[[6~.cleanup: line 75:  2619 Segm=
entation
>  fault      chown root:root $CURDIR /etc/init.d/boot.cleanup: line 75=
:  2620
>  Segmentation fault      chown root:root $CURDIR /etc/init.d/boot.cle=
anup:
>  line 75:  2621 Segmentation fault      chown root:root $CURDIR
>  /etc/init.d/boot.cleanup: line 75:  2622 Segmentation fault      cho=
wn
>  root:root $CURDIR /etc/init.d/boot.cleanup: line 75:  2623 Segmentat=
ion
>  fault      c^[[6~hown root:root $CURDIR /etc/init.d/boot.cleanup: li=
ne 82:=20
>  2624 Segmentation fault      chown root:root $CURDIR
>  /etc/init.d/boot.cleanup: line 23:  2625 Segmentation fault      rm =
-f
>  /etc/psdevtab /etc/init.d/boot.cleanup: line 23:  2626 Segmentation =
fault  =20
>    /bin/ps >/dev/null 2>/dev/null No such file or directory
> No such file or directory
> No such file or directory
> No such file or directory
> No such file or directory
> No such file or directory
> System Boot Control: The system has been                             =
 set up
> Failed features: boot.udev boot.localfs boot.clock boot.klog boot.scp=
m
>  boot.crypto boot.localnet boot.swap boot.udev_retry boot.ldconfig
>  boot.sysctl boot.ipconfig System Boot Control: Running
>  /etc/init.d/boot.local                   done INIT: Entering runleve=
l: 3
> EXT3-fs error (device hda2): ext3_add_entry: bad entry in directory #=
971592:
>  rec_len % 4 !=3D 0 - offset=3D0, inode=3D9349464, rec_len=3D54811, n=
ame_len=3D129
>  blogd: can not open /var/run/blogd.pid: Input/output error
> Boot logging started on /dev/hvc0(/dev/console) at Thu Dec 20 14:19:3=
4 2007
> Master Resource Control: previous runlevel: N, switching to runlevel:=
 3
> Master Resource Control: runlevel 3 has been                         =
 reached
> /etc/init.d/rc: line 383:  2669 Illegal instruction     killproc -QUI=
T
>  /sbin/blogd Segmentation fault
> /bin/bash: error while loading shared libraries: =EF=BF=BD=1A=14=7FC=EF=
=BF=BDx=7F=EF=BF=BD=EF=BF=BD=14H: cannot
>  open shared object file: No such file or directory INIT: Id "cons"
>  respawning too fast: disabled for 5 minutes
>=20
> CPU Info:
>  # cat /proc/cpuinfo
> processor       : 0
> cpu             : PPC970, altivec supported
> clock           : 1600.000000MHz
> revision        : 2.2 (pvr 0039 0202)
>=20
>         processor       : 1
>         cpu             : PPC970, altivec supported
>         clock           : 1600.000000MHz
>         revision        : 2.2 (pvr 0039 0202)
>=20
>         timebase        : 199836440
>         platform        : pSeries
>         machine         : CHRP IBM,8842-21X
>=20
> Also Attached is the config file:
>=20
> --
> Cheers,
> Chirag Jog
>=20
>=20
> --
> Cheers,
> Chirag Jog
>=20
> -------------------------------------------------------
>=20

--=20
Cheers,
Chirag Jog
