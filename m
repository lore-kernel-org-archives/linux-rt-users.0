Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A6C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Nov 2021 11:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF2160EE9
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Nov 2021 11:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKBLIT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhKBLIT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Nov 2021 07:08:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C37EC061714;
        Tue,  2 Nov 2021 04:05:44 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:05:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635851141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=To3nz0xcUd50FKbbqoFTcW6AhSctmxd2++k9ZUnoGis=;
        b=hlh08CIkwgQI9F1qgxRB3RTUJDeca52GEoBjV3d50N4E1gHKpjfSc9+6xxU9KlFxk5IN8V
        CqV33zC10CUpuPH97oyADfBkE6V+G0ZgxnmsTAOJQE7qYLUFarJizzIK0NK71YfvcqhVP8
        6vs1ipm2odxfcdhuOvQuPHi/KR7Fol6NdJDFSRsaTlbJw4ryxSPTQbxxjvduPEtmxFc8co
        WRNEQwxT0M09Pa7eUpuPJAUFoNUtQ8BZPxeNj3z10VXlViBjps5XZby81ysz1naBTgEMG0
        ba5YoU3+SP0cRNG9dTi25WMw20KTx3hKEzMHCESBaKkJ7QY8Fk//s7oRwRxJAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635851141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=To3nz0xcUd50FKbbqoFTcW6AhSctmxd2++k9ZUnoGis=;
        b=nS7FWYkYUvCHdKBg9nLL/XwqA1BLOhi16l9rzYO2v+yv331Hcd+UFhKjSWABWgJZFCZUb8
        dkxdOYCIDuFT4VDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15-rt17
Message-ID: <20211102110540.ms7grrieizwnzsop@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15-rt17 patch set. 

Changes since v5.15-rt16:

  - Remove put_cpu_var() in fscache which removal was overseen in the
    last release.

  - Redo the fs/dcache/start_dir_add() related patch and its
    description.

  - Drop preempt_disable_rt(), no more users.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15-rt16 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15-rt16-rt17.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15-rt17

The RT patch against v5.15 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15-rt17.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15-rt17.tar.xz

Sebastian

diff --git a/fs/dcache.c b/fs/dcache.c
index f34344ceece70..02db80f2817fc 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2537,11 +2537,16 @@ EXPORT_SYMBOL(d_rehash);
 
 static inline unsigned start_dir_add(struct inode *dir)
 {
-
-	preempt_disable_rt();
+	/*
+	 * The caller has a spinlock_t (dentry::d_lock) acquired which disables
+	 * preemption on !PREEMPT_RT. On PREEMPT_RT the lock does not disable
+	 * preemption and it has be done explicitly.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	for (;;) {
-		unsigned n = dir->__i_dir_seq;
-		if (!(n & 1) && cmpxchg(&dir->__i_dir_seq, n, n + 1) == n)
+		unsigned n = dir->i_dir_seq;
+		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
 			return n;
 		cpu_relax();
 	}
@@ -2549,8 +2554,9 @@ static inline unsigned start_dir_add(struct inode *dir)
 
 static inline void end_dir_add(struct inode *dir, unsigned n)
 {
-	smp_store_release(&dir->__i_dir_seq, n + 2);
-	preempt_enable_rt();
+	smp_store_release(&dir->i_dir_seq, n + 2);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 static void d_wait_lookup(struct dentry *dentry)
@@ -2586,7 +2592,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 
 retry:
 	rcu_read_lock();
-	seq = smp_load_acquire(&parent->d_inode->__i_dir_seq);
+	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
 	r_seq = read_seqbegin(&rename_lock);
 	dentry = __d_lookup_rcu(parent, name, &d_seq);
 	if (unlikely(dentry)) {
@@ -2614,7 +2620,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	}
 
 	hlist_bl_lock(b);
-	if (unlikely(READ_ONCE(parent->d_inode->__i_dir_seq) != seq)) {
+	if (unlikely(READ_ONCE(parent->d_inode->i_dir_seq) != seq)) {
 		hlist_bl_unlock(b);
 		rcu_read_unlock();
 		goto retry;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 78f332f2e98c8..7a972d144b546 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -814,8 +814,6 @@ void fscache_enqueue_object(struct fscache_object *object)
 				wake_up(&fscache_object_cong_wait);
 		} else
 			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
 	}
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 0c46c1a98c2ac..ed0cab8a32db1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -157,7 +157,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_pipe = NULL;
 	inode->i_cdev = NULL;
 	inode->i_link = NULL;
-	inode->__i_dir_seq = 0;
+	inode->i_dir_seq = 0;
 	inode->i_rdev = 0;
 	inode->dirtied_when = 0;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5ff6117d59f54..e7a633353fd20 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -711,7 +711,7 @@ struct inode {
 		struct pipe_inode_info	*i_pipe;
 		struct cdev		*i_cdev;
 		char			*i_link;
-		unsigned		__i_dir_seq;
+		unsigned		i_dir_seq;
 	};
 
 	__u32			i_generation;
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index dc8158a459859..3da73c9682119 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -331,14 +331,6 @@ do { \
 		set_preempt_need_resched(); \
 } while (0)
 
-#ifdef CONFIG_PREEMPT_RT
-# define preempt_disable_rt()		preempt_disable()
-# define preempt_enable_rt()		preempt_enable()
-#else
-# define preempt_disable_rt()		barrier()
-# define preempt_enable_rt()		barrier()
-#endif
-
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 struct preempt_notifier;
diff --git a/localversion-rt b/localversion-rt
index 1199ebade17b4..1e584b47c987e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17
