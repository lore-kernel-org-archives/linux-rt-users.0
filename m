From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/7] fs: convert two more BH_Uptodate_Lock related bitspinlocks
Date: Thu, 23 Nov 2017 00:23:21 -0500
Message-ID: <20171123052630.020954419@goodmis.org>
References: <20171123052317.319740795@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-fs-convert-two-more-BH_Uptodate_Lock-related-bitspin.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.61-rt52-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

We convert all BH_Uptodate_Lock based bit-spinlocks to use
bh_uptodate_lock_irqsave() instead. Those two were introduced after the
initial change in -RT and were not noticed before.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/ext4/page-io.c | 6 ++----
 fs/xfs/xfs_aops.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 0094923e5ebf..37fa06ef5417 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -95,8 +95,7 @@ static void ext4_finish_bio(struct bio *bio)
 		 * We check all buffers in the page under BH_Uptodate_Lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		flags = bh_uptodate_lock_irqsave(head);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -108,8 +107,7 @@ static void ext4_finish_bio(struct bio *bio)
 			if (bio->bi_error)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		bh_uptodate_unlock_irqrestore(head, flags);
 		if (!under_io) {
 #ifdef CONFIG_EXT4_FS_ENCRYPTION
 			if (data_page)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index d31cd1ebd8e9..5ea3f933a52a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -112,8 +112,7 @@ xfs_finish_page_writeback(
 	ASSERT(bvec->bv_offset + bvec->bv_len <= PAGE_SIZE);
 	ASSERT((bvec->bv_len & (i_blocksize(inode) - 1)) == 0);
 
-	local_irq_save(flags);
-	bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+	flags = bh_uptodate_lock_irqsave(head);
 	do {
 		if (off >= bvec->bv_offset &&
 		    off < bvec->bv_offset + bvec->bv_len) {
@@ -136,8 +135,7 @@ xfs_finish_page_writeback(
 		}
 		off += bh->b_size;
 	} while ((bh = bh->b_this_page) != head);
-	bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-	local_irq_restore(flags);
+	bh_uptodate_unlock_irqrestore(head, flags);
 
 	if (!busy)
 		end_page_writeback(bvec->bv_page);
-- 
2.13.2
