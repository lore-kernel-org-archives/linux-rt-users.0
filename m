From: Hans-Peter Bock <Hans-Peter.Bock@isw.uni-stuttgart.de>
Subject: Re: IRQ timeout
Date: Tue, 8 Sep 2009 16:27:26 +0200
Message-ID: <20090908142726.GJ14282@isw.uni-stuttgart.de>
References: <20090908122650.GI14282@isw.uni-stuttgart.de>
 <80ws49y23l.fsf@merkur.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ms5iOKSBOB9YS8zC"
Cc: linux-rt-users@vger.kernel.org,
	Hans-Peter Bock <Hans-Peter.Bock@isw.uni-stuttgart.de>
To: John Ogness <john.ogness@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from isw70.isw.uni-stuttgart.de ([141.58.102.70]:46335 "EHLO
	mail.isw.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZIHO10 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Sep 2009 10:27:26 -0400
Content-Disposition: inline
In-Reply-To: <80ws49y23l.fsf@merkur.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Ms5iOKSBOB9YS8zC
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello John,

> 1. Is the uio_sercos3 driver sharing its interrupt?
>    $ cat /proc/interrupts

no, it isn't:

           CPU0       CPU1      =20
 16:      26948          0   IO-APIC-fasteoi   Sercos_III_PCI
 17:        794          0   IO-APIC-fasteoi   eth1

But I am wondering, why CPU0 gets all the interrupts.


> 2. What are the rt-priorities for your application (including the UIO
>    thread) and for the network stack threads?
>    $ ps -Alm

The process "geos" is using the uio_sercos3 driver.

F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
4 -     0     1     0  0   -   - -   525 -      ?        00:00:00 init
4 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -     0     2     0  0   -   - -     0 -      ?        00:00:00 kthreadd
5 S     0     -     -  0  75  -5 -     - kthrea -        00:00:00 -
1 -     0     3     2  0   -   - -     0 -      ?        00:00:00 migration=
/0
1 S     0     -     -  0 -40   - -     - migrat -        00:00:00 -
5 -     0     4     2  0   -   - -     0 -      ?        00:00:00 sirq-high=
/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0     5     2  0   -   - -     0 -      ?        00:00:00 sirq-time=
r/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0     6     2  0   -   - -     0 -      ?        00:00:00 sirq-net-=
tx/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0     7     2  0   -   - -     0 -      ?        00:00:00 sirq-net-=
rx/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0     8     2  0   -   - -     0 -      ?        00:00:00 sirq-bloc=
k/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0     9     2  0   -   - -     0 -      ?        00:00:00 sirq-task=
let/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    10     2  0   -   - -     0 -      ?        00:00:00 sirq-sche=
d/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    11     2  0   -   - -     0 -      ?        00:00:00 sirq-hrti=
mer/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    12     2  0   -   - -     0 -      ?        00:00:00 sirq-rcu/0
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
1 -     0    13     2  0   -   - -     0 -      ?        00:00:00 posixcput=
mr/0
1 S     0     -     -  0 -40   - -     - posix_ -        00:00:00 -
5 -     0    14     2  0   -   - -     0 -      ?        00:00:00 watchdog/0
5 S     0     -     -  0 -40   - -     - watchd -        00:00:00 -
1 -     0    15     2  0   -   - -     0 -      ?        00:00:00 desched/0
1 S     0     -     -  0  70 -10 -     - desche -        00:00:00 -
1 -     0    16     2  0   -   - -     0 -      ?        00:00:00 migration=
/1
1 S     0     -     -  0 -40   - -     - migrat -        00:00:00 -
1 -     0    17     2  0   -   - -     0 -      ?        00:00:00 posixcput=
mr/1
1 S     0     -     -  0 -40   - -     - posix_ -        00:00:00 -
5 -     0    18     2  0   -   - -     0 -      ?        00:00:00 sirq-high=
/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    19     2  0   -   - -     0 -      ?        00:00:00 sirq-time=
r/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    20     2  0   -   - -     0 -      ?        00:00:00 sirq-net-=
tx/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    21     2  0   -   - -     0 -      ?        00:00:00 sirq-net-=
rx/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    22     2  0   -   - -     0 -      ?        00:00:00 sirq-bloc=
k/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    23     2  0   -   - -     0 -      ?        00:00:00 sirq-task=
let/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    24     2  0   -   - -     0 -      ?        00:00:00 sirq-sche=
d/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    25     2  0   -   - -     0 -      ?        00:00:00 sirq-hrti=
mer/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    26     2  0   -   - -     0 -      ?        00:00:00 sirq-rcu/1
5 S     0     -     -  0  10   - -     - ksofti -        00:00:00 -
5 -     0    27     2  0   -   - -     0 -      ?        00:00:00 watchdog/1
5 S     0     -     -  0 -40   - -     - watchd -        00:00:00 -
1 -     0    28     2  0   -   - -     0 -      ?        00:00:00 desched/1
1 S     0     -     -  0  70 -10 -     - desche -        00:00:00 -
1 -     0    29     2  0   -   - -     0 -      ?        00:00:00 rcu_sched=
_grace
1 S     0     -     -  0  75  -5 -     - rcu_sc -        00:00:00 -
1 -     0    30     2  0   -   - -     0 -      ?        00:00:00 events/0
1 S     0     -     -  0  58   - -     - worker -        00:00:00 -
1 -     0    31     2  0   -   - -     0 -      ?        00:00:00 events/1
1 S     0     -     -  0  58   - -     - worker -        00:00:00 -
1 -     0    32     2  0   -   - -     0 -      ?        00:00:00 work_on_c=
pu/0
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0    33     2  0   -   - -     0 -      ?        00:00:00 work_on_c=
pu/1
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0    34     2  0   -   - -     0 -      ?        00:00:00 cpuset
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0    35     2  0   -   - -     0 -      ?        00:00:00 khelper
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   119     2  0   -   - -     0 -      ?        00:00:00 kblockd/0
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   120     2  0   -   - -     0 -      ?        00:00:00 kblockd/1
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   122     2  0   -   - -     0 -      ?        00:00:00 kacpid
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   123     2  0   -   - -     0 -      ?        00:00:00 kacpi_not=
ify
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
7 -     0   124     2  0   -   - -     0 -      ?        00:00:00 IRQ-9
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
1 -     0   232     2  0   -   - -     0 -      ?        00:00:00 ata/0
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   233     2  0   -   - -     0 -      ?        00:00:00 ata/1
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   234     2  0   -   - -     0 -      ?        00:00:00 ata_aux
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   236     2  0   -   - -     0 -      ?        00:00:00 kseriod
1 S     0     -     -  0  75  -5 -     - serio_ -        00:00:00 -
1 -     0   291     2  0   -   - -     0 -      ?        00:00:00 khungtaskd
1 S     0     -     -  0  80   0 -     - watchd -        00:00:00 -
1 -     0   292     2  0   -   - -     0 -      ?        00:00:00 pdflush
1 S     0     -     -  0  80   0 -     - pdflus -        00:00:00 -
1 -     0   293     2  0   -   - -     0 -      ?        00:00:00 pdflush
1 S     0     -     -  0  80   0 -     - pdflus -        00:00:00 -
1 -     0   294     2  0   -   - -     0 -      ?        00:00:00 kswapd0
1 S     0     -     -  0  75  -5 -     - kswapd -        00:00:00 -
1 -     0   295     2  0   -   - -     0 -      ?        00:00:00 aio/0
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0   296     2  0   -   - -     0 -      ?        00:00:00 aio/1
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
7 -     0   445     2  0   -   - -     0 -      ?        00:00:00 IRQ-27
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
1 -     0   446     2  0   -   - -     0 -      ?        00:00:00 scsi_eh_0
1 S     0     -     -  0  75  -5 -     - scsi_e -        00:00:00 -
1 -     0   448     2  0   -   - -     0 -      ?        00:00:00 scsi_eh_1
1 S     0     -     -  0  75  -5 -     - scsi_e -        00:00:00 -
1 -     0   450     2  0   -   - -     0 -      ?        00:00:00 scsi_eh_2
1 S     0     -     -  0  75  -5 -     - scsi_e -        00:00:00 -
1 -     0   452     2  0   -   - -     0 -      ?        00:00:00 scsi_eh_3
1 S     0     -     -  0  75  -5 -     - scsi_e -        00:00:00 -
7 -     0   477     2  0   -   - -     0 -      ?        00:00:00 IRQ-12
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
7 -     0   478     2  0   -   - -     0 -      ?        00:00:00 IRQ-1
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
7 -     0   485     2  0   -   - -     0 -      ?        00:00:00 IRQ-8
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
1 -     0   494     2  0   -   - -     0 -      ?        00:00:00 kjournald
1 S     0     -     -  0  75  -5 -     - kjourn -        00:00:00 -
5 -     0   593     1  0   -   - -   739 -      ?        00:00:00 udevd
5 S     0     -     -  0  76  -4 -     - poll_s -        00:00:00 -
1 -     0  1041     2  0   -   - -     0 -      ?        00:00:00 kpsmoused
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0  1045     2  0   -   - -     0 -      ?        00:00:00 khpsbpkt
1 S     0     -     -  0  75  -5 -     - hpsbpk -        00:00:00 -
1 -     0  1055     2  0   -   - -     0 -      ?        00:00:00 ksuspend_=
usbd
1 S     0     -     -  0  75  -5 -     - worker -        00:00:00 -
1 -     0  1057     2  0   -   - -     0 -      ?        00:00:00 khubd
1 S     0     -     -  0  75  -5 -     - hub_th -        00:00:00 -
7 -     0  1074     2  0   -   - -     0 -      ?        00:00:00 IRQ-7
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
7 -     0  1081     2  0   -   - -     0 -      ?        00:00:00 IRQ-22
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
7 -     0  1133     2  0   -   - -     0 -      ?        00:00:00 IRQ-18
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
1 -     0  1134     2  0   -   - -     0 -      ?        00:00:00 knodemgrd=
_0
1 S     0     -     -  0  75  -5 -     - nodemg -        00:00:00 -
7 -     0  1162     2  0   -   - -     0 -      ?        00:00:00 IRQ-14
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
7 -     0  1165     2  0   -   - -     0 -      ?        00:00:00 IRQ-21
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
7 -     0  1576     2  0   -   - -     0 -      ?        00:00:00 IRQ-17
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
1 -     0  1629     1  0   -   - -   454 -      ?        00:00:00 syslogd
1 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -     0  1638     1  0   -   - -   441 -      ?        00:00:00 klogd
5 S     0     -     -  0  80   0 -     - syslog -        00:00:00 -
1 -     0  1647     1  0   -   - -   441 -      ?        00:00:00 acpid
1 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -   105  1661     1  0   -   - -   655 -      ?        00:00:00 dbus-daem=
on
5 S   105     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -   106  1677     1  0   -   - -   721 -      ?        00:00:00 avahi-dae=
mon
5 S   106     -     -  0  80   0 -     - poll_s -        00:00:00 -
1 -   106  1678  1677  0   -   - -   721 -      ?        00:00:00 avahi-dae=
mon
1 S   106     -     -  0  80   0 -     - unix_s -        00:00:00 -
5 -     0  1702     1  0   -   - -  1354 -      ?        00:00:00 sshd
5 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
1 -     0  1714     1  0   -   - -   722 -      ?        00:00:00 dirmngr
1 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -   100  1986     1  0   -   - -  1574 -      ?        00:00:00 exim4
5 S   100     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -     0  1998     1  0   -   - -   488 -      ?        00:00:00 inetd
5 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -   103  2015     1  0   -   - -  1069 -      ?        00:00:00 ntpd
5 S   103     -     -  0  80   0 -     - poll_s -        00:00:00 -
5 -   107  2027     1  0   -   - -  1431 -      ?        00:00:00 hald
5 S   107     -     -  0  80   0 -     - poll_s -        00:00:00 -
0 -     0  2028  2027  0   -   - -   831 -      ?        00:00:00 hald-runn=
er
0 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
0 -     0  2045  2028  0   -   - -   847 -      ?        00:00:00 hald-addo=
n-inpu
0 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
7 -     0  2048     2  0   -   - -     0 -      ?        00:00:00 IRQ-4
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
4 -   107  2055  2028  0   -   - -   568 -      ?        00:00:00 hald-addo=
n-acpi
4 S   107     -     -  0  80   0 -     - unix_s -        00:00:00 -
0 -     0  2059  2028  0   -   - -   847 -      ?        00:00:00 hald-addo=
n-stor
0 S     0     -     -  0  80   0 -     - poll_s -        00:00:00 -
1 -     1  2067     1  0   -   - -   512 -      ?        00:00:00 atd
1 S     1     -     -  0  80   0 -     - hrtime -        00:00:00 -
1 -     0  2087     1  0   -   - -   857 -      ?        00:00:00 cron
1 S     0     -     -  0  80   0 -     - hrtime -        00:00:00 -
4 -     0  2104     1  0   -   - -   657 -      tty1     00:00:00 login
4 S     0     -     -  0  80   0 -     - wait   -        00:00:00 -
4 -     0  2106     1  0   -   - -   657 -      tty2     00:00:00 login
4 S     0     -     -  0  80   0 -     - wait   -        00:00:00 -
0 -     0  2107     1  0   -   - -   441 -      tty3     00:00:00 getty
0 S     0     -     -  0  80   0 -     - n_tty_ -        00:00:00 -
0 -     0  2108     1  0   -   - -   441 -      tty4     00:00:00 getty
0 S     0     -     -  0  80   0 -     - n_tty_ -        00:00:00 -
0 -     0  2110     1  0   -   - -   441 -      tty5     00:00:00 getty
0 S     0     -     -  0  80   0 -     - n_tty_ -        00:00:00 -
0 -     0  2111     1  0   -   - -   441 -      tty6     00:00:00 getty
0 S     0     -     -  0  80   0 -     - n_tty_ -        00:00:00 -
4 -  1000  2149  2104  0   -   - -  1544 -      tty1     00:00:00 bash
4 S  1000     -     -  0  80   0 -     - wait   -        00:00:00 -
7 -     0  2196     2  0   -   - -     0 -      ?        00:00:00 IRQ-16
7 S     0     -     -  0   9   - -     - irqd   -        00:00:00 -
0 -  1000  2210  2149  0   -   - -  1026 -      tty1     00:00:00 screen
0 S  1000     -     -  0  80   0 -     - pause  -        00:00:00 -
1 -  1000  2211  2210  0   -   - -  1165 -      ?        00:00:00 screen
1 S  1000     -     -  0  80   0 -     - poll_s -        00:00:00 -
0 -  1000  2212  2211  0   -   - -  1514 -      pts/0    00:00:00 bash
0 S  1000     -     -  0  80   0 -     - wait   -        00:00:00 -
4 -     0  2229  2212  0   -   - - 22379 -      pts/0    00:00:00 geos
4 S     0     -     -  0 -40   - -     - futex_ -        00:00:00 -
5 S     0     -     -  0 -30   - -     - uio_re -        00:00:00 -
0 -  1000  2231  2211  0   -   - -  1514 -      pts/1    00:00:00 bash
0 S  1000     -     -  0  80   0 -     - wait   -        00:00:00 -
4 -     0  2251  2231  0   -   - - 17916 -      pts/1    00:00:00 v263_com
4 S     0     -     -  0  80   0 -     - hrtime -        00:00:00 -
0 -  1000  2252  2211  0   -   - -  1514 -      pts/2    00:00:00 bash
0 S  1000     -     -  0  80   0 -     - wait   -        00:00:00 -
4 -     0  2269  2252  0   -   - - 24749 -      pts/2    00:00:00 v263_sda
4 S     0     -     -  0  80   0 -     - hrtime -        00:00:00 -
0 -  1000  2270  2211  0   -   - -  1514 -      pts/3    00:00:00 bash
0 S  1000     -     -  0  80   0 -     - wait   -        00:00:00 -
4 -     0  2287  2270  0   -   - -  8518 -      pts/3    00:00:00 v263_init
4 S     0     -     -  0  80   0 -     - hrtime -        00:00:00 -
4 -  1000  2305  2106  0   -   - -  1513 -      tty2     00:00:00 bash
4 R  1000     -     -  0  80   0 -     - -      -        00:00:00 -
4 -     0  2340  1702  0   -   - -  2043 -      ?        00:00:00 sshd
4 S     0     -     -  0  80   0 -     - unix_s -        00:00:00 -
5 -  1000  2342  2340  0   -   - -  2081 -      ?        00:00:00 sshd
5 S  1000     -     -  0  80   0 -     - poll_s -        00:00:00 -
0 -  1000  2343  2342  0   -   - -  1514 -      pts/4    00:00:00 bash
0 S  1000     -     -  0  80   0 -     - n_tty_ -        00:00:00 -
0 -  1000  2368  2305  0   -   - -   872 -      tty2     00:00:00 ps
0 R  1000     -     -  0  80   0 -     - -      -        00:00:00 -


> 3. How many interrupts per second (approx.) are being generated by the
>    Sercos hardware while your application is running?
>    $ cat /proc/interrupts; sleep 1; cat /proc/interrupts

The SERCOS III master runs a cycle time of 2ms, that should be 500 interrup=
ts per second:

           CPU0       CPU1      =20
  0:        125          0   IO-APIC-edge      timer
  1:        696          0   IO-APIC-edge      i8042
  4:          2          0   IO-APIC-edge   =20
  7:          1          0   IO-APIC-edge      parport0
  8:         45          0   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 12:        105          0   IO-APIC-edge      i8042
 14:          0          0   IO-APIC-edge      ide0
 16:      26948          0   IO-APIC-fasteoi   Sercos_III_PCI
 17:        794          0   IO-APIC-fasteoi   eth1
 18:          3          0   IO-APIC-fasteoi   ohci1394
 21:          0          0   IO-APIC-fasteoi   ohci_hcd:usb2
 22:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
 27:       3698          0   PCI-MSI-edge      ahci
NMI:          0          0   Non-maskable interrupts
LOC:     129961      98461   Local timer interrupts
SPU:          0          0   Spurious interrupts
CNT:          0          0   Performance counter interrupts
RES:        169        515   Rescheduling interrupts
CAL:       1465        476   Function call interrupts
TLB:        174        258   TLB shootdowns
TRM:          0          0   Thermal event interrupts
ERR:          1
MIS:          0

           CPU0       CPU1      =20
  0:        125          0   IO-APIC-edge      timer
  1:        697          0   IO-APIC-edge      i8042
  4:          2          0   IO-APIC-edge   =20
  7:          1          0   IO-APIC-edge      parport0
  8:         45          0   IO-APIC-edge      rtc0
  9:          0          0   IO-APIC-fasteoi   acpi
 12:        105          0   IO-APIC-edge      i8042
 14:          0          0   IO-APIC-edge      ide0
 16:      27448          0   IO-APIC-fasteoi   Sercos_III_PCI
 17:        794          0   IO-APIC-fasteoi   eth1
 18:          3          0   IO-APIC-fasteoi   ohci1394
 21:          0          0   IO-APIC-fasteoi   ohci_hcd:usb2
 22:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1
 27:       3712          0   PCI-MSI-edge      ahci
NMI:          0          0   Non-maskable interrupts
LOC:     130597      99473   Local timer interrupts
SPU:          0          0   Spurious interrupts
CNT:          0          0   Performance counter interrupts
RES:        171        516   Rescheduling interrupts
CAL:       1465        476   Function call interrupts
TLB:        174        259   TLB shootdowns
TRM:          0          0   Thermal event interrupts
ERR:          1
MIS:          0



> 4. What is the system load while your application is running and when
>    the network stops working?
>    $ cat /proc/loadavg

The system is idle:

0.01 0.02 0.00 1/114 2374


> 5. Is your application doing anything particular with the network (such
>    as tunneling Sercos data)?

No. The only network data are some basic network services and ssh sessions.

If I plug out the network cable, and plug it in again, I get the previously=
 posted error message and the network starts working again.


Best regards, Hans-Peter
--=20
(=B0< Hans-Peter Bock, Dipl.-Ing., http://www.isw.uni-stuttgart.de/ >=B0)
(/) ISW - Universit=E4t Stuttgart, Seidenstra=DFe 36, 70174 Stuttgart (\)

--Ms5iOKSBOB9YS8zC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQEcBAEBAgAGBQJKpmnOAAoJEFsH0RM0g3lu0ZYH/ROJUxt5LMvI/ESEDaPy4PTX
BOLMLVC61T9pOjfy3O1CLaiYlfjM09mS20/ukG6kZmY1NEmRL2QAUTG6UFWPbSK2
TgNPUP43uCIg/mAr3HCfLTntEO42+bYGH5X6kZOxlxOcIFG5dbSmgQ70667DpxHT
9Q37k6nF5ikoZBpyESS3bhVvq9lXyDyvHxb4Ml09DN4H7awQagA4ioDPGB95YhfK
5FgeGGEW6m7vq7H0SK1mtpqJ+N59JP0KKupv1CZmB3Li4MDOF/Le5Sx05+Lh0h+I
Gf40oJAaRC3pIYre3uG/6ORA101d+rvmcE8MEEBGQrpMpxVLOmB/K6yUokyVnDk=
=9fCZ
-----END PGP SIGNATURE-----

--Ms5iOKSBOB9YS8zC--
