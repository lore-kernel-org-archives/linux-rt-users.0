From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/10] fs: convert two more BH_Uptodate_Lock related bitspinlocks
Date: Thu, 23 Nov 2017 00:33:49 -0500
Message-ID: <20171123053434.323019871@goodmis.org>
References: <20171123053341.174002403@goodmis.org>
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
Content-Disposition: inline; filename=0008-fs-convert-two-more-BH_Uptodate_Lock-related-bitspin.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.97-rt111-rc2 stable review patch.
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
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 6ca56f5f72b5..9e145fe7cae0 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -97,8 +97,7 @@ static void ext4_finish_bio(struct bio *bio)
 		 * We check all buffers in the page under BH_Uptodate_Lock
 		 * to avoid races with other end io clearing async_write flags
 		 */
-		local_irq_save(flags);
-		bit_spin_lock(BH_Uptodate_Lock, &head->b_state);
+		flags = bh_uptodate_lock_irqsave(head);
 		do {
 			if (bh_offset(bh) < bio_start ||
 			    bh_offset(bh) + bh->b_size > bio_end) {
@@ -110,8 +109,7 @@ static void ext4_finish_bio(struct bio *bio)
 			if (bio->bi_error)
 				buffer_io_error(bh);
 		} while ((bh = bh->b_this_page) != head);
-		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
-		local_irq_restore(flags);
+		bh_uptodate_unlock_irqrestore(head, flags);
 		if (!under_io) {
 #ifdef CONFIG_EXT4_FS_ENCRYPTION
 			if (ctx)
-- 
2.13.2
