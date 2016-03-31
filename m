From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [rfc patch] drivers/block/zram: Replace bit spinlocks with
 rtmutex for -rt
Date: Thu, 31 Mar 2016 04:08:28 +0200
Message-ID: <1459390108.4030.5.camel@gmail.com>
References: <1458641979.15742.6.camel@gmail.com>
	 <20160330085622.GA21849@linutronix.de> <1459329836.4175.16.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36319 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbcCaCIc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2016 22:08:32 -0400
Received: by mail-wm0-f49.google.com with SMTP id 127so117279544wmu.1
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Mar 2016 19:08:31 -0700 (PDT)
In-Reply-To: <1459329836.4175.16.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2016-03-30 at 11:23 +0200, Mike Galbraith wrote:
> On Wed, 2016-03-30 at 10:56 +0200, Sebastian Andrzej Siewior wrote:
> > * Mike Galbraith | 2016-03-22 11:19:39 [+0100]:
> > 
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -568,12 +570,13 @@ static int zram_decompress_page(struct z
> > > 	> > > > > unsigned long handle;
> > > 	> > > > > size_t size;
> > > 
> > > -> > > > > 	> > > > > bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
> > > +> > > > > 	> > > > > zram_lock_table(&meta->table[index]);
> > > 	> > > > > handle = meta->table[index].handle;
> > > 	> > > > > size = zram_get_obj_size(meta, index);
> > > 
> > > 	> > > > > if (!handle || zram_test_flag(meta, index, ZRAM_ZERO)) {
> > > 	> > > > > > > > 	> > > > > bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
> > > +> > > > > 	> > > > > > > > 	> > > > > zram_unlock_table(&meta->table[index]);
> > 
> > shouldn't you remove that ZRAM_ACCESS lock here?
> 
> Oops, yup.
> 
> > ZRAM_ACCESS is the only bit used for locking. ZRAM_ZERO is the only flag
> > set / tested. 
> > Would it be possible to make value u32 and add a spinlock? value is has
> > not 64bit on 64bit systems and it uses only the first 23bits for the
> > size and bit 24+25 for the two flags we have now. So the size should not
> > change on 64bit systems only increase by four byte on 32bit systems.
> > That is without the lock debugging of course.
> 
> I started going the raw locks route for the allocator instead of
> whacking the bit spinlocks, given what it is, but chickened out when I
> saw compression, and started thinking of just disabling it for rt
> instead.  I flipped back, figuring a bloated zram gizmo is better than
> no gizmo at all :-/

(fixed the missed bit spinlock whackage you pointed out)

drivers/block/zram: Replace bit spinlocks with rtmutex for -rt

They're nondeterministic, and lead to ___might_sleep() splats in -rt.
OTOH, they're a lot less wasteful than an rtmutex per page.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 drivers/block/zram/zram_drv.c |   30 ++++++++++++++++--------------
 drivers/block/zram/zram_drv.h |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 14 deletions(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -520,6 +520,8 @@ static struct zram_meta *zram_meta_alloc
 		goto out_error;
 	}
 
+	zram_meta_init_table_locks(meta, disksize);
+
 	return meta;
 
 out_error:
@@ -568,12 +570,12 @@ static int zram_decompress_page(struct z
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
@@ -584,7 +586,7 @@ static int zram_decompress_page(struct z
 	else
 		ret = zcomp_decompress(zram->comp, cmem, size, mem);
 	zs_unmap_object(meta->mem_pool, handle);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 
 	/* Should NEVER happen. Return bio error if it does. */
 	if (unlikely(ret)) {
@@ -604,14 +606,14 @@ static int zram_bvec_read(struct zram *z
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
@@ -689,10 +691,10 @@ static int zram_bvec_write(struct zram *
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
@@ -752,12 +754,12 @@ static int zram_bvec_write(struct zram *
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
@@ -800,9 +802,9 @@ static void zram_bio_discard(struct zram
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
@@ -928,9 +930,9 @@ static void zram_slot_free_notify(struct
 	zram = bdev->bd_disk->private_data;
 	meta = zram->meta;
 
-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_lock_table(&meta->table[index]);
 	zram_free_page(zram, index);
-	bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
+	zram_unlock_table(&meta->table[index]);
 	atomic64_inc(&zram->stats.notify_free);
 }
 
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -72,6 +72,9 @@ enum zram_pageflags {
 struct zram_table_entry {
 	unsigned long handle;
 	unsigned long value;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	spinlock_t lock;
+#endif
 };
 
 struct zram_stats {
@@ -119,4 +122,42 @@ struct zram {
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
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

