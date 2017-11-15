From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] fs: convert two mroe BH_Uptodate_Lock related bitspinlocks
Date: Wed, 15 Nov 2017 17:47:24 +0100
Message-ID: <20171115164724.y4obsvycytm4mlk7@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42549 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdKOQr0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Nov 2017 11:47:26 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We convert all BH_Uptodate_Lock based bit-spinlocks to use
bh_uptodate_lock_irqsave() instead. Those two were introduced after the
initial change in -RT and were not noticed before.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/ext4/page-io.c | 6 ++----
 fs/xfs/xfs_aops.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index c2fce4478cca..a8e94791990d 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -94,8 +94,7 @@ static void ext4_finish_bio(struct bio *bio)
 		 * We check all buffers in the page under BH_Uptodate_Lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		flags = bh_uptodate_lock_irqsave(head);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -107,8 +106,7 @@ static void ext4_finish_bio(struct bio *bio)
 			if (bio->bi_status)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		bh_uptodate_unlock_irqrestore(head, flags);
 		if (!under_io) {
 #ifdef CONFIG_EXT4_FS_ENCRYPTION
 			if (data_page)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 41b767ecfe50..e35ad09124ab 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -107,8 +107,7 @@ xfs_finish_page_writeback(
 	ASSERT(bvec->bv_offset + bvec->bv_len <= PAGE_SIZE);
 	ASSERT((bvec->bv_len & (i_blocksize(inode) - 1)) == 0);
 
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+	flags = bh_uptodate_lock_irqsave(head);
 	do {
 		if (off >= bvec->bv_offset &&
 		    off < bvec->bv_offset + bvec->bv_len) {
@@ -130,8 +129,7 @@ xfs_finish_page_writeback(
 		}
 		off += bh->b_size;
 	} while ((bh = bh->b_this_page) != head);
-	bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-	local_irq_restore(flags);
+	bh_uptodate_unlock_irqrestore(head, flags);
 
 	if (!busy)
 		end_page_writeback(bvec->bv_page);
-- 
2.15.0

