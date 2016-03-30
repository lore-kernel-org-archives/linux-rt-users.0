From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch] drivers/block/zram: Replace bit spinlocks with
 rtmutex for -rt
Date: Wed, 30 Mar 2016 10:56:22 +0200
Message-ID: <20160330085622.GA21849@linutronix.de>
References: <1458641979.15742.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38164 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbcC3I4Z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2016 04:56:25 -0400
Content-Disposition: inline
In-Reply-To: <1458641979.15742.6.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2016-03-22 11:19:39 [+0100]:

>--- a/drivers/block/zram/zram_drv.c
>+++ b/drivers/block/zram/zram_drv.c
>@@ -568,12 +570,13 @@ static int zram_decompress_page(struct z
> 	unsigned long handle;
> 	size_t size;
> 
>-	bit_spin_lock(ZRAM_ACCESS, &meta->table[index].value);
>+	zram_lock_table(&meta->table[index]);
> 	handle = meta->table[index].handle;
> 	size = zram_get_obj_size(meta, index);
> 
> 	if (!handle || zram_test_flag(meta, index, ZRAM_ZERO)) {
> 		bit_spin_unlock(ZRAM_ACCESS, &meta->table[index].value);
>+		zram_unlock_table(&meta->table[index]);

shouldn't you remove that ZRAM_ACCESS lock here?

> 		clear_page(mem);
> 		return 0;
> 	}
>--- a/drivers/block/zram/zram_drv.h
>+++ b/drivers/block/zram/zram_drv.h
>@@ -72,6 +72,9 @@ enum zram_pageflags {
> struct zram_table_entry {
> 	unsigned long handle;
> 	unsigned long value;
>+#ifdef CONFIG_PREEMPT_RT_BASE
>+	spinlock_t lock;
>+#endif
> };
> 
> struct zram_stats {
>@@ -119,4 +122,42 @@ struct zram {
> 	 */
> 	bool claim; /* Protected by bdev->bd_mutex */
> };
>+
>+#ifndef CONFIG_PREEMPT_RT_BASE
>+static inline void zram_lock_table(struct zram_table_entry *table)
>+{
>+	bit_spin_lock(ZRAM_ACCESS, &table->value);
>+}
>+
>+static inline void zram_unlock_table(struct zram_table_entry *table)
>+{
>+	bit_spin_unlock(ZRAM_ACCESS, &table->value);
>+}
>+
>+static inline void zram_meta_init_locks(struct zram_meta *meta, u64 disksize) { }
>+#else /* CONFIG_PREEMPT_RT_BASE */
>+static inline void zram_lock_table(struct zram_table_entry *table)
>+{
>+	spin_lock(&table->lock);
>+	__set_bit(ZRAM_ACCESS, &table->value);
>+}
>+
>+static inline void zram_unlock_table(struct zram_table_entry *table)
>+{
>+	__clear_bit(ZRAM_ACCESS, &table->value);
>+	spin_unlock(&table->lock);
>+}

ZRAM_ACCESS is the only bit used for locking. ZRAM_ZERO is the only flag
set / tested. 
Would it be possible to make value u32 and add a spinlock? value is has
not 64bit on 64bit systems and it uses only the first 23bits for the
size and bit 24+25 for the two flags we have now. So the size should not
change on 64bit systems only increase by four byte on 32bit systems.
That is without the lock debugging of course.

Minchan, Nitin, Sergey do see any reason not to do so?

>+static inline void zram_meta_init_table_locks(struct zram_meta *meta, u64 disksize)
>+{
>+        size_t num_pages = disksize >> PAGE_SHIFT;
>+        size_t index;
>+
>+        for (index = 0; index < num_pages; index++) {
>+		spinlock_t *lock = &meta->table[index].lock;
>+		spin_lock_init(lock);
>+        }
>+}
>+#endif /* CONFIG_PREEMPT_RT_BASE */
>+
> #endif

Sebastian
