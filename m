Return-Path: <SRS0=ow8w=TD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA709C004C9
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8662F2087F
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 May 2019 14:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UkyGV39y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfECOvK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 May 2019 10:51:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38252 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfECOvK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 May 2019 10:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YqiCBACiZB9yJPeNVw7HD+X4o6GiFFjdeNy9cZJSLEs=; b=UkyGV39yc1oyUh76L0dPN4KLK
        sd/MY+chrWqZWjkIFre5yIVgtcp+dVaxYjLJz87apWiml8ZUZjZgfjZ5ksbA8l7z92zDcBQI9x9T7
        2sc8mMHNSQstEcsiQwP3ryEbnfS3HR/4iV0+AG++8IZXZCRWAg6el540NVdoaeFMbga2kD1KiiK28
        mXOWef1CyUZuVBokebEuaQzN9RguvH6KXI3sCXs5jlwriFzOaG5V5KODjDXo7+2gsXcm3WB5lwtDS
        fqaCaXg9bJHkjaLSc0PCgTOy2F+XnqAN+Ehvl8JvpS3+9s1uNyynYdRPNlMLAzcr9aYR1n2LuIBRL
        aYNhPl3zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMZWg-0008LX-B3; Fri, 03 May 2019 14:51:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BD99214242EE; Fri,  3 May 2019 16:50:59 +0200 (CEST)
Date:   Fri, 3 May 2019 16:50:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, jack@suse.com,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190503145059.GC2606@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <20190502100932.GA7323@redhat.com>
 <20190502114258.GB7323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502114258.GB7323@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 02, 2019 at 01:42:59PM +0200, Oleg Nesterov wrote:
> On 05/02, Oleg Nesterov wrote:
> >
> > But this all is cosmetic, it seems that we can remove ->rw_sem altogether
> > but I am not sure...
> 
> I mean, afaics percpu_down_read() can just do
> 
> 	wait_event(readers_block == 0);
> 
> in the slow path, while percpu_down_write()
> 
> 	wait_even_exclusive(xchg(readers_block, 1) == 0);

Cute.. yes that might work.

Although at that point I think we might want to switch readers_block to
atomic_t or something.

> we do not really need ->rw_sem if we rely on wait_queue_head.
> 
> 
> But in fact, either way it seems that we going to implement another simple
> "non owner" read/write lock, so perhaps we should do this explicitly?

I'd rather not; people might start using it, and then -RT ends up with
another problem.

I mean, percpu-rwsem isn't used in situations where PI really matters,
but rwsem is.

So how about something like so then?

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
@@ -1660,7 +1637,7 @@ static void sb_freeze_unlock(struct supe
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
@@ -1779,14 +1755,11 @@ static int thaw_super_locked(struct supe
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
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1557,9 +1557,9 @@ void __sb_end_write(struct super_block *
 int __sb_start_write(struct super_block *sb, int level, bool wait);
 
 #define __sb_writers_acquired(sb, lev)	\
-	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
+	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], _THIS_IP_)
 #define __sb_writers_release(sb, lev)	\
-	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
+	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], _THIS_IP_)
 
 /**
  * sb_end_write - drop write access to a superblock
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -5,25 +5,34 @@
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
-	int			readers_block;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#else
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define DEFINE_STATIC_PERCPU_RWSEM(name)				\
 static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
 static struct percpu_rw_semaphore name = {				\
 	.rss = __RCU_SYNC_INITIALIZER(name.rss, RCU_SCHED_SYNC),	\
 	.read_count = &__percpu_rwsem_rc_##name,			\
-	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
-	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	.waiters = __WAIT_QUEUE_HEAD_INITIALIZER(name.waiters),		\
+	.block = ATOMIC_INIT(0),					\
+	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
 }
 
 extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
@@ -33,7 +42,7 @@ static inline void percpu_down_read(stru
 {
 	might_sleep();
 
-	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
 	preempt_disable();
 	/*
@@ -72,7 +81,7 @@ static inline int percpu_down_read_trylo
 	 */
 
 	if (ret)
-		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1, _RET_IP_);
+		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
 
 	return ret;
 }
@@ -89,12 +98,15 @@ static inline void percpu_up_read(struct
 		__percpu_up_read(sem); /* Unconditional memory barrier */
 	preempt_enable();
 
-	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 }
 
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
+extern void percpu_down_write_non_owner(struct percpu_rw_semaphore *);
+extern void percpu_up_write_non_owner(struct percpu_rw_semaphore *);
+
 extern int __percpu_init_rwsem(struct percpu_rw_semaphore *,
 				const char *, struct lock_class_key *);
 
@@ -112,23 +124,15 @@ extern void percpu_free_rwsem(struct per
 	lockdep_assert_held(&(sem)->rw_sem)
 
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
-					bool read, unsigned long ip)
+					unsigned long ip)
 {
-	lock_release(&sem->rw_sem.dep_map, 1, ip);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	if (!read)
-		sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
-#endif
+	lock_release(&sem->dep_map, 1, ip);
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
+	lock_acquire(&sem->dep_map, 0, 1, 1, 1, NULL, ip);
 }
 
 #endif
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -395,6 +395,9 @@ do {										\
 	__wait_event_exclusive_cmd(wq_head, condition, cmd1, cmd2);		\
 } while (0)
 
+#define wait_event_exclusive(wq_head, condition)				\
+	wait_event_exclusive_cmd(wq_head, condition, ,)
+
 #define __wait_event_cmd(wq_head, condition, cmd1, cmd2)			\
 	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			    cmd1; schedule(); cmd2)
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
@@ -16,11 +17,13 @@ int __percpu_init_rwsem(struct percpu_rw
 	if (unlikely(!sem->read_count))
 		return -ENOMEM;
 
-	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss, RCU_SCHED_SYNC);
-	__init_rwsem(&sem->rw_sem, name, rwsem_key);
-	rcuwait_init(&sem->writer);
-	sem->readers_block = 0;
+	init_waitqueue_head(&sem->waiters);
+	atomic_set(&sem->block, 0);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__percpu_init_rwsem);
@@ -63,7 +66,7 @@ int __percpu_down_read(struct percpu_rw_
 	 * If !readers_block the critical section starts here, matched by the
 	 * release in percpu_up_write().
 	 */
-	if (likely(!smp_load_acquire(&sem->readers_block)))
+	if (likely(!atomic_read_acquire(&sem->block)))
 		return 1;
 
 	/*
@@ -80,14 +83,8 @@ int __percpu_down_read(struct percpu_rw_
 	 * and reschedule on the preempt_enable() in percpu_down_read().
 	 */
 	preempt_enable_no_resched();
-
-	/*
-	 * Avoid lockdep for the down/up_read() we already have them.
-	 */
-	__down_read(&sem->rw_sem);
+	wait_event(sem->waiters, !atomic_read(&sem->block));
 	this_cpu_inc(*sem->read_count);
-	__up_read(&sem->rw_sem);
-
 	preempt_disable();
 	return 1;
 }
@@ -104,7 +101,7 @@ void __percpu_up_read(struct percpu_rw_s
 	__this_cpu_dec(*sem->read_count);
 
 	/* Prod writer to recheck readers_active */
-	rcuwait_wake_up(&sem->writer);
+	wake_up(&sem->waiters);
 }
 EXPORT_SYMBOL_GPL(__percpu_up_read);
 
@@ -139,18 +136,22 @@ static bool readers_active_check(struct
 	return true;
 }
 
+static inline bool acquire_block(struct percpu_rw_semaphore *sem)
+{
+	if (atomic_read(&sem->block))
+		return false;
+
+	return atomic_xchg(&sem->block, 1) == 0;
+}
+
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
 
-	down_write(&sem->rw_sem);
-
-	/*
-	 * Notify new readers to block; up until now, and thus throughout the
-	 * longish rcu_sync_enter() above, new readers could still come in.
-	 */
-	WRITE_ONCE(sem->readers_block, 1);
+	wait_event_exclusive(sem->waiters, acquire_block(sem));
 
 	smp_mb(); /* D matches A */
 
@@ -161,7 +162,7 @@ void percpu_down_write(struct percpu_rw_
 	 */
 
 	/* Wait for all now active readers to complete. */
-	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
+	wait_event(sem->waiters, readers_active_check(sem));
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
@@ -177,12 +178,8 @@ void percpu_up_write(struct percpu_rw_se
 	 * Therefore we force it through the slow path which guarantees an
 	 * acquire and thereby guarantees the critical section's consistency.
 	 */
-	smp_store_release(&sem->readers_block, 0);
-
-	/*
-	 * Release the write lock, this will allow readers back in the game.
-	 */
-	up_write(&sem->rw_sem);
+	atomic_set_release(&sem->block, 0);
+	wake_up(&sem->waiters);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
@@ -190,5 +187,21 @@ void percpu_up_write(struct percpu_rw_se
 	 * exclusive write lock because its counting.
 	 */
 	rcu_sync_exit(&sem->rss);
+
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(percpu_up_write);
+
+void percpu_down_write_non_owner(struct percpu_rw_semaphore *sem)
+{
+	percpu_down_write(sem);
+	rwsem_release(&sem->dep_map, 1, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(percpu_down_write_non_owner);
+
+void percpu_up_write_non_owner(struct percpu_rw_semaphore *sem)
+{
+	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+	percpu_up_write(sem);
+}
+EXPORT_SYMBOL_GPL(percpu_up_write_non_owner);
