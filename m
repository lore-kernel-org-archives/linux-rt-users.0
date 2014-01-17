From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH RT] use local spin_locks in local_lock
Date: Fri, 17 Jan 2014 20:41:58 +0100
Message-ID: <20140117194158.GB20157@opentech.at>
References: <20131229171154.GA23586@opentech.at> <20140117144729.GB5785@linutronix.de> <20140117145955.GA5637@opentech.at> <52D94891.80109@linutronix.de> <20140117153323.GA23566@opentech.at> <20140117113218.7392363d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Sami Pietikainen <Sami.Pietikainen@wapice.com>,
	Jouko Haapaluoma <jouko.haapaluoma@wapice.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140117113218.7392363d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Drop recursive call to migrate_disabel/enable for local_*lock* api
reported by Steven Rostedt.

local_lock will call migrate_disable via get_local_var - call tree is

get_locked_var
 `-> local_lock(lvar)
       `-> __local_lock(&get_local_var(lvar));
                          `--> # define get_local_var(var) (*({     
                                    migrate_disable();              
                                    &__get_cpu_var(var); }))       \

thus there should be no need to call migrate_disable/enable recursively in 
spin_try/lock/unlock. This patch addes a spin_trylock_local and replaces
the migration disabling calls by the local calls.

This patch is incomplete as it does not yet cover the _irq/_irqsave variants
by local locks. This patch requires the API cleanup in kernel/softirq.c or
it would break softirq_lock/unlock with respect to migration.

on top of -rt9 with timers-do-not-raise-softirq-unconditionally.patch removed
and API-cleanup-use-local_lock-not-__local_lock-for-soft.patch applied.

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 include/linux/locallock.h   |    8 ++++----
 include/linux/spinlock_rt.h |    1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index e7bd8be..32c684b 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -39,7 +39,7 @@ struct local_irq_lock {
 static inline void __local_lock(struct local_irq_lock *lv)
 {
 	if (lv->owner != current) {
-		spin_lock(&lv->lock);
+		spin_lock_local(&lv->lock);
 		LL_WARN(lv->owner);
 		LL_WARN(lv->nestcnt);
 		lv->owner = current;
@@ -52,7 +52,7 @@ static inline void __local_lock(struct local_irq_lock *lv)
 
 static inline int __local_trylock(struct local_irq_lock *lv)
 {
-	if (lv->owner != current && spin_trylock(&lv->lock)) {
+	if (lv->owner != current && spin_trylock_local(&lv->lock)) {
 		LL_WARN(lv->owner);
 		LL_WARN(lv->nestcnt);
 		lv->owner = current;
@@ -79,7 +79,7 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 		return;
 
 	lv->owner = NULL;
-	spin_unlock(&lv->lock);
+	spin_unlock_local(&lv->lock);
 }
 
 #define local_unlock(lvar)					\
@@ -211,7 +211,7 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 		&__get_cpu_var(var);					\
 	}))
 
-#define put_locked_var(lvar, var)		local_unlock(lvar)
+#define put_locked_var(lvar, var)	local_unlock(lvar);
 
 #define local_lock_cpu(lvar)						\
 	({								\
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index b3c504b..4f91114 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -37,6 +37,7 @@ extern void __lockfunc __rt_spin_lock(struct rt_mutex *lock);
 extern void __lockfunc __rt_spin_unlock(struct rt_mutex *lock);
 
 #define spin_lock_local(lock)			rt_spin_lock(lock)
+#define spin_trylock_local(lock)		rt_spin_trylock(lock)
 #define spin_unlock_local(lock)			rt_spin_unlock(lock)
 
 #define spin_lock(lock)				\
-- 
1.7.2.5
