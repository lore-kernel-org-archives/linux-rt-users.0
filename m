From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Tue, 8 Sep 2015 10:09:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509080959460.15006@nanos>
References: <20150904011900.730816481@goodmis.org> <alpine.DEB.2.11.1509051217330.15006@nanos> <20150905120457.GA21338@gmail.com> <alpine.DEB.2.11.1509070959440.15006@nanos> <20150908073116.GA6565@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33334 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbbIHIKJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Sep 2015 04:10:09 -0400
In-Reply-To: <20150908073116.GA6565@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 8 Sep 2015, Ingo Molnar wrote:
> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > 3) sched_yield() makes me shudder
> > 
> >    CPU0			CPU1	
> > 
> >    taskA
> >      lock(x->lock)
> > 
> >    preemption
> >    taskC
> > 			taskB
> > 			  lock(y->lock);
> > 			  x = y->x;
> > 			  if (!try_lock(x->lock)) {
> > 			    unlock(y->lock);
> > 			    boost(taskA);
> > 			    sched_yield();  <- returns immediately
> 
> So I'm still struggling with properly parsing the usecase.
> 
> If y->x might become invalid the moment we drop y->lock, what makes
> the 'taskA' use (after we've dropped y->lock) safe? Shouldn't we at
> least also have a task_get(taskA)/task_put(taskA) reference count,
> to make sure the boosted task stays around?

Stevens trylock_and_boost() function makes sure that taskA cannot go
away while doing the boosting. It's a bug in my pseudo code, but that
does not make the issue above going away.
 
> And if we are into getting reference counts, why not solve it at a
> higher level and get a reference count to 'x' to make sure it's safe
> to use? Then we could do:
>
>         lock(y->lock);
> retry:
> 	x = y->x;
>         if (!trylock(x->lock)) {
> 		get_ref(x->count)
>                 unlock(y->lock);
>                 lock(x->lock);
>                 lock(y->lock);
> 		put_ref(x->count);
> 		if (y->x != x) { /* Retry if 'x' got dropped meanwhile */
> 			unlock(x->lock);
> 			goto retry;
> 		}
>         }
> 
> Or so.

In the case of dcache::dentry_kill() we probably do not have to take
refcounts and it might be actually counterproductive to do so. y->x,
i.e. dentry->parent, cannot vanish under us, if I understand the life
time rules correctly.

Aside of that, yes, I was thinking about a similar scheme for
that. I need some more time to grok all the rules there :)

Thanks,

	tglx


 
