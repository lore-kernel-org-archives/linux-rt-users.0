Return-Path: <SRS0=uP6E=SR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4768C10F0E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 20:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779AC2070D
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 20:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfDOUQU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:16:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfDOUQD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Apr 2019 16:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79875308FF30;
        Mon, 15 Apr 2019 20:16:03 +0000 (UTC)
Received: from amt.cnet (ovpn-112-12.gru2.redhat.com [10.97.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BEFE608C2;
        Mon, 15 Apr 2019 20:15:58 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 771A610515D;
        Mon, 15 Apr 2019 17:15:38 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x3FKFcqX013909;
        Mon, 15 Apr 2019 17:15:38 -0300
Message-Id: <20190415201429.342103190@amt.cnet>
User-Agent: quilt/0.60-1
Date:   Mon, 15 Apr 2019 17:12:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/3] timers: raise timer softirq on __mod_timer/add_timer_on
References: <20190415201213.600254019@amt.cnet>
Content-Disposition: inline; filename=01-modtimer-remote-softirqraise
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 15 Apr 2019 20:16:03 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

For isolated CPUs, we'd like to skip awakening ktimersoftd
(the switch to and then back from ktimersoftd takes 10us in
virtualized environments, in addition to other OS overhead,
which exceeds telco requirements for packet forwarding for
5G) from the sched tick.

The patch "timers: do not raise softirq unconditionally" from Thomas
attempts to address that by checking, in the sched tick, whether its
necessary to raise the timer softirq. Unfortunately, it attempts to grab
the tvec base spinlock which generates the issue described in the patch
"Revert "timers: do not raise softirq unconditionally"".

tvec_base->lock protects addition of timers to the wheel versus
timer interrupt execution.

This patch does not grab the tvec base spinlock from irq context,
but rather performs a lockless access to base->pending_map.

It handles the the race between timer addition and timer interrupt
execution by unconditionally (in case of isolated CPUs) raising the
timer softirq after making sure the updated bitmap is visible 
on remote CPUs.

This patch reduces cyclictest latency from 25us to 14us 
on my testbox.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 kernel/time/timer.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

Index: linux-rt-devel/kernel/time/timer.c
===================================================================
--- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 13:56:06.974210992 -0300
+++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:21:02.788704354 -0300
@@ -41,6 +41,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/swait.h>
@@ -907,6 +908,12 @@
 #endif
 }
 
+static DEFINE_PER_CPU(call_single_data_t, raise_timer_csd);
+
+static void raise_timer_softirq(void *arg)
+{
+	raise_softirq(TIMER_SOFTIRQ);
+}
 
 /*
  * We are using hashed locking: Holding per_cpu(timer_bases[x]).lock means
@@ -1056,6 +1063,17 @@
 		internal_add_timer(base, timer);
 	}
 
+	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER) &&
+	    !(timer->flags & TIMER_DEFERRABLE)) {
+		call_single_data_t *c;
+
+		c = per_cpu_ptr(&raise_timer_csd, base->cpu);
+
+		/* Make sure bitmap updates are visible on remote CPUs */
+		smp_wmb();
+		smp_call_function_single_async(base->cpu, c);
+	}
+
 out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
@@ -1175,6 +1193,17 @@
 
 	debug_activate(timer, timer->expires);
 	internal_add_timer(base, timer);
+
+	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER) &&
+	    !(timer->flags & TIMER_DEFERRABLE)) {
+		call_single_data_t *c;
+
+		c = per_cpu_ptr(&raise_timer_csd, base->cpu);
+
+		/* Make sure bitmap updates are visible on remote CPUs */
+		smp_wmb();
+		smp_call_function_single_async(base->cpu, c);
+	}
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
@@ -1970,6 +1999,15 @@
 {
 	int cpu;
 
+	for_each_possible_cpu(cpu) {
+		call_single_data_t *c;
+
+		c = per_cpu_ptr(&raise_timer_csd, cpu);
+		c->func = raise_timer_softirq;
+		c->info = NULL;
+		c->flags = 0;
+	}
+
 	for_each_possible_cpu(cpu)
 		init_timer_cpu(cpu);
 }


