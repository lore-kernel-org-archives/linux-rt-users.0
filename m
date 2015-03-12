From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 18/36] rt: fix __ww_mutex_lock_interruptible() lockdep annotation
Date: Thu, 12 Mar 2015 15:21:57 -0400
Message-ID: <20150312192157.499105041@goodmis.org>
References: <20150312192139.799127123@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0018-rt-fix-__ww_mutex_lock_interruptible-lockdep-annotat.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.38-rt53-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

Using mutex_acquire_nest() as used in __ww_mutex_lock() fixes the
splat below.  Remove superfluous line break in __ww_mutex_lock()
as well.

|=============================================
|[ INFO: possible recursive locking detected ]
|3.14.4-rt5 #26 Not tainted
|---------------------------------------------
|Xorg/4298 is trying to acquire lock:
| (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffa02b4270>] nouveau_gem_ioctl_pushbuf+0x870/0x19f0 [nouveau]
|but task is already holding lock:
| (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffa02b4270>] nouveau_gem_ioctl_pushbuf+0x870/0x19f0 [nouveau]
|other info that might help us debug this:
| Possible unsafe locking scenario:
|       CPU0
|       ----
|  lock(reservation_ww_class_mutex);
|  lock(reservation_ww_class_mutex);
|
| *** DEADLOCK ***
|
| May be due to missing lock nesting notation
|
|3 locks held by Xorg/4298:
| #0:  (&cli->mutex){+.+.+.}, at: [<ffffffffa02b597b>] nouveau_abi16_get+0x2b/0x100 [nouveau]
| #1:  (reservation_ww_class_acquire){+.+...}, at: [<ffffffffa0160cd2>] drm_ioctl+0x4d2/0x610 [drm]
| #2:  (reservation_ww_class_mutex){+.+.+.}, at: [<ffffffffa02b4270>] nouveau_gem_ioctl_pushbuf+0x870/0x19f0 [nouveau]

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rtmutex.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 77f50d221d9c..76cb88027fc2 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -2165,7 +2165,7 @@ __ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ww_c
 
 	might_sleep();
 
-	mutex_acquire(&lock->base.dep_map, 0, 0, _RET_IP_);
+	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
 	ret = rt_mutex_slowlock(&lock->base.lock, TASK_INTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
@@ -2183,8 +2183,7 @@ __ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
 
 	might_sleep();
 
-	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map,
-			_RET_IP_);
+	mutex_acquire_nest(&lock->base.dep_map, 0, 0, &ww_ctx->dep_map, _RET_IP_);
 	ret = rt_mutex_slowlock(&lock->base.lock, TASK_UNINTERRUPTIBLE, NULL, 0, ww_ctx);
 	if (ret)
 		mutex_release(&lock->base.dep_map, 1, _RET_IP_);
-- 
2.1.4
