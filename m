From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] dont calculate hweight in update_migrate_disable
Date: Mon, 24 Mar 2014 10:18:00 -0400
Message-ID: <20140324101800.3f978842@gandalf.local.home>
References: <20140324121848.GA18300@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:41715 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753250AbaCXOSD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Mar 2014 10:18:03 -0400
In-Reply-To: <20140324121848.GA18300@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 24 Mar 2014 13:18:48 +0100
Nicholas Mc Guire <der.herr@hofr.at> wrote:

> Hi ! 
> 
> Proposal for a minor optimization in update_migrate_disable - its only a few 
> instructions saved but those are in the hot path of locks so it might be worth
> it
> 
> When being scheduled out while migrate_disable > 0 and migrate_disabled_updated
> is not yet set we end up here (kernel/sched/core.c):
> 
> static inline void update_migrate_disable(struct task_struct *p)
> {
>         ...
> 
>         mask = tsk_cpus_allowed(p);
> 
>         if (p->sched_class->set_cpus_allowed)
>                 p->sched_class->set_cpus_allowed(p, mask);
>         p->nr_cpus_allowed = cpumask_weight(mask);
> 
> 
> as we only can get here if migrate_disable > 0 there is no need to calculate
> the cpumask_weight(mask) as tsk_cpus_allowed in that case will return
> cpumask_of(task_cpu(p)) which only can have a hamming weight of 1 anyway.
> So we can simply do:
> 
>         p->nr_cpus_allowed = 1;
> 
> without changing the behavior.
> 
> Patch is on top of 3.12.13-rt21
> 

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

