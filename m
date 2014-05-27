From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3.14-rt] sched/numa: Fix task_numa_free() lockdep splat
Date: Tue, 27 May 2014 14:52:01 -0400
Message-ID: <20140527145201.6e79230f@gandalf.local.home>
References: <20140509181214.GK29014@linutronix.de>
	<1400297819.9493.11.camel@marge.simpson.net>
	<20140527141836.4f466086@gandalf.local.home>
	<20140527182541.GH11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Sasha Levin <sasha.levin@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:49387 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751706AbaE0SwF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 May 2014 14:52:05 -0400
In-Reply-To: <20140527182541.GH11096@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 27 May 2014 20:25:41 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> Nope, its really IRQs.
> 
> do_exit()
>   exit_itimers()
>     itimer_delete()
>       spin_lock_irqsave(&timer->it_lock, &flags);
>       timer_delete_hook(timer);
>         kc->timer_del(timer) := posix_cpu_timer_del()
>           put_task_struct()
>             __put_task_struct()
>               task_numa_free()
>                 spin_lock(&grp->lock);
> 
> Which nests the grp->lock inside the timer->it_lock, and where the
> timer->it_lock is IRQ-safe, the grp->lock is not.
> 
> This allows for IRQ deadlocks.

Ah crap. I did a search on all the callers of put_task_struct(), and
somehow missed this one.  Yep, I was looking for places that called
this while holding other irq safe locks.

-- Steve

