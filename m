Return-Path: <SRS0=+jQa=7J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562A6C433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 May 2020 09:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402D9207E8
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 May 2020 09:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgE0JkR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 May 2020 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgE0JkQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 May 2020 05:40:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F6C061A0F;
        Wed, 27 May 2020 02:40:15 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdsXl-0005YJ-CX; Wed, 27 May 2020 11:40:13 +0200
Date:   Wed, 27 May 2020 11:40:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.6.14-rt7
Message-ID: <20200527094013.u4awz6uv7ozw5p6o@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.6.14-rt7 patch set. 

Changes since v5.6.14-rt6:

  - 汪勇 sent a patch to not lose a line break on pr_cont() if
    requested.

  - A few missing locking spots were identified in the zswap patch while
    it was reworked for upstream. Changes have been integrated in the
    original patch.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.6.14-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/incr/patch-5.6.14-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.14-rt7

The RT patch against v5.6.14 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.14-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.14-rt7.tar.xz

Sebastian

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8bc683be08574..6296d348f3008 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1871,6 +1871,7 @@ static void cont_add(int ctx, int cpu, u32 caller_id, int facility, int level,
 	// but later continuations can add a newline.
 	if (flags & LOG_NEWLINE) {
 		c->flags |= LOG_NEWLINE;
+		cont_flush(ctx);
 	}
 }
 
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/mm/zswap.c b/mm/zswap.c
index 1591b5d37f65d..51944e98c1249 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -391,6 +391,8 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
 * per-cpu code
 **********************************/
 static DEFINE_PER_CPU(u8 *, zswap_dstmem);
+/* Used for zswap_dstmem and tfm */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_cpu_lock);
 
 static int zswap_dstmem_prepare(unsigned int cpu)
 {
@@ -920,10 +922,11 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
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
@@ -996,8 +999,6 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
-/* protect zswap_dstmem from concurrency */
-static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1077,7 +1078,8 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* compress */
-	dst = get_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_lock(zswap_cpu_lock);
+	dst = *this_cpu_ptr(&zswap_dstmem);
 	tfm = *this_cpu_ptr(entry->pool->tfm);
 	src = kmap_atomic(page);
 	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
@@ -1105,7 +1107,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1133,7 +1135,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
@@ -1178,9 +1180,10 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
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
