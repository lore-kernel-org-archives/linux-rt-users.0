From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/7] lockdep: Handle statically initialized PER_CPU locks proper
Date: Wed, 08 Mar 2017 15:30:11 -0500
Message-ID: <20170308203022.426593196@goodmis.org>
References: <20170308203007.731237400@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Mike Galbraith <efault@gmx.de>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-lockdep-Handle-statically-initialized-PER_CPU-locks-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.105-rt120-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

If a PER_CPU struct which contains a spin_lock is statically initialized
via:

DEFINE_PER_CPU(struct foo, bla) = {
	.lock = __SPIN_LOCK_UNLOCKED(bla.lock)
};

then lockdep assigns a seperate key to each lock because the logic for
assigning a key to statically initialized locks is to use the address as
the key. With per CPU locks the address is obvioulsy different on each CPU.

That's wrong, because all locks should have the same key.

To solve this the following modifications are required:

 1) Extend the is_kernel/module_percpu_addr() functions to hand back the
    canonical address of the per CPU address, i.e. the per CPU address
    minus the per CPU offset.

 2) Check the lock address with these functions and if the per CPU check
    matches use the returned canonical address as the lock key, so all per
    CPU locks have the same key.

 3) Move the static_obj(key) check into look_up_lock_class() so this check
    can be avoided for statically initialized per CPU locks.  That's
    required because the canonical address fails the static_obj(key) check
    for obvious reasons.

Reported-by: Mike Galbraith <efault@gmx.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/module.h |  1 +
 include/linux/percpu.h |  1 +
 kernel/lockdep.c       | 32 +++++++++++++++++++++++---------
 kernel/module.c        | 31 +++++++++++++++++++------------
 mm/percpu.c            | 37 +++++++++++++++++++++++--------------
 5 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 761dc2848ffa..f75ab887838d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -394,6 +394,7 @@ static inline int module_is_live(struct module *mod)
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 12b394f75d8e..aa2799e07b88 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -176,6 +176,7 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 #endif
 
 extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align);
+extern bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr);
 extern bool is_kernel_percpu_address(unsigned long addr);
 
 #if !defined(CONFIG_SMP) || !defined(CONFIG_HAVE_SETUP_PER_CPU_AREA)
diff --git a/kernel/lockdep.c b/kernel/lockdep.c
index 6cbe12c0fc34..092fe64a49f6 100644
--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -650,6 +650,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
 	struct lock_class *class;
+	bool is_static = false;
 
 #ifdef CONFIG_DEBUG_LOCKDEP
 	/*
@@ -677,10 +678,23 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 
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
@@ -710,7 +724,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 		}
 	}
 
-	return NULL;
+	return is_static || static_obj(lock->key) ? NULL : ERR_PTR(-EINVAL);
 }
 
 /*
@@ -727,13 +741,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	unsigned long flags;
 
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
@@ -3275,7 +3289,7 @@ static int match_held_lock(struct held_lock *hlock, struct lockdep_map *lock)
 		 * Clearly if the lock hasn't been acquired _ever_, we're not
 		 * holding it either, so report failure.
 		 */
-		if (!class)
+		if (IS_ERR_OR_NULL(class))
 			return 0;
 
 		/*
@@ -3937,7 +3951,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		 * If the class exists we look it up and zap it:
 		 */
 		class = look_up_lock_class(lock, j);
-		if (class)
+		if (!IS_ERR_OR_NULL(class))
 			zap_class(class);
 	}
 	/*
diff --git a/kernel/module.c b/kernel/module.c
index 2c87e521032b..2e32c2b42e3a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -524,16 +524,7 @@ static void percpu_modcopy(struct module *mod,
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
@@ -547,9 +538,11 @@ bool is_module_percpu_address(unsigned long addr)
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
@@ -560,6 +553,20 @@ bool is_module_percpu_address(unsigned long addr)
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
diff --git a/mm/percpu.c b/mm/percpu.c
index 25e2ea52db82..b96d41d20b1e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -946,18 +946,7 @@ void free_percpu(void __percpu *ptr)
 }
 EXPORT_SYMBOL_GPL(free_percpu);
 
-/**
- * is_kernel_percpu_address - test whether address is from static percpu area
- * @addr: address to test
- *
- * Test whether @addr belongs to in-kernel static percpu area.  Module
- * static percpu areas are not considered.  For those, use
- * is_module_percpu_address().
- *
- * RETURNS:
- * %true if @addr is from in-kernel static percpu area, %false otherwise.
- */
-bool is_kernel_percpu_address(unsigned long addr)
+bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 #ifdef CONFIG_SMP
 	const size_t static_size = __per_cpu_end - __per_cpu_start;
@@ -966,16 +955,36 @@ bool is_kernel_percpu_address(unsigned long addr)
 
 	for_each_possible_cpu(cpu) {
 		void *start = per_cpu_ptr(base, cpu);
+		void *va = (void *)addr;
 
-		if ((void *)addr >= start && (void *)addr < start + static_size)
+		if (va >= start && va < start + static_size) {
+			if (can_addr)
+				*can_addr = (unsigned long) (va - start);
 			return true;
-        }
+		}
+	}
 #endif
 	/* on UP, can't distinguish from other static vars, always false */
 	return false;
 }
 
 /**
+ * is_kernel_percpu_address - test whether address is from static percpu area
+ * @addr: address to test
+ *
+ * Test whether @addr belongs to in-kernel static percpu area.  Module
+ * static percpu areas are not considered.  For those, use
+ * is_module_percpu_address().
+ *
+ * RETURNS:
+ * %true if @addr is from in-kernel static percpu area, %false otherwise.
+ */
+bool is_kernel_percpu_address(unsigned long addr)
+{
+	return __is_kernel_percpu_address(addr, NULL);
+}
+
+/**
  * per_cpu_ptr_to_phys - convert translated percpu address to physical address
  * @addr: the address to be converted to physical address
  *
-- 
2.10.2
