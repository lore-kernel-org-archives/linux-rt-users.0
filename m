From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] net: iptables: rework the fix of xt_info locking
Date: Wed, 2 Mar 2011 21:58:53 +0100
Message-ID: <20110302205853.GJ22310@pengutronix.de>
References: <20110302201414.GE8384@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54387 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1CBU65 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2011 15:58:57 -0500
Content-Disposition: inline
In-Reply-To: <20110302201414.GE8384@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 02, 2011 at 05:14:14PM -0300, Luis Claudio R. Goncalves wro=
te:
> Thomas,
>=20
> Maybe PREEMPT_NONE is not really what we want to check against, maybe=
 it is=20
> RT_MUTEXES... anyway, this patch works fine as is in kernels with
> PREEMPT_NONE, PREEMPT_DESKTOP, PREEMPT_VOLUNTARY and PREEMPT_RT set.
>=20
> ---
>=20
> net: iptables: rework the fix of xt_info locking
>=20
> Commit 5bbbedc from tip/rt/2.6.33 fixed an annoying locking issue on
> PREEMPT_RT enabled kernels. I have observed a similar issue when test=
ing a
> kernel with PREEMPT_DESKTOP enabled. My test kernels would boot fine =
and as
> soon as I tried to ssh into the test box I would see messages like th=
is one:
>=20
> 	BUG: %Ps exited with wrong preemption count!
> 	=3D> enter: 00000101, exit: 00000100.
> 	BUG: %Ps exited with wrong preemption count!
> 	=3D> enter: 00000101, exit: 00000100.
> 	BUG: %Ps exited with wrong preemption count!
> 	=3D> enter: 00000102, exit: 00000101.

This error message would be a bit more usful after this patch:

diff --git a/kernel/softirq.c b/kernel/softirq.c
index c35f72b..b3b20b0 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -335,8 +335,8 @@ debug_check_preempt_count_stop(__u32 *preempt_count=
, struct softirq_action *h)
 	if (*preempt_count =3D=3D preempt_count())
 		return;
=20
-	print_symbol("BUG: %Ps exited with wrong preemption count!\n",
-		     (unsigned long)h->action);
+	printk("BUG: %ps exited with wrong preemption count!\n",
+			h->action);
 	printk("=3D> enter: %08x, exit: %08x.\n", *preempt_count, preempt_cou=
nt());
 	preempt_count() =3D *preempt_count;
 #endif

Note this is completely untested and applies on top of v2.6.33.7.2-rt30=
=2E

Thomas: should I send a proper patch or isn't it worth the effort?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
