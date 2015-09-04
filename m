From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 2/3] locking: Convert trylock spinners over to spin_try_or_boost_lock()
Date: Thu, 03 Sep 2015 21:19:02 -0400
Message-ID: <20150904012118.361644516@goodmis.org>
References: <20150904011900.730816481@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52471 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbbIDBVW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Sep 2015 21:21:22 -0400
Content-Disposition: inline; filename=0002-locking-Convert-trylock-spinners-over-to-spin_try_or.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

When trying to take locks in reverse order, it is possible that on
PREEMPT_RT that the running task could have preempted the owner and never
let it run, creating a live lock. This is because spinlocks in PREEMPT_RT
can be preempted.

Currently, this is solved by calling cpu_chill(), which on PREEMPT_RT is
converted into a msleep(1), and we just hopen that the owner will have time
to release the lock, and nobody else will take in when the task wakes up.

By converting these to spin_try_or_boost_lock() which will boost the owners,
the cpu_chill() can be converted into a sched_yield() which will allow the
owners to make immediate progress even if it was preempted by a high
priority task.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 block/blk-ioc.c     | 4 ++--
 fs/autofs4/expire.c | 2 +-
 fs/dcache.c         | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 28f467e636cc..de5eccdc8abb 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -105,7 +105,7 @@ static void ioc_release_fn(struct work_struct *work)
 						struct io_cq, ioc_node);
 		struct request_queue *q = icq->q;
 
-		if (spin_trylock(q->queue_lock)) {
+		if (spin_try_or_boost_lock(q->queue_lock)) {
 			ioc_destroy_icq(icq);
 			spin_unlock(q->queue_lock);
 		} else {
@@ -183,7 +183,7 @@ retry:
 	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
 		if (icq->flags & ICQ_EXITED)
 			continue;
-		if (spin_trylock(icq->q->queue_lock)) {
+		if (spin_try_or_boost_lock(icq->q->queue_lock)) {
 			ioc_exit_icq(icq);
 			spin_unlock(icq->q->queue_lock);
 		} else {
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index d487fa27add5..025bfc71dc6c 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -148,7 +148,7 @@ again:
 			}
 
 			parent = p->d_parent;
-			if (!spin_trylock(&parent->d_lock)) {
+			if (!spin_try_or_boost_lock(&parent->d_lock)) {
 				spin_unlock(&p->d_lock);
 				cpu_chill();
 				goto relock;
diff --git a/fs/dcache.c b/fs/dcache.c
index c1dad92434d5..6b5643ecdf37 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -573,12 +573,12 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	struct inode *inode = dentry->d_inode;
 	struct dentry *parent = NULL;
 
-	if (inode && unlikely(!spin_trylock(&inode->i_lock)))
+	if (inode && unlikely(!spin_try_or_boost_lock(&inode->i_lock)))
 		goto failed;
 
 	if (!IS_ROOT(dentry)) {
 		parent = dentry->d_parent;
-		if (unlikely(!spin_trylock(&parent->d_lock))) {
+		if (unlikely(!spin_try_or_boost_lock(&parent->d_lock))) {
 			if (inode)
 				spin_unlock(&inode->i_lock);
 			goto failed;
@@ -2394,7 +2394,7 @@ again:
 	inode = dentry->d_inode;
 	isdir = S_ISDIR(inode->i_mode);
 	if (dentry->d_lockref.count == 1) {
-		if (!spin_trylock(&inode->i_lock)) {
+		if (!spin_try_or_boost_lock(&inode->i_lock)) {
 			spin_unlock(&dentry->d_lock);
 			cpu_chill();
 			goto again;
-- 
2.4.6


