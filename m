Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E7BC432BE
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4AC61008
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbhIANLr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbhIANLk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Sep 2021 09:11:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0BC0613D9;
        Wed,  1 Sep 2021 06:10:42 -0700 (PDT)
Date:   Wed, 1 Sep 2021 15:10:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630501840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3anV4hQHnkObcm4SjLFFqpqzk/b83hbJC8mwLZK5Ipc=;
        b=RcYA3tU5KeXRH8VIO5jT/Xi6dn5JTmxAZ/sEh+/TiBj5cNXlb5weeOube+DJtRJ5Ba8WdK
        KSV2KgV12llAQ8sReu0YPgiQ+LOTKOsoRcl7uHQTAGGSGYwf7OrO/mymcC7lr78fxtEyxw
        b1PR2gH0cLYQTOpzzAJval86ePL5Nd0uqEe0PYVu2Z9MgI5u0Ow4rB0a2ZWswvMv7hbjHz
        P6GCqZZCt5mHAm4lAxTDItkyffzlHxvUVLqAVbvlZZ1U23qq/QtlAXyzVCKVCtw/F3zAEk
        amyRy8E4FSaIcEwGkyBwp+SWYBlN53INARl8Ip9nCUxEilXnhf3GXlELKQqxYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630501840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3anV4hQHnkObcm4SjLFFqpqzk/b83hbJC8mwLZK5Ipc=;
        b=pEXdxuxyDd54/pg+DTvsT3iDodWWm6N1BOTwSnyEBqcxdbIzq58BkiwXvjWUUumcbJHySG
        ww8Wg5EHfIdYb+DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rt16
Message-ID: <20210901131038.dyjltwgr4xjkujyq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rt16 patch set. 

Changes since v5.14-rt15:

  - The scheduler related "balance_push()" fix in the previous release
    had a logic error which has been now corrected. Patch by Thomas
    Gleixner.

  - The kcov related warning, reported by Clark Williams, has been
    addressed.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - A RCU and ARM64 warning has been fixed by Valentin Schneider. It is
       still not clear if the RCU related change is correct.

     - Clark Williams reported issues in i915 (execlists_dequeue_irq())

     - Valentin Schneider reported a few splats on ARM64, see
          https://https://lkml.kernel.org/r/.kernel.org/lkml/20210810134127.1394269-1-valentin.schneider@arm.com/

The delta patch against v5.14-rt15 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rt16

The RT patch against v5.14 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rt16.tar.xz

Sebastian

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index d2c4c27e1702d..d83c9ab494275 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -50,6 +50,7 @@ The following program demonstrates coverage collection from within a test
     #include <sys/mman.h>
     #include <unistd.h>
     #include <fcntl.h>
+    #include <linux/types.h>
 
     #define KCOV_INIT_TRACE			_IOR('c', 1, unsigned long)
     #define KCOV_ENABLE			_IO('c', 100)
@@ -177,6 +178,8 @@ Comparison operands collection
 	/* Read number of comparisons collected. */
 	n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
 	for (i = 0; i < n; i++) {
+		uint64_t ip;
+
 		type = cover[i * KCOV_WORDS_PER_CMP + 1];
 		/* arg1 and arg2 - operands of the comparison. */
 		arg1 = cover[i * KCOV_WORDS_PER_CMP + 2];
@@ -251,6 +254,8 @@ selectively from different subsystems.
 
 .. code-block:: c
 
+    /* Same includes and defines as above. */
+
     struct kcov_remote_arg {
 	__u32		trace_mode;
 	__u32		area_size;
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 80bfe71bbe13e..36ca640c4f8e7 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -88,6 +88,7 @@ static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
 
 struct kcov_percpu_data {
 	void			*irq_area;
+	local_lock_t		lock;
 
 	unsigned int		saved_mode;
 	unsigned int		saved_size;
@@ -96,7 +97,9 @@ struct kcov_percpu_data {
 	int			saved_sequence;
 };
 
-static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
+static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
 
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
@@ -824,7 +827,7 @@ void kcov_remote_start(u64 handle)
 	if (!in_task() && !in_serving_softirq())
 		return;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&kcov_percpu_data.lock, flags);
 
 	/*
 	 * Check that kcov_remote_start() is not called twice in background
@@ -832,7 +835,7 @@ void kcov_remote_start(u64 handle)
 	 */
 	mode = READ_ONCE(t->kcov_mode);
 	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/*
@@ -841,14 +844,15 @@ void kcov_remote_start(u64 handle)
 	 * happened while collecting coverage from a background thread.
 	 */
 	if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 
 	spin_lock(&kcov_remote_lock);
 	remote = kcov_remote_find(handle);
 	if (!remote) {
-		spin_unlock_irqrestore(&kcov_remote_lock, flags);
+		spin_unlock(&kcov_remote_lock);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	kcov_debug("handle = %llx, context: %s\n", handle,
@@ -869,19 +873,19 @@ void kcov_remote_start(u64 handle)
 		size = CONFIG_KCOV_IRQ_AREA_SIZE;
 		area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
 	}
-	spin_unlock_irqrestore(&kcov_remote_lock, flags);
+	spin_unlock(&kcov_remote_lock);
 
 	/* Can only happen when in_task(). */
 	if (!area) {
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		area = vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			kcov_put(kcov);
 			return;
 		}
+		local_lock_irqsave(&kcov_percpu_data.lock, flags);
 	}
 
-	local_irq_save(flags);
-
 	/* Reset coverage size. */
 	*(u64 *)area = 0;
 
@@ -891,7 +895,7 @@ void kcov_remote_start(u64 handle)
 	}
 	kcov_start(t, kcov, size, area, mode, sequence);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 
 }
 EXPORT_SYMBOL(kcov_remote_start);
@@ -965,12 +969,12 @@ void kcov_remote_stop(void)
 	if (!in_task() && !in_serving_softirq())
 		return;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&kcov_percpu_data.lock, flags);
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (!kcov_mode_enabled(mode)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/*
@@ -978,12 +982,12 @@ void kcov_remote_stop(void)
 	 * actually found the remote handle and started collecting coverage.
 	 */
 	if (in_serving_softirq() && !t->kcov_softirq) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/* Make sure that kcov_softirq is only set when in softirq. */
 	if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 
@@ -1013,7 +1017,7 @@ void kcov_remote_stop(void)
 		spin_unlock(&kcov_remote_lock);
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 
 	/* Get in kcov_remote_start(). */
 	kcov_put(kcov);
@@ -1034,8 +1038,8 @@ static int __init kcov_init(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		void *area = vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE *
-				sizeof(unsigned long));
+		void *area = vmalloc_node(CONFIG_KCOV_IRQ_AREA_SIZE *
+				sizeof(unsigned long), cpu_to_node(cpu));
 		if (!area)
 			return -ENOMEM;
 		per_cpu_ptr(&kcov_percpu_data, cpu)->irq_area = area;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7ce1935e74540..bb115218bb78b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8686,7 +8686,7 @@ static void balance_push(struct rq *rq)
 	 * Only active while going offline and when invoked on the outgoing
 	 * CPU.
 	 */
-	if (!cpu_dying(rq->cpu) && rq == this_rq())
+	if (!cpu_dying(rq->cpu) || rq != this_rq())
 		return;
 
 	/*
diff --git a/localversion-rt b/localversion-rt
index 18777ec0c27d4..1199ebade17b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
