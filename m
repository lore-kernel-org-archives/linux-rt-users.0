From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.8.2-rt3
Date: Mon, 24 Oct 2016 11:03:22 +0200
Message-ID: <20161024090322.h7jhlgm34tyt4uze@linutronix.de>
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

I'm pleased to announce the v4.8.2-rt3 patch set. 

Changes since v4.8.2-rt2:

  - The connector subsystem could sleep in invalid context. Found and
    fixed by Mike Galbraith

  - zram / zcomp has shown new warnings. The warnings have been
    addressed and an old error fixed (Mike Galbraith)

  - The ftrace header was off slightly and the ascii arrow were point to
    the wrong direction (Mike Galbraith)

  - On CPU-down (CPU hotplug) we could attempt to sleep in wrong context.
    (Mike Galbraith)

  - Removed an unused static variable in RXPRC (noticed by kbuild test
    robot)

  - ifdefed a variable in APIC so we don't get this "unused variable"
    warning on certain configurations (noticed by kbuild test robot)

  - Added `-no-PIE' to the Makefile. This breaks gcc 3.2. Is someone
    here still using it?

  - Fixed docbook in two places (noticed by kbuild test robot)

  - Fixed compile on sparc which was broken after I moved RCU headers
    (noticed by kbuild test robot)

  - The kbuild test robot sent me a warning about sleeping in invalid
    context in the NFS4 code. I didn't manage to reproduce this myself
    but the warning is valid. I attempted to fix this and will wait for
    robot's feedback :)

  - Lazy preempt was broken on x86-32. Fixed by Paul Gortmaker.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.8.2-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/incr/patch-4.8.2-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.8.2-rt3

The RT patch against 4.6.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patch-4.8.2-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patches-4.8.2-rt3.tar.xz

Sebastian

diff --git a/Makefile b/Makefile
index bf6e44a421df..97296d66b586 100644
--- a/Makefile
+++ b/Makefile
@@ -398,7 +398,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -std=gnu89
 
 KBUILD_AFLAGS_KERNEL :=
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index aa149231b1ff..1d8ee026c9c5 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -282,6 +282,7 @@ ENTRY(resume_kernel)
 	cmpl $_PREEMPT_ENABLED,PER_CPU_VAR(__preempt_count)
 	jne restore_all
 
+	GET_THREAD_INFO(%ebp)
 	cmpl $0,TI_preempt_lazy_count(%ebp)	# non-zero preempt_lazy_count ?
 	jnz restore_all
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index fbd19444403f..e78f477a4ae3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -87,7 +87,9 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
  *		->ioapic_mutex
  *			->ioapic_lock
  */
+#ifdef CONFIG_X86_IO_APIC
 static DEFINE_MUTEX(acpi_ioapic_lock);
+#endif
 
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 4b5cd3a7b2b6..fa8329ad79fd 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -118,12 +118,19 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	struct zcomp_strm *zstrm;
+
+	zstrm = *this_cpu_ptr(comp->stream);
+	spin_lock(&zstrm->zcomp_lock);
+	return zstrm;
 }
 
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	struct zcomp_strm *zstrm;
+
+	zstrm = *this_cpu_ptr(comp->stream);
+	spin_unlock(&zstrm->zcomp_lock);
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
@@ -174,6 +181,7 @@ static int __zcomp_cpu_notifier(struct zcomp *comp,
 			pr_err("Can't allocate a compression stream\n");
 			return NOTIFY_BAD;
 		}
+		spin_lock_init(&zstrm->zcomp_lock);
 		*per_cpu_ptr(comp->stream, cpu) = zstrm;
 		break;
 	case CPU_DEAD:
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 478cac2ed465..f7a6efdc3285 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -14,6 +14,7 @@ struct zcomp_strm {
 	/* compression/decompression buffer */
 	void *buffer;
 	struct crypto_comp *tfm;
+	spinlock_t zcomp_lock;
 };
 
 /* dynamic per-device compression frontend */
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d16c876c2400..b4a0577a4dbc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -568,6 +568,7 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
 	struct zram_meta *meta = zram->meta;
 	unsigned long handle;
 	unsigned int size;
+	struct zcomp_strm *zstrm;
 
 	zram_lock_table(&meta->table[index]);
 	handle = meta->table[index].handle;
@@ -579,16 +580,15 @@ static int zram_decompress_page(struct zram *zram, char *mem, u32 index)
 		return 0;
 	}
 
+	zstrm = zcomp_stream_get(zram->comp);
 	cmem = zs_map_object(meta->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
 		copy_page(mem, cmem);
 	} else {
-		struct zcomp_strm *zstrm = zcomp_stream_get(zram->comp);
-
 		ret = zcomp_decompress(zstrm, cmem, size, mem);
-		zcomp_stream_put(zram->comp);
 	}
 	zs_unmap_object(meta->mem_pool, handle);
+	zcomp_stream_put(zram->comp);
 	zram_unlock_table(&meta->table[index]);
 
 	/* Should NEVER happen. Return bio error if it does. */
diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index a782ce87715c..19d265948526 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -32,6 +32,7 @@
 #include <linux/pid_namespace.h>
 
 #include <linux/cn_proc.h>
+#include <linux/locallock.h>
 
 /*
  * Size of a cn_msg followed by a proc_event structure.  Since the
@@ -54,10 +55,11 @@ static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
 
 /* proc_event_counts is used as the sequence number of the netlink message */
 static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
+static DEFINE_LOCAL_IRQ_LOCK(send_msg_lock);
 
 static inline void send_msg(struct cn_msg *msg)
 {
-	preempt_disable();
+	local_lock(send_msg_lock);
 
 	msg->seq = __this_cpu_inc_return(proc_event_counts) - 1;
 	((struct proc_event *)msg->data)->cpu = smp_processor_id();
@@ -70,7 +72,7 @@ static inline void send_msg(struct cn_msg *msg)
 	 */
 	cn_netlink_send(msg, 0, CN_IDX_PROC, GFP_NOWAIT);
 
-	preempt_enable();
+	local_unlock(send_msg_lock);
 }
 
 void proc_fork_connector(struct task_struct *task)
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 322c2585bc34..aff0448aa0f2 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -140,11 +140,11 @@ static int nfs_delegation_claim_opens(struct inode *inode,
 		sp = state->owner;
 		/* Block nfs4_proc_unlck */
 		mutex_lock(&sp->so_delegreturn_mutex);
-		seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
+		seq = read_seqbegin(&sp->so_reclaim_seqlock);
 		err = nfs4_open_delegation_recall(ctx, state, stateid, type);
 		if (!err)
 			err = nfs_delegation_claim_locks(ctx, state, stateid);
-		if (!err && read_seqcount_retry(&sp->so_reclaim_seqcount, seq))
+		if (!err && read_seqretry(&sp->so_reclaim_seqlock, seq))
 			err = -EAGAIN;
 		mutex_unlock(&sp->so_delegreturn_mutex);
 		put_nfs_open_context(ctx);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 9bf64eacba5b..041da5cb80f5 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -107,7 +107,7 @@ struct nfs4_state_owner {
 	unsigned long	     so_flags;
 	struct list_head     so_states;
 	struct nfs_seqid_counter so_seqid;
-	seqcount_t	     so_reclaim_seqcount;
+	seqlock_t	     so_reclaim_seqlock;
 	struct mutex	     so_delegreturn_mutex;
 };
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a9dec32ba9ba..49b64dfb307c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2525,7 +2525,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	unsigned int seq;
 	int ret;
 
-	seq = raw_seqcount_begin(&sp->so_reclaim_seqcount);
+	seq = raw_seqcount_begin(&sp->so_reclaim_seqlock.seqcount);
 
 	ret = _nfs4_proc_open(opendata);
 	if (ret != 0)
@@ -2561,7 +2561,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	ctx->state = state;
 	if (d_inode(dentry) == state->inode) {
 		nfs_inode_attach_open_context(ctx);
-		if (read_seqcount_retry(&sp->so_reclaim_seqcount, seq))
+		if (read_seqretry(&sp->so_reclaim_seqlock, seq))
 			nfs4_schedule_stateid_recovery(server, state);
 	}
 out:
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index cada00aa5096..d8ad3d406523 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -488,7 +488,7 @@ nfs4_alloc_state_owner(struct nfs_server *server,
 	nfs4_init_seqid_counter(&sp->so_seqid);
 	atomic_set(&sp->so_count, 1);
 	INIT_LIST_HEAD(&sp->so_lru);
-	seqcount_init(&sp->so_reclaim_seqcount);
+	seqlock_init(&sp->so_reclaim_seqlock);
 	mutex_init(&sp->so_delegreturn_mutex);
 	return sp;
 }
@@ -1459,8 +1459,8 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 	 * recovering after a network partition or a reboot from a
 	 * server that doesn't support a grace period.
 	 */
+	write_seqlock(&sp->so_reclaim_seqlock);
 	spin_lock(&sp->so_lock);
-	raw_write_seqcount_begin(&sp->so_reclaim_seqcount);
 restart:
 	list_for_each_entry(state, &sp->so_states, open_states) {
 		if (!test_and_clear_bit(ops->state_flag_bit, &state->flags))
@@ -1525,14 +1525,12 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 		spin_lock(&sp->so_lock);
 		goto restart;
 	}
-	raw_write_seqcount_end(&sp->so_reclaim_seqcount);
 	spin_unlock(&sp->so_lock);
+	write_sequnlock(&sp->so_reclaim_seqlock);
 	return 0;
 out_err:
 	nfs4_put_open_state(state);
-	spin_lock(&sp->so_lock);
-	raw_write_seqcount_end(&sp->so_reclaim_seqcount);
-	spin_unlock(&sp->so_lock);
+	write_sequnlock(&sp->so_reclaim_seqlock);
 	return status;
 }
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c8f178549d7b..c0a351daf736 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -219,6 +219,7 @@ extern void resume_device_irqs(void);
  * struct irq_affinity_notify - context for notification of IRQ affinity changes
  * @irq:		Interrupt to which notification applies
  * @kref:		Reference count, for internal use
+ * @swork:		Swork item, for internal use
  * @work:		Work item, for internal use
  * @notify:		Function to be called on change.  This will be
  *			called in process context.
diff --git a/include/linux/rcu_assign_pointer.h b/include/linux/rcu_assign_pointer.h
index 1f49a6dd1b67..7066962a4379 100644
--- a/include/linux/rcu_assign_pointer.h
+++ b/include/linux/rcu_assign_pointer.h
@@ -1,6 +1,7 @@
 #ifndef __LINUX_RCU_ASSIGN_POINTER_H__
 #define __LINUX_RCU_ASSIGN_POINTER_H__
 #include <linux/compiler.h>
+#include <asm/barrier.h>
 
 /**
  * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75666215b8cd..55aafcff5810 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7569,7 +7569,7 @@ int sched_cpu_dying(unsigned int cpu)
 	nohz_balance_exit_idle(cpu);
 	hrtick_clear(rq);
 	if (per_cpu(idle_last_mm, cpu)) {
-		mmdrop(per_cpu(idle_last_mm, cpu));
+		mmdrop_delayed(per_cpu(idle_last_mm, cpu));
 		per_cpu(idle_last_mm, cpu) = NULL;
 	}
 	return 0;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8c0b960c60da..84ffcb813263 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2896,17 +2896,17 @@ get_total_entries(struct trace_buffer *buf,
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                   _--------=> CPU#              \n"
-		    "#                  / _-------=> irqs-off          \n"
-		    "#                 | / _------=> need-resched      \n"
-		    "#                 || / _-----=> need-resched_lazy \n"
-		    "#                 ||| / _----=> hardirq/softirq   \n"
-		    "#                 |||| / _---=> preempt-depth     \n"
-		    "#                 ||||| / _--=> preempt-lazy-depth\n"
-		    "#                 |||||| / _-=> migrate-disable   \n"
-		    "#                 ||||||| /     delay             \n"
-		    "#  cmd     pid    |||||||| time  |   caller       \n"
-		    "#     \\   /      ||||||||  \\   |   /            \n");
+	seq_puts(m, "#                  _--------=> CPU#              \n"
+		    "#                 / _-------=> irqs-off          \n"
+		    "#                | / _------=> need-resched      \n"
+		    "#                || / _-----=> need-resched_lazy \n"
+		    "#                ||| / _----=> hardirq/softirq   \n"
+		    "#                |||| / _---=> preempt-depth     \n"
+		    "#                ||||| / _--=> preempt-lazy-depth\n"
+		    "#                |||||| / _-=> migrate-disable   \n"
+		    "#                ||||||| /     delay             \n"
+		    "# cmd     pid    |||||||| time   |  caller       \n"
+		    "#     \\   /      ||||||||   \\    |  /            \n");
 }
 
 static void print_event_info(struct trace_buffer *buf, struct seq_file *m)
@@ -2935,11 +2935,11 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 		    "#                            |/  _-----=> need-resched_lazy\n"
 		    "#                            || / _---=> hardirq/softirq\n"
 		    "#                            ||| / _--=> preempt-depth\n"
-		    "#                            |||| /_--=> preempt-lazy-depth\n"
-		    "#                            |||||  _-=> migrate-disable   \n"
-		    "#                            ||||| /    delay\n"
-		    "#           TASK-PID   CPU#  ||||||    TIMESTAMP  FUNCTION\n"
-		    "#              | |       |   ||||||       |         |\n");
+		    "#                            |||| / _-=> preempt-lazy-depth\n"
+		    "#                            ||||| / _-=> migrate-disable   \n"
+		    "#                            |||||| /    delay\n"
+		    "#           TASK-PID   CPU#  |||||||   TIMESTAMP  FUNCTION\n"
+		    "#              | |       |   |||||||      |         |\n");
 }
 
 void
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 479775f5d97d..c7a62d6adb00 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -878,7 +878,7 @@ static void wake_up_worker(struct worker_pool *pool)
 
 /**
  * wq_worker_running - a worker is running again
- * @cpu: CPU @task is waking up to
+ * @task: task waking up
  *
  * This function is called when a worker returns from schedule()
  */
diff --git a/localversion-rt b/localversion-rt
index c3054d08a112..1445cd65885c 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f264d387a5ec..5af6426fbcbe 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -53,6 +53,7 @@
 #include <linux/mount.h>
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
+#include <linux/locallock.h>
 
 #define ZSPAGE_MAGIC	0x58
 
@@ -70,19 +71,20 @@
  */
 #define ZS_MAX_ZSPAGE_ORDER 2
 #define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
+#define ZS_HANDLE_SIZE (sizeof(unsigned long))
 
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 
 struct zsmalloc_handle {
 	unsigned long addr;
 	struct mutex lock;
 };
 
-#define ZS_HANDLE_SIZE (sizeof(struct zsmalloc_handle))
+#define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
 
 #else
 
-#define ZS_HANDLE_SIZE (sizeof(unsigned long))
+#define ZS_HANDLE_ALLOC_SIZE (sizeof(unsigned long))
 #endif
 
 /*
@@ -339,7 +341,7 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 
 static int create_cache(struct zs_pool *pool)
 {
-	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
+	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_ALLOC_SIZE,
 					0, 0, NULL);
 	if (!pool->handle_cachep)
 		return 1;
@@ -367,7 +369,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 
 	p = kmem_cache_alloc(pool->handle_cachep,
 			     gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	if (p) {
 		struct zsmalloc_handle *zh = p;
 
@@ -377,7 +379,7 @@ static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
 	return (unsigned long)p;
 }
 
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 static struct zsmalloc_handle *zs_get_pure_handle(unsigned long handle)
 {
 	return (void *)(handle &~((1 << OBJ_TAG_BITS) - 1));
@@ -402,7 +404,7 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 
 static void record_obj(unsigned long handle, unsigned long obj)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	WRITE_ONCE(zh->addr, obj);
@@ -502,6 +504,7 @@ MODULE_ALIAS("zpool-zsmalloc");
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
 static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
+static DEFINE_LOCAL_IRQ_LOCK(zs_map_area_lock);
 
 static bool is_zspage_isolated(struct zspage *zspage)
 {
@@ -937,7 +940,7 @@ static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
 
 static unsigned long handle_to_obj(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return zh->addr;
@@ -957,7 +960,7 @@ static unsigned long obj_to_head(struct page *page, void *obj)
 
 static inline int testpin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_is_locked(&zh->lock);
@@ -968,7 +971,7 @@ static inline int testpin_tag(unsigned long handle)
 
 static inline int trypin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_trylock(&zh->lock);
@@ -979,7 +982,7 @@ static inline int trypin_tag(unsigned long handle)
 
 static void pin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_lock(&zh->lock);
@@ -990,7 +993,7 @@ static void pin_tag(unsigned long handle)
 
 static void unpin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_unlock(&zh->lock);
@@ -1488,7 +1491,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = pool->size_class[class_idx];
 	off = (class->size * obj_idx) & ~PAGE_MASK;
 
-	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
+	area = &get_locked_var(zs_map_area_lock, zs_map_area);
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1542,7 +1545,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_light();
+	put_locked_var(zs_map_area_lock, zs_map_area);
 
 	migrate_read_unlock(zspage);
 	unpin_tag(handle);
diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
index 814d285ff802..d4d088e9be85 100644
--- a/net/rxrpc/security.c
+++ b/net/rxrpc/security.c
@@ -19,9 +19,6 @@
 #include <keys/rxrpc-type.h>
 #include "ar-internal.h"
 
-static LIST_HEAD(rxrpc_security_methods);
-static DECLARE_RWSEM(rxrpc_security_sem);
-
 static const struct rxrpc_security *rxrpc_security_types[] = {
 	[RXRPC_SECURITY_NONE]	= &rxrpc_no_security,
 #ifdef CONFIG_RXKAD
