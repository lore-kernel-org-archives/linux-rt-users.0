From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 1/1] fs/locks: Use plain percpu spinlocks instead of lglock to protect file_lock
Date: Thu, 19 Feb 2015 15:26:14 +0100
Message-ID: <1424355974-30952-2-git-send-email-daniel.wagner@bmw-carit.de>
References: <1424355974-30952-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-fsdevel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:53405 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753306AbbBSO0U (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Feb 2015 09:26:20 -0500
In-Reply-To: <1424355974-30952-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The lglock version of file_lock_lock is used in combination of
blocked_lock_lock to protect file_lock's fl_link, fl_block, fl_next,
blocked_hash and the percpu file_lock_list.

The plan is to reorganize the usage of the locks and what they protect
so that the usage of the global blocked_lock_lock is reduced.

Whenever we insert a new lock we are going to grab besides the i_lock
also the corresponding percpu file_lock_lock. The global
blocked_lock_lock is only used when blocked_hash is involved.

file_lock_list exists to be being able to produce the content of
/proc/locks. For listing the all locks it seems a bit excessive to
grab all locks at once. We should be okay just grabbing the
corresponding lock when iterating over the percpu file_lock_list.

file_lock_lock protects now file_lock_list and fl_link, fl_block and
fl_next allone. That means we need to define which file_lock_lock is
used for all waiters. Luckely, fl_link_cpu can be reused for fl_block
and fl_next.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@poochiereds.net>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
 fs/locks.c | 164 +++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 112 insertions(+), 52 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 59e2f90..1ad7cff 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -163,10 +163,24 @@ int lease_break_time = 45;
 /*
  * The global file_lock_list is only used for displaying /proc/locks, so we
  * keep a list on each CPU, with each list protected by its own spinlock via
- * the file_lock_lglock. Note that alterations to the list also require that
+ * the file_lock_lock. Note that alterations to the list also require that
  * the relevant i_lock is held.
+ *
+ * In addition, it also protects the fl->fl_block list, and the fl->fl_next
+ * pointer for file_lock structures that are acting as lock requests (in
+ * contrast to those that are acting as records of acquired locks).
+ *
+ * file_lock structures acting as lock requests (waiters) use the same
+ * spinlock as the those acting as lock holder (blocker). E.g. the
+ * blocker is initially added to the file_lock_list living on CPU 0,
+ * all waiters on that blocker are serialized via CPU 0 (see fl_link_cpu).
+ *
+ * Note that when we acquire this lock in order to change the above fields,
+ * we often hold the i_lock as well. In certain cases, when reading the fields
+ * protected by this lock, we can skip acquiring it iff we already hold the
+ * i_lock.
  */
-DEFINE_STATIC_LGLOCK(file_lock_lglock);
+static DEFINE_PER_CPU(spinlock_t, file_lock_lock);
 static DEFINE_PER_CPU(struct hlist_head, file_lock_list);
 
 /*
@@ -186,19 +200,6 @@ static DEFINE_HASHTABLE(blocked_hash, BLOCKED_HASH_BITS);
 /*
  * This lock protects the blocked_hash. Generally, if you're accessing it, you
  * want to be holding this lock.
- *
- * In addition, it also protects the fl->fl_block list, and the fl->fl_next
- * pointer for file_lock structures that are acting as lock requests (in
- * contrast to those that are acting as records of acquired locks).
- *
- * Note that when we acquire this lock in order to change the above fields,
- * we often hold the i_lock as well. In certain cases, when reading the fields
- * protected by this lock, we can skip acquiring it iff we already hold the
- * i_lock.
- *
- * In particular, adding an entry to the fl_block list requires that you hold
- * both the i_lock and the blocked_lock_lock (acquired in that order). Deleting
- * an entry from the list however only requires the file_lock_lock.
  */
 static DEFINE_SPINLOCK(blocked_lock_lock);
 
@@ -516,10 +517,10 @@ static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 /* Must be called with the i_lock held! */
 static void locks_insert_global_locks(struct file_lock *fl)
 {
-	lg_local_lock(&file_lock_lglock);
+	spin_lock(this_cpu_ptr(&file_lock_lock));
 	fl->fl_link_cpu = smp_processor_id();
-	hlist_add_head(&fl->fl_link, this_cpu_ptr(&file_lock_list));
-	lg_local_unlock(&file_lock_lglock);
+	hlist_add_head_rcu(&fl->fl_link, this_cpu_ptr(&file_lock_list));
+	spin_unlock(this_cpu_ptr(&file_lock_lock));
 }
 
 /* Must be called with the i_lock held! */
@@ -532,9 +533,9 @@ static void locks_delete_global_locks(struct file_lock *fl)
 	 */
 	if (hlist_unhashed(&fl->fl_link))
 		return;
-	lg_local_lock_cpu(&file_lock_lglock, fl->fl_link_cpu);
-	hlist_del_init(&fl->fl_link);
-	lg_local_unlock_cpu(&file_lock_lglock, fl->fl_link_cpu);
+	spin_lock(per_cpu_ptr(&file_lock_lock, fl->fl_link_cpu));
+	hlist_del_init_rcu(&fl->fl_link);
+	spin_unlock(per_cpu_ptr(&file_lock_lock, fl->fl_link_cpu));
 }
 
 static unsigned long
@@ -557,11 +558,15 @@ static void locks_delete_global_blocked(struct file_lock *waiter)
 
 /* Remove waiter from blocker's block list.
  * When blocker ends up pointing to itself then the list is empty.
- *
- * Must be called with blocked_lock_lock held.
  */
 static void __locks_delete_block(struct file_lock *waiter)
 {
+	list_del_init(&waiter->fl_block);
+	waiter->fl_next = NULL;
+}
+
+static void __locks_delete_posix_block(struct file_lock *waiter)
+{
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->fl_block);
 	waiter->fl_next = NULL;
@@ -569,9 +574,18 @@ static void __locks_delete_block(struct file_lock *waiter)
 
 static void locks_delete_block(struct file_lock *waiter)
 {
-	spin_lock(&blocked_lock_lock);
+	spin_lock(per_cpu_ptr(&file_lock_lock, waiter->fl_link_cpu));
 	__locks_delete_block(waiter);
+	spin_unlock(per_cpu_ptr(&file_lock_lock, waiter->fl_link_cpu));
+}
+
+static void locks_delete_posix_block(struct file_lock *waiter)
+{
+	spin_lock(per_cpu_ptr(&file_lock_lock, waiter->fl_link_cpu));
+	spin_lock(&blocked_lock_lock);
+	locks_delete_block(waiter);
 	spin_unlock(&blocked_lock_lock);
+	spin_unlock(per_cpu_ptr(&file_lock_lock, waiter->fl_link_cpu));
 }
 
 /* Insert waiter into blocker's block list.
@@ -579,18 +593,22 @@ static void locks_delete_block(struct file_lock *waiter)
  * the order they blocked. The documentation doesn't require this but
  * it seems like the reasonable thing to do.
  *
- * Must be called with both the i_lock and blocked_lock_lock held. The fl_block
- * list itself is protected by the blocked_lock_lock, but by ensuring that the
- * i_lock is also held on insertions we can avoid taking the blocked_lock_lock
- * in some cases when we see that the fl_block list is empty.
+ * Must be called with both the i_lock and file_lock_lock held.
  */
 static void __locks_insert_block(struct file_lock *blocker,
 					struct file_lock *waiter)
 {
 	BUG_ON(!list_empty(&waiter->fl_block));
+	waiter->fl_link_cpu = blocker->fl_link_cpu;
 	waiter->fl_next = blocker;
 	list_add_tail(&waiter->fl_block, &blocker->fl_block);
-	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
+}
+
+static void __locks_insert_posix_block(struct file_lock *blocker,
+					struct file_lock *waiter)
+{
+	__locks_insert_block(blocker, waiter);
+	if (!IS_OFDLCK(blocker))
 		locks_insert_global_blocked(waiter);
 }
 
@@ -598,9 +616,9 @@ static void __locks_insert_block(struct file_lock *blocker,
 static void locks_insert_block(struct file_lock *blocker,
 					struct file_lock *waiter)
 {
-	spin_lock(&blocked_lock_lock);
+	spin_lock(per_cpu_ptr(&file_lock_lock, blocker->fl_link_cpu));
 	__locks_insert_block(blocker, waiter);
-	spin_unlock(&blocked_lock_lock);
+	spin_unlock(per_cpu_ptr(&file_lock_lock, blocker->fl_link_cpu));
 }
 
 /*
@@ -615,24 +633,29 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 	 * blocked requests are only added to the list under the i_lock, and
 	 * the i_lock is always held here. Note that removal from the fl_block
 	 * list does not require the i_lock, so we must recheck list_empty()
-	 * after acquiring the blocked_lock_lock.
+	 * after acquiring the file_lock_lock.
 	 */
 	if (list_empty(&blocker->fl_block))
 		return;
 
-	spin_lock(&blocked_lock_lock);
+	spin_lock(per_cpu_ptr(&file_lock_lock, blocker->fl_link_cpu));
 	while (!list_empty(&blocker->fl_block)) {
 		struct file_lock *waiter;
 
 		waiter = list_first_entry(&blocker->fl_block,
 				struct file_lock, fl_block);
-		__locks_delete_block(waiter);
+		if (IS_POSIX(blocker)) {
+			spin_lock(&blocked_lock_lock);
+			__locks_delete_posix_block(waiter);
+			spin_unlock(&blocked_lock_lock);
+		} else
+			__locks_delete_block(waiter);
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
 	}
-	spin_unlock(&blocked_lock_lock);
+	spin_unlock(per_cpu_ptr(&file_lock_lock, blocker->fl_link_cpu));
 }
 
 /* Insert file lock fl into an inode's lock list at the position indicated
@@ -690,9 +713,11 @@ static void locks_delete_lock(struct file_lock **thisfl_p,
 	struct file_lock *fl = *thisfl_p;
 
 	locks_unlink_lock(thisfl_p);
-	if (dispose)
+	if (dispose) {
+		spin_lock(per_cpu_ptr(&file_lock_lock, fl->fl_link_cpu));
 		list_add(&fl->fl_block, dispose);
-	else
+		spin_unlock(per_cpu_ptr(&file_lock_lock, fl->fl_link_cpu));
+	} else
 		locks_free_lock(fl);
 }
 
@@ -971,12 +996,14 @@ static int __posix_lock_file(struct inode *inode, struct file_lock *request, str
 			 * locks list must be done while holding the same lock!
 			 */
 			error = -EDEADLK;
+			spin_lock(per_cpu_ptr(&file_lock_lock, fl->fl_link_cpu));
 			spin_lock(&blocked_lock_lock);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
-				__locks_insert_block(fl, request);
+				__locks_insert_posix_block(fl, request);
 			}
 			spin_unlock(&blocked_lock_lock);
+			spin_unlock(per_cpu_ptr(&file_lock_lock, fl->fl_link_cpu));
 			goto out;
   		}
   	}
@@ -1183,7 +1210,7 @@ int posix_lock_file_wait(struct file *filp, struct file_lock *fl)
 		if (!error)
 			continue;
 
-		locks_delete_block(fl);
+		locks_delete_posix_block(fl);
 		break;
 	}
 	return error;
@@ -1273,7 +1300,7 @@ int locks_mandatory_area(int read_write, struct inode *inode,
 				continue;
 		}
 
-		locks_delete_block(&fl);
+		locks_delete_posix_block(&fl);
 		break;
 	}
 
@@ -2432,12 +2459,14 @@ posix_unblock_lock(struct file_lock *waiter)
 {
 	int status = 0;
 
+	spin_lock(per_cpu_ptr(&file_lock_lock, waiter->fl_link_cpu));
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_next)
-		__locks_delete_block(waiter);
+		__locks_delete_posix_block(waiter);
 	else
 		status = -ENOENT;
 	spin_unlock(&blocked_lock_lock);
+	spin_unlock(per_cpu_ptr(&file_lock_lock, waiter->fl_link_cpu));
 	return status;
 }
 EXPORT_SYMBOL(posix_unblock_lock);
@@ -2563,30 +2592,61 @@ static int locks_show(struct seq_file *f, void *v)
 	return 0;
 }
 
+
 static void *locks_start(struct seq_file *f, loff_t *pos)
-	__acquires(&blocked_lock_lock)
 {
 	struct locks_iterator *iter = f->private;
+	struct hlist_node *node;
+	loff_t p = *pos;
 
 	iter->li_pos = *pos + 1;
-	lg_global_lock(&file_lock_lglock);
-	spin_lock(&blocked_lock_lock);
-	return seq_hlist_start_percpu(&file_lock_list, &iter->li_cpu, *pos);
+
+	for_each_possible_cpu(iter->li_cpu) {
+		spin_lock(per_cpu_ptr(&file_lock_lock, iter->li_cpu));
+		hlist_for_each(node, per_cpu_ptr(&file_lock_list, iter->li_cpu)) {
+			if (p-- == 0)
+				return node;
+		}
+		spin_unlock(per_cpu_ptr(&file_lock_lock, iter->li_cpu));
+	}
+	return NULL;
 }
 
 static void *locks_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	struct locks_iterator *iter = f->private;
+	struct hlist_node *node = v;
 
 	++iter->li_pos;
-	return seq_hlist_next_percpu(v, &file_lock_list, &iter->li_cpu, pos);
+	++*pos;
+
+	if (node->next)
+		return node->next;
+
+	spin_unlock(per_cpu_ptr(&file_lock_lock, iter->li_cpu));
+
+	for (iter->li_cpu = cpumask_next(iter->li_cpu, cpu_possible_mask);
+	     iter->li_cpu < nr_cpu_ids;
+	     iter->li_cpu = cpumask_next(iter->li_cpu, cpu_possible_mask)) {
+		struct hlist_head *bucket;
+
+		spin_lock(per_cpu_ptr(&file_lock_lock, iter->li_cpu));
+		bucket = per_cpu_ptr(&file_lock_list, iter->li_cpu);
+
+		if (!hlist_empty(bucket))
+			return bucket->first;
+
+		spin_unlock(per_cpu_ptr(&file_lock_lock, iter->li_cpu));
+	}
+	return NULL;
 }
 
 static void locks_stop(struct seq_file *f, void *v)
-	__releases(&blocked_lock_lock)
 {
-	spin_unlock(&blocked_lock_lock);
-	lg_global_unlock(&file_lock_lglock);
+	struct locks_iterator *iter = f->private;
+
+	if (v)
+		spin_unlock(per_cpu_ptr(&file_lock_lock, iter->li_cpu));
 }
 
 static const struct seq_operations locks_seq_operations = {
@@ -2624,10 +2684,10 @@ static int __init filelock_init(void)
 	filelock_cache = kmem_cache_create("file_lock_cache",
 			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
 
-	lg_lock_init(&file_lock_lglock, "file_lock_lglock");
