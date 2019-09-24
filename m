Return-Path: <SRS0=UEZv=XT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C4C432C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1887C20872
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 11:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438723AbfIXLWA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:22:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33667 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389615AbfIXLWA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Sep 2019 07:22:00 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCitH-0004qN-P8; Tue, 24 Sep 2019 13:21:55 +0200
Date:   Tue, 24 Sep 2019 13:21:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
Message-ID: <20190924112155.rxeyksetgqmer3pg@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-4-swood@redhat.com>
 <20190917075943.qsaakyent4dxjkq4@linutronix.de>
 <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
 <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
 <20190923175233.yub32stn3xcwkaml@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923175233.yub32stn3xcwkaml@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-23 19:52:33 [+0200], To Scott Wood wrote:

I made dis:

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 885a195dfbe02..25afa2bb1a2cf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -308,7 +308,9 @@ void pin_current_cpu(void)
 	preempt_lazy_enable();
 	preempt_enable();
 
+	sleeping_lock_inc();
 	__read_rt_lock(cpuhp_pin);
+	sleeping_lock_dec();
 
 	preempt_disable();
 	preempt_lazy_disable();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e1bdd7f9be054..63a6420d01053 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7388,6 +7388,7 @@ void migrate_enable(void)
 
 		WARN_ON(smp_processor_id() != task_cpu(p));
 		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+			struct task_struct *self = current;
 			const struct cpumask *cpu_valid_mask = cpu_active_mask;
 			struct migration_arg arg;
 			unsigned int dest_cpu;
@@ -7405,7 +7406,21 @@ void migrate_enable(void)
 			unpin_current_cpu();
 			preempt_lazy_enable();
 			preempt_enable();
+			rt_invol_sleep_inc();
+
+			raw_spin_lock_irq(&self->pi_lock);
+			self->saved_state = self->state;
+			__set_current_state_no_track(TASK_RUNNING);
+			raw_spin_unlock_irq(&self->pi_lock);
+
 			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
+
+			raw_spin_lock_irq(&self->pi_lock);
+			__set_current_state_no_track(self->saved_state);
+			self->saved_state = TASK_RUNNING;
+			raw_spin_unlock_irq(&self->pi_lock);
+
+			rt_invol_sleep_dec();
 			return;
 		}
 	}

I think we need to preserve the current state, otherwise we will lose
anything != TASK_RUNNING here. So the spin_lock() would preserve it
while waiting but the migrate_enable() will lose it if it needs to
change the CPU at the end.
I will try to prepare all commits for the next release before I release
so you can have a look first and yell if needed.

> > -Scott
 
Sebastian
