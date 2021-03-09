Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE201C433E9
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Mar 2021 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC37D652CC
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Mar 2021 20:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhCIUkP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhCIUjz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Mar 2021 15:39:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB7C06174A;
        Tue,  9 Mar 2021 12:39:54 -0800 (PST)
Date:   Tue, 9 Mar 2021 21:39:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615322392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OKNd7/rxYhsQelqiJwdxJxn//ZZydN8JASiDCTZZB7g=;
        b=Jnp3fZr6v+apcHPh8jxqPomCAnAFzcx78KT2LQ4ZRCwQnceg4aaRBwLfRNsdmf3jH6kJN0
        G3p7dYSooSoxOoFnhQmbXNaLzK/DGuGJoFnXCOFCb8Z1dz7bJKCb6L8NSnl/WQDX7WnkZo
        0PjR8Lids7pbcG74xe0y0mYBgQ3gzFyIN1ankq3LCxas9GoEuz/s78AlHX0iSq/nwbR2KH
        6yPMnMolfKyCf2SA/Rx5ns0wQuzbz2iNmAq211e3eYU267O9Q+rrg+jHBNM73AdVnG3Olj
        Egv986JIsuDStnZwhMFdtGSR1EVulwt67KUpRFGlb8vGZ93F+f/ofKt0CKFlHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615322392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=OKNd7/rxYhsQelqiJwdxJxn//ZZydN8JASiDCTZZB7g=;
        b=/mOgnauX/la44fyehgxzWPGwcy2MTcg6zb6AjRq8lfUvRb0reOymdtyT2i8hA5qUzn8xJc
        mdMN8pEbC/jLRnAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10.21-rt34
Message-ID: <20210309203950.33ikot2ddvoj7gmo@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10.21-rt34 patch set.

Changes since v5.10.21-rt33:

  - The alloc/free tracker sysfs file uses one PAGE size for
    collecting the results. If it runs out of space it reallocates
    more memory with disabled interrupts. The reallocation is now
    forbidden on PREEMPT_RT.

  - Update the softirq/tasklet patches to the latest version posted to
    the list.

Known issues
     - kdb/kgdb can easily deadlock.
     - netconsole triggers WARN.

The delta patch against v5.10.21-rt33 is appended below and can be found here:

     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.21-rt33-rt34.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10.21-rt34

The RT patch against v5.10.21 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.21-rt34.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10.21-rt34.tar.xz

Sebastian

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2725c6ad10af6..7545a2f18560a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -663,6 +663,7 @@ static inline int tasklet_trylock(struct tasklet_struct *t)
 void tasklet_unlock(struct tasklet_struct *t);
 void tasklet_unlock_wait(struct tasklet_struct *t);
 void tasklet_unlock_spin_wait(struct tasklet_struct *t);
+
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
 static inline void tasklet_unlock(struct tasklet_struct *t) { }
@@ -693,8 +694,8 @@ static inline void tasklet_disable_nosync(struct tasklet_struct *t)
 }
 
 /*
- * Do not use in new code. There is no real reason to invoke this from
- * atomic contexts.
+ * Do not use in new code. Disabling tasklets from atomic contexts is
+ * error prone and should be avoided.
  */
 static inline void tasklet_disable_in_atomic(struct tasklet_struct *t)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index f0074f1344402..c9adc5c462485 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -830,8 +830,8 @@ EXPORT_SYMBOL(tasklet_init);
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /*
- * Do not use in new code. There is no real reason to invoke this from
- * atomic contexts.
+ * Do not use in new code. Waiting for tasklets from atomic contexts is
+ * error prone and should be avoided.
  */
 void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 {
diff --git a/localversion-rt b/localversion-rt
index e1d8362520178..21988f9ad53f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt33
+-rt34
diff --git a/mm/slub.c b/mm/slub.c
index 32a87e0038776..15690db5223e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4697,6 +4697,9 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
 	struct location *l;
 	int order;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && flags == GFP_ATOMIC)
+		return 0;
+
 	order = get_order(sizeof(struct location) * max);
 
 	l = (void *)__get_free_pages(flags, order);
