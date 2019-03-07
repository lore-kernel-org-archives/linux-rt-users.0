Return-Path: <SRS0=0bBW=RK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14833C43381
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 12:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E440A20684
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Mar 2019 12:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfCGMia (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:38:30 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:57150 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbfCGMi3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Mar 2019 07:38:29 -0500
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h1sI4-0005vw-EB; Thu, 07 Mar 2019 13:38:24 +0100
Date:   Thu, 7 Mar 2019 13:38:24 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        gregkh@linuxfoundation.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
Message-ID: <20190307123823.fnzb7njqdib4xghk@flow>
References: <20190304172053.17340-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304172053.17340-1-julien.grall@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-04 17:20:53 [+0000], Julien Grall wrote:
> At the moment show_lock is implemented using spin_lock_t and called from
> an interrupt context on Arm64. The following backtrace was triggered by:
> 
> 42sh# echo l > /proc/sysrq-trigger
> 
> [ 4432.073756] sysrq: SysRq : Show backtrace of all active CPUs
> [ 4432.403422] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
> [ 4432.403424] sysrq: CPU6:
> [ 4432.403426] in_atomic(): 1, irqs_disabled(): 128, pid: 2410, name: kworker/u16:2
> 
> [...]
> 
> [ 4432.403581] Call trace:
> [ 4432.403584]  dump_backtrace+0x0/0x148
> [ 4432.403586]  show_stack+0x14/0x20
> [ 4432.403588]  dump_stack+0x9c/0xd4
> [ 4432.403592]  ___might_sleep+0x1cc/0x298
> [ 4432.403595]  rt_spin_lock+0x5c/0x70
> [ 4432.403596]  showacpu+0x34/0x68
> [ 4432.403599]  flush_smp_call_function_queue+0xd4/0x278
> [ 4432.403602]  generic_smp_call_function_single_interrupt+0x10/0x18
> [ 4432.403605]  handle_IPI+0x26c/0x668
> [ 4432.403607]  gic_handle_irq+0x9c/0xa0
> [ 4432.403609]  el1_irq+0xb4/0x13c
> 
> With RT-patches, spin_lock can now sleep and therefore cannot be used from
> interrupt context. Use a raw_spin_lock instead to prevent the lock to
> sleep.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>

Now that I had time to look at it, for the change itself:
	Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

For the description please take into consideration to add something like
this:

 Systems which don't provide arch_trigger_cpumask_backtrace() will
 invoke showacpu() from a smp_call_function() function which is invoked
 with disabled interrupts even on -RT systems.
 The function acquires the show_lock lock which only purpose is to
 ensure that the CPUs don't print simultaneously. Otherwise the output
 would clash and it would be hard to tell the output from CPUx apart
 from CPUy.
 On -RT the spin_lock() can not be acquired from this context. A
 raw_spin_lock() is required. It will introduce the system's latency
 by performing the sysrq request and other CPUs will block on the lock
 until the request is done. This is okay because the user asked for a
 backtrace of all active CPUs and under "normal circumstances in
 production" this path should not be triggered.

Which explains *why* you do the change and *why* it is okay to do the
change. If we start changing each spin_lock() to a raw_spin_lock()
because lockdep said so then soon the RT switch will make less change
than it should.

From top of my head I think you won't see the output on -RT right away.
The output won't be printed from the non-preemptible context and will be
delayed until a printk occurs from a preemptible context. There are
printk related patches which fix that and allow a printk from a
non-preemptible context for a configured log level.

Looking at the showacpu() construct: Do you get a proper stacktrace for a
busy CPU or does it always start at el1_irq()? Because if the interrupt
always starts with its own interrupt stack then the backtrace is
useless. All you would need is the information that the CPU is alive and
a oneline printk() saying so would be enough. Or, if it starts on its
own stack but is able to unwind to the previous context *then* you gain
additional information you are looking for.

> ---
>  drivers/tty/sysrq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 1f03078ec352..8473557c7ab2 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -208,7 +208,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
>  #endif
>  
>  #ifdef CONFIG_SMP
> -static DEFINE_SPINLOCK(show_lock);
> +static DEFINE_RAW_SPINLOCK(show_lock);
>  
>  static void showacpu(void *dummy)
>  {
> @@ -218,10 +218,10 @@ static void showacpu(void *dummy)
>  	if (idle_cpu(smp_processor_id()))
>  		return;
>  
> -	spin_lock_irqsave(&show_lock, flags);
> +	raw_spin_lock_irqsave(&show_lock, flags);
>  	pr_info("CPU%d:\n", smp_processor_id());
>  	show_stack(NULL, NULL);
> -	spin_unlock_irqrestore(&show_lock, flags);
> +	raw_spin_unlock_irqrestore(&show_lock, flags);
>  }
>  
>  static void sysrq_showregs_othercpus(struct work_struct *dummy)
> -- 
> 2.11.0
> 

Sebastian
