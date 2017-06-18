From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Sun, 18 Jun 2017 08:46:15 +0200
Message-ID: <1497768375.8055.12.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497687277.6908.31.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497687277.6908.31.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2017-06-17 at 10:14 +0200, Mike Galbraith wrote:
> 
>... the RT workaround in futex.c induces
> grumbling in nonrt builds with PREEMPT_COUNT enabled.

A trivial way to fix it up is to...

futex: Fix migrate_disable/enable workaround for !PREEMPT_RT_FULL

The imbalance fixed by aed0f50e58eb only exists for PREEMPT_RT_FULL,
and creates for other PREEMPT_COUNT configs.  Create/use _rt variants
of migrate_disable/enable() which are compiled away when not needed.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Fixes: aed0f50e58eb ("futex: workaround migrate_disable/enable in different context")
---
 include/linux/preempt.h |   11 +++++++++++
 kernel/futex.c          |    8 ++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -227,12 +227,21 @@ do { \
 
 extern void migrate_disable(void);
 extern void migrate_enable(void);
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define migrate_disable_rt()		migrate_disable()
+#define migrate_enable_rt()		migrate_enable()
+#else
+static inline void migrate_disable_rt(void) { }
+static inline void migrate_enable_rt(void) { }
+#endif
 
 int __migrate_disabled(struct task_struct *p);
 
 #else
 #define migrate_disable()		barrier()
 #define migrate_enable()		barrier()
+static inline void migrate_disable_rt(void) { }
+static inline void migrate_enable_rt(void) { }
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
@@ -323,6 +332,8 @@ do { \
 
 #define migrate_disable()			barrier()
 #define migrate_enable()			barrier()
+static inline void migrate_disable_rt(void) { }
+static inline void migrate_enable_rt(void) { }
 
 static inline int __migrate_disabled(struct task_struct *p)
 {
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2690,12 +2690,12 @@ static int futex_lock_pi(u32 __user *uad
 	 * one migrate_disable() pending in the slow-path which is reversed
 	 * after the raw_spin_unlock_irq() where we leave the atomic context.
 	 */
-	migrate_disable();
+	migrate_disable_rt();
 
 	spin_unlock(q.lock_ptr);
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	migrate_enable();
+	migrate_enable_rt();
 
 	if (ret) {
 		if (ret == 1)
@@ -2846,13 +2846,13 @@ static int futex_unlock_pi(u32 __user *u
 		 * won't undo the migrate_disable() which was issued when
 		 * locking hb->lock.
 		 */
-		migrate_disable();
+		migrate_disable_rt();
 		spin_unlock(&hb->lock);
 
 		/* Drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
 
-		migrate_enable();
+		migrate_enable_rt();
 
 		put_pi_state(pi_state);
 
