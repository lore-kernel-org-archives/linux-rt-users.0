From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 5/9] rt: Drop mutex_disable() on !DEBUG configs and the GPL
Date: Tue, 7 Mar 2017 16:32:55 -0600
Message-ID: <fcce6b07b910459c54d37f4f1c2cac7d60b5b34b.1488919535.git.julia@ni.com>
References: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488919535.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.38-rt46-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Alex Goins reported that mutex_destroy() on RT will force a GPL only symbol
which won't link and therefore fail on a non-GPL kernel module.
This does not happen on !RT and is a regression on RT which we would like to
avoid.
I try here the easy thing and to not use rt_mutex_destroy() if
CONFIG_DEBUG_MUTEXES is not enabled. This will still break for the DEBUG
configs so instead of adding a wrapper around rt_mutex_destroy() (which we have
for rt_mutex_lock() for instance) I am simply dropping the GPL part from the
export.

Reported-by: Alex Goins <agoins@nvidia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 93f3bd72784ed58cbba1a32b043a842f205a631f)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/mutex_rt.h | 5 +++++
 kernel/locking/rtmutex.c | 3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/mutex_rt.h b/include/linux/mutex_rt.h
index c38a44b14da5..e0284edec655 100644
--- a/include/linux/mutex_rt.h
+++ b/include/linux/mutex_rt.h
@@ -43,7 +43,12 @@ extern void __lockfunc _mutex_unlock(struct mutex *lock);
 #define mutex_lock_killable(l)		_mutex_lock_killable(l)
 #define mutex_trylock(l)		_mutex_trylock(l)
 #define mutex_unlock(l)			_mutex_unlock(l)
+
+#ifdef CONFIG_DEBUG_MUTEXES
 #define mutex_destroy(l)		rt_mutex_destroy(&(l)->lock)
+#else
+static inline void mutex_destroy(struct mutex *lock) {}
+#endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define mutex_lock_nested(l, s)	_mutex_lock_nested(l, s)
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e0b0d9b419b5..469075e06cde 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2015,8 +2015,7 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 	lock->magic = NULL;
 #endif
 }
-
-EXPORT_SYMBOL_GPL(rt_mutex_destroy);
+EXPORT_SYMBOL(rt_mutex_destroy);
 
 /**
  * __rt_mutex_init - initialize the rt lock
-- 
2.11.1
