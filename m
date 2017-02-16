From: Mike Galbraith <efault@gmx.de>
Subject: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 07:03:06 +0100
Message-ID: <1487224986.5258.45.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.10-rt6-virgin on 72 core +SMT box.

Below is 1 line per minute, box idling along daintily nibbling, I fire
up a parallel kbuild loop at 40465, and box gobbles greedily.

I have entries bumped to 128k, and chain bits to 18 so box will get
booted and run for a while before lockdep says "I quit".  With stock
settings, this box will barely get booted.  Seems the bigger the box,
the sooner you're gonna run out.  A NOPREEMPT kernel seems to nibble
entries too, but nowhere remotely near as greedily as RT.

           <...>-100309 [064] d....13  2885.873312: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40129
           <...>-104320 [116] dN..211  2959.633630: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40155
 btrfs-transacti-1955  [043] d...111  3021.073949: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40183
           <...>-118865 [120] d....13  3086.146794: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40209
  systemd-logind-4763  [068] d....11  3146.953001: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40239
           <...>-123725 [032] dN..2..  3215.735774: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40285
           <...>-33968 [031] d...1..  3347.919001: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40409
           <...>-130886 [143] d....12  3412.586643: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 40465
           <...>-138291 [037] d....11  3477.816405: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 42825
           <...>-67678 [137] d...112  3551.648282: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 47899
    ksoftirqd/45-421   [045] d....13  3617.926394: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 48751
         ihex2fw-24635 [035] d....11  3686.899690: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 49345
           <...>-76041 [047] d...111  3758.230009: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 49757
            stty-10772 [118] d...1..  3825.626815: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 50115
  kworker/u289:4-13376 [075] d....12  3896.432428: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 51189
           <...>-92785 [047] d....12  3905.137578: add_lock_to_list.isra.24.constprop.42+0x20/0x100: nr_list_entries: 51287

With stacktrace on, buffer contains 1010 __lru_cache_add+0x4f...

(gdb) list *__lru_cache_add+0x4f
0xffffffff811dca9f is in __lru_cache_add (./include/linux/locallock.h:59).
54
55      static inline void __local_lock(struct local_irq_lock *lv)
56      {
57              if (lv->owner != current) {
58                      spin_lock_local(&lv->lock);
59                      LL_WARN(lv->owner);
60                      LL_WARN(lv->nestcnt);
61                      lv->owner = current;
62              }
63              lv->nestcnt++;

...which seems to be this.

0xffffffff811dca80 is in __lru_cache_add (mm/swap.c:397).
392     }
393     EXPORT_SYMBOL(mark_page_accessed);
394
395     static void __lru_cache_add(struct page *page)
396     {
397             struct pagevec *pvec = &get_locked_var(swapvec_lock, lru_add_pvec);
398
399             get_page(page);
400             if (!pagevec_add(pvec, page) || PageCompound(page))
401                     __pagevec_lru_add(pvec);

swapvec_lock?  Oodles of 'em?  Nope.

	-Mike
