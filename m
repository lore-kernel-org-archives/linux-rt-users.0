Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B613C433ED
	for <linux-rt-users@archiver.kernel.org>; Sat, 15 May 2021 07:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6BC6613F0
	for <linux-rt-users@archiver.kernel.org>; Sat, 15 May 2021 07:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhEOHbo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 15 May 2021 03:31:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:51049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhEOHbn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 15 May 2021 03:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621063779;
        bh=NAlu5S4642xOfats9/zNVj4rMRpbVRpx/O6EEm7IkzI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NI0GxpCxWoH4IwN7F8Bk9FJqo+Hr7Ra5X7SP4etC+EUESDoZxjlAjsPnPjONw1MWC
         x1hFM5sLcduSOi8GAW764H390mic7zGzye9LbKp6Bvaz00FrcAYWCly/1T8vLbGPBs
         IhejJq9gWXDdJG5HhldH4SjBcMzU2xHWyjr1vAyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1lC0gx0nrQ-00ngSQ; Sat, 15
 May 2021 09:29:39 +0200
Message-ID: <284735cfa1b23484cb0aaeb896067cbf888ac6af.camel@gmx.de>
Subject: Re: [PATCH v2 3/3] sched/fair: break out of newidle balancing if an
 RT task appears
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 15 May 2021 09:29:37 +0200
In-Reply-To: <YJUecEMZNDfD1Z4K@hirez.programming.kicks-ass.net>
References: <20210428232821.2506201-1-swood@redhat.com>
         <20210428232821.2506201-4-swood@redhat.com>
         <YJUecEMZNDfD1Z4K@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ka/KlqfxQKXEIn3Cg+EwBh9ky+iZeMquyjje/Ugxn3xj2VckLrq
 6lsLYiYlKI3FJmCqTcUkoSTRMETbuFXjGxgLtg+RXfrwThG+hWB68YeTrod8IWsJjZDQvBN
 +hJ+0sC7qeSf4wIzYLMe6UsLnanciuTq/me3w/tjGFIjLuOVB/T4us/A9cnzYKDFuX1tWy4
 N/LPvG0o2f7FOcd6baOQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8TXQKAv7jpQ=:Wmw+FJlQUmDB5HKsC4cnyz
 hDDA8Owknf7mWs7+sg43oAR3BvRDw8ivjcfucuJkBL68vfkq0Y9+TqecLydIflZx2g2eol+nN
 j3KEA2tyqQ5T7FVGnfeeJwGDSxpuMtjL0jK0k72XZvumqVbdiJJniiDhS7O/zQcUxzKD219kg
 M21gtR39u7Gr3JBbznawG0YkzhUACZbCaDH1zibvkUEEQ2+ZLD1BwiMMdMeWngJDBKF1mZi9q
 S/zyV9rczdPmsem/OuE1P0brDpvIgv8ayUEFgxXUUy9p8vBOvUDP2Ts+KpCSyBl1u7Wxc9okl
 QO1u+zeAPu5Xv5NWg04HciduCWdHU1ePsAGhR1y3qQ0EAdLaBP7m+du+PVnP9zgDL0eGbDpm9
 Lnlr2DSieqjMleKLyhxdHwG7oVRKMKMTtqko2IFG81gxiCcZr3S/5r1PyLi300Ta9BofTcFUX
 VOQ//cuX0JF3nIzWYW2evuIBXsaS7ujxkGKeqhAwhN04qXU7xXlQpcazkbj2WJ0gpCghfK27+
 3nItVEOb2ji2+9CBSmpKiFVtktV0IM7uuLIWuB+YeTDf41v4e3uVMriQnv50XjtV2blQAIeLt
 GVBQ0umTX/XcHx6CWmdZ+mf8v8xcxuyIkJiOXpmj5weJlU3HUH5jf2VbLxkzI4rHF6aamR9am
 9Pl/tsJKpd6Zq0Dncg6ealdLjHU0w0alGHCx8ahK1iFGUlvFsIfvTcMsIoHozOye8Tgw8Da3Z
 +FzoLHSx/lqciSKIMbDjxsjv9IkTU9Z8qmXzf+JXQaaWOzN8L2rdtboUN3ePruI1f1S7aQvda
 xEl/0eubj7atIqTvBNEI8U54JID2qTIEpDslINS3YyqnIbhrhPaIh9cnVghjcWbqJgXat39mX
 kDS0/zusRwHIPDDJ/9yMi/KhLK1/spylXIALGbc3dF5I0z++J5forNOOPZ4YQoGCLLXivWvXo
 2INuk1TxUDaZDrfQJoU8ClIGH2Ruve2ztOsH77JJVa7FAv4hIsR0u4W5YZlt0kBDsgkt92FUG
 ktiaurtoKfeLOJRw06EaaGLdpd1/x/svTutkHdb/9b882+OZeVC6BljDpt7wROobmoTYe29zj
 fagJsOfhbXmhsHBULPbIgLThsueOuIQBdDphW3qquQQOkjsk0JG0IUJ/QI8TkJrklNgn/+/4v
 fs2/icQvHUavyirbxFerK/KX7VvdCXl3TpemttjNH8Amlp52ZNkYIpLsSmmygxZ1Y6VPw=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-05-07 at 13:03 +0200, Peter Zijlstra wrote:
>
> newidle_balance() already has 'stop, you're spending too much time'
> controls; you've failed to explain how those are falling short and why
> they cannot be improved.

Greetings,

I bet a nickle he's meeting contention on a more painful scale than the
2212.429350 sample from my little i4790 desktop box, as master.today+rt
does.. nothing remotely RT like, just plays youtube as I instead watch
trace output.

homer:..debug/tracing # tail -20 trace
 MediaPl~back #1-17837   [003] d...2..  2212.292335: load_balance: NEWIDLE=
 rq:2 lock acquired
  Gecko_IOThread-4001    [000] d...2..  2212.315030: load_balance: NEWIDLE=
 rq:3 lock acquired
         firefox-3980    [007] d...1..  2212.315030: load_balance: NEWIDLE=
 rq:3 locked - aborting
           Timer-4089    [007] d...2..  2212.317260: load_balance: NEWIDLE=
 rq:0 lock acquired
           Timer-4089    [007] d...2..  2212.317319: load_balance: NEWIDLE=
 rq:0 lock acquired
     ksoftirqd/6-51      [006] d...2..  2212.317358: load_balance: NEWIDLE=
 rq:0 lock acquired
           Timer-4089    [007] d...2..  2212.317474: load_balance: NEWIDLE=
 rq:0 lock acquired
 MediaPl~back #2-17839   [002] d...1..  2212.345438: load_balance: NEWIDLE=
 rq:3 locked - aborting
 Chrome_~dThread-16830   [006] d...2..  2212.345438: load_balance: NEWIDLE=
 rq:3 lock acquired
 AudioIP~ent RPC-17665   [003] d...2..  2212.404999: load_balance: NEWIDLE=
 rq:5 lock acquired
 ImageBridgeChld-16855   [001] d...2..  2212.429350: load_balance: NEWIDLE=
 rq:6 lock acquired
 MediaPl~back #1-17837   [000] d...1..  2212.429351: load_balance: NEWIDLE=
 rq:6 locked - aborting
 Chrome_~dThread-16830   [002] d...1..  2212.429356: load_balance: NEWIDLE=
 rq:6 locked - aborting
               X-2157    [003] d...2..  2212.461351: load_balance: NEWIDLE=
 rq:6 lock acquired
           <...>-4043    [006] d...2..  2212.480451: load_balance: NEWIDLE=
 rq:2 lock acquired
     ksoftirqd/0-12      [000] d...2..  2212.505545: load_balance: NEWIDLE=
 rq:3 lock acquired
     ksoftirqd/0-12      [000] d...2..  2212.505550: load_balance: NEWIDLE=
 rq:3 lock acquired
     threaded-ml-4399    [001] d...2..  2212.517943: load_balance: NEWIDLE=
 rq:7 lock acquired
      pulseaudio-1917    [002] d...2..  2212.575245: load_balance: NEWIDLE=
 rq:6 lock acquired
 IPDL Background-4028    [004] d...2..  2212.581085: load_balance: NEWIDLE=
 rq:5 lock acquired
homer:..debug/tracing #

homer:..debug/tracing # cat trace | grep lock | wc -l
218165
homer:..debug/tracing # cat trace | grep abort | wc -l
40081

I still carry the below in my local RT trees, to which I added those
trace_printk()s.  It was born some years ago on a 64 core box.

=2D--
 kernel/sched/fair.c     |   11 +++++++++++
 kernel/sched/features.h |    4 ++++
 kernel/sched/sched.h    |   10 ++++++++++
 3 files changed, 25 insertions(+)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7200,6 +7200,12 @@ done: __maybe_unused;
 	if (!rf)
 		return NULL;

+#ifdef CONFIG_PREEMPT_RT
+	/* RT tasks have better things to do than load balancing. */
+	if (prev && prev->sched_class !=3D &fair_sched_class)
+		return NULL;
+#endif
+
 	new_tasks =3D newidle_balance(rq, rf);

 	/*
@@ -9669,7 +9675,12 @@ static int load_balance(int this_cpu, st
 		env.loop_max  =3D min(sysctl_sched_nr_migrate, busiest->nr_running);

 more_balance:
+#ifdef CONFIG_PREEMPT_RT
+		if (!rq_lock_trylock_irqsave(busiest, &rf))
+			goto out;
+#else
 		rq_lock_irqsave(busiest, &rf);
+#endif
 		update_rq_clock(busiest);

 		/*
=2D-- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -86,7 +86,11 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 #endif

 SCHED_FEAT(RT_RUNTIME_SHARE, false)
+#ifndef CONFIG_PREEMPT_RT
 SCHED_FEAT(LB_MIN, false)
+#else
+SCHED_FEAT(LB_MIN, true)
+#endif
 SCHED_FEAT(ATTACH_AGE_LOAD, true)

 SCHED_FEAT(WA_IDLE, true)
=2D-- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1322,6 +1322,16 @@ rq_lock_irqsave(struct rq *rq, struct rq
 	rq_pin_lock(rq, rf);
 }

+static inline int
+rq_lock_trylock_irqsave(struct rq *rq, struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	if (!raw_spin_trylock_irqsave(&rq->lock, rf->flags))
+		return 0;
+	rq_pin_lock(rq, rf);
+	return 1;
+}
+
 static inline void
 rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)

