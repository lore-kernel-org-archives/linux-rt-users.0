From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: hrtimer problem on AT91RM9200
Date: Sat, 12 Sep 2009 01:07:35 +0200
Message-ID: <20090911230735.GA23652@pengutronix.de>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>, Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33049 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbZIKXHi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Sep 2009 19:07:38 -0400
Content-Disposition: inline
In-Reply-To: <20090911152044.GA5872@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Sep 11, 2009 at 05:20:44PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Bo,
>=20
> In the meantime I got access to an at91rm9200, too.  To help me
> reproducing the problem:
I still cannot reproduce, but I found something anyhow.

The problem is that hrtimer_interrupt_hanging decreases min_delta_ns.
(Initially it's 61036.)

I talked to jstultz on irc and both of us are unsure if asserting that
min_delta_ns isn't decreased in hrtimer_interrupt_hanging is enough or
if there is another problem.

Bo, can you please apply the patch below, pass the kernel parameter
ftrace_dump_on_oops (or alternatively do=20

	# echo 1 > /proc/sys/kernel/ftrace_dump_on_oops

), reproduce the problem and send the resulting oops?

Best regards
Uwe

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 51bd089..cd72ca9 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -18,6 +18,7 @@
 #include <linux/personality.h>
 #include <linux/kallsyms.h>
 #include <linux/delay.h>
+#include <linux/kdebug.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
@@ -223,6 +224,8 @@ static void __die(const char *str, int err, struct =
thread_info *thread, struct p
 		dump_backtrace(regs, tsk);
 		dump_instr(regs);
 	}
+
+	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV=
);
 }
=20
 DEFINE_RAW_SPINLOCK(die_lock);
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 9e308ab..a0c05f3 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1390,8 +1390,16 @@ void hrtimer_interrupt(struct clock_event_device=
 *dev)
=20
 	/* Reprogramming necessary ? */
 	if (expires_next.tv64 !=3D KTIME_MAX) {
-		if (tick_program_event(expires_next, force_clock_reprogram))
+		if (tick_program_event(expires_next, force_clock_reprogram)) {
+			if (nr_retries > 1)
+				trace_printk("tick_program_event failed, "
+						"now=3D%lld, expires_next=3D%lld, "
+						"nr_retries=3D%d\n",
+					(long long)now.tv64,
+					(long long)expires_next.tv64,
+				       	nr_retries);
 			goto retry;
+		}
 	}
=20
 	if (raise)

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
