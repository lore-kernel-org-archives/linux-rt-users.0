From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] x86/32: Use kmap switch for non highmem as well
Date: Tue, 19 Feb 2013 00:31:17 -0500
Message-ID: <20130219053159.813066899@goodmis.org>
References: <20130219053116.706325380@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-x86-32-Use-kmap-switch-for-non-highmem-as-well.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Even with CONFIG_HIGHMEM=n we need to take care of the "atomic"
mappings which are installed via iomap_atomic.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kernel/process_32.c |    2 +-
 include/linux/sched.h        |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 95f2630..4a0d37f 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -336,7 +336,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 		     task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT))
 		__switch_to_xtra(prev_p, next_p, tss);
 
-#if defined CONFIG_PREEMPT_RT_FULL && defined CONFIG_HIGHMEM
+#ifdef CONFIG_PREEMPT_RT_FULL
 	/*
 	 * Save @prev's kmap_atomic stack
 	 */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8772834..285ab45 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1602,9 +1602,11 @@ struct task_struct {
 	struct rcu_head put_rcu;
 	int softirq_nestcnt;
 #endif
-#if defined CONFIG_PREEMPT_RT_FULL && defined CONFIG_HIGHMEM
+#ifdef CONFIG_PREEMPT_RT_FULL
+# if defined CONFIG_HIGHMEM || defined CONFIG_X86_32
 	int kmap_idx;
 	pte_t kmap_pte[KM_TYPE_NR];
+# endif
 #endif
 
 #ifdef CONFIG_DEBUG_PREEMPT
-- 
1.7.10.4
