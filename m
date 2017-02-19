From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.11-rt9
Date: Sun, 19 Feb 2017 16:51:46 +0100
Message-ID: <20170219155145.do2ea3z5eqb3iu5k@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.9.11-rt9 patch set. 

Changes since v4.9.11-rt8:

  - rt_mutex_destroy() is EXPORT_SYMBOL_GPL again. As pointed by Peter
    Zijlstra, the removal of _GPL is not required.

  - Added a rescheduling point so we don't forget to run a runnable task
    at elevated priority under certain circumstances.

  - The static initializes for PER_CPU locks were wrong. This affects
    the local_locks and resulted in lockdep disabling itself a few
    minutes after boot on _big_ iron (100 CPUs+). Reported by Mike
    Galbraith and patched by Thomas Gleixner.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.9.11-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.11-rt8-rt9.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.11-rt9

The RT patch against v4.9.11 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.11-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.11-rt9.tar.xz

Sebastian
diff --git a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -496,6 +496,7 @@ static inline int module_is_live(struct module *mod)
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -139,6 +139,7 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 #endif
 
 extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align);
+extern bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr);
 extern bool is_kernel_percpu_address(unsigned long addr);
 
 #if !defined(CONFIG_SMP) || !defined(CONFIG_HAVE_SETUP_PER_CPU_AREA)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -658,6 +658,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	struct lockdep_subclass_key *key;
 	struct hlist_head *hash_head;
 	struct lock_class *class;
+	bool is_static = false;
 
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
 		debug_locks_off();
@@ -671,10 +672,23 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 
 	/*
 	 * Static locks do not have their class-keys yet - for them the key
-	 * is the lock object itself:
+	 * is the lock object itself. If the lock is in the per cpu area,
+	 * the canonical address of the lock (per cpu offset removed) is
+	 * used.
 	 */
-	if (unlikely(!lock->key))
-		lock->key = (void *)lock;
+	if (unlikely(!lock->key)) {
+		unsigned long can_addr, addr = (unsigned long)lock;
+
+		if (__is_kernel_percpu_address(addr, &can_addr))
+			lock->key = (void *)can_addr;
+		else if (__is_module_percpu_address(addr, &can_addr))
+			lock->key = (void *)can_addr;
+		else if (static_obj(lock))
+			lock->key = (void *)lock;
+		else
+			return ERR_PTR(-EINVAL);
+		is_static = true;
+	}
 
 	/*
 	 * NOTE: the class-key must be unique. For dynamic locks, a static
@@ -706,7 +720,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 		}
 	}
 
-	return NULL;
+	return is_static || static_obj(lock->key) ? NULL : ERR_PTR(-EINVAL);
 }
 
 /*
@@ -724,19 +738,18 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
 	class = look_up_lock_class(lock, subclass);
-	if (likely(class))
+	if (likely(!IS_ERR_OR_NULL(class)))
 		goto out_set_class_cache;
 
 	/*
 	 * Debug-check: all keys must be persistent!
- 	 */
-	if (!static_obj(lock->key)) {
+	 */
+	if (IS_ERR(class)) {
 		debug_locks_off();
 		printk("INFO: trying to register non-static key.\n");
 		printk("the code is fine but needs lockdep annotation.\n");
 		printk("turning off the locking correctness validator.\n");
 		dump_stack();
-
 		return NULL;
 	}
 
@@ -3410,7 +3423,7 @@ static int match_held_lock(struct held_lock *hlock, struct lockdep_map *lock)
 		 * Clearly if the lock hasn't been acquired _ever_, we're not
 		 * holding it either, so report failure.
 		 */
-		if (!class)
+		if (IS_ERR_OR_NULL(class))
 			return 0;
 
 		/*
@@ -4161,7 +4174,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		 * If the class exists we look it up and zap it:
 		 */
 		class = look_up_lock_class(lock, j);
-		if (class)
+		if (!IS_ERR_OR_NULL(class))
 			zap_class(class);
 	}
 	/*
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2211,7 +2211,8 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 	lock->magic = NULL;
 #endif
 }
-EXPORT_SYMBOL(rt_mutex_destroy);
+
+EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
 /**
  * __rt_mutex_init - initialize the rt lock
diff --git a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -660,16 +660,7 @@ static void percpu_modcopy(struct module *mod,
 		memcpy(per_cpu_ptr(mod->percpu, cpu), from, size);
 }
 
-/**
- * is_module_percpu_address - test whether address is from module static percpu
- * @addr: address to test
- *
- * Test whether @addr belongs to module static percpu area.
- *
- * RETURNS:
- * %true if @addr is from module static percpu area
- */
-bool is_module_percpu_address(unsigned long addr)
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 	struct module *mod;
 	unsigned int cpu;
@@ -683,9 +674,11 @@ bool is_module_percpu_address(unsigned long addr)
 			continue;
 		for_each_possible_cpu(cpu) {
 			void *start = per_cpu_ptr(mod->percpu, cpu);
+			void *va = (void *)addr;
 
-			if ((void *)addr >= start &&
-			    (void *)addr < start + mod->percpu_size) {
+			if (va >= start && va < start + mod->percpu_size) {
+				if (can_addr)
+					*can_addr = (unsigned long) (va - start);
 				preempt_enable();
 				return true;
 			}
@@ -696,6 +689,20 @@ bool is_module_percpu_address(unsigned long addr)
 	return false;
 }
 
+/**
+ * is_module_percpu_address - test whether address is from module static percpu
+ * @addr: address to test
+ *
+ * Test whether @addr belongs to module static percpu area.
+ *
+ * RETURNS:
+ * %true if @addr is from module static percpu area
+ */
+bool is_module_percpu_address(unsigned long addr)
+{
+	return __is_module_percpu_address(addr, NULL);
+}
+
 #else /* ... !CONFIG_SMP */
 
 static inline void __percpu *mod_percpu(struct module *mod)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1730,12 +1730,11 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 #ifdef CONFIG_SMP
 		if (tsk_nr_cpus_allowed(p) > 1 && rq->dl.overloaded)
 			queue_push_tasks(rq);
-#else
+#endif
 		if (dl_task(rq->curr))
 			check_preempt_curr_dl(rq, p, 0);
 		else
 			resched_curr(rq);
-#endif
 	}
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2200,10 +2200,9 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 #ifdef CONFIG_SMP
 		if (tsk_nr_cpus_allowed(p) > 1 && rq->rt.overloaded)
 			queue_push_tasks(rq);
-#else
+#endif /* CONFIG_SMP */
 		if (p->prio < rq->curr->prio)
 			resched_curr(rq);
-#endif /* CONFIG_SMP */
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
diff --git a/mm/percpu.c b/mm/percpu.c
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1280,6 +1280,28 @@ void free_percpu(void __percpu *ptr)
 }
 EXPORT_SYMBOL_GPL(free_percpu);
 
+bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
+{
+#ifdef CONFIG_SMP
+	const size_t static_size = __per_cpu_end - __per_cpu_start;
+	void __percpu *base = __addr_to_pcpu_ptr(pcpu_base_addr);
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		void *start = per_cpu_ptr(base, cpu);
+		void *va = (void *)addr;
+
+		if (va >= start && va < start + static_size) {
+			if (can_addr)
+				*can_addr = (unsigned long) (va - start);
+			return true;
+		}
+	}
+#endif
+	/* on UP, can't distinguish from other static vars, always false */
+	return false;
+}
+
 /**
  * is_kernel_percpu_address - test whether address is from static percpu area
  * @addr: address to test
@@ -1293,20 +1315,7 @@ EXPORT_SYMBOL_GPL(free_percpu);
  */
 bool is_kernel_percpu_address(unsigned long addr)
 {
-#ifdef CONFIG_SMP
-	const size_t static_size = __per_cpu_end - __per_cpu_start;
-	void __percpu *base = __addr_to_pcpu_ptr(pcpu_base_addr);
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu) {
-		void *start = per_cpu_ptr(base, cpu);
-
-		if ((void *)addr >= start && (void *)addr < start + static_size)
-			return true;
-        }
-#endif
-	/* on UP, can't distinguish from other static vars, always false */
-	return false;
+	return __is_kernel_percpu_address(addr, NULL);
 }
 
 /**
