From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/7] rt: Drop mutex_disable() on !DEBUG configs and the GPL suffix from
 export symbol
Date: Wed, 08 Mar 2017 15:22:30 -0500
Message-ID: <20170308202254.085804811@goodmis.org>
References: <20170308202227.841639815@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>, Alex Goins <agoins@nvidia.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753934AbdCHU0I (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Mar 2017 15:26:08 -0500
Content-Disposition: inline; filename=0003-rt-Drop-mutex_disable-on-DEBUG-configs-and-the-GPL-s.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.12.70-rt95-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/mutex_rt.h | 5 +++++
 kernel/rtmutex.c         | 3 +--
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
diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 43d98d373809..63ac099b3b8d 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -2004,8 +2004,7 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 	lock->magic = NULL;
 #endif
 }
-
-EXPORT_SYMBOL_GPL(rt_mutex_destroy);
+EXPORT_SYMBOL(rt_mutex_destroy);
 
 /**
  * __rt_mutex_init - initialize the rt lock
-- 
2.10.2


