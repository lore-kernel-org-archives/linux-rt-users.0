Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DAFC433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5219A20882
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgFPQcv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgFPQcu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 12:32:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53089C061573
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2020 09:32:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlEW0-0003w4-7D; Tue, 16 Jun 2020 18:32:48 +0200
Date:   Tue, 16 Jun 2020 18:32:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 2/2] mm: page_alloc: drain pages remotely
Message-ID: <20200616163248.z5bdrx7gj2sf7d3m@linutronix.de>
References: <20200616161149.392213902@fuller.cnet>
 <20200616161409.299575008@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616161409.299575008@fuller.cnet>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-16 13:11:51 [-0300], Marcelo Tosatti wrote:
> Remote draining of pages was removed from 5.6-rt.
> 
> Unfortunately its necessary for use-cases which have a busy spinning 
> SCHED_FIFO thread on isolated CPU:
> 
> [ 7475.821066] INFO: task ld:274531 blocked for more than 600 seconds.
> [ 7475.822157]       Not tainted 4.18.0-208.rt5.20.el8.x86_64 #1
> [ 7475.823094] echo 0  /proc/sys/kernel/hung_task_timeout_secs disables this message.
> [ 7475.824392] ld              D    0 274531 274530 0x00084080
> [ 7475.825307] Call Trace:
> [ 7475.825761]  __schedule+0x342/0x850
> [ 7475.826377]  schedule+0x39/0xd0
> [ 7475.826923]  schedule_timeout+0x20e/0x410
> [ 7475.827610]  ? __schedule+0x34a/0x850
> [ 7475.828247]  ? ___preempt_schedule+0x16/0x18
> [ 7475.828953]  wait_for_completion+0x85/0xe0
> [ 7475.829653]  flush_work+0x11a/0x1c0
> [ 7475.830313]  ? flush_workqueue_prep_pwqs+0x130/0x130
> [ 7475.831148]  drain_all_pages+0x140/0x190
> [ 7475.831803]  __alloc_pages_slowpath+0x3f8/0xe20
> [ 7475.832571]  ? mem_cgroup_commit_charge+0xcb/0x510
> [ 7475.833371]  __alloc_pages_nodemask+0x1ca/0x2b0
> [ 7475.834134]  pagecache_get_page+0xb5/0x2d0
> [ 7475.834814]  ? account_page_dirtied+0x11a/0x220
> [ 7475.835579]  grab_cache_page_write_begin+0x1f/0x40
> [ 7475.836379]  iomap_write_begin.constprop.44+0x1c1/0x370
> [ 7475.837241]  ? iomap_write_end+0x91/0x290
> [ 7475.837911]  iomap_write_actor+0x92/0x170
> ...
> 
> So enable remote draining again.

Is upstream affected by this? And if not, why not?

> Index: linux-rt-devel/mm/page_alloc.c
> ===================================================================
> --- linux-rt-devel.orig/mm/page_alloc.c
> +++ linux-rt-devel/mm/page_alloc.c
> @@ -360,6 +360,16 @@ EXPORT_SYMBOL(nr_online_nodes);
>  
>  static DEFINE_LOCAL_IRQ_LOCK(pa_lock);
>  
> +#ifdef CONFIG_PREEMPT_RT
> +# define cpu_lock_irqsave(cpu, flags)          \
> +	local_lock_irqsave_on(pa_lock, flags, cpu)
> +# define cpu_unlock_irqrestore(cpu, flags)     \
> +	local_unlock_irqrestore_on(pa_lock, flags, cpu)
> +#else
> +# define cpu_lock_irqsave(cpu, flags)		local_irq_save(flags)
> +# define cpu_unlock_irqrestore(cpu, flags)	local_irq_restore(flags)
> +#endif

This is going to be tough. I removed the cross-CPU local-locks from RT
because it does something different for !RT. Furthermore we have
local_locks in upstream as of v5.8-rc1, see commit
   91710728d1725 ("locking: Introduce local_lock()")

so whatever happens here should have upstream blessing or I will be
forced to drop the patch again while moving forward.

Before this, I looked for cases where remote drain is useful / needed
and didn't find one. I talked to Frederick and for the NO_HZ_FULL people
it is not a problem because they don't go to kernel and so they never
got anything on their per-CPU list.

We had this
  https://lore.kernel.org/linux-mm/20190424111208.24459-1-bigeasy@linutronix.de/

Sebastian
