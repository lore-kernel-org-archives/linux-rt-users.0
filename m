From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.9.61-rt52
Date: Wed, 29 Nov 2017 11:52:31 -0500
Message-ID: <20171129115231.16f95da7@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.9.61-rt52 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 90a44e3e7d9e94f96d8d6c2f70789f8eeb594ca8


Or to build 4.9.61-rt52 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.61.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.61-rt52.patch.xz



You can also build from 4.9.61-rt51 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.61-rt51-rt52.patch.xz



Enjoy,

-- Steve


Changes from v4.9.61-rt51:

---

Haris Okanovic (1):
      tpm_tis: fix stall after iowrite*()s

Mike Galbraith (1):
      drivers/zram: fix zcomp_stream_get() smp_processor_id() use in preemptible code

Mikulas Patocka (1):
      locking/rt-mutex: fix deadlock in device mapper / block-IO

Sebastian Andrzej Siewior (3):
      fs/dcache: disable preemption on i_dir_seq's write side
      fs: convert two more BH_Uptodate_Lock related bitspinlocks
      md/raid5: do not disable interrupts

Steven Rostedt (VMware) (1):
      Linux 4.9.61-rt52

----
 drivers/block/zram/zcomp.c |  3 ++-
 drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
 drivers/md/raid5.c         |  4 ++--
 fs/dcache.c                | 12 +++++++-----
 fs/ext4/page-io.c          |  6 ++----
 fs/inode.c                 |  2 +-
 fs/libfs.c                 |  6 ++++--
 fs/xfs/xfs_aops.c          |  6 ++----
 include/linux/fs.h         |  2 +-
 kernel/locking/rtmutex.c   | 13 +++++++++++++
 localversion-rt            |  2 +-
 11 files changed, 62 insertions(+), 23 deletions(-)
---------------------------
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index fa8329ad79fd..8c93ee150ee8 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -120,7 +120,7 @@ struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
 	struct zcomp_strm *zstrm;
 
-	zstrm = *this_cpu_ptr(comp->stream);
+	zstrm = *get_local_ptr(comp->stream);
 	spin_lock(&zstrm->zcomp_lock);
 	return zstrm;
 }
@@ -131,6 +131,7 @@ void zcomp_stream_put(struct zcomp *comp)
 
 	zstrm = *this_cpu_ptr(comp->stream);
 	spin_unlock(&zstrm->zcomp_lock);
+	put_local_ptr(zstrm);
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 8022bea27fed..247330efd310 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -50,6 +50,31 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_tcg_phy, priv);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * Flushes previous write operations to chip so that a subsequent
+ * ioread*()s won't stall a cpu.
+ */
+static inline void tpm_tis_flush(void __iomem *iobase)
+{
+	ioread8(iobase + TPM_ACCESS(0));
+}
+#else
+#define tpm_tis_flush(iobase) do { } while (0)
+#endif
+
+static inline void tpm_tis_iowrite8(u8 b, void __iomem *iobase, u32 addr)
+{
+	iowrite8(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
+static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
+{
+	iowrite32(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
 static bool interrupts = true;
 module_param(interrupts, bool, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
@@ -103,7 +128,7 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
 	while (len--)
-		iowrite8(*value++, phy->iobase + addr);
+		tpm_tis_iowrite8(*value++, phy->iobase, addr);
 	return 0;
 }
 
@@ -127,7 +152,7 @@ static int tpm_tcg_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	iowrite32(value, phy->iobase + addr);
+	tpm_tis_iowrite32(value, phy->iobase, addr);
 	return 0;
 }
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4d8cfce1de86..4dde911925dc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -429,7 +429,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		md_wakeup_thread(conf->mddev->thread);
 	return;
 slow_path:
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
 	if (atomic_dec_and_lock(&sh->count, &conf->device_lock)) {
 		INIT_LIST_HEAD(&list);
@@ -438,7 +438,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		spin_unlock(&conf->device_lock);
 		release_inactive_stripe_list(conf, &list, hash);
 	}
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static inline void remove_hash(struct stripe_head *sh)
diff --git a/fs/dcache.c b/fs/dcache.c
index 37948da28742..f0719b2f1be5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2409,9 +2409,10 @@ EXPORT_SYMBOL(d_rehash);
 static inline unsigned start_dir_add(struct inode *dir)
 {
 
+	preempt_disable_rt();
 	for (;;) {
-		unsigned n = dir->i_dir_seq;
-		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
+		unsigned n = dir->__i_dir_seq;
+		if (!(n & 1) && cmpxchg(&dir->__i_dir_seq, n, n + 1) == n)
 			return n;
 		cpu_relax();
 	}
@@ -2419,7 +2420,8 @@ static inline unsigned start_dir_add(struct inode *dir)
 
 static inline void end_dir_add(struct inode *dir, unsigned n)
 {
-	smp_store_release(&dir->i_dir_seq, n + 2);
+	smp_store_release(&dir->__i_dir_seq, n + 2);
+	preempt_enable_rt();
 }
 
 static void d_wait_lookup(struct dentry *dentry)
@@ -2455,7 +2457,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 
 retry:
 	rcu_read_lock();
-	seq = smp_load_acquire(&parent->d_inode->i_dir_seq) & ~1;
+	seq = smp_load_acquire(&parent->d_inode->__i_dir_seq) & ~1;
 	r_seq = read_seqbegin(&rename_lock);
 	dentry = __d_lookup_rcu(parent, name, &d_seq);
 	if (unlikely(dentry)) {
@@ -2477,7 +2479,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		goto retry;
 	}
 	hlist_bl_lock(b);
-	if (unlikely(parent->d_inode->i_dir_seq != seq)) {
+	if (unlikely(parent->d_inode->__i_dir_seq != seq)) {
 		hlist_bl_unlock(b);
 		rcu_read_unlock();
 		goto retry;
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
diff --git a/fs/inode.c b/fs/inode.c
index 920aa0b1c6b0..3d6b5fd1bf06 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -153,7 +153,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_bdev = NULL;
 	inode->i_cdev = NULL;
 	inode->i_link = NULL;
-	inode->i_dir_seq = 0;
+	inode->__i_dir_seq = 0;
 	inode->i_rdev = 0;
 	inode->dirtied_when = 0;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 48826d4da189..3ea54d1fc431 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -89,7 +89,7 @@ static struct dentry *next_positive(struct dentry *parent,
 				    struct list_head *from,
 				    int count)
 {
-	unsigned *seq = &parent->d_inode->i_dir_seq, n;
+	unsigned *seq = &parent->d_inode->__i_dir_seq, n;
 	struct dentry *res;
 	struct list_head *p;
 	bool skipped;
@@ -122,8 +122,9 @@ static struct dentry *next_positive(struct dentry *parent,
 static void move_cursor(struct dentry *cursor, struct list_head *after)
 {
 	struct dentry *parent = cursor->d_parent;
-	unsigned n, *seq = &parent->d_inode->i_dir_seq;
+	unsigned n, *seq = &parent->d_inode->__i_dir_seq;
 	spin_lock(&parent->d_lock);
+	preempt_disable_rt();
 	for (;;) {
 		n = *seq;
 		if (!(n & 1) && cmpxchg(seq, n, n + 1) == n)
@@ -136,6 +137,7 @@ static void move_cursor(struct dentry *cursor, struct list_head *after)
 	else
 		list_add_tail(&cursor->d_child, &parent->d_subdirs);
 	smp_store_release(seq, n + 2);
+	preempt_enable_rt();
 	spin_unlock(&parent->d_lock);
 }
 
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d705ae084edd..ab1946f4a729 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -688,7 +688,7 @@ struct inode {
 		struct block_device	*i_bdev;
 		struct cdev		*i_cdev;
 		char			*i_link;
-		unsigned		i_dir_seq;
+		unsigned		__i_dir_seq;
 	};
 
 	__u32			i_generation;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 78a6c4a223c1..b73cd7c87551 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -22,6 +22,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
+#include <linux/blkdev.h>
 
 #include "rtmutex_common.h"
 
@@ -1968,6 +1969,15 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	/*
+	 * If rt_mutex blocks, the function sched_submit_work will not call
+	 * blk_schedule_flush_plug (because tsk_is_pi_blocked would be true).
+	 * We must call blk_schedule_flush_plug here, if we don't call it,
+	 * a deadlock in device mapper may happen.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK, ww_ctx);
 }
 
@@ -1985,6 +1995,9 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	return slowfn(lock, state, timeout, chwalk, ww_ctx);
 }
 
diff --git a/localversion-rt b/localversion-rt
index 75493460c41f..66a5ed8bf3d7 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt51
+-rt52
