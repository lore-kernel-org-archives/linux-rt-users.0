From: "Braud Caroline" <Caroline.Braud@univ-lille1.fr>
Subject: RT + comedi (dual boot ubuntu 9.10/debian 7.0)
Date: Wed, 26 Jun 2013 15:08:51 +0200
Message-ID: <ce1-51cae800-39-67adc880@74461503>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp02.univ-lille1.fr ([193.49.225.20]:33299 "EHLO
	smtp02.univ-lille1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3FZNIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Jun 2013 09:08:54 -0400
Received: from sogo2.univ-lille1.fr (sogo2.univ-lille1.fr [193.49.225.215])
	by smtp02.univ-lille1.fr (8.14.3/8.14.3) with ESMTP id r5QD8rwj031860
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Jun 2013 15:08:54 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi evryone,

I was using ubuntu 9.10 (ubuntustudio-9.10-alternate-amd64.iso) with li=
nux-rt package.
It was working well, I could run the Cyclictest with good RT jitters.
Also, I was using comedi and could manage a USBDUX board and a M&C boar=
d (PCI-DAS6036).

 I needed to update my distrib for some reasons, so I did some search a=
nd found that Ubuntu does not support anymore the package linux-rt ... =
so I couldn't keep RT with an update version of ubuntu ...
I installed a debian distrib in dual boot using a liveCD (debian livecd=
 7.0 AMD64, Gnome).
Everthing went well and I could drive my board (PCI-DAS6036) with comed=
i without any problems.

Here is the structure of my disk:
/dev/sda1 =3D /boot
/dev/sda2 =3D /  (Unbuntu 9.10)
/dev/sda6 =3D /  (debian 7.0)
/dev/sda7 =3D /home=20

with a common swap, home and boot for both distributions

$ sudo fdisk -l
Disque /dev/sda : 80.0 Go, 80026361856 octets
255 t=C3=AAtes, 63 secteurs/piste, 9729 cylindres, total 156301488 sect=
eurs
Unit=C3=A9s =3D secteurs de 1 * 512 =3D 512 octets
Taille de secteur (logique / physique) : 512 octets / 512 octets
taille d'E/S (minimale / optimale) : 512 octets / 512 octets
Identifiant de disque : 0x000aa812

P=C3=A9riph=C3=A9rique Amorce  D=C3=A9but        Fin      Blocs     Id =
 Syst=C3=A8me
/dev/sda1   *          63      208844      104391   83  Linux
/dev/sda2          208845    61641404    30716280   83  Linux
/dev/sda3        61641466   156296384    47327459+   5  =C3=89tendue
/dev/sda5        61641468    70027334     4192933+  82  partition d'=C3=
=A9change Linux / Solaris
/dev/sda6        70027398   131459894    30716248+  83  Linux
/dev/sda7       131459958   156296384    12418213+  83  Linux


I was quite happy with that and I decided to boot the rt of the debian =
distribution. It was not working (it was frozen at the login stage ...)=
=2E So I installed the RT following this website: http://www.pengutroni=
x.com/software/linux-rt/debian_en.html

Since I installed it I have now 3 problems (that may be linked):
1- Grub erased my previous grub so I cannot boot on Ubuntu anymore ... =
(not linked directly to rt-user problems, but comes from the installati=
on of rt distrib)
2- Cyclictest tests do not work anymore
3- My board is not reconnized automatically by comedi anymore

1- =20
On debian: EVERYTHING OK
$ ls -lah /
lrwxrwxrwx   1 root root   40 juin  25 17:13 initrd.img -> /boot/initrd=
=2Eimg-2.6.33.7.2-rt30-1-amd64
lrwxrwxrwx   1 root root   30 juin  25 10:13 initrd.img.old -> /boot/in=
itrd.img-3.2.0-4-amd64
lrwxrwxrwx   1 root root   36 juin  25 17:13 vmlinuz -> boot/vmlinuz-2.=
6.33.7.2-rt30-1-amd64
lrwxrwxrwx   1 root root   26 juin  25 10:18 vmlinuz.old -> boot/vmlinu=
z-3.2.0-4-amd64

On Ubuntu (from debian): PROBLEM WITH THE IMAGE LINK
$ sudo mkdir /mnt/Ubuntu
$ sudo mount /dev/sda2 /mnt/Ubuntu/
$ sudo mount /dev/sda1 /mnt/Ubuntu/boot
$ ls -lah /mnt/Ubuntu/
lrwxrwxrwx   1 root root   27 janv. 10  2012 initrd.img -> boot/initrd.=
img-2.6.31-9-rt
lrwxrwxrwx   1 root root   24 janv. 10  2012 vmlinuz -> boot/vmlinuz-2.=
6.31-9-rt

I understand the problem ... but how to repair it ?

2-
It seems that I'm missing linux-headers from kernel 2.6 (see bellow):

~/rt-tests$ make all
cc -D VERSION_STRING=3D0.85 -c src/cyclictest/cyclictest.c -Wall -Wno-n=
onnull -O2 -DNUMA -D_GNU_SOURCE -Isrc/include
In file included from src/cyclictest/cyclictest.c:37:0:
src/cyclictest/rt_numa.h:23:68: fatal error: /usr/src/linux-headers-2.6=
=2E31-9-rt/include/config/numa.h: Aucun fichier ou dossier de ce type
compilation terminated.
make: *** [cyclictest.o] Erreur 1

$ ls /usr/src/linux-headers-2.6.31-9-rt
ls: impossible d'acc=C3=A9der =C3=A0 /usr/src/linux-headers-2.6.31-9-rt=
: Aucun fichier ou dossier de ce type

$ sudo apt-get install  linux-headers-2.6.33.7.2-rt30-1-amd64
Les paquets suivants contiennent des d=C3=A9pendances non satisfaites :
 linux-headers-2.6.33.7.2-rt30-1-amd64 : D=C3=A9pend: gcc-4.3 mais il n=
'est pas installable
E: Impossible de corriger les probl=C3=A8mes, des paquets d=C3=A9fectue=
ux sont en mode =C2=AB garder en l'=C3=A9tat =C2=BB.

How can I solve this problem ? Can I install headers for kernel 2.6 tog=
ether with linux-headers-3.2.0-4-amd64 from the standart debian ?

3-
/dev/comedi0: No such file or directory

(http://www.comedi.org/doc/install.html)

$ sudo modprobe options comedi comedi_num_legacy_minors=3D4
libkmod: ERROR ../libkmod/libkmod.c:505 kmod_lookup_alias_from_builtin_=
file: could not open builtin file '/lib/modules/2.6.33.7.2-rt30-1-amd64=
/modules.builtin.bin'
=46ATAL: Module options not found.

$ ls /lib/modules/2.6.33.7.2-rt30-1-amd64/
kernel           modules.alias.bin    modules.dep      modules.devname =
 modules.symbols
modules.alias  modules.builtin.bin  modules.dep.bin  modules.softdep  m=
odules.symbols.bin

Please, can you tell me what went wrong with the installation of the rt=
 distrib ??
Thanks and sorry for this long message,

Caro
PC: Intel/1xQuadCore @ 2.5 GHz, 4 GB RAM, 3 TB space
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
