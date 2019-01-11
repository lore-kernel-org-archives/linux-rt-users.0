From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] rtmutex/rwlock: preserve state like a sleeping lock
Date: Fri, 11 Jan 2019 21:22:57 +0100
Message-ID: <20190111202257.5wcqht6nwx7y6lmy@linutronix.de>
References: <20181119194619.GA32121@zipoli.concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "julia@ni.com" <julia@ni.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Joe Korty <Joe.Korty@concurrent-rt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119194619.GA32121@zipoli.concurrent-rt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The rwlock is spinning while acquiring a lock. Therefore it must become
a sleeping lock on RT and preserve its task state while sleeping and
waiting for the lock.

Reported-by: Joe Korty <Joe.Korty@concurrent-rt.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rwlock-rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index f2e155b2c4a8b..c3b91205161cc 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -128,7 +128,7 @@ void __sched __read_rt_lock(struct rt_rw_lock *lock)
 	 * That would put Reader1 behind the writer waiting on
 	 * Reader2 to call read_unlock() which might be unbound.
 	 */
-	rt_mutex_init_waiter(&waiter, false);
+	rt_mutex_init_waiter(&waiter, true);
 	rt_spin_lock_slowlock_locked(m, &waiter, flags);
 	/*
 	 * The slowlock() above is guaranteed to return with the rtmutex is
-- 
2.20.1
