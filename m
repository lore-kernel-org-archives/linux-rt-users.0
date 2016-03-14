From: Clark Williams <williams@redhat.com>
Subject: [RT] Warning from swake_up_all_locked in rt-4.4.4-rt11
Date: Sun, 13 Mar 2016 22:53:58 -0500
Message-ID: <20160313225358.4eb9316a@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/SJMNLt4z17w5DFCKD8vejsY"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Daniel Wagner <wagi@monom.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343AbcCNDyF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 13 Mar 2016 23:54:05 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/SJMNLt4z17w5DFCKD8vejsY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I'm hitting the WARN_ON(wakes > 2) in $SUBJECT when resuming from suspend o=
n my laptop (quad-core i7 with HT on). Looks like the warning gets hit 36 t=
imes on resume. E.g.:

Call Trace:
 [<ffffffff813c13c0>] dump_stack+0x65/0x85
 [<ffffffff810a7572>] warn_slowpath_common+0x82/0xd0
 [<ffffffff810a76ca>] warn_slowpath_null+0x1a/0x20
 [<ffffffff810ec8d8>] swake_up_all_locked+0x68/0x80
 [<ffffffff810ecd40>] complete_all+0x30/0x50
 [<ffffffff81506328>] device_resume_noirq+0x48/0x190
 [<ffffffff8150648d>] async_resume_noirq+0x1d/0x50
 [<ffffffff810ca188>] async_run_entry_fn+0x48/0x130
 [<ffffffff810c14a9>] process_one_work+0x139/0x480
 [<ffffffff810c1847>] worker_thread+0x57/0x490
 [<ffffffff810c17f0>] ? process_one_work+0x480/0x480
 [<ffffffff810c779d>] kthread+0xed/0x110
 [<ffffffff810c76b0>] ? kthread_worker_fn+0x150/0x150
ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
 [<ffffffff817b0d0f>] ret_from_fork+0x3f/0x70
 [<ffffffff810c76b0>] ? kthread_worker_fn+0x150/0x150
---[ end trace 0000000000000002 ]---



This trace (and a similar one with device_resume) happens on all cpus so th=
e trace info is kinda jumbled up. I'll try it with WARN_ON_ONCE instead tom=
orrow.=20

I'll send the console log if you want it.=20

Clark

--Sig_/SJMNLt4z17w5DFCKD8vejsY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJW5jXWAAoJEOI5asVwYXLrngYP/iHmJgQ/WuTrtEwRxvKJnzxC
rcIBJ0oodzUI4Fl16Aa3dGqvBaAQjIz1YbfU7i62T/sf2zOin24VZCgEoTUGw8jf
wqRw6cRFHx+5YtChE/AePTIvfMj6hGdcjjQUgHEqSpVcBft58AiuHowCT92F5Wwc
VTwEh81nFbCcnTh0RN3ipnkJXVy6N8ypp7V2jWoD2FIiaFsGaC4O0VNbnFLgOljE
wR5/tP8Q9S3lNI13lByY1Q/PONnp7U5Tp+1tPJYIsJYoce/s8J8zESoJqOFo8JKn
UMe4R+m037YLlKkWEgVR9mBoyn+MBzl1ZM9X2Z8u8mlU4/Gowu3b6Zji84LrhfWd
vQzCpM512mizBjYeo0mKXpS+M1KEL4EpIbRAMPf5B+vY8r3yOhQ9XU/pzFzNOSD3
PGsyMZNipa5M+Z6QYvdbRZwaXOHn4GhOyFEVgW9BxJx6+jDijXRAOiC+7OtcR8Ar
/rc6wqBzEYof6ixK8Xlealgk1nadGBfYdrEFnxlvQY04gWq2F2zo8Jib4HX3cIO8
2z3RgRs3tEAmolyjCb1tis8zhECUZ1+mukL/teorRnvBA4jFUlv+s0sN7roCLRfS
QUz/z1uPNhu5V2mGAfnlxaJ/5oNcElD0OI9PKKbvFlNgUD+uXOyKnLXB0R/dARiw
XMFcnJ1xyPgVih9keOe6
=DYmJ
-----END PGP SIGNATURE-----

--Sig_/SJMNLt4z17w5DFCKD8vejsY--
