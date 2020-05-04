Return-Path: <SRS0=LbvN=6S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C29C47247
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2192620707
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 20:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEDUF1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 May 2020 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgEDUF1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 May 2020 16:05:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB06EC061A0E;
        Mon,  4 May 2020 13:05:26 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jVhLA-00074N-Cr; Mon, 04 May 2020 22:05:24 +0200
Date:   Mon, 4 May 2020 22:05:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.6.10-rt5
Message-ID: <20200504200524.363rtiomih5stpez@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.6.10-rt5 patch set. 

Changes since v5.6.10-rt4:

  - Jiri Kosina reported that the IRQ's core spurious detector disables
    8250's interrupt line under high load on qemu/KVM. The root cause
    is that qemu process quite fast and issues the edge interrupt more
    often than actual hardware. The threaded interrupt runs longer
    because the RT patch increased the number of iterations of the
    handler for a reason which has been resolved in the meantime.
    It appears to the core that the IRQ is left unhandled because the
    primary handler fires constantly and the threaded handler appears to
    make no progress. To minimize the issue the loop-count is decreased
    to what upstream has.

  - A patch by Liwei Song to suppress a warning from the memory allocator
    during suspend-to-ram and not enable interrupts.

  - On kmem's cache destruction, the cache structure could be used after
    its destruction. Patch by Kevin Hao.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.6.10-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/incr/patch-5.6.10-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.6.10-rt5

The RT patch against v5.6.10 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patch-5.6.10-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.6/older/patches-5.6.10-rt5.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 15d7c47fb7ca3..475b51f4321db 100644
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
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/mm/slub.c b/mm/slub.c
index 15c194ff16e6e..9ec40d561b68c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1655,7 +1655,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		enableirqs = true;
 
 #ifdef CONFIG_PREEMPT_RT
-	if (system_state > SYSTEM_BOOTING)
+	if (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND)
 		enableirqs = true;
 #endif
 	if (enableirqs)
@@ -2402,9 +2402,6 @@ static void flush_all(struct kmem_cache *s)
 	for_each_online_cpu(cpu) {
 		struct slub_free_list *f;
 
-		if (!has_cpu_slab(cpu, s))
-			continue;
-
 		f = &per_cpu(slub_free_list, cpu);
 		raw_spin_lock_irq(&f->lock);
 		list_splice_init(&f->list, &tofree);
@@ -2771,7 +2768,8 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	unsigned long tid;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	s = slab_pre_alloc_hook(s, gfpflags);
 	if (!s)
@@ -3236,7 +3234,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	int i;
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP))
-		WARN_ON_ONCE(!preemptible() && system_state >= SYSTEM_SCHEDULING);
+		WARN_ON_ONCE(!preemptible() &&
+			     (system_state > SYSTEM_BOOTING && system_state < SYSTEM_SUSPEND));
 
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, flags);
