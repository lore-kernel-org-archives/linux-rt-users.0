From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: KVM and Prempt?
Date: Mon, 22 Oct 2007 11:14:05 -0700
Message-ID: <1193076845.5738.23.camel@sven.thebigcorporation.com>
References: <003F437218F04842B2A6976FA19368B1886B99@ERLM863A.ww001.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Back, Michael (ext)" <michael.back.ext@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:58975 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbXJVSTT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2007 14:19:19 -0400
In-Reply-To: <003F437218F04842B2A6976FA19368B1886B99@ERLM863A.ww001.siemens.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-10-22 at 09:01 +0200, Back, Michael (ext) wrote:
> Hallo,
> I tried to run Windows XP with KVM on Linux 2.6.31.1 on a 

You mean .21.1 ? 

> AMD Opteron and on a Intel Xeon, on both it works fine!

> After this test I patch the kernel with the current prempt-patch and on
> both it doesn't works! 

Did you try against 2.6.23-rt1.

If you must stay on .21, you might have some other issues with the AMD
and NUMA.

At the very least, you will need to apply the attached patch from git
somehow, although this patch is against a new scheduler post 2.6.22, so
good luck :)

Sven

> -> After a very short time - I could see the windows startup screen -
> the complied system froze!
>  
> Has you ever tried to do the same and it works?
> Or will KVM with Windows on a prempt kernel 
> - never work?
> - maybe work in the future?
> - should now work but this .. and this ... should be done and consider?
> 
> With best regards,
> Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




diff-tree e107be36efb2a233833e8c9899039a370e4b2318 (from b47e8608a08766ef8121cd747d3aaf6c3dc22649)
Author: Avi Kivity <avi@qumranet.com>
Date:   Thu Jul 26 13:40:43 2007 +0200

    [PATCH] sched: arch preempt notifier mechanism
    
    This adds a general mechanism whereby a task can request the scheduler to
    notify it whenever it is preempted or scheduled back in.  This allows the
    task to swap any special-purpose registers like the fpu or Intel's VT
    registers.
    
    Signed-off-by: Avi Kivity <avi@qumranet.com>
    [ mingo@elte.hu: fixes, cleanups ]
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d0926d6..484988e 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -8,6 +8,7 @@
 
 #include <linux/thread_info.h>
 #include <linux/linkage.h>
+#include <linux/list.h>
 
 #ifdef CONFIG_DEBUG_PREEMPT
   extern void fastcall add_preempt_count(int val);
@@ -60,4 +61,47 @@ do { \
 
 #endif
 
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+
+struct preempt_notifier;
+
+/**
+ * preempt_ops - notifiers called when a task is preempted and rescheduled
+ * @sched_in: we're about to be rescheduled:
+ *    notifier: struct preempt_notifier for the task being scheduled
+ *    cpu:  cpu we're scheduled on
+ * @sched_out: we've just been preempted
+ *    notifier: struct preempt_notifier for the task being preempted
+ *    next: the task that's kicking us out
+ */
+struct preempt_ops {
+	void (*sched_in)(struct preempt_notifier *notifier, int cpu);
+	void (*sched_out)(struct preempt_notifier *notifier,
+			  struct task_struct *next);
+};
+
+/**
+ * preempt_notifier - key for installing preemption notifiers
+ * @link: internal use
+ * @ops: defines the notifier functions to be called
+ *
+ * Usually used in conjunction with container_of().
+ */
+struct preempt_notifier {
+	struct hlist_node link;
+	struct preempt_ops *ops;
+};
+
+void preempt_notifier_register(struct preempt_notifier *notifier);
+void preempt_notifier_unregister(struct preempt_notifier *notifier);
+
+static inline void preempt_notifier_init(struct preempt_notifier *notifier,
+				     struct preempt_ops *ops)
+{
+	INIT_HLIST_NODE(&notifier->link);
+	notifier->ops = ops;
+}
+
+#endif
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7c61b50..7a4de87 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -935,6 +935,11 @@ struct task_struct {
 	struct sched_class *sched_class;
 	struct sched_entity se;
 
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+	/* list of struct preempt_notifier: */
+	struct hlist_head preempt_notifiers;
+#endif
+
 	unsigned short ioprio;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	unsigned int btrace_seq;
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c64ce9c..6b06663 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -63,3 +63,6 @@ config PREEMPT_BKL
 	  Say Y here if you are building a kernel for a desktop system.
 	  Say N if you are unsure.
 
+config PREEMPT_NOTIFIERS
+	bool
+
diff --git a/kernel/sched.c b/kernel/sched.c
index 93cf241..e901aa5 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -1592,6 +1592,10 @@ static void __sched_fork(struct task_str
 	INIT_LIST_HEAD(&p->run_list);
 	p->se.on_rq = 0;
 
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+	INIT_HLIST_HEAD(&p->preempt_notifiers);
+#endif
+
 	/*
 	 * We mark the process as running here, but have not actually
 	 * inserted it onto the runqueue yet. This guarantees that
@@ -1673,6 +1677,63 @@ void fastcall wake_up_new_task(struct ta
 	task_rq_unlock(rq, &flags);
 }
 
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+
+/**
+ * preempt_notifier_register - tell me when current is being being preempted
+ *                         and rescheduled
+ */
+void preempt_notifier_register(struct preempt_notifier *notifier)
+{
+	hlist_add_head(&notifier->link, &current->preempt_notifiers);
+}
+EXPORT_SYMBOL_GPL(preempt_notifier_register);
+
+/**
+ * preempt_notifier_unregister - no longer interested in preemption notifications
+ *
+ * This is safe to call from within a preemption notifier.
+ */
+void preempt_notifier_unregister(struct preempt_notifier *notifier)
+{
+	hlist_del(&notifier->link);
+}
+EXPORT_SYMBOL_GPL(preempt_notifier_unregister);
+
+static void fire_sched_in_preempt_notifiers(struct task_struct *curr)
+{
+	struct preempt_notifier *notifier;
+	struct hlist_node *node;
+
+	hlist_for_each_entry(notifier, node, &curr->preempt_notifiers, link)
+		notifier->ops->sched_in(notifier, raw_smp_processor_id());
+}
+
+static void
+fire_sched_out_preempt_notifiers(struct task_struct *curr,
+				 struct task_struct *next)
+{
+	struct preempt_notifier *notifier;
+	struct hlist_node *node;
+
+	hlist_for_each_entry(notifier, node, &curr->preempt_notifiers, link)
+		notifier->ops->sched_out(notifier, next);
+}
+
+#else
+
+static void fire_sched_in_preempt_notifiers(struct task_struct *curr)
+{
+}
+
+static void
+fire_sched_out_preempt_notifiers(struct task_struct *curr,
+				 struct task_struct *next)
+{
+}
+
+#endif
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -1685,8 +1746,11 @@ void fastcall wake_up_new_task(struct ta
  * prepare_task_switch sets up locking and calls architecture specific
  * hooks.
  */
-static inline void prepare_task_switch(struct rq *rq, struct task_struct *next)
+static inline void
+prepare_task_switch(struct rq *rq, struct task_struct *prev,
+		    struct task_struct *next)
 {
+	fire_sched_out_preempt_notifiers(prev, next);
 	prepare_lock_switch(rq, next);
 	prepare_arch_switch(next);
 }
@@ -1728,6 +1792,7 @@ static inline void finish_task_switch(st
 	prev_state = prev->state;
 	finish_arch_switch(prev);
 	finish_lock_switch(rq, prev);
+	fire_sched_in_preempt_notifiers(current);
 	if (mm)
 		mmdrop(mm);
 	if (unlikely(prev_state == TASK_DEAD)) {
@@ -1768,7 +1833,7 @@ context_switch(struct rq *rq, struct tas
 {
 	struct mm_struct *mm, *oldmm;
 
-	prepare_task_switch(rq, next);
+	prepare_task_switch(rq, prev, next);
 	mm = next->mm;
 	oldmm = prev->active_mm;
 	/*
@@ -6335,6 +6400,10 @@ void __init sched_init(void)
 
 	set_load_weight(&init_task);
 
+#ifdef CONFIG_PREEMPT_NOTIFIERS
+	INIT_HLIST_HEAD(&init_task.preempt_notifiers);
+#endif
+
 #ifdef CONFIG_SMP
 	nr_cpu_ids = highest_cpu + 1;
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains, NULL);
