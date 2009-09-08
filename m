From: Hans-Peter Bock <Hans-Peter.Bock@isw.uni-stuttgart.de>
Subject: IRQ timeout
Date: Tue, 8 Sep 2009 14:26:50 +0200
Message-ID: <20090908122650.GI14282@isw.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fLj60tP2PZ34xyqD"
Cc: john.ogness@linutronix.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from isw70.isw.uni-stuttgart.de ([141.58.102.70]:41360 "EHLO
	mail.isw.uni-stuttgart.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZIHMgL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Sep 2009 08:36:11 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--fLj60tP2PZ34xyqD
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

when I start my application using the uio_sercos3 driver, the network on my=
 e100 stops working after a short time. Some miutes later I got this messag=
e in the console and my network started working again:

[  725.000141] ------------[ cut here ]------------
[  725.000185] WARNING: at net/sched/sch_generic.c:230 dev_watchdog+0xf5/0x=
186()
[  725.000226] Hardware name: GA-73PVM-S2H
[  725.000262] NETDEV WATCHDOG: eth1 (e100): transmit timed out
[  725.000299] Modules linked in: uio_sercos3 uio ipv6 sbp2 loop com20020_p=
ci serio_raw com20020 e100 ohci1394 ohci_hcd amd74xx ehci_hcd arcnet parpor=
t_pc psmouse mii ieee1394 pcspkr usbcore ide_pci_generic parport evdev
[  725.000881] Pid: 5, comm: sirq-timer/0 Not tainted 2.6.29.5-rt22 #3
[  725.000919] Call Trace:
[  725.000957]  [<c012b571>] warn_slowpath+0x71/0xa8
[  725.000996]  [<c011d5fc>] ? pick_next_highest_task_rt+0xc6/0xd8
[  725.001039]  [<c011f3b1>] ? enqueue_task_rt+0x13a/0x232
[  725.001100]  [<c0348e00>] ? __read_trylock+0x3e/0x47
[  725.001139]  [<c0172136>] ? cpupri_set+0xdd/0xfb
[  725.001177]  [<c0162bed>] ? __rcu_read_unlock+0x69/0x78
[  725.001215]  [<c0348d5f>] ? __spin_unlock+0xf/0x23
[  725.001253]  [<c0174326>] ? perf_counter_task_sched_in+0x14e/0x15c
[  725.001293]  [<c021f8c2>] ? strlcpy+0x17/0x49
[  725.001331]  [<c02f398e>] dev_watchdog+0xf5/0x186
[  725.001369]  [<c0144fa1>] ? clocksource_watchdog+0x22f/0x23a
[  725.001408]  [<c0122d50>] ? __wake_up+0x28/0x32
[  725.001445]  [<c02f3899>] ? dev_watchdog+0x0/0x186
[  725.001484]  [<c013370c>] run_timer_softirq+0x19a/0x22a
[  725.001522]  [<c02f3899>] ? dev_watchdog+0x0/0x186
[  725.001560]  [<c012fb5a>] ksoftirqd+0x134/0x228
[  725.001597]  [<c012fa26>] ? ksoftirqd+0x0/0x228
[  725.001635]  [<c013c399>] kthread+0x3b/0x61
[  725.001672]  [<c013c35e>] ? kthread+0x0/0x61
[  725.001710]  [<c010350f>] kernel_thread_helper+0x7/0x10
[  725.001747] ---[ end trace 9b182b0252a7e099 ]---
[  725.014615] e100 0000:01:06.0: firmware: requesting e100/d101m_ucode.bin
[  725.029213] e100: eth1 NIC Link is Up 100 Mbps Full Duplex

What can I do to solve this issue?


Best regards, Hans-Peter
--=20
(=B0< Hans-Peter Bock, Dipl.-Ing., http://www.isw.uni-stuttgart.de/ >=B0)
(/) ISW - Universit=E4t Stuttgart, Seidenstra=DFe 36, 70174 Stuttgart (\)

--fLj60tP2PZ34xyqD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQEcBAEBAgAGBQJKpk2KAAoJEFsH0RM0g3lu4g8H/0T+hMt7P3haXXMB5KXA+Tue
xJ96Mtfcau+sEBfpG+l5c7yU2HcMhsPeoJtDJ9ya5o7fDwChoV1NMM47p1YNYeay
yDRBPTstpzZorC6wnm94NVCryy8KqTcKkqnTjuLrbUpcawtZGC7raZXxhelo+FWk
T3AYHe0F1X8exBSd2vaqt7QrClh8srjr29bnXQEYZhuOoRLnAPsYH+3VvOiESciB
qZZunPlyguvkbakBObpTYTPRYBmAFmgO+MeT4zqysCsue/La0JEuFvstazuqrR8j
xz+j6y8EjoNaMgJwjcQOGnG8pl/HHG70+iKCPqg+zSFAOre2hzt3wU5Rtp2Cy4M=
=ewDO
-----END PGP SIGNATURE-----

--fLj60tP2PZ34xyqD--
