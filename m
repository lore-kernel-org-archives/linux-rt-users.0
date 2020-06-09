Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812CAC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B98B2078D
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbgFIU3w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731422AbgFIU3t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 16:29:49 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF1D206C3;
        Tue,  9 Jun 2020 20:29:47 +0000 (UTC)
Date:   Tue, 9 Jun 2020 16:29:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.4.44-rt27
Message-ID: <20200609162946.2a575bcf@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.4.44-rt27 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: ee8a165804fcf167113319fa659a4a3d1f18e536


Or to build 5.4.44-rt27 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.44.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.44-rt27.patch.xz



You can also build from 5.4.44-rt26 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.44-rt26-rt27.patch.xz



Enjoy,

-- Steve


Changes from v5.4.44-rt26:

---

John Ogness (1):
      printk: console must not schedule for drivers

Kevin Hao (1):
      mm: slub: Always flush the delayed empty slubs in flush_all()

Liwei Song (1):
      mm: Don't warn about atomic memory allocations during suspend

Sebastian Andrzej Siewior (3):
      fs/dcache: Include swait.h header
      Revert "rt: Improve the serial console PASS_LIMIT"
      mm/zswap: Use local lock to protect per-CPU data

Steven Rostedt (VMware) (1):
      Linux 5.4.44-rt27

汪勇10269566 (1):
      printk: Force a line break on pr_cont(" ")

----
 drivers/tty/serial/8250/8250_core.c | 11 +----------
 fs/proc/base.c                      |  1 +
 kernel/printk/printk.c              |  2 ++
 localversion-rt                     |  2 +-
 mm/slub.c                           | 11 +++++------
 mm/zswap.c                          | 21 ++++++++++++---------
 6 files changed, 22 insertions(+), 26 deletions(-)
---------------------------
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 809a65f68028..02bfafa8a672 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -55,16 +55,7 @@ static struct uart_driver serial8250_reg;
 
 static unsigned int skip_txen_test; /* force skip of txen test at init time */
 
-/*
- * On -rt we can have a more delays, and legitimately
- * so - so don't drop work spuriously and spam the
- * syslog:
- */
-#ifdef CONFIG_PREEMPT_RT
-# define PASS_LIMIT	1000000
-#else
-# define PASS_LIMIT	512
-#endif
+#define PASS_LIMIT	512
 
 #include <asm/serial.h>
 /*
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 2dcd8fb3abb5..dc6cfa5de1df 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -95,6 +95,7 @@
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
 #include <trace/events/oom.h>
+#include <linux/swait.h>
 #include "internal.h"
 #include "fd.h"
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2affe95866a4..2beb8eac13d1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1902,6 +1902,7 @@ static void cont_add(int ctx, int cpu, u32 caller_id, int facility, int level,
 	// but later continuations can add a newline.
 	if (flags & LOG_NEWLINE) {
 		c->flags |= LOG_NEWLINE;
+		cont_flush(ctx);
 	}
 }
 
@@ -2746,6 +2747,7 @@ static int printk_kthread_func(void *data)
 			    &len, printk_time);
 
 		console_lock();
+		console_may_schedule = 0;
 		call_console_drivers(master_seq, ext_text, ext_len, text, len,
 				     msg->level, msg->facility);
 		if (len > 0 || ext_len > 0)
diff --git a/localversion-rt b/localversion-rt
index 2e9afd4a0afd..be1e37b64ad0 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt26
+-rt27
diff --git a/mm/slub.c b/mm/slub.c
index 44a602fc8a16..b2809a9ca8f8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1635,7 +1635,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		enableirqs = true;
 
 #ifdef CONFIG_PREEMPT_RT
-	if (system_state > SYSTEM_BOOTING)
+	if (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND)
 		enableirqs = true;
 #endif
 	if (enableirqs)
@@ -2382,9 +2382,6 @@ static void flush_all(struct kmem_cache *s)
 	for_each_online_cpu(cpu) {
 		struct slub_free_list *f;
 
-		if (!has_cpu_slab(cpu, s))
-			continue;
-
 		f = &per_cpu(slub_free_list, cpu);
 		raw_spin_lock_irq(&f->lock);
 		list_splice_init(&f->list, &tofree);
@@ -2751,7 +2748,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	unsigned long tid;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (!s)
@@ -3216,7 +3214,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	int i;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, flags);
diff --git a/mm/zswap.c b/mm/zswap.c
index 21d2d3ed3d6d..3c9644b51f3f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -372,6 +372,8 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
 * per-cpu code
 **********************************/
 static DEFINE_PER_CPU(u8 *, zswap_dstmem);
+/* Used for zswap_dstmem and tfm */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_cpu_lock);
 
 static int zswap_dstmem_prepare(unsigned int cpu)
 {
@@ -889,10 +891,11 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		dlen = PAGE_SIZE;
 		src = (u8 *)zhdr + sizeof(struct zswap_header);
 		dst = kmap_atomic(page);
-		tfm = *get_cpu_ptr(entry->pool->tfm);
+		local_lock(zswap_cpu_lock);
+		tfm = *this_cpu_ptr(entry->pool->tfm);
 		ret = crypto_comp_decompress(tfm, src, entry->length,
 					     dst, &dlen);
-		put_cpu_ptr(entry->pool->tfm);
+		local_unlock(zswap_cpu_lock);
 		kunmap_atomic(dst);
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);
@@ -981,8 +984,6 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
-/* protect zswap_dstmem from concurrency */
-static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1060,7 +1061,8 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* compress */
-	dst = get_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_lock(zswap_cpu_lock);
+	dst = *this_cpu_ptr(&zswap_dstmem);
 	tfm = *this_cpu_ptr(entry->pool->tfm);
 	src = kmap_atomic(page);
 	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
@@ -1088,7 +1090,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1116,7 +1118,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
@@ -1161,9 +1163,10 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	if (zpool_evictable(entry->pool->zpool))
 		src += sizeof(struct zswap_header);
 	dst = kmap_atomic(page);
-	tfm = *get_cpu_ptr(entry->pool->tfm);
+	local_lock(zswap_cpu_lock);
+	tfm = *this_cpu_ptr(entry->pool->tfm);
 	ret = crypto_comp_decompress(tfm, src, entry->length, dst, &dlen);
-	put_cpu_ptr(entry->pool->tfm);
+	local_unlock(zswap_cpu_lock);
 	kunmap_atomic(dst);
 	zpool_unmap_handle(entry->pool->zpool, entry->handle);
 	BUG_ON(ret);
