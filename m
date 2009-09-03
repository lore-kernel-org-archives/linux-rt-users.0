From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: hrtimer problem on AT91RM9200
Date: Thu, 3 Sep 2009 16:12:17 +0200
Message-ID: <20090903141217.GB22289@pengutronix.de>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53166 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbZICOMP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Sep 2009 10:12:15 -0400
Content-Disposition: inline
In-Reply-To: <4A8E99C7.6080106@newtec.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Aug 21, 2009 at 02:57:43PM +0200, Bo Hansen wrote:
> Hi Uwe,
>
> I cannot find anything in the dmesg or serial output regarding the
> WARN_ON_ONCE(...)
> I guess the WARN_ON_ONCE(...) should show up in dmesg output?
>
> What puzzles me is that I tried the CONFIG_DEBUG_BUGVERBOSE=3Dy
> also when I enabled CONFIG_DEBUG_INFO. When I do
> this I don't get the kernel panic. Is this somehow related to the
> WARN_ON_ONCE?
>
> Attachments only sent to Uwe - anybody are welcome to get a copy.
Hhhhmm, clkevt32k_next_event is called with delta=3D1 which hits
BUG_ON(delta < 2).

I calculated the clockeventdevice parameters by hand, and the numbers
look good:

	clkevt.shift =3D 32
	clkevt.mult =3D div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift)
		=3D (32768 << 32) / 1000000000
		=3D 140737
	clkevt.min_delta_ns =3D clockevent_delta2ns(2, &clkevt) + 1
		=3D (2 << clkevt.shift) / clkevt.mult + 1
		=3D (2 << 32) / 140737 + 1
		=3D 61036
	min_delta =3D (clkevt.min_delta_ns * mult) >> clkevt.shift
		=3D (61036 * 140737) >> 32
		=3D 2

Can you please apply the patch below, reproduce and provide the two
lines of output resulting from the two added printks?

Best regards
Uwe

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/=
at91rm9200_time.c
index 1ff1bda..83a7379 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -136,7 +136,13 @@ clkevt32k_next_event(unsigned long delta, struct c=
lock_event_device *dev)
 	u32		alm;
 	int		status =3D 0;
=20
-	BUG_ON(delta < 2);
+	if (unlikely(delta < 2)) {
+		pr_emerg("************** %s: shift=3D%d, mult=3D%lu, "
+				"min_delta_ns=3D%lu, dev=3D%pS\n", __func__,
+				dev->shift, dev->mult,
+				dev->min_delta_ns, dev);
+		BUG();
+	}
=20
 	/* Use "raw" primitives so we behave correctly on RT kernels. */
 	raw_local_irq_save(flags);
@@ -205,6 +211,18 @@ void __init at91rm9200_timer_init(void)
 	clkevt.mult =3D div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift);
 	clkevt.max_delta_ns =3D clockevent_delta2ns(AT91_ST_ALMV, &clkevt);
 	clkevt.min_delta_ns =3D clockevent_delta2ns(2, &clkevt) + 1;
+
+	{
+		unsigned long long clc =3D (int64_t)clkevt.min_delta_ns *
+			clkevt.mult;
+
+		clc >>=3D clkevt.shift;
+
+		pr_info("************** %s: shift=3D%d, mult=3D%lu, "
+				"min_delta_ns=3D%lu, minclc=3D%llu\n", __func__,
+				clkevt.shift, clkevt.mult,
+				clkevt.min_delta_ns, clc);
+	}
 	clkevt.cpumask =3D cpumask_of(0);
 	clockevents_register_device(&clkevt);
=20




--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
