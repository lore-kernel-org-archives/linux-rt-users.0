From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.13.10-rt3
Date: Sat, 28 Oct 2017 00:27:09 +0200
Message-ID: <20171027222709.sna64giwxak4dxxc@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.13.10-rt3 patch set. 

Changes since v4.13.10-rt2:

  - A dcache related live lock could occur. The writer could get
    preempted within the critical section and the reader would spin to
    see the update completed. This update would never complete if the
    writer was preempted by a reader with a higher priority. Reported by
    Oleg Karfich.

  - The tpm_tis driver can cause latency spikes (~400us) after multiple
    writes to the chip is followed by a read operation. This read causes
    a flush of all the cached writes to the chip and is blocking the CPU
    until the operation completes. Reported and patched by Haris
    Okanovic.

  - The upgrade to v4.13-RT broke the zram driver. Patched by Mike
    Galbraith.

  - Tom Zanussi's "tracing: Inter-event (e.g. latency) support" patchset
    has been update to v3.

  - The static SRCU notifier wasn't compiling with SRCU_TINY. Reported
    by kbuild test robot.

The delta patch appended at the bottom of this email contains all the
changes except tracing due to the size of the tracing delta. For
complete diff please visit
  https://git.kernel.org/rt/linux-rt-devel/d/v4.13.10-rt3/v4.13.10-rt2

Known issues
	None

The delta patch against v4.13.10-rt2 can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/incr/patch-4.13.10-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.13.10-rt3

The RT patch against v4.13.10 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patch-4.13.10-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.13/older/patches-4.13.10-rt3.tar.xz

Sebastian

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index df6fd9df698e..15e7ff4ea178 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -530,7 +530,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		return false;
 	}
 
-	zram_meta_init_table_locks(zram, disksize);
+	zram_meta_init_table_locks(zram, num_pages);
 	return true;
 }
 
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7e55aa9ce680..85750ec39645 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -52,6 +52,31 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
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
@@ -230,7 +255,7 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	tpm_platform_begin_xfer();
 
 	while (len--)
-		iowrite8(*value++, phy->iobase + addr);
+		tpm_tis_iowrite8(*value++, phy->iobase, addr);
 
 	tpm_platform_end_xfer();
 
@@ -269,7 +294,7 @@ static int tpm_tcg_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 
 	tpm_platform_begin_xfer();
 
-	iowrite32(value, phy->iobase + addr);
+	tpm_tis_iowrite32(value, phy->iobase, addr);
 
 	tpm_platform_end_xfer();
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 1ec40bb6eb3b..6842e2220924 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2417,9 +2417,10 @@ EXPORT_SYMBOL(d_rehash);
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
@@ -2427,7 +2428,8 @@ static inline unsigned start_dir_add(struct inode *dir)
 
 static inline void end_dir_add(struct inode *dir, unsigned n)
 {
-	smp_store_release(&dir->i_dir_seq, n + 2);
+	smp_store_release(&dir->__i_dir_seq, n + 2);
+	preempt_enable_rt();
 }
 
 static void d_wait_lookup(struct dentry *dentry)
@@ -2463,7 +2465,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 
 retry:
 	rcu_read_lock();
-	seq = smp_load_acquire(&parent->d_inode->i_dir_seq) & ~1;
+	seq = smp_load_acquire(&parent->d_inode->__i_dir_seq) & ~1;
 	r_seq = read_seqbegin(&rename_lock);
 	dentry = __d_lookup_rcu(parent, name, &d_seq);
 	if (unlikely(dentry)) {
@@ -2485,7 +2487,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		goto retry;
 	}
 	hlist_bl_lock(b);
-	if (unlikely(parent->d_inode->i_dir_seq != seq)) {
+	if (unlikely(parent->d_inode->__i_dir_seq != seq)) {
 		hlist_bl_unlock(b);
 		rcu_read_unlock();
 		goto retry;
diff --git a/fs/inode.c b/fs/inode.c
index 6a1626e0edaf..601b666e76a9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -154,7 +154,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_bdev = NULL;
 	inode->i_cdev = NULL;
 	inode->i_link = NULL;
-	inode->i_dir_seq = 0;
+	inode->__i_dir_seq = 0;
 	inode->i_rdev = 0;
 	inode->dirtied_when = 0;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 3aabe553fc45..b5d63bf1ad8e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -90,7 +90,7 @@ static struct dentry *next_positive(struct dentry *parent,
 				    struct list_head *from,
 				    int count)
 {
-	unsigned *seq = &parent->d_inode->i_dir_seq, n;
+	unsigned *seq = &parent->d_inode->__i_dir_seq, n;
 	struct dentry *res;
 	struct list_head *p;
 	bool skipped;
@@ -123,8 +123,9 @@ static struct dentry *next_positive(struct dentry *parent,
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
@@ -137,6 +138,7 @@ static void move_cursor(struct dentry *cursor, struct list_head *after)
 	else
 		list_add_tail(&cursor->d_child, &parent->d_subdirs);
 	smp_store_release(seq, n + 2);
+	preempt_enable_rt();
 	spin_unlock(&parent->d_lock);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d0c0ca8ea8c1..30b9561cf142 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -651,7 +651,7 @@ struct inode {
 		struct block_device	*i_bdev;
 		struct cdev		*i_cdev;
 		char			*i_link;
-		unsigned		i_dir_seq;
+		unsigned		__i_dir_seq;
 	};
 
 	__u32			i_generation;
diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index e9515066250e..49bef3e96eb2 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -119,12 +119,20 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 	struct raw_notifier_head name =				\
 		RAW_NOTIFIER_INIT(name)
 
+#ifdef CONFIG_TREE_SRCU
 #define _SRCU_NOTIFIER_HEAD(name, mod)				\
 	static DEFINE_PER_CPU(struct srcu_data,			\
 			name##_head_srcu_data);			\
 	mod struct srcu_notifier_head name =			\
 			SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
 
+#else
+#define _SRCU_NOTIFIER_HEAD(name, mod)				\
+	mod struct srcu_notifier_head name =			\
+			SRCU_NOTIFIER_INIT(name, name)
+
+#endif
+
 #define SRCU_NOTIFIER_HEAD(name)				\
 	_SRCU_NOTIFIER_HEAD(name, )
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index cfbfc540cafc..1bdcbdd3317c 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -43,7 +43,7 @@ struct srcu_struct {
 
 void srcu_drive_gp(struct work_struct *wp);
 
-#define __SRCU_STRUCT_INIT(name)					\
+#define __SRCU_STRUCT_INIT(name, __ignored)				\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
@@ -56,9 +56,9 @@ void srcu_drive_gp(struct work_struct *wp);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name = __SRCU_STRUCT_INIT(name)
+	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
 #define DEFINE_STATIC_SRCU(name) \
-	static struct srcu_struct name = __SRCU_STRUCT_INIT(name)
+	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name)
 
 void synchronize_srcu(struct srcu_struct *sp);
 
diff --git a/localversion-rt b/localversion-rt
index c3054d08a112..1445cd65885c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
