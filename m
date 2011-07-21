From: hermann <brummer-@web.de>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Thu, 21 Jul 2011 18:22:41 +0200
Message-ID: <1311265361.2323.6.camel@box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:34023 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab1GUQXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jul 2011 12:23:03 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 87DFF195EC202
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Jul 2011 18:22:42 +0200 (CEST)
Received: from [93.208.173.56] (helo=[192.168.2.102])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qjw1K-0004Rv-00
	for linux-rt-users@vger.kernel.org; Thu, 21 Jul 2011 18:22:42 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> Dear RT Folks,
>=20
> I'm pleased to announce the first drop of the 3.0-rc7 based RT
> patch.

Hi=20
Many thanks for all this work.=20

I try to build the 3.0-rc7-rt0 but fail with the following message:
 CC [M]  fs/ext3/balloc.o
In file included from include/linux/jbd.h:247:0,
                 from fs/ext3/balloc.c:18:
include/linux/jbd_common.h: In function =E2=80=98jbd_lock_bh_state=E2=80=
=99:
include/linux/jbd_common.h:43:2: error: =E2=80=98struct buffer_head=E2=80=
=99 has no member named =E2=80=98b_state_lock=E2=80=99
include/linux/jbd_common.h: In function =E2=80=98jbd_trylock_bh_state=E2=
=80=99:
include/linux/jbd_common.h:52:9: error: =E2=80=98struct buffer_head=E2=80=
=99 has no member named =E2=80=98b_state_lock=E2=80=99
include/linux/jbd_common.h: In function =E2=80=98jbd_is_locked_bh_state=
=E2=80=99:
include/linux/jbd_common.h:61:27: error: =E2=80=98struct buffer_head=E2=
=80=99 has no member named =E2=80=98b_state_lock=E2=80=99
include/linux/jbd_common.h: In function =E2=80=98jbd_unlock_bh_state=E2=
=80=99:
include/linux/jbd_common.h:70:2: error: =E2=80=98struct buffer_head=E2=80=
=99 has no member named =E2=80=98b_state_lock=E2=80=99
include/linux/jbd_common.h: In function =E2=80=98jbd_lock_bh_journal_he=
ad=E2=80=99:
include/linux/jbd_common.h:79:2: error: =E2=80=98struct buffer_head=E2=80=
=99 has no member named =E2=80=98b_journal_head_lock=E2=80=99
include/linux/jbd_common.h: In function =E2=80=98jbd_unlock_bh_journal_=
head=E2=80=99:
include/linux/jbd_common.h:88:2: error: =E2=80=98struct buffer_head=E2=80=
=99 has no member named =E2=80=98b_journal_head_lock=E2=80=99
make[3]: *** [fs/ext3/balloc.o] Fehler 1
make[2]: *** [fs/ext3] Fehler 2
make[1]: *** [fs] Fehler 2
make[1]: Leaving directory `/home/brummer/Projekte/Kernel/linux-3.0-rc7=
'
make: *** [debian/stamp/build/kernel] Fehler 2


my system is:
System:    Host box Kernel 2.6.39-rc7 i686 (32 bit gcc 4.5.2)=20
           Desktop Xfce 4.8.2 (Gtk 2.24.4) Distro Debian GNU/Linux whee=
zy/sid
Machine:   System Hewlett-Packard product hp workstation version x2100/=
2600
           Mobo Hewlett-Packard model HP WMTA System Board version A03 =
Bios Phoenix version JG.W1.04US date 07/26/2002
CPU:       Single core Intel Pentium 4 CPU (-UP-) cache 512 KB flags (s=
se sse2) bmips 5183.59 clocked at 2591.796 MHz=20
Graphics:  Card: ATI Radeon R200 QH [Radeon 8500] bus-ID: 01:00.0 X.Org=
 1.10.1 drivers ati,radeon Resolution 1024x768@75.0hz=20
           GLX Renderer Mesa X11 GLX Version 2.1 Mesa 7.10.2 Direct Ren=
dering Yes
Audio:     Card Creative Labs SB Live! EMU10k1 driver EMU10K1_Audigy po=
rt 5040 bus-ID: 02:0a.0 Sound: ALSA v: 1.0.24
Network:   Card Intel 82801BA/BAM/CA/CAM Ethernet Controller driver e10=
0 v: 3.5.24-k2-NAPI port 5000 bus-ID: 02:08.0
           IF: eth0 state: up speed: 100 Mbps duplex: full mac: 00:30:6=
e:26:c4:6d
Drives:    HDD Total Size: 58.1GB (57.4% used) 1: /dev/sda IC35L060AVV2=
07 41.2GB=20
           2: /dev/sdb IBM 16.9GB=20
           Optical: /dev/sr0 model: TOSHIBA DVD-ROM SD-M1612 rev: 1004 =
dev-links: cdrom,dvd,scd0
           Features: speed: 48x multisession: yes audio: yes dvd: yes r=
w: none state: running
Partition: ID:/ size: 38G used: 27G (76%) fs: ext3 dev: /dev/sda2 label=
: N/A uuid: 1c8cbe6a-e15f-4a86-9b2b-2c75628ed183=20
           ID:/media/sdb1 size: 15G used: 4.6G (33%) fs: ext4 dev: /dev=
/sdb1 label: N/A uuid: b6d0dca6-d88a-4096-bd54-c20dc98db436=20
           ID:swap-1 size: 0.74GB used: 0.00GB (0%) fs: swap dev: /dev/=
sda1 label: N/A uuid: N/A=20
Unmounted: ID: /dev/sdb5 size: 0.75G label: N/A uuid: 6b246475-8d0a-441=
4-9657-4586b3a57ea1=20
Sensors:   Error: You do not have the sensors app installed.
Info:      Processes 113 Uptime 13:07 Memory 449.0/2026.4MB Runlevel 5 =
Client Shell

regards
hermann

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
