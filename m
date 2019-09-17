Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B2C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 16:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AED1214AF
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 16:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfIQQAj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:00:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42604 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfIQQAj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 12:00:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAFu2-0002Qp-Ir; Tue, 17 Sep 2019 18:00:30 +0200
Date:   Tue, 17 Sep 2019 18:00:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 7/8] sched: migrate_enable: Use select_fallback_rq()
Message-ID: <20190917160030.i24gvyye2bpdykfy@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-8-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-8-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-27 00:56:37 [-0500], Scott Wood wrote:
> migrate_enable() currently open-codes a variant of select_fallback_rq().
> However, it does not have the "No more Mr. Nice Guy" fallback and thus
> it will pass an invalid CPU to the migration thread if cpus_mask only
> contains a CPU that is !active.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> This scenario will be more likely after the next patch, since
> the migrate_disable_update check goes away.  However, it could happen
> anyway if cpus_mask was updated to a CPU other than the one we were
> pinned to, and that CPU subsequently became inactive.

I'm unclear about the problem / side effect this has (before and after
the change). It is possible (before and after that change) that a CPU is
selected which is invalid / goes offline after the "preempt_enable()"
statement and before stop_one_cpu() does its job, correct?

> ---
>  kernel/sched/core.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index eb27a9bf70d7..3a2d8251a30c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7368,6 +7368,7 @@ void migrate_enable(void)
>  	if (p->migrate_disable_update) {
>  		struct rq *rq;
>  		struct rq_flags rf;
> +		int cpu = task_cpu(p);
>  
>  		rq = task_rq_lock(p, &rf);
>  		update_rq_clock(rq);
> @@ -7377,21 +7378,15 @@ void migrate_enable(void)
>  
>  		p->migrate_disable_update = 0;
>  
> -		WARN_ON(smp_processor_id() != task_cpu(p));
> -		if (!cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> -			const struct cpumask *cpu_valid_mask = cpu_active_mask;
> -			struct migration_arg arg;
> -			unsigned int dest_cpu;
> -
> -			if (p->flags & PF_KTHREAD) {
> -				/*
> -				 * Kernel threads are allowed on online && !active CPUs
> -				 */
> -				cpu_valid_mask = cpu_online_mask;
> -			}
> -			dest_cpu = cpumask_any_and(cpu_valid_mask, &p->cpus_mask);
> -			arg.task = p;
> -			arg.dest_cpu = dest_cpu;
> +		WARN_ON(smp_processor_id() != cpu);
> +		if (!cpumask_test_cpu(cpu, &p->cpus_mask)) {
> +			struct migration_arg arg = { p };
> +			struct rq_flags rf;
> +
> +			rq = task_rq_lock(p, &rf);
> +			update_rq_clock(rq);
> +			arg.dest_cpu = select_fallback_rq(cpu, p);
> +			task_rq_unlock(rq, p, &rf);
>  
>  			unpin_current_cpu();
>  			preempt_lazy_enable();

Sebastian
