From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.24-rc7-rt1
Date: Mon, 14 Jan 2008 09:27:40 +0100
Message-ID: <1200299260.4665.17.camel@homer.simson.net>
References: <1200250801.9190.7.camel@localhost.localdomain>
	 <200801132143.34889.m.kozlowski@tuxland.pl>
	 <Pine.LNX.4.58.0801131552350.10093@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752245AbYANI1q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jan 2008 03:27:46 -0500
In-Reply-To: <Pine.LNX.4.58.0801131552350.10093@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Sun, 2008-01-13 at 15:54 -0500, Steven Rostedt wrote:

> OK, -rt2 will take a bit more beating from me before I release it, so=
 it
> might take some time to get it out (expect it out on Monday).

Ah, that reminds me (tests, yup) I still need the patchlet below to
resume from ram without black screen of death.  No idea why my P4 box
seems to be the only box in the rt galaxy affected.  (haven't poked at
it since the holidays)

Index: linux-2.6.24.git-rt1/kernel/sched_rt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24.git-rt1.orig/kernel/sched_rt.c
+++ linux-2.6.24.git-rt1/kernel/sched_rt.c
@@ -33,6 +33,9 @@ static inline void rt_clear_overload(str
=20
 static void update_rt_migration(struct rq *rq)
 {
+	if (unlikely(num_online_cpus() =3D=3D 1))
+		return;
+
 	if (rq->rt.rt_nr_migratory && (rq->rt.rt_nr_running > 1)) {
 		if (!rq->rt.overloaded) {
 			rt_set_overload(rq);
@@ -105,8 +108,10 @@ static inline void dec_rt_tasks(struct t
 		} /* otherwise leave rq->highest prio alone */
 	} else
 		rq->rt.highest_prio =3D MAX_RT_PRIO;
-	if (p->nr_cpus_allowed > 1)
+	if (p->nr_cpus_allowed > 1) {
+		BUG_ON(!rq->rt.rt_nr_migratory);
 		rq->rt.rt_nr_migratory--;
+	}
=20
 	if (rq->rt.highest_prio !=3D highest_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio);


btw, CONFIG_INTEL_IOATDMA compile booboo

  CC      drivers/dma/ioat_dma.o
drivers/dma/ioat_dma.c: In function =E2=80=98ioat1_tx_submit=E2=80=99:
drivers/dma/ioat_dma.c:300: error: too few arguments to function =E2=80=
=98__list_splice=E2=80=99
make[2]: *** [drivers/dma/ioat_dma.o] Error 1
