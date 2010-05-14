From: Clark Williams <williams@redhat.com>
Subject: backtrace from tmpfs umount on 2.6.33.4-rt19 (tip/rt/2.6.33)
Date: Fri, 14 May 2010 14:45:06 -0500
Message-ID: <20100514144506.1046599c@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/ujbwIKIArDPbVxgk0FMNaKx"; protocol="application/pgp-signature"
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1731 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab0ENTp0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 15:45:26 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/ujbwIKIArDPbVxgk0FMNaKx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thomas/Peter,

I got the below backtrace while running the 'mock' unit-tests (most of
which make heavy use of tmpfs). Basically it's creating a chroot
build environment for a particular distro (in this case
fedora-12-x86_64) and building a source RPM inside that chroot.=20

I'm running 2.6.33.4-rt19 from tip/rt/2.6.33

Clark

BUG: Dentry ffff880053401928{i=3D1ef806,n=3Dptmx} still in use (-1)
[unmount of tmpfs tmpfs] ------------[ cut here ]------------
kernel BUG at fs/dcache.c:835!
invalid opcode: 0000 [#1] PREEMPT SMP=20
last sysfs
file: /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/PNP0C09:00/=
PNP0C0A:00/power_supply/BAT0/status
CPU 0 Pid: 14563, comm: umount Not tainted 2.6.33.4-rt19
#36        / RIP: 0010:[<ffffffff81107f12>]  [<ffffffff81107f12>]
shrink_dcache_for_umount_subtree+0x119/0x253 RSP:
0018:ffff880080073da8  EFLAGS: 00010292 RAX: 000000000000005f RBX:
ffff880053401928 RCX: 0000000000000000 RDX: 0000000000000000 RSI:
0000000000000046 RDI: ffff880080073c88 RBP: ffff880080073de8 R08:
ffff88009823c000 R09: 0000000000000073 R10: 0000000000000000 R11:
0000000000000000 R12: ffff880011f7ad18 R13: ffff8800534019c8 R14:
ffff880011f7ad10 R15: ffff8800b4bb6e08 FS:  00007f62035d4740(0000)
GS:ffff88000a200000(0000) knlGS:0000000000000000 CS:  0010 DS: 0000 ES:
0000 CR0: 000000008005003b CR2: 00007f6202c9b488 CR3: 0000000076b36000
CR4: 00000000000006f0 DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000 DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400 Process umount (pid: 14563, threadinfo
ffff880080072000, task ffff88003d6da5c0) Stack:
 ffff88004329b2f0 0000000000000000 ffff88003d6da5c0 ffff880037ddeb18
<0> ffff88004329b000 ffff880037ddeb20 ffffffff81af26d0 ffff880080073fd8
<0> ffff880080073e18 ffffffff81108092 ffff880037ddeb20 ffff88004329b000
Call Trace:
 [<ffffffff81108092>] shrink_dcache_for_umount+0x46/0x5b
 [<ffffffff810f824f>] generic_shutdown_super+0x1f/0xf9
 [<ffffffff810f837e>] kill_anon_super+0x16/0x54
 [<ffffffff810f83e3>] kill_litter_super+0x27/0x2b
 [<ffffffff810f8aab>] deactivate_super+0x6d/0x82
 [<ffffffff8110eadb>] mntput_no_expire+0x1a5/0x218
 [<ffffffff8110f0f5>] sys_umount+0x2d5/0x300
 [<ffffffff8108af27>] ? audit_syscall_entry+0x1ec/0x218
 [<ffffffff81002c1b>] system_call_fastpath+0x16/0x1b
Code: 0a 48 8b 4b 70 31 d2 48 85 f6 74 04 48 8b 56 40 48 05 f0 02 00 00
48 89 de 48 89 04 24 48 c7 c7 6f 9a 78 81 31 c0 e8 93 be 32 00 <0f> 0b
eb fe 4c 8b 63 60 4c 39 e3 75 3c 48 8b 93 90 00 00 00 48 RIP
[<ffffffff81107f12>] shrink_dcache_for_umount_subtree+0x119/0x253 RSP
<ffff880080073da8> ---[ end trace 34e97e0ec2c5ae6a ]---

--Sig_/ujbwIKIArDPbVxgk0FMNaKx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkvtqEsACgkQHyuj/+TTEp3hMwCfQ7lDQAfBvJNNyseTLXZoPuMI
WDYAmQHHTqCwxb8tJMT41YB6rXbsw9Xe
=CzX2
-----END PGP SIGNATURE-----

--Sig_/ujbwIKIArDPbVxgk0FMNaKx--
