From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 07 Apr 2015 07:09:43 +0200
Message-ID: <1428383383.3152.5.camel@gmail.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-2-git-send-email-tmac@hp.com>
	 <20150406215959.4e8ad37b@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150406215959.4e8ad37b@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2015-04-06 at 21:59 -0400, Steven Rostedt wrote:
> 
> We really should have a rt_spin_trylock_in_irq() and not have the
> below if conditional.
> 
> The paths that will be executed in hard irq context are static. They
> should be labeled as such.

I did it as an explicitly labeled special purpose (naughty) pair.

---
 include/linux/spinlock_rt.h |    2 ++
 kernel/locking/rtmutex.c    |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -27,6 +27,8 @@ extern void __lockfunc rt_spin_unlock_wa
 extern int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags);
 extern int __lockfunc rt_spin_trylock_bh(spinlock_t *lock);
 extern int __lockfunc rt_spin_trylock(spinlock_t *lock);
+extern int __lockfunc rt_spin_trylock_in_irq(spinlock_t *lock);
+extern void __lockfunc rt_spin_trylock_in_irq_unlock(spinlock_t *lock);
 extern int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock);
 
 /*
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -87,7 +87,7 @@ static int rt_mutex_real_waiter(struct r
  * supports cmpxchg and if there's no debugging state to be set up
  */
 #if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_RT_MUTEXES)
-# define rt_mutex_cmpxchg(l,c,n)       (cmpxchg(&l->owner, c, n) == c)
+# define rt_mutex_cmpxchg(l,c,n)       (cmpxchg(&(l)->owner, (c), (n)) == (c))
 static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 {
        unsigned long owner, *p = (unsigned long *) &lock->owner;
@@ -1208,6 +1208,35 @@ int __lockfunc rt_spin_trylock_irqsave(s
 }
 EXPORT_SYMBOL(rt_spin_trylock_irqsave);
 
+/*
+ * Special purpose for locks taken in interrupt context: Take and hold
+ * ->wait_lock lest PI catching us with our fingers in the cookie jar.
+ * Do NOT abuse.
+ */
+int __lockfunc rt_spin_trylock_in_irq(spinlock_t *lock)
+{
+       struct task_struct *owner;
+       if (!raw_spin_trylock(&lock->lock.wait_lock))
+               return 0;
+       owner = idle_task(raw_smp_processor_id());
+       if (!(rt_mutex_cmpxchg(&lock->lock, NULL, owner))) {
+               raw_spin_unlock(&lock->lock.wait_lock);
+               return 0;
+       }
+       spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+       return 1;
+}
+
+/* ONLY for use with rt_spin_trylock_in_irq(), do NOT abuse. */
+void __lockfunc rt_spin_trylock_in_irq_unlock(spinlock_t *lock)
+{
+       struct task_struct *owner = idle_task(raw_smp_processor_id());
+       /* NOTE: we always pass in '1' for nested, for simplicity */
+       spin_release(&lock->dep_map, 1, _RET_IP_);
+       BUG_ON(!(rt_mutex_cmpxchg(&lock->lock, owner, NULL)));
+       raw_spin_unlock(&lock->lock.wait_lock);
+}
+
 int atomic_dec_and_spin_lock(atomic_t *atomic, spinlock_t *lock)
 {
        /* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
