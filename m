Return-Path: <SRS0=CtTq=5P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41EFC2D0F1
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Mar 2020 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D89207FF
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Mar 2020 20:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgC3UPj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbgC3UPi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Mar 2020 16:15:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2DE20714;
        Mon, 30 Mar 2020 20:15:36 +0000 (UTC)
Date:   Mon, 30 Mar 2020 16:15:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com,
        bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: 4.19.106-rt44 -- boot problems with irqwork: push most work
 into softirq context
Message-ID: <20200330161534.5d4e7174@gandalf.local.home>
In-Reply-To: <20200321230028.GA22058@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
        <20200319214835.GA29781@duo.ucw.cz>
        <20200319232225.GA7878@duo.ucw.cz>
        <20200319204859.5011a488@gandalf.local.home>
        <20200320195432.GA12666@duo.ucw.cz>
        <20200320160545.26a65de3@gandalf.local.home>
        <20200321224339.GA20728@duo.ucw.cz>
        <20200321230028.GA22058@duo.ucw.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 22 Mar 2020 00:00:28 +0100
Pavel Machek <pavel@denx.de> wrote:

> Hi!
> 
> > > > > Does this patch help?    
> > > > 
> > > > I don't think so. It also failed, and the failure seems to be
> > > > identical to me.
> > > > 
> > > > https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-cip
> > > > https://lava.ciplatform.org/scheduler/job/13110
> > > >   
> > > 
> > > Can you send me a patch that shows the difference between the revert that
> > > you say works, and the upstream v4.19-rt tree (let me know which version
> > > of v4.19-rt you are basing it on).  
> > 
> > I was using -rt44, and yes, I can probably generate better diffs.
> > 
> > But I guess I found it with code review: how does this look to you? I
> > applied it on top of your fix, and am testing. 2 successes so far.  
> 
> And I'd recommend some kind of cleanup on top. The code is really
> "interesting" and we don't want to have two copies. Totally untested.
> 
> Looking at the code, it could be probably cleaned up further.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> Best regards,
> 								Pavel

I applied this patch, does this work for you. It's slightly different than
yours as I thought only the condition needed to be saved, not the lists
themselves.

-- Steve

Index: stable-rt.git/kernel/irq_work.c
===================================================================
--- stable-rt.git.orig/kernel/irq_work.c	2020-03-30 15:11:13.849875145 -0400
+++ stable-rt.git/kernel/irq_work.c	2020-03-30 15:18:54.365242025 -0400
@@ -70,6 +70,12 @@ static void __irq_work_queue_local(struc
 		arch_irq_work_raise();
 }
 
+static inline bool use_lazy_list(struct irq_work *work)
+{
+	return (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+		|| (work->flags & IRQ_WORK_LAZY);
+}
+
 /* Enqueue the irq work @work on the current CPU */
 bool irq_work_queue(struct irq_work *work)
 {
@@ -81,11 +87,10 @@ bool irq_work_queue(struct irq_work *wor
 
 	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL) && !(work->flags & IRQ_WORK_HARD_IRQ))
+	if (use_lazy_list(work))
 		list = this_cpu_ptr(&lazy_list);
 	else
 		list = this_cpu_ptr(&raised_list);
-
 	__irq_work_queue_local(work, list);
 	preempt_enable();
 
@@ -106,7 +111,6 @@ bool irq_work_queue_on(struct irq_work *
 
 #else /* CONFIG_SMP: */
 	struct llist_head *list;
-	bool lazy_work, realtime = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
 
 	/* All work should have been flushed before going offline */
 	WARN_ON_ONCE(cpu_is_offline(cpu));
@@ -116,10 +120,7 @@ bool irq_work_queue_on(struct irq_work *
 		return false;
 
 	preempt_disable();
-
-	lazy_work = work->flags & IRQ_WORK_LAZY;
-
-	if (lazy_work || (realtime && !(work->flags & IRQ_WORK_HARD_IRQ)))
+	if (use_lazy_list(work))
 		list = &per_cpu(lazy_list, cpu);
 	else
 		list = &per_cpu(raised_list, cpu);
