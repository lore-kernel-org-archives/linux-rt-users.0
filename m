Return-Path: <SRS0=UEZv=XT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8576C432C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855BD20872
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 13:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441139AbfIXNyH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:54:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441133AbfIXNyH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Sep 2019 09:54:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A3A4306E171;
        Tue, 24 Sep 2019 13:54:07 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 715DA60852;
        Tue, 24 Sep 2019 13:54:01 +0000 (UTC)
Message-ID: <55dc19fcc44b2e658b71f68206306c8310335564.camel@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
In-Reply-To: <20190924112155.rxeyksetgqmer3pg@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-4-swood@redhat.com>
         <20190917075943.qsaakyent4dxjkq4@linutronix.de>
         <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
         <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
         <20190923175233.yub32stn3xcwkaml@linutronix.de>
         <20190924112155.rxeyksetgqmer3pg@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 24 Sep 2019 08:53:43 -0500
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 24 Sep 2019 13:54:07 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-24 at 13:21 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-23 19:52:33 [+0200], To Scott Wood wrote:
> 
> I made dis:
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 885a195dfbe02..25afa2bb1a2cf 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -308,7 +308,9 @@ void pin_current_cpu(void)
>  	preempt_lazy_enable();
>  	preempt_enable();
>  
> +	sleeping_lock_inc();
>  	__read_rt_lock(cpuhp_pin);
> +	sleeping_lock_dec();
>  
>  	preempt_disable();
>  	preempt_lazy_disable();
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e1bdd7f9be054..63a6420d01053 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7388,6 +7388,7 @@ void migrate_enable(void)
>  
>  		WARN_ON(smp_processor_id() != task_cpu(p));
>  		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> +			struct task_struct *self = current;
>  			const struct cpumask *cpu_valid_mask =
> cpu_active_mask;
>  			struct migration_arg arg;
>  			unsigned int dest_cpu;
> @@ -7405,7 +7406,21 @@ void migrate_enable(void)
>  			unpin_current_cpu();
>  			preempt_lazy_enable();
>  			preempt_enable();
> +			rt_invol_sleep_inc();
> +
> +			raw_spin_lock_irq(&self->pi_lock);
> +			self->saved_state = self->state;
> +			__set_current_state_no_track(TASK_RUNNING);
> +			raw_spin_unlock_irq(&self->pi_lock);
> +
>  			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
> +
> +			raw_spin_lock_irq(&self->pi_lock);
> +			__set_current_state_no_track(self->saved_state);
> +			self->saved_state = TASK_RUNNING;
> +			raw_spin_unlock_irq(&self->pi_lock);
> +
> +			rt_invol_sleep_dec();
>  			return;
>  		}
>  	}
> 
> I think we need to preserve the current state, otherwise we will lose
> anything != TASK_RUNNING here. So the spin_lock() would preserve it
> while waiting but the migrate_enable() will lose it if it needs to
> change the CPU at the end.
> I will try to prepare all commits for the next release before I release
> so you can have a look first and yell if needed.

As I pointed out in the "[PATCH RT 6/8] sched: migrate_enable: Set state to
TASK_RUNNING" discussion, we can get here inside the rtmutex code (e.g. from
debug_rt_mutex_print_deadlock) where saved_state is already holding
something -- plus, the waker won't have WF_LOCK_SLEEPER and therefore
saved_state will get cleared anyway.

-Scott


