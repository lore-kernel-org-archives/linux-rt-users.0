From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Tue, 8 Sep 2015 09:31:16 +0200
Message-ID: <20150908073116.GA6565@gmail.com>
References: <20150904011900.730816481@goodmis.org>
 <alpine.DEB.2.11.1509051217330.15006@nanos>
 <20150905120457.GA21338@gmail.com>
 <alpine.DEB.2.11.1509070959440.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1509070959440.15006@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> 3) sched_yield() makes me shudder
> 
>    CPU0			CPU1	
> 
>    taskA
>      lock(x->lock)
> 
>    preemption
>    taskC
> 			taskB
> 			  lock(y->lock);
> 			  x = y->x;
> 			  if (!try_lock(x->lock)) {
> 			    unlock(y->lock);
> 			    boost(taskA);
> 			    sched_yield();  <- returns immediately

So I'm still struggling with properly parsing the usecase.

If y->x might become invalid the moment we drop y->lock, what makes the 'taskA' 
use (after we've dropped y->lock) safe? Shouldn't we at least also have a 
task_get(taskA)/task_put(taskA) reference count, to make sure the boosted task 
stays around?

And if we are into getting reference counts, why not solve it at a higher level 
and get a reference count to 'x' to make sure it's safe to use? Then we could do:

        lock(y->lock);
retry:
	x = y->x;
        if (!trylock(x->lock)) {
		get_ref(x->count)
                unlock(y->lock);
                lock(x->lock);
                lock(y->lock);
		put_ref(x->count);
		if (y->x != x) { /* Retry if 'x' got dropped meanwhile */
			unlock(x->lock);
			goto retry;
		}
        }

Or so.

Note how much safer this sequence is, and still just as fast in the common case 
(which I suppose is the main motivation within dcache.c?).

Thanks,

	Ingo
