From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: looking for something like raw_rwlock_t or some optimization in
 rwlock_t in Linux 3.0
Date: Tue, 15 May 2012 21:36:44 -0400
Message-ID: <1337132204.6724.15.camel@gandalf.stny.rr.com>
References: <CACpc7petSnyR4qwE+F_b-OcdXc9+c5RRrX_u0TiLZnzy2eDWOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Priyanka Gupta Jain <p.priyankagupta@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16119 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab2EPBgq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 21:36:46 -0400
In-Reply-To: <CACpc7petSnyR4qwE+F_b-OcdXc9+c5RRrX_u0TiLZnzy2eDWOg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-05-07 at 10:19 +0530, Priyanka Gupta Jain wrote:
> hi,
> 
> I would really appreciate if someone can help in finding an
> alternative to rwlock_t.
> I want one particular rw_lock to behave as in native linux not as
> mutex of if there is any other optimization that I can do in that
> rwlock or in general to all rwlocks as well.
> This is required to boost the performance in case of multicore systems
> 

You want to try this patch? It's against 3.4-rc7-rt6, but if it works I
can backport it to 3.0-rt and 3.2-rt. Although, as it is a "feature" it
will never be added to either of the stable branches. I could make an
"unstable" branch to house it ;-)

Do not enable lockdep, as it's currently broken in this version.

This is not a stable patch, and it needs a lot of clean ups and fixes.
But it can be used to see if it has the potential to fix your issues.

-- Steve

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 853ee36..9be0c71 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -5,12 +5,17 @@
 #error Do not include directly. Use spinlock.h
 #endif
 
-#define rwlock_init(rwl)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	rt_mutex_init(&(rwl)->lock);			\
-	__rt_rwlock_init(rwl, #rwl, &__key);		\
+#define rwlock_init(rwl)						\
+do {									\
+	static struct lock_class_key __key[NR_CPUS];			\
+									\
+	int ____i;							\
+									\
+	for (____i = 0; ____i < NR_CPUS; ____i++) {			\
+		rt_mutex_init(&((rwl)->lock[____i]).lock);		\
+		__rt_rwlock_init(&((rwl)->lock[____i]), #rwl, &__key[____i]); \
+	}								\
+	(rwl)->initialized = 1;						\
 } while (0)
 
 extern void __lockfunc rt_write_lock(rwlock_t *rwlock);
@@ -22,7 +27,7 @@ extern void __lockfunc rt_write_unlock(rwlock_t *rwlock);
 extern void __lockfunc rt_read_unlock(rwlock_t *rwlock);
 extern unsigned long __lockfunc rt_write_lock_irqsave(rwlock_t *rwlock);
 extern unsigned long __lockfunc rt_read_lock_irqsave(rwlock_t *rwlock);
-extern void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key);
+extern void __rt_rwlock_init(__rwlock_t *rwlock, char *name, struct lock_class_key *key);
 
 #define read_trylock(lock)	__cond_lock(lock, rt_read_trylock(lock))
 #define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
diff --git a/include/linux/rwlock_types_rt.h b/include/linux/rwlock_types_rt.h
index b138321..3525060 100644
--- a/include/linux/rwlock_types_rt.h
+++ b/include/linux/rwlock_types_rt.h
@@ -5,6 +5,8 @@
 #error "Do not include directly. Include spinlock_types.h instead"
 #endif
 
+#include <linux/threads.h>
+
 /*
  * rwlocks - rtmutex which allows single reader recursion
  */
@@ -15,6 +17,15 @@ typedef struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
+} __rwlock_t;
+
+typedef struct {
+	int			initialized;
+	__rwlock_t		lock[NR_CPUS];
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	const char		*name;
+	struct lock_class_key	__key[NR_CPUS];
+#endif
 } rwlock_t;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -24,8 +35,7 @@ typedef struct {
 #endif
 
 #define __RW_LOCK_UNLOCKED(name) \
-	{ .lock = __RT_MUTEX_INITIALIZER_SAVE_STATE(name.lock),	\
-	  RW_DEP_MAP_INIT(name) }
+	{ RW_DEP_MAP_INIT(name) }
 
 #define DEFINE_RWLOCK(name) \
 	rwlock_t name __cacheline_aligned_in_smp = __RW_LOCK_UNLOCKED(name)
diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem_rt.h
index 802c690..cd0c812 100644
--- a/include/linux/rwsem_rt.h
+++ b/include/linux/rwsem_rt.h
@@ -18,7 +18,7 @@
 
 #include <linux/rtmutex.h>
 
-struct rw_semaphore {
+struct __rw_semaphore {
 	struct rt_mutex		lock;
 	int			read_depth;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -26,22 +26,40 @@ struct rw_semaphore {
 #endif
 };
 
+struct rw_semaphore {
+	int			initialized;
+	struct __rw_semaphore	lock[NR_CPUS];
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	const char		*name;
+	struct lock_class_key	__key[NR_CPUS];
+#endif
+};
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define __RWSEM_INITIALIZER(_name) \
+	{ .name = _name }
+#else
 #define __RWSEM_INITIALIZER(name) \
-	{ .lock = __RT_MUTEX_INITIALIZER(name.lock), \
-	  RW_DEP_MAP_INIT(name) }
+	{  }
+
+#endif
 
 #define DECLARE_RWSEM(lockname) \
 	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
 
-extern void  __rt_rwsem_init(struct rw_semaphore *rwsem, char *name,
+extern void  __rt_rwsem_init(struct __rw_semaphore *rwsem, char *name,
 				     struct lock_class_key *key);
 
-# define rt_init_rwsem(sem)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	rt_mutex_init(&(sem)->lock);			\
-	__rt_rwsem_init((sem), #sem, &__key);		\
+# define rt_init_rwsem(sem)						\
+do {									\
+	static struct lock_class_key __key[NR_CPUS];			\
+	int ____i;							\
+									\
+	for (____i = 0; ____i < NR_CPUS; ____i++) {			\
+		rt_mutex_init(&((sem)->lock[____i]).lock);		\
+		__rt_rwsem_init(&((sem)->lock[____i]), #sem, &__key[____i]); \
+	}								\
+	(sem)->initialized = 1;						\
 } while (0)
 
 extern void  rt_down_write(struct rw_semaphore *rwsem);
@@ -55,7 +73,11 @@ extern void  rt_up_write(struct rw_semaphore *rwsem);
 extern void  rt_downgrade_write(struct rw_semaphore *rwsem);
 
 #define init_rwsem(sem)		rt_init_rwsem(sem)
-#define rwsem_is_locked(s)	rt_mutex_is_locked(&(s)->lock)
+/*
+ * Use raw_smp_processor_id(), as readlocks use migrate disable,
+ * and write locks lock all of them (we don't care which one we test.
+ */
+#define rwsem_is_locked(s)	rt_mutex_is_locked(&(s)->lock[raw_smp_processor_id()].lock)
 
 static inline void down_read(struct rw_semaphore *sem)
 {
diff --git a/kernel/rt.c b/kernel/rt.c
index 092d6b3..b9e862e 100644
--- a/kernel/rt.c
+++ b/kernel/rt.c
@@ -178,15 +178,46 @@ EXPORT_SYMBOL(_mutex_unlock);
 /*
  * rwlock_t functions
  */
+
+static void __initialize_rwlock(rwlock_t *rwlock)
+{
+	int i;
+
+	/* TODO add spinlock here? */
+	rwlock->initialized = 1;
+
+	for (i = 0; i < NR_CPUS; i++)
+		rt_mutex_init(&rwlock->lock[i].lock);
+}
+
+#define initialize_rwlock(rwlock)			\
+	do {						\
+		if (unlikely(!rwlock->initialized))	\
+			__initialize_rwlock(rwlock);	\
+	} while (0)
+
 int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 {
-	int ret = rt_mutex_trylock(&rwlock->lock);
+	int ret;
+	int i;
+
+	initialize_rwlock(rwlock);
 
 	migrate_disable();
-	if (ret)
-		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
-	else
-		migrate_enable();
+	for_each_possible_cpu(i) {
+		ret = rt_mutex_trylock(&rwlock->lock[i].lock);
+		if (ret)
+			rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		else
+			goto release;
+	}
+	return 1;
+ release:
+	while (--i >= 0) {
+		rwlock_release(&rwlock->lock[i].dep_map, 1, _RET_IP_);
+		rt_mutex_unlock(&rwlock->lock[i].lock);
+	}
+	migrate_enable();
 
 	return ret;
 }
@@ -196,6 +227,8 @@ int __lockfunc rt_write_trylock_irqsave(rwlock_t *rwlock, unsigned long *flags)
 {
 	int ret;
 
+	initialize_rwlock(rwlock);
+
 	*flags = 0;
 	migrate_disable();
 	ret = rt_write_trylock(rwlock);
@@ -207,8 +240,11 @@ EXPORT_SYMBOL(rt_write_trylock_irqsave);
 
 int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 {
-	struct rt_mutex *lock = &rwlock->lock;
+	struct rt_mutex *lock;
 	int ret = 1;
+	int cpu;
+
+	initialize_rwlock(rwlock);
 
 	/*
 	 * recursive read locks succeed when current owns the lock,
@@ -216,14 +252,17 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 	 * write locked.
 	 */
 	migrate_disable();
+	cpu = smp_processor_id();
+	lock = &rwlock->lock[cpu].lock;
+
 	if (rt_mutex_owner(lock) != current)
 		ret = rt_mutex_trylock(lock);
-	else if (!rwlock->read_depth)
+	else if (!rwlock->lock[cpu].read_depth)
 		ret = 0;
 
 	if (ret) {
-		rwlock->read_depth++;
-		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rwlock->lock[cpu].read_depth++;
+		rwlock_acquire_read(&rwlock->lock[cpu].dep_map, 0, 1, _RET_IP_);
 	} else
 		migrate_enable();
 
@@ -233,42 +272,64 @@ EXPORT_SYMBOL(rt_read_trylock);
 
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
-	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
-	__rt_spin_lock(&rwlock->lock);
+	int i;
+
+	initialize_rwlock(rwlock);
+
+	for_each_possible_cpu(i) {
+		rwlock_acquire(&rwlock->lock[i].dep_map, 0, 0, _RET_IP_);
+		__rt_spin_lock(&rwlock->lock[i].lock);
+	}
 }
 EXPORT_SYMBOL(rt_write_lock);
 
 void __lockfunc rt_read_lock(rwlock_t *rwlock)
 {
-	struct rt_mutex *lock = &rwlock->lock;
+	struct rt_mutex *lock;
+	int cpu;
+
+	initialize_rwlock(rwlock);
+
+	migrate_disable();
+
+	cpu = smp_processor_id();
+	lock = &rwlock->lock[cpu].lock;
 
-	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rwlock_acquire_read(&rwlock->lock[cpu].dep_map, 0, 0, _RET_IP_);
 
 	/*
 	 * recursive read locks succeed when current owns the lock
 	 */
 	if (rt_mutex_owner(lock) != current)
 		__rt_spin_lock(lock);
-	rwlock->read_depth++;
+	rwlock->lock[cpu].read_depth++;
 }
 
 EXPORT_SYMBOL(rt_read_lock);
 
 void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 {
-	/* NOTE: we always pass in '1' for nested, for simplicity */
-	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
-	__rt_spin_unlock(&rwlock->lock);
+	int i;
+
+	for_each_possible_cpu(i) {
+		/* NOTE: we always pass in '1' for nested, for simplicity */
+		rwlock_release(&rwlock->lock[i].dep_map, 1, _RET_IP_);
+		__rt_spin_unlock(&rwlock->lock[i].lock);
+	}
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
 void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 {
-	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
+	int cpu = smp_processor_id();
+
+	rwlock_release(&rwlock->lock[cpu].dep_map, 1, _RET_IP_);
 
 	/* Release the lock only when read_depth is down to 0 */
-	if (--rwlock->read_depth == 0)
-		__rt_spin_unlock(&rwlock->lock);
+	if (--rwlock->lock[cpu].read_depth == 0) {
+		__rt_spin_unlock(&rwlock->lock[cpu].lock);
+		migrate_enable();
+	}
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
@@ -288,7 +349,7 @@ unsigned long __lockfunc rt_read_lock_irqsave(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_read_lock_irqsave);
 
-void __rt_rwlock_init(rwlock_t *rwlock, char *name, struct lock_class_key *key)
+void __rt_rwlock_init(__rwlock_t *rwlock, char *name, struct lock_class_key *key)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -306,18 +367,52 @@ EXPORT_SYMBOL(__rt_rwlock_init);
  * rw_semaphores
  */
 
+static void __initialize_rwsem(struct rw_semaphore *rwsem)
+{
+	int i;
+
+	/* TODO add spinlock here? */
+	rwsem->initialized = 1;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		rt_mutex_init(&rwsem->lock[i].lock);
+		__rt_rwsem_init(&rwsem->lock[i],
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+				rwsem->name, &rwsem->key[i]
+#else
+				"", 0
+#endif
+			);
+	}
+}
+
+#define initialize_rwsem(rwsem)				\
+	do {						\
+		if (unlikely(!rwsem->initialized))	\
+			__initialize_rwsem(rwsem);	\
+	} while (0)
+
 void  rt_up_write(struct rw_semaphore *rwsem)
 {
-	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	rt_mutex_unlock(&rwsem->lock);
+	int i;
+
+	for_each_possible_cpu(i) {
+		rwsem_release(&rwsem->lock[i].dep_map, 1, _RET_IP_);
+		rt_mutex_unlock(&rwsem->lock[i].lock);
+	}
 }
 EXPORT_SYMBOL(rt_up_write);
 
 void  rt_up_read(struct rw_semaphore *rwsem)
 {
-	rwsem_release(&rwsem->dep_map, 1, _RET_IP_);
-	if (--rwsem->read_depth == 0)
-		rt_mutex_unlock(&rwsem->lock);
+	int cpu;
+
+	cpu = smp_processor_id();
+	rwsem_release(&rwsem->lock[cpu].dep_map, 1, _RET_IP_);
+	if (--rwsem->lock[cpu].read_depth == 0) {
+		rt_mutex_unlock(&rwsem->lock[cpu].lock);
+		migrate_enable();
+	}
 }
 EXPORT_SYMBOL(rt_up_read);
 
@@ -327,67 +422,112 @@ EXPORT_SYMBOL(rt_up_read);
  */
 void  rt_downgrade_write(struct rw_semaphore *rwsem)
 {
-	BUG_ON(rt_mutex_owner(&rwsem->lock) != current);
-	rwsem->read_depth = 1;
+	int cpu;
+	int i;
+
+	migrate_disable();
+	cpu = smp_processor_id();
+	for_each_possible_cpu(i) {
+		if (cpu == i) {
+			BUG_ON(rt_mutex_owner(&rwsem->lock[i].lock) != current);
+			rwsem->lock[i].read_depth = 1;
+		} else {
+			rwsem_release(&rwsem->lock[i].dep_map, 1, _RET_IP_);
+			rt_mutex_unlock(&rwsem->lock[i].lock);
+		}
+	}
 }
 EXPORT_SYMBOL(rt_downgrade_write);
 
 int  rt_down_write_trylock(struct rw_semaphore *rwsem)
 {
-	int ret = rt_mutex_trylock(&rwsem->lock);
+	int ret;
+	int i;
 
-	if (ret)
-		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
-	return ret;
+	initialize_rwsem(rwsem);
+
+	for_each_possible_cpu(i) {
+		ret = rt_mutex_trylock(&rwsem->lock[i].lock);
+		if (ret)
+			rwsem_acquire(&rwsem->lock[i].dep_map, 0, 1, _RET_IP_);
+		else
+			goto release;
+	}
+	return 1;
+ release:
+	while (--i >= 0) {
+		rwsem_release(&rwsem->lock[i].dep_map, 1, _RET_IP_);
+		rt_mutex_unlock(&rwsem->lock[i].lock);
+	}
+	return 0;
 }
 EXPORT_SYMBOL(rt_down_write_trylock);
 
 void  rt_down_write(struct rw_semaphore *rwsem)
 {
-	rwsem_acquire(&rwsem->dep_map, 0, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
+	int i;
+	initialize_rwsem(rwsem);
+	for_each_possible_cpu(i) {
+		rwsem_acquire(&rwsem->lock[i].dep_map, 0, 0, _RET_IP_);
+		rt_mutex_lock(&rwsem->lock[i].lock);
+	}
 }
 EXPORT_SYMBOL(rt_down_write);
 
 void  rt_down_write_nested(struct rw_semaphore *rwsem, int subclass)
 {
-	rwsem_acquire(&rwsem->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_lock(&rwsem->lock);
+	int i;
+
+	initialize_rwsem(rwsem);
+	for_each_possible_cpu(i) {
+		rwsem_acquire(&rwsem->lock[i].dep_map, subclass, 0, _RET_IP_);
+		rt_mutex_lock(&rwsem->lock[i].lock);
+	}
 }
 EXPORT_SYMBOL(rt_down_write_nested);
 
 int  rt_down_read_trylock(struct rw_semaphore *rwsem)
 {
-	struct rt_mutex *lock = &rwsem->lock;
+	struct rt_mutex *lock;
 	int ret = 1;
+	int cpu;
 
+	initialize_rwsem(rwsem);
+	migrate_disable();
+	cpu = smp_processor_id();
+	lock = &rwsem->lock[cpu].lock;
 	/*
 	 * recursive read locks succeed when current owns the rwsem,
 	 * but not when read_depth == 0 which means that the rwsem is
 	 * write locked.
 	 */
 	if (rt_mutex_owner(lock) != current)
-		ret = rt_mutex_trylock(&rwsem->lock);
-	else if (!rwsem->read_depth)
+		ret = rt_mutex_trylock(lock);
+	else if (!rwsem->lock[cpu].read_depth)
 		ret = 0;
 
 	if (ret) {
-		rwsem->read_depth++;
-		rwsem_acquire(&rwsem->dep_map, 0, 1, _RET_IP_);
-	}
+		rwsem->lock[cpu].read_depth++;
+		rwsem_acquire(&rwsem->lock[cpu].dep_map, 0, 1, _RET_IP_);
+	} else
+		migrate_enable();
 	return ret;
 }
 EXPORT_SYMBOL(rt_down_read_trylock);
 
 static void __rt_down_read(struct rw_semaphore *rwsem, int subclass)
 {
-	struct rt_mutex *lock = &rwsem->lock;
+	struct rt_mutex *lock;
+	int cpu;
 
-	rwsem_acquire_read(&rwsem->dep_map, subclass, 0, _RET_IP_);
+	migrate_disable();
+	cpu = smp_processor_id();
+	lock = &rwsem->lock[cpu].lock;
+	rwsem_acquire_read(&rwsem->lock[cpu].dep_map, subclass, 0, _RET_IP_);
 
 	if (rt_mutex_owner(lock) != current)
-		rt_mutex_lock(&rwsem->lock);
-	rwsem->read_depth++;
+		rt_mutex_lock(lock);
+	rwsem->lock[cpu].read_depth++;
 }
 
 void  rt_down_read(struct rw_semaphore *rwsem)
@@ -402,7 +542,7 @@ void  rt_down_read_nested(struct rw_semaphore *rwsem, int subclass)
 }
 EXPORT_SYMBOL(rt_down_read_nested);
 
-void  __rt_rwsem_init(struct rw_semaphore *rwsem, char *name,
+void  __rt_rwsem_init(struct __rw_semaphore *rwsem, char *name,
 			      struct lock_class_key *key)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC


