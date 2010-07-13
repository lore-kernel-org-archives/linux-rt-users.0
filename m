From: =?utf-8?q?Philipp_=C3=9Cberbacher?= <hollunder@lavabit.com>
Subject: Re: [ANNOUNCE] 2.6.33.6-rt26
Date: Tue, 13 Jul 2010 20:04:29 +0200
Message-ID: <1279042118-sup-7239@eris>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain> <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain> <alpine.LFD.2.00.1003121124120.22855@localhost.localdomain> <alpine.LFD.2.00.1003211158130.3147@localhost.localdomain> <alpine.LFD.2.00.1004071619490.32352@localhost.localdomain> <alpine.LFD.2.00.1004271744280.2951@localhost.localdomain> <alpine.LFD.2.00.1004301156590.2951@localhost.localdomain> <alpine.LFD.2.00.1005022109150.25342@localhost.localdomain> <alpine.LFD.2.00.1006091837410.2933@localhost.localdomain> <alpine.LFD.2.00.1007131745230.3321@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from karen.lavabit.com ([72.249.41.33]:35604 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab0GMSEh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Jul 2010 14:04:37 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 03C8C11B8F2
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jul 2010 13:04:37 -0500 (CDT)
Received: from localhost (eris.mozart.uni-klu.ac.at [143.205.216.185])
	by lavabit.com with ESMTP id GE3D8FFTHGMR
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jul 2010 13:04:33 -0500
In-reply-to: <alpine.LFD.2.00.1007131745230.3321@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Excerpts from Thomas Gleixner's message of 2010-07-13 17:54:35 +0200:
> We are pleased to announce the next update to our new preempt-rt
> series.
> =20
> Changes from 2.6.33.5-rt23 to 2.6.33.5-rt24:
>=20
>   42edbcb: gianfar: Fix TX ring processing on SMP machines
>   faf3581: timer_stats: Convert table_lock to raw_spin_lock
>   654e404: hvc_console: Fix race between hvc_close and hvc_remove
>   09fd768: hvc_console: Fix race between hvc_close and hvc_remove
>   ea2d2a0: perf: Fix errors path in perf_output_begin()
>   60bd946: KEYS: find_keyring_by_name() can gain access to a freed ke=
yring
>   b5ac516: tracing: Update the comm field in the right variable in up=
date_max_tr
>   77cb7c1: lockdep: Reduce stack_trace usage
>   cee9ee0: powerpc: Disable sparse irq for RT
>   c7dec16: powerpc: Enable interrupts in do_signal()
>=20
> Changes from 2.6.33.5-rt24 to 2.6.33.5-rt25:
>=20
>   ec646ea: vfs: Revert the scalability patches
>=20
> Changes from 2.6.33.5-rt26 to 2.6.33.6-rt26:
>=20
>   7e1af11: Merge git://git.kernel.org/pub/scm/linux/kernel/git/stable=
/linux-2.6.33.y
>=20
> Bulk of changes comes from the stable tree and from the big revert of
> the VFS scalability patches. They looked promising, but the nasty
> details bit us hard. We'll revisit them later.
>=20
> There are some pending issues:
>       - rtc_lock suspend/resume (working on a patch)
>       - futex requeue_pi (patch available, needs testing/confirmation=
)
>       - powerpc64 oddities (patch available, needs rework)
>=20
> Download locations:
>   =20
>    http://www.kernel.org/pub/linux/kernel/projects/rt/
>=20
> Git release branch:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.gi=
t rt/2.6.33
>=20
> Gitweb:
>    http://git.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.git;=
a=3Dshortlog;h=3Drt/2.6.33
>=20
> Information on the RT patch can be found at:
>=20
>    http://rt.wiki.kernel.org/index.php/Main_Page
>=20
> To build the 2.6.33.6-rt26 tree, the following patches should be
> applied:
>=20
>    http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.6.tar.bz2
>    http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.6-=
rt26.bz2
>=20
> Enjoy !
>=20
>       tglx

Thanks Thomas,
but I have a problem applying the patch.
I get lots of ignored hunks and it ends and fails with:

2 out of 2 hunks ignored -- saving rejects to file sound/soc/codecs/wm8=
990.c.rej
patching file virt/kvm/kvm_main.c

I tried to build with my usual script, which just does:
patch -Np1 -i ../patch-2.6.33.6-rt26

Before that it applies the .6 patch, with the same command, without any=
 hickup.
I don't know whether something is wrong with the patch or whether I did
something wrong.
--=20
Regards,
Philipp

--
"Wir stehen selbst entt=C3=A4uscht und sehn betroffen / Den Vorhang zu =
und alle Fragen offen." Bertolt Brecht, Der gute Mensch von Sezuan

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
