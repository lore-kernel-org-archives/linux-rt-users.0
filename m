Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE9C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A17B61040
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbhG3NNE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:13:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbhG3NND (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 09:13:03 -0400
Date:   Fri, 30 Jul 2021 15:12:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627650778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BWcVGmbWyWcoDB2biQikuWjpg7PJH7JnLeQSr4fcBOg=;
        b=DaEvOh7YBqxJ+XBiAlMmoj4cwx0qHJfc1k0o40j77w6yquj3Jpu1FKh6yd9b7SqxrquO4Y
        PZEu1yNjA10HdhanONlMulyKCIMuI4pKvmbEzELMcOlBeDRfUluNMVYeuZzSlPfzHmWGgw
        +15wG9GBI4My0hJZdS08EGXyL5es9c9DLfoM0iueckZ/xnpSbchSQPC3+0+W4+8vT9uNUA
        jUcL7DUPENvOFbXEclGmS6VGCYyXe0uFRd5uKPxujcR4kH9b/tJhUmJMFIDP06WW4MLdLW
        LFpOKnQI29I+/da2v33CVywEdhSaQARzxew8V40/J9XkI+GX+B7MX2J55OZgIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627650778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BWcVGmbWyWcoDB2biQikuWjpg7PJH7JnLeQSr4fcBOg=;
        b=F5JpWNEHN/KAgXKk89pnOpY2SJ0NP5pnxj/X2jgZSGx5XR//BorHTZTXH4q0Opam8Fqjeb
        O0uS4Wl7AcYCmjAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.14-rc3-rt2
Message-ID: <20210730131256.7d3jccmpuiw5pr4o@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.14-rc3-rt2 patch set. 

Changes since v5.14-rc3-rt1:

  - To cope with SLUB based hackbench regression adaptive spinning has
    been introduced for all rtmutex based locks. This improves the
    hackbench time significantly.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

The delta patch against v5.14-rc3-rt1 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/incr/patch-5.14-rc3-rt1-rt2.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.14-rc3-rt2

The RT patch against v5.14-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patch-5.14-rc3-rt2.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.14/older/patches-5.14-rc3-rt2.tar.xz

Sebastian


diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 58762a3970ed7..e347bbc12641d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1277,6 +1277,43 @@ static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
 	rt_mutex_slowunlock(lock);
 }
 
+#ifdef CONFIG_SMP
+/*
+ * Note that owner is a speculative pointer and dereferencing relies
+ * on rcu_read_lock() and the check against the lock owner.
+ */
+static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
+				     struct task_struct *owner)
+{
+	bool res = true;
+
+	rcu_read_lock();
+	for (;;) {
+		/* Owner changed. Trylock again */
+		if (owner != rt_mutex_owner(lock))
+			break;
+		/*
+		 * Ensure that owner->on_cpu is dereferenced _after_
+		 * checking the above to be valid.
+		 */
+		barrier();
+		if (!owner->on_cpu) {
+			res = false;
+			break;
+		}
+		cpu_relax();
+	}
+	rcu_read_unlock();
+	return res;
+}
+#else
+static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
+				     struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 #ifdef RT_MUTEX_BUILD_MUTEX
 /*
  * Functions required for:
@@ -1361,6 +1398,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
+	struct task_struct *owner;
 	int ret = 0;
 
 	for (;;) {
@@ -1383,9 +1421,14 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 				break;
 		}
 
+		if (waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule();
+		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+			schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1534,43 +1577,6 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
  * Functions required for spin/rw_lock substitution on RT kernels
  */
 
-#ifdef CONFIG_SMP
-/*
- * Note that owner is a speculative pointer and dereferencing relies
- * on rcu_read_lock() and the check against the lock owner.
- */
-static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
-{
-	bool res = true;
-
-	rcu_read_lock();
-	for (;;) {
-		/* Owner changed. Trylock again */
-		if (owner != rt_mutex_owner(lock))
-			break;
-		/*
-		 * Ensure that owner->on_cpu is dereferenced _after_
-		 * checking the above to be valid.
-		 */
-		barrier();
-		if (!owner->on_cpu) {
-			res = false;
-			break;
-		}
-		cpu_relax();
-	}
-	rcu_read_unlock();
-	return res;
-}
-#else
-static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
-{
-	return false;
-}
-#endif
-
 /**
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
  * @lock:	The underlying rt mutex
@@ -1603,7 +1609,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		if (!owner || !rtlock_adaptive_spinwait(lock, owner))
+		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
 			schedule_rtlock();
 
 		raw_spin_lock_irq(&lock->wait_lock);
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd28..c3054d08a1129 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2
