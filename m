From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 15:42:59 +0100
Message-ID: <1487256179.28442.8.camel@gmx.de>
References: <1487224986.5258.45.camel@gmx.de>
         <alpine.DEB.2.20.1702160933420.3543@nanos>
         <1487235000.5258.48.camel@gmx.de>
         <alpine.DEB.2.20.1702161001100.3543@nanos>
         <20170216110618.GC6557@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170216110618.GC6557@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-02-16 at 12:06 +0100, Peter Zijlstra wrote:
> On Thu, Feb 16, 2017 at 10:01:18AM +0100, Thomas Gleixner wrote:
> > On Thu, 16 Feb 2017, Mike Galbraith wrote:
> > 
> > > On Thu, 2017-02-16 at 09:37 +0100, Thomas Gleixner wrote:
> > > > On Thu, 16 Feb 2017, Mike Galbraith wrote:
> > > > 
> > > ...
> > > > > swapvec_lock?  Oodles of 'em?  Nope.
> > > > 
> > > > Well, it's a per cpu lock and the lru_cache_add() variants might be called
> > > > from a gazillion of different call chains, but yes, it does not make a lot
> > > > of sense. We'll have a look.
> > > 
> > > Adding explicit local_irq_lock_init() makes things heaps better, so
> > > presumably we need better lockdep-foo in DEFINE_LOCAL_IRQ_LOCK().
> > 
> > Bah.
> 
> 
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> #define PER_CPU_DEP_MAP_INIT(lockname)                          \
>         .dep_map = {                                            \
>                 .key = ({ static struct lock_class_key __key; &__key }), \
>                 .name = #lockname,                              \
>         }
> #else
> #define PER_CPU_DEP_MAP_INIT(lockname)
> #endif
> 
> #define DEFINE_LOCAL_IRQ_LOCK(lvar)                             \
>         DEFINE_PER_CPU(struct local_irq_lock, lvar) = {         \
>                 .lock = { .rlock = {                            \
>                         .raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,  \
>                         SPIN_DEBUG_INIT(lvar)                   \
>                         PER_CPU_DEP_MAP_INIT(lvar)              \
>                 } }                                             \
>         }
> 
> That's fairly horrible for poking inside all the internals, but it might
> just work ;-

Weeell, I'm trying to cobble something kinda like that together using
__RT_SPIN_INITIALIZER() instead, but seems mean ole Mr. Compiler NAKs
the PER_CPU_DEP_MAP_INIT() thingy.

  CC      mm/swap.o
mm/swap.c:54:689: error: braced-group within expression allowed only
inside a function

	-Mike
