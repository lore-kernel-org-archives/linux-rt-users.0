From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/15] drivers/block/zram: Replace bit spinlocks with rtmutex for -rt
Date: Tue, 12 Jul 2016 10:29:11 -0400
Message-ID: <20160712142919.329830581@goodmis.org>
References: <20160712142907.636678217@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-drivers-block-zram-Replace-bit-spinlocks-with-rtmute.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.36-rt38-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

They're nondeterministic, and lead to ___might_sleep() splats in -rt.
OTOH, they're a lot less wasteful than an rtmutex per page.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/block/zram/zram_drv.c | 30 ++++++++++++++++--------------
 drivers/block/zram/zram_drv.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 3920ee45aa59..548b5bb5eeb6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -336,6 +336,8 @@ static struct zram_meta *zram_meta_alloc(u64 disksize)
 		goto free_table;
 	}
 
+	zram_meta_init_table_locks(meta, disksize);
+
 	return meta;
 
 free_table:
@@ -425,12 +427,12 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
 	unsigned long handle;
 	size_t size;
 
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	handle = meta->table[index].handle;
 	size = zram_get_obj_size(meta, index);
 
 	if (!handle || zram_test_flag(meta, index, ZRAM_ZERO)) {
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 		clear_page(mem);
 		return 0;
 	}
@@ -441,7 +443,7 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
 	else
 		ret = zcomp_decompress(zram->comp, cmem, size, mem);
 	zs_unmap_object(meta->mem_pool, handle);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	/* Should NEVER happen. Return bio error if it does. */
 	if (unlikely(ret)) {
@@ -461,14 +463,14 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	struct zram_meta *meta = zram->meta;
 	page = bvec->bv_page;
 
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	if (unlikely(!meta->table[index].handle) ||
 			zram_test_flag(meta, index, ZRAM_ZERO)) {
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 		handle_zero_page(bvec);
 		return 0;
 	}
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	if (is_partial_io(bvec))
 		/* Use  a temporary buffer to decompress the page */
@@ -563,10 +565,10 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec, u32 index,
 		if (user_mem)
 			kunmap_atomic(user_mem);
 		/* Free memory associated with this sector now. */
-		bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_lock_table(&meta->table[index]);
 		zram_free_page(zram, index);
 		zram_set_flag(meta, index, ZRAM_ZERO);
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 
 		atomic64_inc(&zram->stats.zero_pages);
 		ret = 0;
@@ -626,12 +628,12 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec, u32 index,
 	 * Free memory associated with this sector
 	 * before overwriting unused sectors.
 	 */
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	zram_free_page(zram, index);
 
 	meta->table[index].handle = handle;
 	zram_set_obj_size(meta, index, clen);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	/* Update stats */
 	atomic64_add(clen, &zram->stats.compr_data_size);
@@ -698,9 +700,9 @@ static void zram_bio_discard(struct zram *zram, u32 index,
 	}
 
 	while (n >= PAGE_SIZE) {
-		bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_lock_table(&meta->table[index]);
 		zram_free_page(zram, index);
-		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+		zram_unlock_table(&meta->table[index]);
 		atomic64_inc(&zram->stats.notify_free);
 		index++;
 		n -= PAGE_SIZE;
@@ -939,9 +941,9 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram = bdev->bd_disk->private_data;
 	meta = zram->meta;
 
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	zram_free_page(zram, index);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 	atomic64_inc(&zram->stats.notify_free);
 }
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index c6ee271317f5..1251d718f4bd 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -78,6 +78,9 @@ enum zram_pageflags {
 struct zram_table_entry {
 	unsigned long handle;
 	unsigned long value;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	spinlock_t lock;
+#endif
 };
 
 struct zram_stats {
@@ -120,4 +123,42 @@ struct zram {
 
 	char compressor[10];
 };
+
+#ifndef CONFIG_PREEMPT_RT_BASE
+static inline void zram_lock_table(struct zram_table_entry *table)
+{
+	bit_spin_lock(ZRAM_ACCESS, &table->value);
+}
+
+static inline void zram_unlock_table(struct zram_table_entry *table)
+{
+	bit_spin_unlock(ZRAM_ACCESS, &table->value);
+}
+
+static inline void zram_meta_init_locks(struct zram_meta *meta, u64 disksize) { }
+#else /* CONFIG_PREEMPT_RT_BASE */
+static inline void zram_lock_table(struct zram_table_entry *table)
+{
+	spin_lock(&table->lock);
+	__set_bit(ZRAM_ACCESS, &table->value);
+}
+
+static inline void zram_unlock_table(struct zram_table_entry *table)
+{
+	__clear_bit(ZRAM_ACCESS, &table->value);
+	spin_unlock(&table->lock);
+}
+
+static inline void zram_meta_init_table_locks(struct zram_meta *meta, u64 disksize)
+{
+        size_t num_pages = disksize >> PAGE_SHIFT;
+        size_t index;
+
+        for (index = 0; index < num_pages; index++) {
+		spinlock_t *lock = &meta->table[index].lock;
+		spin_lock_init(lock);
+        }
+}
+#endif /* CONFIG_PREEMPT_RT_BASE */
+
 #endif
-- 
2.8.1
