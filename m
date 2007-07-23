From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.22.1-rt4 lockups
Date: Mon, 23 Jul 2007 22:38:58 +0200
Message-ID: <20070723203858.GA18569@elte.hu>
References: <1184325752.12353.312.camel@chaos> <46A283A1.6030005@rncbc.org> <1185206905.2573.52.camel@imap.mvista.com> <1185221746.2573.142.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rui Nuno Capela <rncbc@rncbc.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:48825 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762084AbXGWUjg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 16:39:36 -0400
Content-Disposition: inline
In-Reply-To: <1185221746.2573.142.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> It looks like sched_class->enqueue_task() is NULL and that's why the 
> system hangs ..
> 
> The reason why that happens is because check_pgt_cache() is called 
> from the idle thread, and with PREEMPT_RT check_pgt_cache() locks at 
> least one mutex .. Once the idle thread is on a wait_list, as soon as 
> it's woke by the mutex owner the system will crash in enqueue_task. 
> Since the idle thread has a NULL sched_class->enqueue_task ..
> 
> check_pgt_cache() is already getting called from the desched_thread() 
> , so I think it could just be removed from i386 cpu_idle().
> 
> Anyone have comments on the theory above?

yeah, that call definitely looks wrong in cpu_idle(). Most of the other 
check_pgd_cache() calls introduced by commit f1d1a842 look wrong too in 
an -rt context. Fix is below.

	Ingo

Index: linux-rt.q/arch/i386/kernel/process.c
===================================================================
--- linux-rt.q.orig/arch/i386/kernel/process.c
+++ linux-rt.q/arch/i386/kernel/process.c
@@ -189,7 +189,6 @@ void cpu_idle(void)
 
 			tick_nohz_stop_sched_tick();
 
-			check_pgt_cache();
 			rmb();
 			idle = pm_idle;
 
