From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] locallock: add local_lock_bh()
Date: Fri, 13 Jul 2018 19:50:49 +0200
Message-ID: <20180713175049.nx2xg4no4zbfcnfl@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Galbraith <efault@gmx.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

For the ARM64 simd locking it would be easier to have local_lock_bh()
which grabs a local_lock with BH disabled and turns into a
local_bh_disable() on !RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
obviously required by the previous one…

 include/linux/locallock.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 921eab83cd34..15aa0dea2bfb 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -47,9 +47,23 @@ static inline void __local_lock(struct local_irq_lock *lv)
 	lv->nestcnt++;
 }
 
+static inline void __local_lock_bh(struct local_irq_lock *lv)
+{
+	if (lv->owner != current) {
+		spin_lock_bh(&lv->lock);
+		LL_WARN(lv->owner);
+		LL_WARN(lv->nestcnt);
+		lv->owner = current;
+	}
+	lv->nestcnt++;
+}
+
 #define local_lock(lvar)					\
 	do { __local_lock(&get_local_var(lvar)); } while (0)
 
+#define local_lock_bh(lvar)					\
+	do { __local_lock_bh(&get_local_var(lvar)); } while (0)
+
 #define local_lock_on(lvar, cpu)				\
 	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
 
@@ -88,12 +102,29 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 	spin_unlock(&lv->lock);
 }
 
+static inline void __local_unlock_bh(struct local_irq_lock *lv)
+{
+	LL_WARN(lv->nestcnt == 0);
+	LL_WARN(lv->owner != current);
+	if (--lv->nestcnt)
+		return;
+
+	lv->owner = NULL;
+	spin_unlock_bh(&lv->lock);
+}
+
 #define local_unlock(lvar)					\
 	do {							\
 		__local_unlock(this_cpu_ptr(&lvar));		\
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_bh(lvar)					\
+	do {							\
+		__local_unlock_bh(this_cpu_ptr(&lvar));		\
+		put_local_var(lvar);				\
+	} while (0)
+
 #define local_unlock_on(lvar, cpu)                       \
 	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
 
@@ -253,6 +284,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define local_lock(lvar)			preempt_disable()
 #define local_unlock(lvar)			preempt_enable()
+#define local_lock_bh(lvar)			local_bh_disable()
+#define local_unlock_bh(lvar)			local_bh_enable()
 #define local_lock_irq(lvar)			local_irq_disable()
 #define local_lock_irq_on(lvar, cpu)		local_irq_disable()
 #define local_unlock_irq(lvar)			local_irq_enable()
-- 
2.18.0
