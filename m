From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 6/9] lockdep: Handle statically initialized PER_CPU locks
Date: Tue, 7 Mar 2017 16:32:56 -0600
Message-ID: <7eda9aee1b504a863b86d1b3a043d2a59e0f3202.1488919535.git.julia@ni.com>
References: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, <stable-rt@vger.kernel.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488919535.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.38-rt46-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
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
(cherry picked from commit b2ee2b3e4642646571fa2368c350278b6b9d991b)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/module.h   |  1 +
 include/linux/percpu.h   |  1 +
 kernel/locking/lockdep.c | 33 +++++++++++++++++++++++----------
 kernel/module.c          | 31 +++++++++++++++++++------------
 mm/percpu.c              | 37 +++++++++++++++++++++++--------------
 5 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index b2da02e1591d..af9a771a9346 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -386,6 +386,7 @@ static inline int module_is_live(struct module *mod)
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
+bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 53a60a51c758..4ecc057b6e27 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -145,6 +145,7 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 #endif
 
 extern void __percpu *__alloc_reserved_percpu(size_t size, size_t align);
+extern bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr);
 extern bool is_kernel_percpu_address(unsigned long addr);
 
 #if !defined(CONFIG_SMP) || !defined(CONFIG_HAVE_SETUP_PER_CPU_AREA)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 577f02617c63..1681f99ed566 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -668,6 +668,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	struct lockdep_subclass_key *key;
 	struct list_head *hash_head;
 	struct lock_class *class;
+	bool is_static = false;
 
 #ifdef CONFIG_DEBUG_LOCKDEP
 	/*
@@ -695,10 +696,23 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 
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
@@ -730,7 +744,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 		}
 	}
 
-	return NULL;
+	return is_static || static_obj(lock->key) ? NULL : ERR_PTR(-EINVAL);
 }
 
 /*
@@ -748,19 +762,18 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
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
 
@@ -3297,7 +3310,7 @@ static int match_held_lock(struct held_lock *hlock, struct lockdep_map *lock)
 		 * Clearly if the lock hasn't been acquired _ever_, we're not
 		 * holding it either, so report failure.
 		 */
-		if (!class)
+		if (IS_ERR_OR_NULL(class))
 			return 0;
 
 		/*
@@ -3982,7 +3995,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		 * If the class exists we look it up and zap it:
 		 */
 		class = look_up_lock_class(lock, j);
-		if (class)
+		if (!IS_ERR_OR_NULL(class))
 			zap_class(class);
 	}
 	/*
diff --git a/kernel/module.c b/kernel/module.c
index 6920d1080cdd..b4ebb2fd4849 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -525,16 +525,7 @@ static void percpu_modcopy(struct module *mod,
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
@@ -548,9 +539,11 @@ bool is_module_percpu_address(unsigned long addr)
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
@@ -561,6 +554,20 @@ bool is_module_percpu_address(unsigned long addr)
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
index b97617587620..3289dbd519a1 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1282,18 +1282,7 @@ void free_percpu(void __percpu *ptr)
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
@@ -1302,16 +1291,36 @@ bool is_kernel_percpu_address(unsigned long addr)
 
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
2.11.1
