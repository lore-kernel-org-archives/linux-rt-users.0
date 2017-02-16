From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 09:37:06 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702160933420.3543@nanos>
References: <1487224986.5258.45.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487224986.5258.45.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 16 Feb 2017, Mike Galbraith wrote:

> 4.9.10-rt6-virgin on 72 core +SMT box.
> 
> Below is 1 line per minute, box idling along daintily nibbling, I fire
> up a parallel kbuild loop at 40465, and box gobbles greedily.
> 
> I have entries bumped to 128k, and chain bits to 18 so box will get
> booted and run for a while before lockdep says "I quit".  With stock
> settings, this box will barely get booted.  Seems the bigger the box,
> the sooner you're gonna run out.  A NOPREEMPT kernel seems to nibble
> entries too, but nowhere remotely near as greedily as RT.

Right. RT adds a bunch of locks through the local lock mechanism.

>            <...>-100309 [064] d....13  2885.873312: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40129
>            <...>-92785 [047] d....12  3905.137578: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 51287

That's odd.

> With stacktrace on, buffer contains 1010 __lru_cache_add+0x4f...
> 
> (gdb) list *__lru_cache_add+0x4f
> 0xffffffff811dca9f is in __lru_cache_add (./include/linux/locallock.h:59).
> 54
> 55      static inline void __local_lock(struct local_irq_lock *lv)
> 56      {
> 57              if (lv->owner != current) {
> 58                      spin_lock_local(&lv->lock);
> 59                      LL_WARN(lv->owner);
> 60                      LL_WARN(lv->nestcnt);
> 61                      lv->owner = current;
> 62              }
> 63              lv->nestcnt++;
> 
> ...which seems to be this.
> 
> 0xffffffff811dca80 is in __lru_cache_add (mm/swap.c:397).
> 392     }
> 393     EXPORT_SYMBOL(mark_page_accessed);
> 394
> 395     static void __lru_cache_add(struct page *page)
> 396     {
> 397             struct pagevec *pvec = &get_locked_var(swapvec_lock, lru_add_pvec);
> 398
> 399             get_page(page);
> 400             if (!pagevec_add(pvec, page) || PageCompound(page))
> 401                     __pagevec_lru_add(pvec);
> 
> swapvec_lock?  Oodles of 'em?  Nope.

Well, it's a per cpu lock and the lru_cache_add() variants might be called
from a gazillion of different call chains, but yes, it does not make a lot
of sense. We'll have a look.

Thanks,

	tglx
