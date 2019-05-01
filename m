Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E363C43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AE220645
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 17:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rvdJtYFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfEARKF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 13:10:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47076 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfEARKF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 13:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PHgLsKQMBP/rg6N34ArN/d4IlTAvZMQCtwzu5XcNJ6U=; b=rvdJtYFacwNWRUf0X1YjcvkgL
        6X5iyCjGwYjd547AhhDCwWXnmTJPUdAl3pRyVkZxjGP1mFug1XboJEuNxKNzxEUFn9b7TeFr/pljz
        ZATwmHyw/KWRRGwV+F7aCkoDx1zPHuTBXdgOWTaN62SuA7JjOylFFtvSJjfpfGj/wZ23ImY3E1xOO
        FfGlyaJ8Zq4EuiKaGMufnHTLoy7zwB0ErDh9dvrXODWYnQVwSzSZ+RBPX8vWvFFI4sYcaZTZnM6PK
        X0Ivkx9Gsg8+WuIREoJ6yohVXZE6UAjvQGlGgWkIgaotSZErYmPajj0U8icKqkUW4o0ovJ47WBNCZ
        Ur2cPnptA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLsk1-0002Bu-Ft; Wed, 01 May 2019 17:09:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF78E29AA6077; Wed,  1 May 2019 19:09:53 +0200 (CEST)
Date:   Wed, 1 May 2019 19:09:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, jack@suse.com,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190501170953.GB2650@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430132811.GB2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 30, 2019 at 03:28:11PM +0200, Peter Zijlstra wrote:

> Yeah, but AFAIK fs freezing code has a history of doing exactly that..
> This is just the latest incarnation here.
> 
> So the immediate problem here is that the task doing thaw isn't the same
> that did freeze, right? The thing is, I'm not seeing how that isn't a
> problem with upstream either.
> 
> The freeze code seems to do: percpu_down_write() for the various states,
> and then frobs lockdep state.
> 
> Thaw then does the reverse, frobs lockdep and then does: percpu_up_write().
> 
> percpu_down_write() directly relies on down_write(), and
> percpu_up_write() on up_write(). And note how __up_write() has:
> 
> 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
> 
> So why isn't this same code coming unstuck in mainline?

Anyway; I cobbled together the below. Oleg, could you have a look, I'm
sure I messed it up.

---
 fs/super.c                    | 31 ++----------------
 include/linux/fs.h            |  4 +--
 include/linux/percpu-rwsem.h  | 25 ++++++--------
 kernel/locking/percpu-rwsem.c | 76 ++++++++++++++++++++++++++++++++-----------
 4 files changed, 71 insertions(+), 65 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 583a0124bc39..bf9c54d05edb 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1629,30 +1629,7 @@ EXPORT_SYMBOL(__sb_start_write);
  */
 static void sb_wait_write(struct super_block *sb, int level)
 {
-	percpu_down_write(sb->s_writers.rw_sem + level-1);
-}
-
-/*
- * We are going to return to userspace and forget about these locks, the
- * ownership goes to the caller of thaw_super() which does unlock().
- */
-static void lockdep_sb_freeze_release(struct super_block *sb)
-{
-	int level;
-
-	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
-		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
-}
-
-/*
- * Tell lockdep we are holding these locks before we call ->unfreeze_fs(sb).
- */
-static void lockdep_sb_freeze_acquire(struct super_block *sb)
-{
-	int level;
-
-	for (level = 0; level < SB_FREEZE_LEVELS; ++level)
-		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
+	percpu_down_write_non_owner(sb->s_writers.rw_sem + level-1);
 }
 
 static void sb_freeze_unlock(struct super_block *sb)
@@ -1660,7 +1637,7 @@ static void sb_freeze_unlock(struct super_block *sb)
 	int level;
 
 	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
-		percpu_up_write(sb->s_writers.rw_sem + level);
+		percpu_up_write_non_owner(sb->s_writers.rw_sem + level);
 }
 
 /**
@@ -1753,7 +1730,6 @@ int freeze_super(struct super_block *sb)
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
-	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
 	return 0;
 }
@@ -1779,14 +1755,11 @@ static int thaw_super_locked(struct super_block *sb)
 		goto out;
 	}
 
-	lockdep_sb_freeze_acquire(sb);
-
 	if (sb->s_op->unfreeze_fs) {
 		error = sb->s_op->unfreeze_fs(sb);
 		if (error) {
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
-			lockdep_sb_freeze_release(sb);
 			up_write(&sb->s_umount);
 			return error;
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e7679089..3b61740b90d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1557,9 +1557,9 @@ void __sb_end_write(struct super_block *sb, int level);
 int __sb_start_write(struct super_block *sb, int level, bool wait);
 
 #define __sb_writers_acquired(sb, lev)	\
-	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
+	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], _THIS_IP_)
 #define __sb_writers_release(sb, lev)	\
-	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
+	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], _THIS_IP_)
 
 /**
  * sb_end_write - drop write access to a superblock
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 03cb4b6f842e..e0c02d0f82a6 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -5,15 +5,15 @@
 #include <linux/atomic.h>
 #include <linux/rwsem.h>
 #include <linux/percpu.h>
-#include <linux/rcuwait.h>
+#include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
 	unsigned int __percpu	*read_count;
-	struct rw_semaphore	rw_sem; /* slowpath */
-	struct rcuwait          writer; /* blocked writer */
+	struct rw_semaphore	rw_sem;
+	wait_queue_head_t	writer;
 	int			readers_block;
 };
 
@@ -23,7 +23,7 @@ static struct percpu_rw_semaphore name = {				\
 	.rss = __RCU_SYNC_INITIALIZER(name.rss, RCU_SCHED_SYNC),	\
 	.read_count = &__percpu_rwsem_rc_##name,			\
 	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
-	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	.writer = __WAIT_QUEUE_HEAD_INITIALIZER(name.writer),		\
 }
 
 extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
@@ -95,6 +95,9 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
+extern void percpu_down_write_non_owner(struct percpu_rw_semaphore *);
+extern void percpu_up_write_non_owner(struct percpu_rw_semaphore *);
+
 extern int __percpu_init_rwsem(struct percpu_rw_semaphore *,
 				const char *, struct lock_class_key *);
 
@@ -112,23 +115,15 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
 	lockdep_assert_held(&(sem)->rw_sem)
 
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
-					bool read, unsigned long ip)
+					unsigned long ip)
 {
 	lock_release(&sem->rw_sem.dep_map, 1, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
-#endif
 }
 
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
-					bool read, unsigned long ip)
+					unsigned long ip)
 {
-	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		sem->rw_sem.owner = current;
-#endif
+	lock_acquire(&sem->rw_sem.dep_map, 0, 1, 1, 1, NULL, ip);
 }
 
 #endif
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index f17dad99eec8..a51fd2a9ee90 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -1,6 +1,7 @@
 #include <linux/atomic.h>
 #include <linux/rwsem.h>
 #include <linux/percpu.h>
+#include <linux/wait.h>
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/rcupdate.h>
@@ -19,7 +20,7 @@ int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss, RCU_SCHED_SYNC);
 	__init_rwsem(&sem->rw_sem, name, rwsem_key);
-	rcuwait_init(&sem->writer);
+	init_waitqueue_head(&sem->writer);
 	sem->readers_block = 0;
 	return 0;
 }
@@ -40,6 +41,40 @@ void percpu_free_rwsem(struct percpu_rw_semaphore *sem)
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
+static void readers_block(struct percpu_rw_semaphore *sem)
+{
+	wait_event_cmd(sem->writer, !sem->readers_block,
+		       __up_read(&sem->rw_sem), __down_read(&sem->rw_sem));
+}
+
+static void block_readers(struct percpu_rw_semaphore *sem)
+{
+	wait_event_exclusive_cmd(sem->writer, !sem->readers_block,
+				 __up_write(&sem->rw_sem),
+				 __down_write(&sem->rw_sem));
+	/*
+	 * Notify new readers to block; up until now, and thus throughout the
+	 * longish rcu_sync_enter() above, new readers could still come in.
+	 */
+	WRITE_ONCE(sem->readers_block, 1);
+}
+
+static void unblock_readers(struct percpu_rw_semaphore *sem)
+{
+	/*
+	 * Signal the writer is done, no fast path yet.
+	 *
+	 * One reason that we cannot just immediately flip to readers_fast is
+	 * that new readers might fail to see the results of this writer's
+	 * critical section.
+	 *
+	 * Therefore we force it through the slow path which guarantees an
+	 * acquire and thereby guarantees the critical section's consistency.
+	 */
+	smp_store_release(&sem->readers_block, 0);
+	wake_up(&sem->writer);
+}
+
 int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 {
 	/*
@@ -85,6 +120,9 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 	 * Avoid lockdep for the down/up_read() we already have them.
 	 */
 	__down_read(&sem->rw_sem);
+
+	readers_block(sem);
+
 	this_cpu_inc(*sem->read_count);
 	__up_read(&sem->rw_sem);
 
@@ -104,7 +142,7 @@ void __percpu_up_read(struct percpu_rw_semaphore *sem)
 	__this_cpu_dec(*sem->read_count);
 
 	/* Prod writer to recheck readers_active */
-	rcuwait_wake_up(&sem->writer);
+	wake_up(&sem->writer);
 }
 EXPORT_SYMBOL_GPL(__percpu_up_read);
 
@@ -146,11 +184,7 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
 
 	down_write(&sem->rw_sem);
 
-	/*
-	 * Notify new readers to block; up until now, and thus throughout the
-	 * longish rcu_sync_enter() above, new readers could still come in.
-	 */
-	WRITE_ONCE(sem->readers_block, 1);
+	block_readers(sem);
 
 	smp_mb(); /* D matches A */
 
@@ -161,23 +195,13 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
 	 */
 
 	/* Wait for all now active readers to complete. */
-	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
+	wait_event(sem->writer, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
 void percpu_up_write(struct percpu_rw_semaphore *sem)
 {
-	/*
-	 * Signal the writer is done, no fast path yet.
-	 *
-	 * One reason that we cannot just immediately flip to readers_fast is
-	 * that new readers might fail to see the results of this writer's
-	 * critical section.
-	 *
-	 * Therefore we force it through the slow path which guarantees an
-	 * acquire and thereby guarantees the critical section's consistency.
-	 */
-	smp_store_release(&sem->readers_block, 0);
+	unblock_readers(sem);
 
 	/*
 	 * Release the write lock, this will allow readers back in the game.
@@ -191,4 +215,18 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	 */
 	rcu_sync_exit(&sem->rss);
 }
+EXPORT_SYMBOL_GPL(percpu_up_write_non_owner);
+
+void percpu_down_write_non_owner(struct percpu_rw_semaphore *sem)
+{
+	percpu_down_write(sem);
+	up_write(&sem->rw_sem);
+}
+EXPORT_SYMBOL_GPL(percpu_down_write_non_owner);
+
+void percpu_up_write_non_owner(struct percpu_rw_semaphore *sem)
+{
+	down_write(&sem->rw_sem);
+	percpu_up_write(sem);
+}
 EXPORT_SYMBOL_GPL(percpu_up_write);
