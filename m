From: Mike Galbraith <efault@gmx.de>
Subject: [rt-patch 2/3] sched: Introduce raw_cond_resched_lock()
Date: Sat, 28 Jul 2018 11:07:22 +0200
Message-ID: <1532768842.9882.72.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532764179.9882.14.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Add raw_cond_resched_lock() infrastructure.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 include/linux/sched.h |   15 +++++++++++++++
 kernel/sched/core.c   |   20 ++++++++++++++++++++
 2 files changed, 35 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1779,12 +1779,18 @@ static inline int _cond_resched(void) {
 })
 
 extern int __cond_resched_lock(spinlock_t *lock);
+extern int __raw_cond_resched_lock(raw_spinlock_t *lock);
 
 #define cond_resched_lock(lock) ({				\
 	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
 	__cond_resched_lock(lock);				\
 })
 
+#define raw_cond_resched_lock(lock) ({				\
+	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
+	__raw_cond_resched_lock(lock);				\
+})
+
 #ifndef CONFIG_PREEMPT_RT_FULL
 extern int __cond_resched_softirq(void);
 
@@ -1817,6 +1823,15 @@ static inline int spin_needbreak(spinloc
 #else
 	return 0;
 #endif
+}
+
+static inline int raw_spin_needbreak(raw_spinlock_t *lock)
+{
+#ifdef CONFIG_PREEMPT
+	return raw_spin_is_contended(lock);
+#else
+	return 0;
+#endif
 }
 
 static __always_inline bool need_resched(void)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5065,6 +5065,26 @@ int __cond_resched_lock(spinlock_t *lock
 }
 EXPORT_SYMBOL(__cond_resched_lock);
 
+int __raw_cond_resched_lock(raw_spinlock_t *lock)
+{
+	int resched = should_resched(PREEMPT_LOCK_OFFSET);
+	int ret = 0;
+
+	lockdep_assert_held(lock);
+
+	if (raw_spin_needbreak(lock) || resched) {
+		raw_spin_unlock(lock);
+		if (resched)
+			preempt_schedule_common();
+		else
+			cpu_relax();
+		ret = 1;
+		raw_spin_lock(lock);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(__raw_cond_resched_lock);
+
 #ifndef CONFIG_PREEMPT_RT_FULL
 int __sched __cond_resched_softirq(void)
 {
