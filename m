Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7262153BEE;
	Mon, 16 Sep 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492437; cv=none; b=kEf/SjPfldL3ctg+p6GEwKRBU3t16wMGdbvm+lD88tLeOZzLgvk3MtMZADd4qlDpoO43zAB5rv4lQN125VDGvV0l4T47QMEbADVwH4kf4Bwvh8hsgycyki2JWHVj7xqB8mygfHYk5JG0IlA8Q59bLiDEgol6gnPgKxHzDDiSpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492437; c=relaxed/simple;
	bh=5xbJRPM5I/QUhhW37BMp0qk5mUtl79b4gRQGutAPENo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NB+0One8t/aetN3YrMCITUi/5LZwununRyxaD61quOCB28E91REOU21V0T75PCMajMg5JwmWHsswic3Swo+oX4J1QrCoPXOyDAjI5jjwqvdecWyECaxXvMpC0DHU/tLvZ3tSeX43EAjA6ey4JndVq+Zj6fR/69fCU//0/Z5l+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eu1n/4nY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqW199fO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eu1n/4nY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqW199fO"
Date: Mon, 16 Sep 2024 15:13:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726492433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Pqt/TehzIW9zMxPyhxG2C6Ab8C9WLJhAIv+nO7RVndI=;
	b=eu1n/4nYvzNV4I6WO1FMlnIirGPeKt4nbRlZt0w4DjOarQxRFXdmjHBXKFJn3Qc89Hs5sl
	JNjqHVegpNmb0t0IgrORST6Q0Tcf+xyPUIrQeHXXm6vjPuQ2G974hV3k4sYEmMcZm1wgAM
	m30Ya3tk03639ZMoNiFGDA1teM+ISZq3PLk3vpeFX4XTyLDOMk6UTYFizChODg9h6jtLMK
	1hcM/PLhadMEuxJwg+zwn72tjTJqm9PO3sqkIV6pNC4mMHYbJ/oGdGPud+c7NVMxenEiyx
	O9axcbxydjQHaQQqTzxwuRrdl3H9DdRGLDk7ZUruQ93TqXW6wIzU4SacllHOLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726492433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Pqt/TehzIW9zMxPyhxG2C6Ab8C9WLJhAIv+nO7RVndI=;
	b=AqW199fOZUKIgw1G9QDGuQlYzA1L9IXxwIKMi3lGGD/I7x3QGoYoGM6+6Z/fuzn5yeQmcP
	1sov143w9j/8LWDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.11-rt7
Message-ID: <20240916131351.qZv6CzyB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.11-rt7 patch set. 

Changes since v6.11-rt6:

  - Update zram patches to latest version which has been picked up by
    upstream.

  - Update prinkt queue to the latest version in printk.git. The atomic
    console for 8250 UART has been kept as is.

Known issues
    None.

The delta patch against v6.11-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/incr/patch-6.11-rt6-rt7.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.11-rt7

The RT patch against v6.11 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patch-6.11-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patches-6.11-rt7.tar.xz

Sebastian

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4afffb19f99e0..84cd62efac0f6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -57,14 +57,6 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 			  struct bio *parent);
 
-static void zram_meta_init_table_locks(struct zram *zram, size_t num_pages)
-{
-	size_t index;
-
-	for (index = 0; index < num_pages; index++)
-		spin_lock_init(&zram->table[index].lock);
-}
-
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
 	return spin_trylock(&zram->table[index].lock);
@@ -1219,7 +1211,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
-	size_t num_pages;
+	size_t num_pages, index;
 
 	num_pages = disksize >> PAGE_SHIFT;
 	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
@@ -1234,7 +1226,9 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 
 	if (!huge_class_size)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
-	zram_meta_init_table_locks(zram, num_pages);
+
+	for (index = 0; index < num_pages; index++)
+		spin_lock_init(&zram->table[index].lock);
 	return true;
 }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 32a383c4f62eb..fd12efcc4aeda 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1259,6 +1259,9 @@ void nbcon_kthreads_wake(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
+		if (!(console_srcu_read_flags(con) & CON_NBCON))
+			continue;
+
 		/*
 		 * Only schedule irq_work if the printing thread is
 		 * actively waiting. If not waiting, the thread will
@@ -1292,8 +1295,14 @@ void nbcon_kthread_stop(struct console *con)
  * Return:	True if the kthread was started or already exists.
  *		Otherwise false and @con must not be registered.
  *
- * If @con was already registered, it must be unregistered before
- * the global state variable @printk_kthreads_running can be set.
+ * This function is called when it will be expected that nbcon consoles are
+ * flushed using the kthread. The messages printed with NBCON_PRIO_NORMAL
+ * will be no longer flushed by the legacy loop. This is why failure must
+ * be fatal for console registration.
+ *
+ * If @con was already registered and this function fails, @con must be
+ * unregistered before the global state variable @printk_kthreads_running
+ * can be set.
  */
 bool nbcon_kthread_create(struct console *con)
 {
@@ -1347,8 +1356,7 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 	if (!printk_percpu_data_ready())
 		return &early_nbcon_pcpu_emergency_nesting;
 
-	/* Open code this_cpu_ptr() without checking migration. */
-	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
+	return raw_cpu_ptr(&nbcon_pcpu_emergency_nesting);
 }
 
 /**
@@ -1696,6 +1704,7 @@ bool nbcon_alloc(struct console *con)
 		if (printk_kthreads_running) {
 			if (!nbcon_kthread_create(con)) {
 				kfree(con->pbufs);
+				con->pbufs = NULL;
 				return false;
 			}
 		}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2994f6a1ca7af..71e4fe6f9b85e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2451,7 +2451,6 @@ static u64 syslog_seq;
 
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
-static inline void legacy_kthread_wake(void) { }
 
 #endif /* CONFIG_PRINTK */
 
@@ -3162,10 +3161,11 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			bool progress;
 
 			/*
-			 * console_flush_all() is only for legacy consoles when
-			 * the nbcon consoles have their printer threads.
+			 * console_flush_all() is only responsible for nbcon
+			 * consoles when the nbcon consoles cannot print via
+			 * their atomic or threaded flushing.
 			 */
-			if ((flags & CON_NBCON) && ft.nbcon_offload)
+			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 				continue;
 
 			if (!console_is_usable(con, flags, !do_cond_resched))
@@ -3507,7 +3507,7 @@ void console_start(struct console *console)
 	printk_get_console_flush_type(&ft);
 	if (is_nbcon && ft.nbcon_offload)
 		nbcon_kthread_wake(console);
-	else if (!is_nbcon && ft.legacy_offload)
+	else if (ft.legacy_offload)
 		defer_console_output();
 
 	__pr_flush(console, 1000, true);
@@ -3540,10 +3540,11 @@ static bool legacy_kthread_should_wakeup(void)
 		u64 printk_seq;
 
 		/*
-		 * The legacy printer thread is only for legacy consoles when
-		 * the nbcon consoles have their printer threads.
+		 * The legacy printer thread is only responsible for nbcon
+		 * consoles when the nbcon consoles cannot print via their
+		 * atomic or threaded flushing.
 		 */
-		if ((flags & CON_NBCON) && ft.nbcon_offload)
+		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
 		if (!console_is_usable(con, flags, false))
@@ -4343,6 +4344,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	/* Flush the consoles so that records up to @seq are printed. */
 	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
@@ -4446,19 +4449,14 @@ static bool pr_flush(int timeout_ms, bool reset_on_progress)
 
 static DEFINE_PER_CPU(int, printk_pending);
 
-static void legacy_kthread_wake(void)
-{
-	if (printk_legacy_kthread)
-		wake_up_interruptible(&legacy_wait);
-}
-
 static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
 	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
 		if (force_legacy_kthread()) {
-			legacy_kthread_wake();
+			if (printk_legacy_kthread)
+				wake_up_interruptible(&legacy_wait);
 		} else {
 			if (console_trylock())
 				console_unlock();
@@ -4873,6 +4871,8 @@ void console_try_replay_all(void)
 	printk_get_console_flush_type(&ft);
 	if (console_trylock()) {
 		__console_rewind_all();
+		if (ft.nbcon_atomic)
+			nbcon_atomic_flush_pending();
 		if (ft.nbcon_offload)
 			nbcon_kthreads_wake();
 		if (ft.legacy_offload)
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index ba778e2ef28b9..4ef81349d9fbe 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -4,6 +4,7 @@
 #define _KERNEL_PRINTK_RINGBUFFER_H
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/dev_printk.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -122,7 +123,7 @@ enum desc_state {
 
 #define _DATA_SIZE(sz_bits)	(1UL << (sz_bits))
 #define _DESCS_COUNT(ct_bits)	(1U << (ct_bits))
-#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
+#define DESC_SV_BITS		BITS_PER_LONG
 #define DESC_FLAGS_SHIFT	(DESC_SV_BITS - 2)
 #define DESC_FLAGS_MASK		(3UL << DESC_FLAGS_SHIFT)
 #define DESC_STATE(sv)		(3UL & (sv >> DESC_FLAGS_SHIFT))
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
