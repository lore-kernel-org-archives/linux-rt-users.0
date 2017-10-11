From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] locking/rtmutex: do lockdep before actual locking in
 rt_spin_lock()
Date: Wed, 11 Oct 2017 18:16:46 +0200
Message-ID: <20171011161646.baxqesjqm4sip6em@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

rt_spin_lock() should first do the lock annotation via lockdep and then
do the actual locking. That way we learn about the deadlock from lockdep
before it happens.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 79f49d73e4d0..639cfdaae72f 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1153,8 +1153,8 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
 	migrate_disable();
-	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
-- 
2.14.2
