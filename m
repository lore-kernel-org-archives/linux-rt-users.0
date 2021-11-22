Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A4C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Nov 2021 12:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhKVMsj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhKVMsh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Nov 2021 07:48:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A8C061574;
        Mon, 22 Nov 2021 04:45:30 -0800 (PST)
Date:   Mon, 22 Nov 2021 13:45:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637585127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Y/YX5DM3iiyMZsyQS7hnGLhQYtABgHIWbYnYtQ69pGQ=;
        b=jdGPcR4PJn5KIpkVBracQkCSaMCGCHZ7MvH+K/0pRIm86G2qKQ1KSipfmDWXwOMQpht9xj
        yAULdm73qxdytLY5w6AJF3CXUATFUkAe1C9eP7K64l218Wx8EAZAqRwzOYiPgSpSVZvK1m
        OrGuSikq3dpassovKxvrzZCUmNXjG4nGHSEwnJQz9keD0HVl+WcA2sfzjXCsg9mg4s0zdH
        QtBNgqbJDpA4ziLSHHn/a6MzPu4vshrFa+B4TdT1AI58VN1pxgCpy7JjeMlkw5efmzZffI
        5SBQbmd6bRp9k+HScKz/hcFjH2LdO2FbzNfGvx53xeVQX45vSJb7Xzr0UKlskg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637585127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Y/YX5DM3iiyMZsyQS7hnGLhQYtABgHIWbYnYtQ69pGQ=;
        b=OoOg7df0IF53JI4ITnHlwwxWbQXJQtfM7V9odEiFUewoOEBfgXldBNp/JAWAKDs5p/3BIH
        REEL74ew9WX9gKCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16-rc2-rt4
Message-ID: <20211122124526.pzhrvgpng7flzh6c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16-rc2-rt4 patch set. 

Changes since v5.16-rc2-rt3:

  - Replace the current zsmalloc patch with patches from Minchan Kim
    which have been applied to akpm tree.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16-rc2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16-rc2-rt3-rt4.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16-rc2-rt4

The RT patch against v5.16-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16-rc2-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16-rc2-rt4.tar.xz

Sebastian

diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 2c0ad417ce3c0..8f416c5e929ea 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -55,6 +55,12 @@ do {								\
 #define write_lock(lock)	_raw_write_lock(lock)
 #define read_lock(lock)		_raw_read_lock(lock)
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define write_lock_nested(lock, subclass)	_raw_write_lock_nested(lock, subclass)
+#else
+#define write_lock_nested(lock, subclass)	_raw_write_lock(lock)
+#endif
+
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 
 #define read_lock_irqsave(lock, flags)			\
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index f1db6f17c4fba..f0c535ec4e654 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -17,6 +17,7 @@
 
 void __lockfunc _raw_read_lock(rwlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_write_lock(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)	__acquires(lock);
 void __lockfunc _raw_read_lock_bh(rwlock_t *lock)	__acquires(lock);
 void __lockfunc _raw_write_lock_bh(rwlock_t *lock)	__acquires(lock);
 void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires(lock);
@@ -46,6 +47,7 @@ _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 
 #ifdef CONFIG_INLINE_WRITE_LOCK
 #define _raw_write_lock(lock) __raw_write_lock(lock)
+#define _raw_write_lock_nested(lock, subclass) __raw_write_lock_nested(lock, subclass)
 #endif
 
 #ifdef CONFIG_INLINE_READ_LOCK_BH
@@ -209,6 +211,13 @@ static inline void __raw_write_lock(rwlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 }
 
+static inline void __raw_write_lock_nested(rwlock_t *lock, int subclass)
+{
+	preempt_disable();
+	rwlock_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
+}
+
 #endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
 
 static inline void __raw_write_unlock(rwlock_t *lock)
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 49c1f3842ed5b..8544ff05e594d 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -28,6 +28,7 @@ extern void rt_read_lock(rwlock_t *rwlock);
 extern int rt_read_trylock(rwlock_t *rwlock);
 extern void rt_read_unlock(rwlock_t *rwlock);
 extern void rt_write_lock(rwlock_t *rwlock);
+extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass);
 extern int rt_write_trylock(rwlock_t *rwlock);
 extern void rt_write_unlock(rwlock_t *rwlock);
 
@@ -83,6 +84,15 @@ static __always_inline void write_lock(rwlock_t *rwlock)
 	rt_write_lock(rwlock);
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
+{
+	rt_write_lock_nested(rwlock, subclass);
+}
+#else
+#define write_lock_nested(lock, subclass)	rt_write_lock(((void)(subclass), (lock)))
+#endif
+
 static __always_inline void write_lock_bh(rwlock_t *rwlock)
 {
 	local_bh_disable();
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index d0d188861ad69..b8ba00ccccdeb 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -59,6 +59,7 @@
 #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
 #define _raw_read_lock(lock)			__LOCK(lock)
 #define _raw_write_lock(lock)			__LOCK(lock)
+#define _raw_write_lock_nested(lock, subclass)	__LOCK(lock)
 #define _raw_spin_lock_bh(lock)			__LOCK_BH(lock)
 #define _raw_read_lock_bh(lock)			__LOCK_BH(lock)
 #define _raw_write_lock_bh(lock)		__LOCK_BH(lock)
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index b562f92893727..996811efa6d6e 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -300,6 +300,12 @@ void __lockfunc _raw_write_lock(rwlock_t *lock)
 	__raw_write_lock(lock);
 }
 EXPORT_SYMBOL(_raw_write_lock);
+
+void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)
+{
+	__raw_write_lock_nested(lock, subclass);
+}
+EXPORT_SYMBOL(_raw_write_lock_nested);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_IRQSAVE
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 9e396a09fe0fd..48a19ed8486d8 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -239,6 +239,18 @@ void __sched rt_write_lock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_lock);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
+{
+	rtlock_might_resched();
+	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
+	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_write_lock_nested);
+#endif
+
 void __sched rt_read_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6a58c1df0cc7c..7e03cc9363bb0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -30,6 +30,14 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+/*
+ * lock ordering:
+ *	page_lock
+ *	pool->migrate_lock
+ *	class->lock
+ *	zspage->lock
+ */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -78,20 +86,6 @@
 
 #define ZS_HANDLE_SIZE (sizeof(unsigned long))
 
-#ifdef CONFIG_PREEMPT_RT
-
-struct zsmalloc_handle {
-	unsigned long addr;
-	spinlock_t lock;
-};
-
-#define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
-
-#else
-
-#define ZS_HANDLE_ALLOC_SIZE (sizeof(unsigned long))
-#endif
-
 /*
  * Object location (<PFN>, <obj_idx>) is encoded as
  * a single (unsigned long) handle value.
@@ -115,15 +109,6 @@ struct zsmalloc_handle {
 
 #define _PFN_BITS		(MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
 
-/*
- * Memory for allocating for handle keeps object position by
- * encoding <page, obj_idx> and the encoded value has a room
- * in least bit(ie, look at obj_to_location).
- * We use the bit to synchronize between object access by
- * user and migration.
- */
-#define HANDLE_PIN_BIT	0
-
 /*
  * Head in allocated object should have OBJ_ALLOCATED_TAG
  * to identify the object was allocated or not.
@@ -136,6 +121,7 @@ struct zsmalloc_handle {
 #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
+#define HUGE_BITS	1
 #define FULLNESS_BITS	2
 #define CLASS_BITS	8
 #define ISOLATED_BITS	3
@@ -173,7 +159,7 @@ enum fullness_group {
 	NR_ZS_FULLNESS,
 };
 
-enum zs_stat_type {
+enum class_stat_type {
 	CLASS_EMPTY,
 	CLASS_ALMOST_EMPTY,
 	CLASS_ALMOST_FULL,
@@ -228,22 +214,6 @@ struct size_class {
 	struct zs_size_stat stats;
 };
 
-/* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
-static void SetPageHugeObject(struct page *page)
-{
-	SetPageOwnerPriv1(page);
-}
-
-static void ClearPageHugeObject(struct page *page)
-{
-	ClearPageOwnerPriv1(page);
-}
-
-static int PageHugeObject(struct page *page)
-{
-	return PageOwnerPriv1(page);
-}
-
 /*
  * Placed within free objects to form a singly linked list.
  * For every zspage, zspage->freeobj gives head of this list.
@@ -284,15 +254,14 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct inode *inode;
 	struct work_struct free_work;
-	/* A wait queue for when migration races with async_free_zspage() */
-	struct wait_queue_head migration_wait;
-	atomic_long_t isolated_pages;
-	bool destroying;
 #endif
+	/* protect page/zspage migration */
+	rwlock_t migrate_lock;
 };
 
 struct zspage {
 	struct {
+		unsigned int huge:HUGE_BITS;
 		unsigned int fullness:FULLNESS_BITS;
 		unsigned int class:CLASS_BITS + 1;
 		unsigned int isolated:ISOLATED_BITS;
@@ -314,12 +283,26 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+/* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
+static void SetZsHugePage(struct zspage *zspage)
+{
+	zspage->huge = 1;
+}
+
+static bool ZsHugePage(struct zspage *zspage)
+{
+	return zspage->huge;
+}
+
 #ifdef CONFIG_COMPACTION
 static int zs_register_migration(struct zs_pool *pool);
 static void zs_unregister_migration(struct zs_pool *pool);
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
+static void migrate_write_lock(struct zspage *zspage);
+static void migrate_write_lock_nested(struct zspage *zspage);
+static void migrate_write_unlock(struct zspage *zspage);
 static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
@@ -331,6 +314,9 @@ static void zs_unregister_migration(struct zs_pool *pool) {}
 static void migrate_lock_init(struct zspage *zspage) {}
 static void migrate_read_lock(struct zspage *zspage) {}
 static void migrate_read_unlock(struct zspage *zspage) {}
+static void migrate_write_lock(struct zspage *zspage) {}
+static void migrate_write_lock_nested(struct zspage *zspage) {}
+static void migrate_write_unlock(struct zspage *zspage) {}
 static void kick_deferred_free(struct zs_pool *pool) {}
 static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
@@ -338,7 +324,7 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 
 static int create_cache(struct zs_pool *pool)
 {
-	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_ALLOC_SIZE,
+	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
 					0, 0, NULL);
 	if (!pool->handle_cachep)
 		return 1;
@@ -362,27 +348,10 @@ static void destroy_cache(struct zs_pool *pool)
 
 static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 {
-	void *p;
-
-	p = kmem_cache_alloc(pool->handle_cachep,
-			     gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
-#ifdef CONFIG_PREEMPT_RT
-	if (p) {
-		struct zsmalloc_handle *zh = p;
-
-		spin_lock_init(&zh->lock);
-	}
-#endif
-	return (unsigned long)p;
+	return (unsigned long)kmem_cache_alloc(pool->handle_cachep,
+			gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
 }
 
-#ifdef CONFIG_PREEMPT_RT
-static struct zsmalloc_handle *zs_get_pure_handle(unsigned long handle)
-{
-	return (void *)(handle & ~((1 << OBJ_TAG_BITS) - 1));
-}
-#endif
-
 static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
 {
 	kmem_cache_free(pool->handle_cachep, (void *)handle);
@@ -399,20 +368,10 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }
 
+/* class->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
-#ifdef CONFIG_PREEMPT_RT
-	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
-
-	WRITE_ONCE(zh->addr, obj);
-#else
-	/*
-	 * lsb of @obj represents handle lock while other bits
-	 * represent object value the handle is pointing so
-	 * updating shouldn't do store tearing.
-	 */
-	WRITE_ONCE(*(unsigned long *)handle, obj);
-#endif
+	*(unsigned long *)handle = obj;
 }
 
 /* zpool driver */
@@ -498,11 +457,6 @@ static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
 	.lock	= INIT_LOCAL_LOCK(lock),
 };
 
-static bool is_zspage_isolated(struct zspage *zspage)
-{
-	return zspage->isolated;
-}
-
 static __maybe_unused int is_first_page(struct page *page)
 {
 	return PagePrivate(page);
@@ -558,6 +512,12 @@ static void get_zspage_mapping(struct zspage *zspage,
 	*class_idx = zspage->class;
 }
 
+static struct size_class *zspage_class(struct zs_pool *pool,
+					     struct zspage *zspage)
+{
+	return pool->size_class[zspage->class];
+}
+
 static void set_zspage_mapping(struct zspage *zspage,
 				unsigned int class_idx,
 				enum fullness_group fullness)
@@ -584,21 +544,21 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
-/* type can be of enum type zs_stat_type or fullness_group */
-static inline void zs_stat_inc(struct size_class *class,
+/* type can be of enum type class_stat_type or fullness_group */
+static inline void class_stat_inc(struct size_class *class,
 				int type, unsigned long cnt)
 {
 	class->stats.objs[type] += cnt;
 }
 
-/* type can be of enum type zs_stat_type or fullness_group */
-static inline void zs_stat_dec(struct size_class *class,
+/* type can be of enum type class_stat_type or fullness_group */
+static inline void class_stat_dec(struct size_class *class,
 				int type, unsigned long cnt)
 {
 	class->stats.objs[type] -= cnt;
 }
 
-/* type can be of enum type zs_stat_type or fullness_group */
+/* type can be of enum type class_stat_type or fullness_group */
 static inline unsigned long zs_stat_get(struct size_class *class,
 				int type)
 {
@@ -760,7 +720,7 @@ static void insert_zspage(struct size_class *class,
 {
 	struct zspage *head;
 
-	zs_stat_inc(class, fullness, 1);
+	class_stat_inc(class, fullness, 1);
 	head = list_first_entry_or_null(&class->fullness_list[fullness],
 					struct zspage, list);
 	/*
@@ -782,10 +742,9 @@ static void remove_zspage(struct size_class *class,
 				enum fullness_group fullness)
 {
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
-	VM_BUG_ON(is_zspage_isolated(zspage));
 
 	list_del_init(&zspage->list);
-	zs_stat_dec(class, fullness, 1);
+	class_stat_dec(class, fullness, 1);
 }
 
 /*
@@ -808,13 +767,9 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
 	if (newfg == currfg)
 		goto out;
 
-	if (!is_zspage_isolated(zspage)) {
-		remove_zspage(class, zspage, currfg);
-		insert_zspage(class, zspage, newfg);
-	}
-
+	remove_zspage(class, zspage, currfg);
+	insert_zspage(class, zspage, newfg);
 	set_zspage_mapping(zspage, class_idx, newfg);
-
 out:
 	return newfg;
 }
@@ -865,7 +820,9 @@ static struct zspage *get_zspage(struct page *page)
 
 static struct page *get_next_page(struct page *page)
 {
-	if (unlikely(PageHugeObject(page)))
+	struct zspage *zspage = get_zspage(page);
+
+	if (unlikely(ZsHugePage(zspage)))
 		return NULL;
 
 	return page->freelist;
@@ -885,6 +842,12 @@ static void obj_to_location(unsigned long obj, struct page **page,
 	*obj_idx = (obj & OBJ_INDEX_MASK);
 }
 
+static void obj_to_page(unsigned long obj, struct page **page)
+{
+	obj >>= OBJ_TAG_BITS;
+	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
+}
+
 /**
  * location_to_obj - get obj value encoded from (<page>, <obj_idx>)
  * @page: page object resides in zspage
@@ -903,66 +866,25 @@ static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
 
 static unsigned long handle_to_obj(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT
-	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
-
-	return zh->addr;
-#else
 	return *(unsigned long *)handle;
-#endif
 }
 
-static unsigned long obj_to_head(struct page *page, void *obj)
+static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
 {
-	if (unlikely(PageHugeObject(page))) {
+	unsigned long handle;
+	struct zspage *zspage = get_zspage(page);
+
+	if (unlikely(ZsHugePage(zspage))) {
 		VM_BUG_ON_PAGE(!is_first_page(page), page);
-		return page->index;
+		handle = page->index;
 	} else
-		return *(unsigned long *)obj;
-}
+		handle = *(unsigned long *)obj;
 
-static inline int testpin_tag(unsigned long handle)
-{
-#ifdef CONFIG_PREEMPT_RT
-	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
+	if (!(handle & OBJ_ALLOCATED_TAG))
+		return false;
 
-	return spin_is_locked(&zh->lock);
-#else
-	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
-#endif
-}
-
-static inline int trypin_tag(unsigned long handle)
-{
-#ifdef CONFIG_PREEMPT_RT
-	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
-
-	return spin_trylock(&zh->lock);
-#else
-	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
-#endif
-}
-
-static void pin_tag(unsigned long handle) __acquires(bitlock)
-{
-#ifdef CONFIG_PREEMPT_RT
-	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
-
-	return spin_lock(&zh->lock);
-#else
-	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
-#endif
-}
-
-static void unpin_tag(unsigned long handle) __releases(bitlock)
-{
-#ifdef CONFIG_PREEMPT_RT
-	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
-
-	return spin_unlock(&zh->lock);
-#else
-	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
-#endif
+	*phandle = handle & ~OBJ_ALLOCATED_TAG;
+	return true;
 }
 
 static void reset_page(struct page *page)
@@ -971,7 +893,6 @@ static void reset_page(struct page *page)
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
 	page_mapcount_reset(page);
-	ClearPageHugeObject(page);
 	page->freelist = NULL;
 }
 
@@ -1023,7 +944,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	cache_free_zspage(pool, zspage);
 
-	zs_stat_dec(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_dec(class, OBJ_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage,
 					&pool->pages_allocated);
 }
@@ -1034,6 +955,11 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(list_empty(&zspage->list));
 
+	/*
+	 * Since zs_free couldn't be sleepable, this function cannot call
+	 * lock_page. The page locks trylock_zspage got will be released
+	 * by __free_zspage.
+	 */
 	if (!trylock_zspage(zspage)) {
 		kick_deferred_free(pool);
 		return;
@@ -1113,7 +1039,7 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 			SetPagePrivate(page);
 			if (unlikely(class->objs_per_zspage == 1 &&
 					class->pages_per_zspage == 1))
-				SetPageHugeObject(page);
+				SetZsHugePage(zspage);
 		} else {
 			prev_page->freelist = page;
 		}
@@ -1317,8 +1243,6 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
-	unsigned int class_idx;
-	enum fullness_group fg;
 	struct size_class *class;
 	struct mapping_area *area;
 	struct page *pages[2];
@@ -1331,18 +1255,22 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 */
 	BUG_ON(in_interrupt());
 
-	/* From now on, migration cannot move the object */
-	pin_tag(handle);
-
+	/* It guarantees it can get zspage from handle safely */
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 
-	/* migration cannot move any subpage in this zspage */
+	/*
+	 * migration cannot move any zpages in this zspage. Here, class->lock
+	 * is too heavy since callers would take some time until they calls
+	 * zs_unmap_object API so delegate the locking from class to zspage
+	 * which is smaller granularity.
+	 */
 	migrate_read_lock(zspage);
+	read_unlock(&pool->migrate_lock);
 
-	get_zspage_mapping(zspage, &class_idx, &fg);
-	class = pool->size_class[class_idx];
+	class = zspage_class(pool, zspage);
 	off = (class->size * obj_idx) & ~PAGE_MASK;
 
 	local_lock(&zs_map_area.lock);
@@ -1362,7 +1290,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 
 	ret = __zs_map_object(area, pages, off, class->size);
 out:
-	if (likely(!PageHugeObject(page)))
+	if (likely(!ZsHugePage(zspage)))
 		ret += ZS_HANDLE_SIZE;
 
 	return ret;
@@ -1376,16 +1304,13 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	unsigned long obj, off;
 	unsigned int obj_idx;
 
-	unsigned int class_idx;
-	enum fullness_group fg;
 	struct size_class *class;
 	struct mapping_area *area;
 
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
-	get_zspage_mapping(zspage, &class_idx, &fg);
-	class = pool->size_class[class_idx];
+	class = zspage_class(pool, zspage);
 	off = (class->size * obj_idx) & ~PAGE_MASK;
 
 	area = this_cpu_ptr(&zs_map_area);
@@ -1403,7 +1328,6 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	local_unlock(&zs_map_area.lock);
 
 	migrate_read_unlock(zspage);
-	unpin_tag(handle);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
@@ -1426,17 +1350,19 @@ size_t zs_huge_class_size(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
-static unsigned long obj_malloc(struct size_class *class,
+static unsigned long obj_malloc(struct zs_pool *pool,
 				struct zspage *zspage, unsigned long handle)
 {
 	int i, nr_page, offset;
 	unsigned long obj;
 	struct link_free *link;
+	struct size_class *class;
 
 	struct page *m_page;
 	unsigned long m_offset;
 	void *vaddr;
 
+	class = pool->size_class[zspage->class];
 	handle |= OBJ_ALLOCATED_TAG;
 	obj = get_freeobj(zspage);
 
@@ -1451,7 +1377,7 @@ static unsigned long obj_malloc(struct size_class *class,
 	vaddr = kmap_atomic(m_page);
 	link = (struct link_free *)vaddr + m_offset / sizeof(*link);
 	set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
-	if (likely(!PageHugeObject(m_page)))
+	if (likely(!ZsHugePage(zspage)))
 		/* record handle in the header of allocated chunk */
 		link->handle = handle;
 	else
@@ -1460,7 +1386,6 @@ static unsigned long obj_malloc(struct size_class *class,
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
-	zs_stat_inc(class, OBJ_USED, 1);
 
 	obj = location_to_obj(m_page, obj);
 
@@ -1496,13 +1421,15 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	size += ZS_HANDLE_SIZE;
 	class = pool->size_class[get_size_class_index(size)];
 
+	/* class->lock effectively protects the zpage migration */
 	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
-		obj = obj_malloc(class, zspage, handle);
+		obj = obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
+		class_stat_inc(class, OBJ_USED, 1);
 		spin_unlock(&class->lock);
 
 		return handle;
@@ -1517,14 +1444,15 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	}
 
 	spin_lock(&class->lock);
-	obj = obj_malloc(class, zspage, handle);
+	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	set_zspage_mapping(zspage, class->index, newfg);
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage,
 				&pool->pages_allocated);
-	zs_stat_inc(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_inc(class, OBJ_ALLOCATED, class->objs_per_zspage);
+	class_stat_inc(class, OBJ_USED, 1);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1534,7 +1462,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(zs_malloc);
 
-static void obj_free(struct size_class *class, unsigned long obj)
+static void obj_free(int class_size, unsigned long obj)
 {
 	struct link_free *link;
 	struct zspage *zspage;
@@ -1544,18 +1472,20 @@ static void obj_free(struct size_class *class, unsigned long obj)
 	void *vaddr;
 
 	obj_to_location(obj, &f_page, &f_objidx);
-	f_offset = (class->size * f_objidx) & ~PAGE_MASK;
+	f_offset = (class_size * f_objidx) & ~PAGE_MASK;
 	zspage = get_zspage(f_page);
 
 	vaddr = kmap_atomic(f_page);
 
 	/* Insert this object in containing zspage's freelist */
 	link = (struct link_free *)(vaddr + f_offset);
-	link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
+	if (likely(!ZsHugePage(zspage)))
+		link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
+	else
+		f_page->index = 0;
 	kunmap_atomic(vaddr);
 	set_freeobj(zspage, f_objidx);
 	mod_zspage_inuse(zspage, -1);
-	zs_stat_dec(class, OBJ_USED, 1);
 }
 
 void zs_free(struct zs_pool *pool, unsigned long handle)
@@ -1563,42 +1493,33 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	struct zspage *zspage;
 	struct page *f_page;
 	unsigned long obj;
-	unsigned int f_objidx;
-	int class_idx;
 	struct size_class *class;
 	enum fullness_group fullness;
-	bool isolated;
 
 	if (unlikely(!handle))
 		return;
 
-	pin_tag(handle);
+	/*
+	 * The pool->migrate_lock protects the race with zpage's migration
+	 * so it's safe to get the page from handle.
+	 */
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
-	obj_to_location(obj, &f_page, &f_objidx);
+	obj_to_page(obj, &f_page);
 	zspage = get_zspage(f_page);
-
-	migrate_read_lock(zspage);
-
-	get_zspage_mapping(zspage, &class_idx, &fullness);
-	class = pool->size_class[class_idx];
-
+	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
-	obj_free(class, obj);
+	read_unlock(&pool->migrate_lock);
+
+	obj_free(class->size, obj);
+	class_stat_dec(class, OBJ_USED, 1);
 	fullness = fix_fullness_group(class, zspage);
-	if (fullness != ZS_EMPTY) {
-		migrate_read_unlock(zspage);
+	if (fullness != ZS_EMPTY)
 		goto out;
-	}
 
-	isolated = is_zspage_isolated(zspage);
-	migrate_read_unlock(zspage);
-	/* If zspage is isolated, zs_page_putback will free the zspage */
-	if (likely(!isolated))
-		free_zspage(pool, class, zspage);
+	free_zspage(pool, class, zspage);
 out:
-
 	spin_unlock(&class->lock);
-	unpin_tag(handle);
 	cache_free_handle(pool, handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1673,7 +1594,6 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 static unsigned long find_alloced_obj(struct size_class *class,
 					struct page *page, int *obj_idx)
 {
-	unsigned long head;
 	int offset = 0;
 	int index = *obj_idx;
 	unsigned long handle = 0;
@@ -1683,13 +1603,8 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		head = obj_to_head(page, addr + offset);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
-			if (trypin_tag(handle))
-				break;
-			handle = 0;
-		}
+		if (obj_allocated(page, addr + offset, &handle))
+			break;
 
 		offset += class->size;
 		index++;
@@ -1735,25 +1650,16 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 
 		/* Stop if there is no more space */
 		if (zspage_full(class, get_zspage(d_page))) {
-			unpin_tag(handle);
 			ret = -ENOMEM;
 			break;
 		}
 
 		used_obj = handle_to_obj(handle);
-		free_obj = obj_malloc(class, get_zspage(d_page), handle);
+		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
 		zs_object_copy(class, free_obj, used_obj);
 		obj_idx++;
-		/*
-		 * record_obj updates handle's value to free_obj and it will
-		 * invalidate lock bit(ie, HANDLE_PIN_BIT) of handle, which
-		 * breaks synchronization using pin_tag(e,g, zs_free) so
-		 * let's keep the lock bit.
-		 */
-		free_obj |= BIT(HANDLE_PIN_BIT);
 		record_obj(handle, free_obj);
-		unpin_tag(handle);
-		obj_free(class, used_obj);
+		obj_free(class->size, used_obj);
 	}
 
 	/* Remember last position in this iteration */
@@ -1778,7 +1684,6 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
 		zspage = list_first_entry_or_null(&class->fullness_list[fg[i]],
 							struct zspage, list);
 		if (zspage) {
-			VM_BUG_ON(is_zspage_isolated(zspage));
 			remove_zspage(class, zspage, fg[i]);
 			return zspage;
 		}
@@ -1799,8 +1704,6 @@ static enum fullness_group putback_zspage(struct size_class *class,
 {
 	enum fullness_group fullness;
 
-	VM_BUG_ON(is_zspage_isolated(zspage));
-
 	fullness = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, fullness);
 	set_zspage_mapping(zspage, class->index, fullness);
@@ -1869,6 +1772,11 @@ static void migrate_write_lock(struct zspage *zspage)
 	write_lock(&zspage->lock);
 }
 
+static void migrate_write_lock_nested(struct zspage *zspage)
+{
+	write_lock_nested(&zspage->lock, SINGLE_DEPTH_NESTING);
+}
+
 static void migrate_write_unlock(struct zspage *zspage)
 {
 	write_unlock(&zspage->lock);
@@ -1882,35 +1790,10 @@ static void inc_zspage_isolation(struct zspage *zspage)
 
 static void dec_zspage_isolation(struct zspage *zspage)
 {
+	VM_BUG_ON(zspage->isolated == 0);
 	zspage->isolated--;
 }
 
-static void putback_zspage_deferred(struct zs_pool *pool,
-				    struct size_class *class,
-				    struct zspage *zspage)
-{
-	enum fullness_group fg;
-
-	fg = putback_zspage(class, zspage);
-	if (fg == ZS_EMPTY)
-		schedule_work(&pool->free_work);
-
-}
-
-static inline void zs_pool_dec_isolated(struct zs_pool *pool)
-{
-	VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
-	atomic_long_dec(&pool->isolated_pages);
-	/*
-	 * Checking pool->destroying must happen after atomic_long_dec()
-	 * for pool->isolated_pages above. Paired with the smp_mb() in
-	 * zs_unregister_migration().
-	 */
-	smp_mb__after_atomic();
-	if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
-		wake_up_all(&pool->migration_wait);
-}
-
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -1929,19 +1812,14 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 	create_page_chain(class, zspage, pages);
 	set_first_obj_offset(newpage, get_first_obj_offset(oldpage));
-	if (unlikely(PageHugeObject(oldpage)))
+	if (unlikely(ZsHugePage(zspage)))
 		newpage->index = oldpage->index;
 	__SetPageMovable(newpage, page_mapping(oldpage));
 }
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
-	struct zs_pool *pool;
-	struct size_class *class;
-	int class_idx;
-	enum fullness_group fullness;
 	struct zspage *zspage;
-	struct address_space *mapping;
 
 	/*
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
@@ -1951,41 +1829,9 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-
-	/*
-	 * Without class lock, fullness could be stale while class_idx is okay
-	 * because class_idx is constant unless page is freed so we should get
-	 * fullness again under class lock.
-	 */
-	get_zspage_mapping(zspage, &class_idx, &fullness);
-	mapping = page_mapping(page);
-	pool = mapping->private_data;
-	class = pool->size_class[class_idx];
-
-	spin_lock(&class->lock);
-	if (get_zspage_inuse(zspage) == 0) {
-		spin_unlock(&class->lock);
-		return false;
-	}
-
-	/* zspage is isolated for object migration */
-	if (list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
-		spin_unlock(&class->lock);
-		return false;
-	}
-
-	/*
-	 * If this is first time isolation for the zspage, isolate zspage from
-	 * size_class to prevent further object allocation from the zspage.
-	 */
-	if (!list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
-		get_zspage_mapping(zspage, &class_idx, &fullness);
-		atomic_long_inc(&pool->isolated_pages);
-		remove_zspage(class, zspage, fullness);
-	}
-
+	migrate_write_lock(zspage);
 	inc_zspage_isolation(zspage);
-	spin_unlock(&class->lock);
+	migrate_write_unlock(zspage);
 
 	return true;
 }
@@ -1995,16 +1841,13 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 {
 	struct zs_pool *pool;
 	struct size_class *class;
-	int class_idx;
-	enum fullness_group fullness;
 	struct zspage *zspage;
 	struct page *dummy;
 	void *s_addr, *d_addr, *addr;
-	int offset, pos;
-	unsigned long handle, head;
+	int offset;
+	unsigned long handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
-	int ret = -EAGAIN;
 
 	/*
 	 * We cannot support the _NO_COPY case here, because copy needs to
@@ -2017,35 +1860,25 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
-	zspage = get_zspage(page);
-
-	/* Concurrent compactor cannot migrate any subpage in zspage */
-	migrate_write_lock(zspage);
-	get_zspage_mapping(zspage, &class_idx, &fullness);
 	pool = mapping->private_data;
-	class = pool->size_class[class_idx];
-	offset = get_first_obj_offset(page);
 
+	/*
+	 * The pool migrate_lock protects the race between zpage migration
+	 * and zs_free.
+	 */
+	write_lock(&pool->migrate_lock);
+	zspage = get_zspage(page);
+	class = zspage_class(pool, zspage);
+
+	/*
+	 * the class lock protects zpage alloc/free in the zspage.
+	 */
 	spin_lock(&class->lock);
-	if (!get_zspage_inuse(zspage)) {
-		/*
-		 * Set "offset" to end of the page so that every loops
-		 * skips unnecessary object scanning.
-		 */
-		offset = PAGE_SIZE;
-	}
+	/* the migrate_write_lock protects zpage access via zs_map_object */
+	migrate_write_lock(zspage);
 
-	pos = offset;
+	offset = get_first_obj_offset(page);
 	s_addr = kmap_atomic(page);
-	while (pos < PAGE_SIZE) {
-		head = obj_to_head(page, s_addr + pos);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
-			if (!trypin_tag(handle))
-				goto unpin_objects;
-		}
-		pos += class->size;
-	}
 
 	/*
 	 * Here, any user cannot access all objects in the zspage so let's move.
@@ -2054,42 +1887,30 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	memcpy(d_addr, s_addr, PAGE_SIZE);
 	kunmap_atomic(d_addr);
 
-	for (addr = s_addr + offset; addr < s_addr + pos;
+	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		head = obj_to_head(page, addr);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
-			BUG_ON(!testpin_tag(handle));
+		if (obj_allocated(page, addr, &handle)) {
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
 			new_obj = (unsigned long)location_to_obj(newpage,
 								obj_idx);
-			new_obj |= BIT(HANDLE_PIN_BIT);
 			record_obj(handle, new_obj);
 		}
 	}
+	kunmap_atomic(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
-	get_page(newpage);
-
-	dec_zspage_isolation(zspage);
-
 	/*
-	 * Page migration is done so let's putback isolated zspage to
-	 * the list if @page is final isolated subpage in the zspage.
+	 * Since we complete the data copy and set up new zspage structure,
+	 * it's okay to release migration_lock.
 	 */
-	if (!is_zspage_isolated(zspage)) {
-		/*
-		 * We cannot race with zs_destroy_pool() here because we wait
-		 * for isolation to hit zero before we start destroying.
-		 * Also, we ensure that everyone can see pool->destroying before
-		 * we start waiting.
-		 */
-		putback_zspage_deferred(pool, class, zspage);
-		zs_pool_dec_isolated(pool);
-	}
+	write_unlock(&pool->migrate_lock);
+	spin_unlock(&class->lock);
+	dec_zspage_isolation(zspage);
+	migrate_write_unlock(zspage);
 
+	get_page(newpage);
 	if (page_zone(newpage) != page_zone(page)) {
 		dec_zone_page_state(page, NR_ZSPAGES);
 		inc_zone_page_state(newpage, NR_ZSPAGES);
@@ -2097,55 +1918,21 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 
 	reset_page(page);
 	put_page(page);
-	page = newpage;
 
-	ret = MIGRATEPAGE_SUCCESS;
-unpin_objects:
-	for (addr = s_addr + offset; addr < s_addr + pos;
-						addr += class->size) {
-		head = obj_to_head(page, addr);
-		if (head & OBJ_ALLOCATED_TAG) {
-			handle = head & ~OBJ_ALLOCATED_TAG;
-			BUG_ON(!testpin_tag(handle));
-			unpin_tag(handle);
-		}
-	}
-	kunmap_atomic(s_addr);
-	spin_unlock(&class->lock);
-	migrate_write_unlock(zspage);
-
-	return ret;
+	return MIGRATEPAGE_SUCCESS;
 }
 
 static void zs_page_putback(struct page *page)
 {
-	struct zs_pool *pool;
-	struct size_class *class;
-	int class_idx;
-	enum fullness_group fg;
-	struct address_space *mapping;
 	struct zspage *zspage;
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	get_zspage_mapping(zspage, &class_idx, &fg);
-	mapping = page_mapping(page);
-	pool = mapping->private_data;
-	class = pool->size_class[class_idx];
-
-	spin_lock(&class->lock);
+	migrate_write_lock(zspage);
 	dec_zspage_isolation(zspage);
-	if (!is_zspage_isolated(zspage)) {
-		/*
-		 * Due to page_lock, we cannot free zspage immediately
-		 * so let's defer.
-		 */
-		putback_zspage_deferred(pool, class, zspage);
-		zs_pool_dec_isolated(pool);
-	}
-	spin_unlock(&class->lock);
+	migrate_write_unlock(zspage);
 }
 
 static const struct address_space_operations zsmalloc_aops = {
@@ -2167,36 +1954,8 @@ static int zs_register_migration(struct zs_pool *pool)
 	return 0;
 }
 
-static bool pool_isolated_are_drained(struct zs_pool *pool)
-{
-	return atomic_long_read(&pool->isolated_pages) == 0;
-}
-
-/* Function for resolving migration */
-static void wait_for_isolated_drain(struct zs_pool *pool)
-{
-
-	/*
-	 * We're in the process of destroying the pool, so there are no
-	 * active allocations. zs_page_isolate() fails for completely free
-	 * zspages, so we need only wait for the zs_pool's isolated
-	 * count to hit zero.
-	 */
-	wait_event(pool->migration_wait,
-		   pool_isolated_are_drained(pool));
-}
-
 static void zs_unregister_migration(struct zs_pool *pool)
 {
-	pool->destroying = true;
-	/*
-	 * We need a memory barrier here to ensure global visibility of
-	 * pool->destroying. Thus pool->isolated pages will either be 0 in which
-	 * case we don't care, or it will be > 0 and pool->destroying will
-	 * ensure that we wake up once isolation hits 0.
-	 */
-	smp_mb();
-	wait_for_isolated_drain(pool); /* This can block */
 	flush_work(&pool->free_work);
 	iput(pool->inode);
 }
@@ -2226,7 +1985,6 @@ static void async_free_zspage(struct work_struct *work)
 		spin_unlock(&class->lock);
 	}
 
-
 	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
 		list_del(&zspage->list);
 		lock_zspage(zspage);
@@ -2290,8 +2048,13 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	struct zspage *dst_zspage = NULL;
 	unsigned long pages_freed = 0;
 
+	/* protect the race between zpage migration and zs_free */
+	write_lock(&pool->migrate_lock);
+	/* protect zpage allocation/free */
 	spin_lock(&class->lock);
 	while ((src_zspage = isolate_zspage(class, true))) {
+		/* protect someone accessing the zspage(i.e., zs_map_object) */
+		migrate_write_lock(src_zspage);
 
 		if (!zs_can_compact(class))
 			break;
@@ -2300,6 +2063,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		cc.s_page = get_first_page(src_zspage);
 
 		while ((dst_zspage = isolate_zspage(class, false))) {
+			migrate_write_lock_nested(dst_zspage);
+
 			cc.d_page = get_first_page(dst_zspage);
 			/*
 			 * If there is no more space in dst_page, resched
@@ -2309,6 +2074,10 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 				break;
 
 			putback_zspage(class, dst_zspage);
+			migrate_write_unlock(dst_zspage);
+			dst_zspage = NULL;
+			if (rwlock_is_contended(&pool->migrate_lock))
+				break;
 		}
 
 		/* Stop if we couldn't find slot */
@@ -2316,19 +2085,28 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			break;
 
 		putback_zspage(class, dst_zspage);
+		migrate_write_unlock(dst_zspage);
+
 		if (putback_zspage(class, src_zspage) == ZS_EMPTY) {
+			migrate_write_unlock(src_zspage);
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
-		}
+		} else
+			migrate_write_unlock(src_zspage);
 		spin_unlock(&class->lock);
+		write_unlock(&pool->migrate_lock);
 		cond_resched();
+		write_lock(&pool->migrate_lock);
 		spin_lock(&class->lock);
 	}
 
-	if (src_zspage)
+	if (src_zspage) {
 		putback_zspage(class, src_zspage);
+		migrate_write_unlock(src_zspage);
+	}
 
 	spin_unlock(&class->lock);
+	write_unlock(&pool->migrate_lock);
 
 	return pages_freed;
 }
@@ -2434,15 +2212,12 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;
 
 	init_deferred_free(pool);
+	rwlock_init(&pool->migrate_lock);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
 		goto err;
 
-#ifdef CONFIG_COMPACTION
-	init_waitqueue_head(&pool->migration_wait);
-#endif
-
 	if (create_cache(pool))
 		goto err;
 
