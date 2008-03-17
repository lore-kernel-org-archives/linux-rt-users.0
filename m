From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH] fix misplaced mb() in rcu_enter/exit_nohz()
Date: Mon, 17 Mar 2008 23:17:41 +0300
Message-ID: <20080317201741.GA92@tv-sign.ru>
References: <20080317010821.GA29875@linux.vnet.ibm.com> <20080317183047.GA188@tv-sign.ru> <20080317190605.GG10955@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, ego@in.ibm.com,
	dipankar@in.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	akpm@linux-foundation.org, josh@freedesktop.org,
	tglx@linutronix.de, niv@us.ibm.com
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from x346.tv-sign.ru ([89.108.83.215]:53484 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbYCQUSM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Mar 2008 16:18:12 -0400
Content-Disposition: inline
In-Reply-To: <20080317190605.GG10955@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

(to clarify: my question is completely offtopic to this patch)

On 03/17, Paul E. McKenney wrote:
>
> On Mon, Mar 17, 2008 at 09:30:47PM +0300, Oleg Nesterov wrote:
> > On 03/16, Paul E. McKenney wrote:
> > > 
> > > In the process of writing up the mechanical proof of correctness for the
> > > dynticks/preemptable-RCU interface, I noticed misplaced memory barriers
> > > in rcu_enter_nohz() and rcu_exit_nohz().
> > 
> > Can't comment this patch, there is no rcu_enter_nohz() in my rcupreempt.h ;)
> 
> It is in 2.6.25-rc4 and later.  ;-)

Ah, for some reasons I'm still with -rc2 ...

> > I'm not sure the code below is up to date, but what I have in
> > arch/s390/kernel/time.c is:
> > 
> > 	stop_hz_timer:
> > 
> > 		cpu_set(cpu, nohz_cpu_mask);
> > 		
> > 		if (rcu_needs_cpu(cpu) || local_softirq_pending()) {
> > 			cpu_clear(cpu, nohz_cpu_mask);
> > 			return;
> > 		}
> > 
> > Don't we need smp_mb() after cpu_set() ?
> 
> S390's memory model is quite strong, so it might not be needed.

OK, in that case we shouldn't worry.

> In any
> case, if needed, it goes -before- the cpu_set(), because the problems
> would arise if prior RCU read-side critical sections were to be reordered
> to follow this cpu_set(), right?

No, but it is very possible I missed something.

What if rcu_needs_cpu(cpu) is executed before cpu_set(cpu, nohz_cpu_mask)?
It can miss rcu_start_batch() -> rcp->cur++ and return false, but at the
same time rcu_start_batch() may see nohz_cpu_mask without this CPU.

No?

Oleg.

