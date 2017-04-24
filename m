From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: [PATCH 1/2] raid5: Use raw_spinlock for stripe management.
Date: Mon, 24 Apr 2017 16:33:35 +0300
Message-ID: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
Cc: Alexander GQ Gerasiov <gq@redlab-i.ru>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:50506 "EHLO
        mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934189AbdDXNkl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Apr 2017 09:40:41 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Alexander GQ Gerasiov <gq@redlab-i.ru>

This commit fixes the following warning:

[ ] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:993
[ ] in_atomic(): 0, irqs_disabled(): 1, pid: 58, name: kworker/u12:1
[ ] CPU: 5 PID: 58 Comm: kworker/u12:1 Tainted: G        W       4.9.20-rt16-stand6-686 #1
[ ] Hardware name: Supermicro SYS-5027R-WRF/X9SRW-F, BIOS 3.2a 10/28/2015
[ ] Workqueue: writeback wb_workfn (flush-253:0)
[ ]  edf21a34 c12cdc6f c1078f0a edf08c40 edf21a64 c10787c1 c1668778 00000000
[ ]  00000001 0000003a edf09144 00000000 80000000 ec694b18 ec775748 ec694ad0
[ ]  edf21a70 c1584587 ec775790 edf21ac4 f893e8a3 00000000 c1078e52 00000000
[ ] Call Trace:
[ ]  [<c12cdc6f>] dump_stack+0x47/0x68
[ ]  [<c1078f0a>] ? migrate_enable+0x4a/0xf0
[ ]  [<c10787c1>] ___might_sleep+0x101/0x180
[ ]  [<c1584587>] rt_spin_lock+0x17/0x40
[ ]  [<f893e8a3>] add_stripe_bio+0x4e3/0x6c0 [raid456]
[ ]  [<c1078e52>] ? preempt_count_add+0x42/0xb0
[ ]  [<f89408f7>] raid5_make_request+0x737/0xdd0 [raid456]

Signed-off-by: Alexander GQ Gerasiov <gq@redlab-i.ru>
---
 drivers/md/raid5.c | 82 +++++++++++++++++++++++++++---------------------------
 drivers/md/raid5.h |  4 +--
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index fa2c4de32a64..e69525b5db7d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -734,18 +734,18 @@ static void lock_two_stripes(struct stripe_head *sh1, struct stripe_head *sh2)
 {
 	local_irq_disable();
 	if (sh1 > sh2) {
-		spin_lock(&sh2->stripe_lock);
-		spin_lock_nested(&sh1->stripe_lock, 1);
+		raw_spin_lock(&sh2->stripe_lock);
+		raw_spin_lock_nested(&sh1->stripe_lock, 1);
 	} else {
-		spin_lock(&sh1->stripe_lock);
-		spin_lock_nested(&sh2->stripe_lock, 1);
+		raw_spin_lock(&sh1->stripe_lock);
+		raw_spin_lock_nested(&sh2->stripe_lock, 1);
 	}
 }
 
 static void unlock_two_stripes(struct stripe_head *sh1, struct stripe_head *sh2)
 {
-	spin_unlock(&sh1->stripe_lock);
-	spin_unlock(&sh2->stripe_lock);
+	raw_spin_unlock(&sh1->stripe_lock);
+	raw_spin_unlock(&sh2->stripe_lock);
 	local_irq_enable();
 }
 
@@ -823,10 +823,10 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 		goto unlock_out;
 
 	if (head->batch_head) {
-		spin_lock(&head->batch_head->batch_lock);
+		raw_spin_lock(&head->batch_head->batch_lock);
 		/* This batch list is already running */
 		if (!stripe_can_batch(head)) {
-			spin_unlock(&head->batch_head->batch_lock);
+			raw_spin_unlock(&head->batch_head->batch_lock);
 			goto unlock_out;
 		}
 
@@ -835,15 +835,15 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 		 * can still add the stripe to batch list
 		 */
 		list_add(&sh->batch_list, &head->batch_list);
-		spin_unlock(&head->batch_head->batch_lock);
+		raw_spin_unlock(&head->batch_head->batch_lock);
 
 		sh->batch_head = head->batch_head;
 	} else {
 		head->batch_head = head;
 		sh->batch_head = head->batch_head;
-		spin_lock(&head->batch_lock);
+		raw_spin_lock(&head->batch_lock);
 		list_add_tail(&sh->batch_list, &head->batch_list);
-		spin_unlock(&head->batch_lock);
+		raw_spin_unlock(&head->batch_lock);
 	}
 
 	if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
@@ -1230,10 +1230,10 @@ static void ops_run_biofill(struct stripe_head *sh)
 		struct r5dev *dev = &sh->dev[i];
 		if (test_bit(R5_Wantfill, &dev->flags)) {
 			struct bio *rbi;
-			spin_lock_irq(&sh->stripe_lock);
+			raw_spin_lock_irq(&sh->stripe_lock);
 			dev->read = rbi = dev->toread;
 			dev->toread = NULL;
-			spin_unlock_irq(&sh->stripe_lock);
+			raw_spin_unlock_irq(&sh->stripe_lock);
 			while (rbi && rbi->bi_iter.bi_sector <
 				dev->sector + STRIPE_SECTORS) {
 				tx = async_copy_data(0, rbi, &dev->page,
@@ -1618,13 +1618,13 @@ ops_run_biodrain(struct stripe_head *sh, struct dma_async_tx_descriptor *tx)
 
 again:
 			dev = &sh->dev[i];
-			spin_lock_irq(&sh->stripe_lock);
+			raw_spin_lock_irq(&sh->stripe_lock);
 			chosen = dev->towrite;
 			dev->towrite = NULL;
 			sh->overwrite_disks = 0;
 			BUG_ON(dev->written);
 			wbi = dev->written = chosen;
-			spin_unlock_irq(&sh->stripe_lock);
+			raw_spin_unlock_irq(&sh->stripe_lock);
 			WARN_ON(dev->page != dev->orig_page);
 
 			while (wbi && wbi->bi_iter.bi_sector <
@@ -1998,8 +1998,8 @@ static struct stripe_head *alloc_stripe(struct kmem_cache *sc, gfp_t gfp,
 
 	sh = kmem_cache_zalloc(sc, gfp);
 	if (sh) {
-		spin_lock_init(&sh->stripe_lock);
-		spin_lock_init(&sh->batch_lock);
+		raw_spin_lock_init(&sh->stripe_lock);
+		raw_spin_lock_init(&sh->batch_lock);
 		INIT_LIST_HEAD(&sh->batch_list);
 		INIT_LIST_HEAD(&sh->lru);
 		atomic_set(&sh->count, 1);
@@ -2984,7 +2984,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 	 * stripe. If a stripe is owned by one stripe, the stripe lock will
 	 * protect it.
 	 */
-	spin_lock_irq(&sh->stripe_lock);
+	raw_spin_lock_irq(&sh->stripe_lock);
 	/* Don't allow new IO added to stripes in batch list */
 	if (sh->batch_head)
 		goto overlap;
@@ -3044,17 +3044,17 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 		 * any more.
 		 */
 		set_bit(STRIPE_BITMAP_PENDING, &sh->state);
-		spin_unlock_irq(&sh->stripe_lock);
+		raw_spin_unlock_irq(&sh->stripe_lock);
 		bitmap_startwrite(conf->mddev->bitmap, sh->sector,
 				  STRIPE_SECTORS, 0);
-		spin_lock_irq(&sh->stripe_lock);
+		raw_spin_lock_irq(&sh->stripe_lock);
 		clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		if (!sh->batch_head) {
 			sh->bm_seq = conf->seq_flush+1;
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
 		}
 	}
-	spin_unlock_irq(&sh->stripe_lock);
+	raw_spin_unlock_irq(&sh->stripe_lock);
 
 	if (stripe_can_batch(sh))
 		stripe_add_to_batch_list(conf, sh);
@@ -3062,7 +3062,7 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 
  overlap:
 	set_bit(R5_Overlap, &sh->dev[dd_idx].flags);
-	spin_unlock_irq(&sh->stripe_lock);
+	raw_spin_unlock_irq(&sh->stripe_lock);
 	return 0;
 }
 
@@ -3114,12 +3114,12 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 		}
-		spin_lock_irq(&sh->stripe_lock);
+		raw_spin_lock_irq(&sh->stripe_lock);
 		/* fail all writes first */
 		bi = sh->dev[i].towrite;
 		sh->dev[i].towrite = NULL;
 		sh->overwrite_disks = 0;
-		spin_unlock_irq(&sh->stripe_lock);
+		raw_spin_unlock_irq(&sh->stripe_lock);
 		if (bi)
 			bitmap_end = 1;
 
@@ -3171,10 +3171,10 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		    s->failed > conf->max_degraded &&
 		    (!test_bit(R5_Insync, &sh->dev[i].flags) ||
 		      test_bit(R5_ReadError, &sh->dev[i].flags))) {
-			spin_lock_irq(&sh->stripe_lock);
+			raw_spin_lock_irq(&sh->stripe_lock);
 			bi = sh->dev[i].toread;
 			sh->dev[i].toread = NULL;
-			spin_unlock_irq(&sh->stripe_lock);
+			raw_spin_unlock_irq(&sh->stripe_lock);
 			if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 				wake_up(&conf->wait_for_overlap);
 			if (bi)
@@ -4219,9 +4219,9 @@ static int clear_batch_ready(struct stripe_head *sh)
 	struct stripe_head *tmp;
 	if (!test_and_clear_bit(STRIPE_BATCH_READY, &sh->state))
 		return (sh->batch_head && sh->batch_head != sh);
-	spin_lock(&sh->stripe_lock);
+	raw_spin_lock(&sh->stripe_lock);
 	if (!sh->batch_head) {
-		spin_unlock(&sh->stripe_lock);
+		raw_spin_unlock(&sh->stripe_lock);
 		return 0;
 	}
 
@@ -4230,14 +4230,14 @@ static int clear_batch_ready(struct stripe_head *sh)
 	 * BATCH_READY, skips it
 	 */
 	if (sh->batch_head != sh) {
-		spin_unlock(&sh->stripe_lock);
+		raw_spin_unlock(&sh->stripe_lock);
 		return 1;
 	}
-	spin_lock(&sh->batch_lock);
+	raw_spin_lock(&sh->batch_lock);
 	list_for_each_entry(tmp, &sh->batch_list, batch_list)
 		clear_bit(STRIPE_BATCH_READY, &tmp->state);
-	spin_unlock(&sh->batch_lock);
-	spin_unlock(&sh->stripe_lock);
+	raw_spin_unlock(&sh->batch_lock);
+	raw_spin_unlock(&sh->stripe_lock);
 
 	/*
 	 * BATCH_READY is cleared, no new stripes can be added.
@@ -4288,17 +4288,17 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
 			sh->dev[i].flags = head_sh->dev[i].flags &
 				(~((1 << R5_WriteError) | (1 << R5_Overlap)));
 		}
-		spin_lock_irq(&sh->stripe_lock);
+		raw_spin_lock_irq(&sh->stripe_lock);
 		sh->batch_head = NULL;
-		spin_unlock_irq(&sh->stripe_lock);
+		raw_spin_unlock_irq(&sh->stripe_lock);
 		if (handle_flags == 0 ||
 		    sh->state & handle_flags)
 			set_bit(STRIPE_HANDLE, &sh->state);
 		raid5_release_stripe(sh);
 	}
-	spin_lock_irq(&head_sh->stripe_lock);
+	raw_spin_lock_irq(&head_sh->stripe_lock);
 	head_sh->batch_head = NULL;
-	spin_unlock_irq(&head_sh->stripe_lock);
+	raw_spin_unlock_irq(&head_sh->stripe_lock);
 	for (i = 0; i < head_sh->disks; i++)
 		if (test_and_clear_bit(R5_Overlap, &head_sh->dev[i].flags))
 			do_wakeup = 1;
@@ -4335,7 +4335,7 @@ static void handle_stripe(struct stripe_head *sh)
 		break_stripe_batch_list(sh, 0);
 
 	if (test_bit(STRIPE_SYNC_REQUESTED, &sh->state) && !sh->batch_head) {
-		spin_lock(&sh->stripe_lock);
+		raw_spin_lock(&sh->stripe_lock);
 		/* Cannot process 'sync' concurrently with 'discard' */
 		if (!test_bit(STRIPE_DISCARD, &sh->state) &&
 		    test_and_clear_bit(STRIPE_SYNC_REQUESTED, &sh->state)) {
@@ -4343,7 +4343,7 @@ static void handle_stripe(struct stripe_head *sh)
 			clear_bit(STRIPE_INSYNC, &sh->state);
 			clear_bit(STRIPE_REPLACED, &sh->state);
 		}
-		spin_unlock(&sh->stripe_lock);
+		raw_spin_unlock(&sh->stripe_lock);
 	}
 	clear_bit(STRIPE_DELAYED, &sh->state);
 
@@ -5113,13 +5113,13 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 			goto again;
 		}
 		clear_bit(R5_Overlap, &sh->dev[sh->pd_idx].flags);
-		spin_lock_irq(&sh->stripe_lock);
+		raw_spin_lock_irq(&sh->stripe_lock);
 		for (d = 0; d < conf->raid_disks; d++) {
 			if (d == sh->pd_idx || d == sh->qd_idx)
 				continue;
 			if (sh->dev[d].towrite || sh->dev[d].toread) {
 				set_bit(R5_Overlap, &sh->dev[d].flags);
-				spin_unlock_irq(&sh->stripe_lock);
+				raw_spin_unlock_irq(&sh->stripe_lock);
 				raid5_release_stripe(sh);
 				schedule();
 				goto again;
@@ -5136,7 +5136,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 			raid5_inc_bi_active_stripes(bi);
 			sh->overwrite_disks++;
 		}
-		spin_unlock_irq(&sh->stripe_lock);
+		raw_spin_unlock_irq(&sh->stripe_lock);
 		if (conf->mddev->bitmap) {
 			for (d = 0;
 			     d < conf->raid_disks - conf->max_degraded;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 0739604990b7..984b156fcf01 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -216,12 +216,12 @@ struct stripe_head {
 						  */
 	enum check_states	check_state;
 	enum reconstruct_states reconstruct_state;
-	spinlock_t		stripe_lock;
+	raw_spinlock_t		stripe_lock;
 	int			cpu;
 	struct r5worker_group	*group;
 
 	struct stripe_head	*batch_head; /* protected by stripe lock */
-	spinlock_t		batch_lock; /* only header's lock is useful */
+	raw_spinlock_t		batch_lock; /* only header's lock is useful */
 	struct list_head	batch_list; /* protected by head's batch lock*/
 
 	struct r5l_io_unit	*log_io;
-- 
2.11.0

