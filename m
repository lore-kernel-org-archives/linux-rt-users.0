From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] drop migrate_disabled section in _cpu_down
Date: Mon, 24 Mar 2014 10:20:29 -0400
Message-ID: <20140324102029.48350386@gandalf.local.home>
References: <20140324122025.GB18300@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:34147 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752322AbaCXOUb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Mar 2014 10:20:31 -0400
In-Reply-To: <20140324122025.GB18300@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 24 Mar 2014 13:20:25 +0100
Nicholas Mc Guire <der.herr@hofr.at> wrote:

> HI !
> 
> 
> Minor cleanup: drop unnecessary migrate_disable in _cpu_down
> 
> in kernel/cpu.c:_cpu_down
>     ...
>     cpumask_andnot(cpumask, cpu_online_mask, cpumask_of(cpu));
>     set_cpus_allowed_ptr(current, cpumask);
>     ...
>     migrate_disable();
>     mycpu = smp_processor_id();
>     if (mycpu == cpu) {
>             printk(KERN_ERR "Yuck! Still on unplug CPU\n!");
>             migrate_enable();
>             err = -EBUSY;
>             goto restore_cpus;
>     }
>     migrate_enable();
> 
> If we got migrated off "cpu" then we can not get migrate
> back as the cpus_allowed was updated. so if smp_processor_id(); returns
> anything != cpu we are fine even if migrated off to a third cpu between
> the mycpu = smp_processor_id() and the if (mycpu == cpu). No need for
> migration protection here.
> 
> Further the migrate disable is effectively only needed for the condition
> check in the if statement - so I think it could be replaced by:
> 
>     if (cpu==smp_processor_id()) {
>             pr_err("Yuck! Still on unplug CPU\n!");
>             err = -EBUSY;
>             goto restore_cpus;
>     }
> 
> even in the case that the cpus_allowed had not been updated.
> 
> Patch is against 3.12.13-rt21

This is checking for an anomaly, and it's in a very slow path. I feel
more comfortable with keeping the code as is, than to change it for a
micro optimization.

-- Steve


> 
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
