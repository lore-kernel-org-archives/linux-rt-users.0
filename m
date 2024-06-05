Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071B20B20;
	Wed,  5 Jun 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601093; cv=none; b=JSKc8832ldTR/BLHu/kAioihI/tS9m+QrJMqOuGbYk6i2OLkZIpwbPod0HhQDfCeIqcs81qK805nGDLbSk1IR/9IamiC+MwmyMMXLMcfWm2IOjK0tDZQD7kawG0KnA3rL46EL74DetzHFs6sOMy83z9Sn2uJhchNFwC2F8ha0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601093; c=relaxed/simple;
	bh=ZsVvkXm8lBkf/1UqC8tnJcw45wFCiV7HHuZajBew4pA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YBLMObM67oDN0BHnQH5yBTqsmR1rpMl3PvLUsNDKOzgRSoL3eNYMOLU1SEsPwoO47ChV+CAVnCsgHRvI5P3M7Pvyz/v4lS2ctJFIWBj2IUBN19838BTmgjXaUzyJfTqJ3Au9ANQ+S8iDc7rQRW4Worg4AaShtfA2Um6A1BMTCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipYdCSPm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lx28VqSx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipYdCSPm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lx28VqSx"
Date: Wed, 5 Jun 2024 17:24:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717601087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ou/on3qDTze3OjYtub/Fyv7aQAp187Raa8cJDFH2bBM=;
	b=ipYdCSPm8Ul9mKUCa9GWM8elQk1HIZlVXuyCHi8RM1JCWgTG7wq1GC+hQ0PUDZz+sDVJv0
	kDt+0H+ASde/j+908XEstLWgusymOL+fj9up5b+XQQaRDsHldxrkiX1bs6ejTv4mufoxE8
	Z8nk382k3I9fKsyKC6looQA3kHsVyEYi9nLX3klbeAzhpDTMru61IbO2ZlUjb7tEqMS3BS
	4WcLH+LLlPcLOFUEihVSvxc7nI/yX6xemdBepyRiHQ5EGIj50G+6NnR9LbVwAkLLMK4Av+
	Bi/E1G0+lcWcWpaFnxcuzwSq0fAqmt5bchP75sb8m7AXkRbq+sUjNa6g6zkb9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717601087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ou/on3qDTze3OjYtub/Fyv7aQAp187Raa8cJDFH2bBM=;
	b=Lx28VqSxjOK5G2lk6lCi6YhTy4uCqPF6al9FbLRhL+C8yDUP9eCUrnjhGTFqFX3La1S17d
	zoSx60QrXdzB19Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10-rc2-rt3
Message-ID: <20240605152445.lr8zdMAd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10-rc2-rt3 patch set. 

Changes since v6.10-rc2-rt2:

  - Update John's printk series
    - Flush legacy consoles directly (if safe) when exiting emergency
      sections.

    - Wake nbcon printer threads on sysrq-R.

    - Sync with latest series posted to LKML for review.

  - Integrate the v4 of the BH-locking series which is currently under
    review. The lock in local_bh_disable() remains for now. The series
    has been added to ease testing in order to remove it ;)
    
  - The v7 of "un-pin tw timer" series by Valentin Schneider and Florian
    Westphal has been added.

Known issues
    None.

The delta patch against v6.10-rc2-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/incr/patch-6.10-rc2-rt2-rt3.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10-rc2-rt3

The RT patch against v6.10-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10-rc2-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10-rc2-rt3.tar.xz

Sebastian

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index e5974b8239c99..53f8c2329c30c 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -452,7 +452,7 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 
 static void sysrq_handle_replay_logs(u8 key)
 {
-	console_replay_all();
+	console_try_replay_all();
 }
 static struct sysrq_key_op sysrq_replay_logs_op = {
 	.handler        = sysrq_handle_replay_logs,
diff --git a/include/linux/console.h b/include/linux/console.h
index 23d51531950f5..96c0923d023b8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -324,7 +324,7 @@ struct nbcon_write_context {
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
- * @nbcon_driver_ctxt:	Context available for driver non-printing operations
+ * @nbcon_device_ctxt:	Context available for non-printing operations
  * @nbcon_prev_seq:	Seq num the previous nbcon owner was assigned to print
  * @pbufs:		Pointer to nbcon private buffer
  * @kthread:		Printer kthread for this console
@@ -372,7 +372,6 @@ struct console {
 	 *
 	 * The callback should allow the takeover whenever it is safe. It
 	 * increases the chance to see messages when the system is in trouble.
-	 *
 	 * If the driver must reacquire ownership in order to finalize or
 	 * revert hardware changes, nbcon_reacquire() can be used. However,
 	 * on reacquire the buffer content is no longer available. A
@@ -387,11 +386,11 @@ struct console {
 	/**
 	 * @write_thread:
 	 *
-	 * NBCON callback to write out text in task context. (Optional)
+	 * NBCON callback to write out text in task context.
 	 *
-	 * This callback is called with the console already acquired. Any
-	 * additional driver synchronization should have been performed by
-	 * device_lock().
+	 * This callback is called after device_lock() and with the nbcon
+	 * console acquired. Any necessary driver synchronization should have
+	 * been performed by the device_lock() callback.
 	 *
 	 * This callback is always called from task context but with migration
 	 * disabled.
@@ -400,8 +399,8 @@ struct console {
 	 * sections applies as with write_atomic(). The difference between
 	 * this callback and write_atomic() is that this callback is used
 	 * during normal operation and is always called from task context.
-	 * This provides drivers with a relatively relaxed locking context
-	 * for synchronizing output to the hardware.
+	 * This allows drivers to operate in their own locking context for
+	 * synchronizing output to the hardware.
 	 */
 	void (*write_thread)(struct console *con, struct nbcon_write_context *wctxt);
 
@@ -450,7 +449,7 @@ struct console {
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
-	struct nbcon_context	__private nbcon_driver_ctxt;
+	struct nbcon_context	__private nbcon_device_ctxt;
 	atomic_long_t           __private nbcon_prev_seq;
 
 	struct printk_buffers	*pbufs;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0f12cf01070e3..2fc16ce4a404b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -744,7 +744,72 @@ struct bpf_redirect_info {
 	struct bpf_nh_params nh;
 };
 
-DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
+struct bpf_net_context {
+	struct bpf_redirect_info ri;
+	struct list_head cpu_map_flush_list;
+	struct list_head dev_map_flush_list;
+	struct list_head xskmap_map_flush_list;
+};
+
+static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
+{
+	struct task_struct *tsk = current;
+
+	if (tsk->bpf_net_context != NULL)
+		return NULL;
+	memset(&bpf_net_ctx->ri, 0, sizeof(bpf_net_ctx->ri));
+
+	if (IS_ENABLED(CONFIG_BPF_SYSCALL)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+	}
+	if (IS_ENABLED(CONFIG_XDP_SOCKETS))
+		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+
+	tsk->bpf_net_context = bpf_net_ctx;
+	return bpf_net_ctx;
+}
+
+static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
+{
+	if (bpf_net_ctx)
+		current->bpf_net_context = NULL;
+}
+
+static inline struct bpf_net_context *bpf_net_ctx_get(void)
+{
+	return current->bpf_net_context;
+}
+
+static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	return &bpf_net_ctx->ri;
+}
+
+static inline struct list_head *bpf_net_ctx_get_cpu_map_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	return &bpf_net_ctx->cpu_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_dev_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	return &bpf_net_ctx->dev_map_flush_list;
+}
+
+static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	return &bpf_net_ctx->xskmap_map_flush_list;
+}
+
+DEFINE_FREE(bpf_net_ctx_clear, struct bpf_net_context *, bpf_net_ctx_clear(_T));
 
 /* flags for bpf_redirect_info kern_flags */
 #define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
@@ -1018,25 +1083,23 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
 
-void bpf_clear_redirect_map(struct bpf_map *map);
-
 static inline bool xdp_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
 }
 
 static inline void xdp_set_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	ri->kern_flags |= BPF_RI_F_RF_NO_DIRECT;
 }
 
 static inline void xdp_clear_return_frame_no_direct(void)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	ri->kern_flags &= ~BPF_RI_F_RF_NO_DIRECT;
 }
@@ -1592,7 +1655,7 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
 						   u64 flags, const u64 flag_mask,
 						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	const u64 action_mask = XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
 
 	/* Lower bits of the flags are used as return code on lookup failure */
diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index e55010fa73296..091dc0b6bdfb9 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,4 +51,25 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
 
+DEFINE_GUARD(local_lock, local_lock_t __percpu*,
+	     local_lock(_T),
+	     local_unlock(_T))
+DEFINE_GUARD(local_lock_irq, local_lock_t __percpu*,
+	     local_lock_irq(_T),
+	     local_unlock_irq(_T))
+DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
+		    local_lock_irqsave(_T->lock, _T->flags),
+		    local_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
+#define local_lock_nested_bh(_lock)				\
+	__local_lock_nested_bh(_lock)
+
+#define local_unlock_nested_bh(_lock)				\
+	__local_unlock_nested_bh(_lock)
+
+DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
+	     local_lock_nested_bh(_T),
+	     local_unlock_nested_bh(_T))
+
 #endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 975e33b793a77..8dd71fbbb6d2b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -62,6 +62,17 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
 
+#define __spinlock_nested_bh_init(lock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_NORMAL);			\
+	local_lock_debug_init(lock);				\
+} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
@@ -98,6 +109,15 @@ do {								\
 		local_irq_restore(flags);			\
 	} while (0)
 
+#define __local_lock_nested_bh(lock)				\
+	do {							\
+		lockdep_assert_in_softirq();			\
+		local_lock_acquire(this_cpu_ptr(lock));	\
+	} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+	local_lock_release(this_cpu_ptr(lock))
+
 #else /* !CONFIG_PREEMPT_RT */
 
 /*
@@ -138,4 +158,15 @@ typedef spinlock_t local_lock_t;
 
 #define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
 
+#define __local_lock_nested_bh(lock)				\
+do {								\
+	lockdep_assert_in_softirq_func();			\
+	spin_lock(this_cpu_ptr(lock));				\
+} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+do {								\
+	spin_unlock(this_cpu_ptr((lock)));			\
+} while (0)
+
 #endif /* CONFIG_PREEMPT_RT */
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 5e51b0de4c4b5..fcc02812bf31e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -605,6 +605,8 @@ do {									\
 		     (!in_softirq() || in_irq() || in_nmi()));		\
 } while (0)
 
+extern void lockdep_assert_in_softirq_func(void);
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -618,6 +620,7 @@ do {									\
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
 # define lockdep_assert_in_softirq() do { } while (0)
+# define lockdep_assert_in_softirq_func() do { } while (0)
 #endif
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb887..f0ab89caf3cc2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3200,6 +3200,7 @@ static inline bool dev_has_header(const struct net_device *dev)
 struct softnet_data {
 	struct list_head	poll_list;
 	struct sk_buff_head	process_queue;
+	local_lock_t		process_queue_bh_lock;
 
 	/* stats */
 	unsigned int		processed;
@@ -3223,7 +3224,9 @@ struct softnet_data {
 #endif
 	/* written and read only by owning cpu: */
 	struct {
+#ifndef CONFIG_PREEMPT_RT
 		u16 recursion;
+#endif
 		u8  more;
 #ifdef CONFIG_NET_EGRESS
 		u8  skip_txqueue;
@@ -3256,10 +3259,19 @@ struct softnet_data {
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
 
+#ifdef CONFIG_PREEMPT_RT
+static inline int dev_recursion_level(void)
+{
+	return current->net_xmit_recursion;
+}
+
+#else
+
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
+#endif
 
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8fc2df6206f2d..8a77bc6fb9bb9 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -198,10 +198,10 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
-void console_replay_all(void);
+void console_try_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
-extern bool nbcon_driver_try_acquire(struct console *con);
-extern void nbcon_driver_release(struct console *con);
+extern bool nbcon_device_try_acquire(struct console *con);
+extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
@@ -282,7 +282,8 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
-static inline void console_replay_all(void)
+
+static inline void console_try_replay_all(void)
 {
 }
 
@@ -290,12 +291,12 @@ static inline void printk_legacy_allow_panic_sync(void)
 {
 }
 
-static inline bool nbcon_driver_try_acquire(struct console *con)
+static inline bool nbcon_device_try_acquire(struct console *con)
 {
 	return false;
 }
 
-static inline void nbcon_driver_release(struct console *con)
+static inline void nbcon_device_release(struct console *con)
 {
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 118ea3533d97d..bd2a568b22d05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -53,6 +53,7 @@ struct bio_list;
 struct blk_plug;
 struct bpf_local_storage;
 struct bpf_run_ctx;
+struct bpf_net_context;
 struct capture_control;
 struct cfs_rq;
 struct fs_struct;
@@ -975,7 +976,9 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
-
+#ifdef CONFIG_PREEMPT_RT
+	u8				net_xmit_recursion;
+#endif
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
 	struct restart_block		restart_block;
@@ -1506,6 +1509,8 @@ struct task_struct {
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
 #endif
+	/* Used by BPF for per-TASK xdp storage */
+	struct bpf_net_context		*bpf_net_context;
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	unsigned long			lowest_stack;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2b3d3aeb057b8..3c122d8bf6bf1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -10,9 +10,9 @@
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/lockdep.h>
 #include <linux/printk.h>
-#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
@@ -659,7 +659,7 @@ static inline bool __uart_port_nbcon_try_acquire(struct uart_port *up)
 	if (!__uart_port_using_nbcon(up))
 		return true;
 
-	return nbcon_driver_try_acquire(up->cons);
+	return nbcon_device_try_acquire(up->cons);
 }
 
 /* Only for internal port lock wrapper usage. */
@@ -668,7 +668,7 @@ static inline void __uart_port_nbcon_acquire(struct uart_port *up)
 	if (!__uart_port_using_nbcon(up))
 		return;
 
-	while (!nbcon_driver_try_acquire(up->cons))
+	while (!nbcon_device_try_acquire(up->cons))
 		cpu_relax();
 }
 
@@ -678,7 +678,7 @@ static inline void __uart_port_nbcon_release(struct uart_port *up)
 	if (!__uart_port_using_nbcon(up))
 		return;
 
-	nbcon_driver_release(up->cons);
+	nbcon_device_release(up->cons);
 }
 
 /**
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 2a536eea9424e..f88b682690127 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -93,17 +93,14 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 					   struct inet_timewait_death_row *dr,
 					   const int state);
 
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			 struct inet_hashinfo *hashinfo);
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo);
 
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
 
-static inline void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
-{
-	__inet_twsk_schedule(tw, timeo, false);
-}
-
 static inline void inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo)
 {
 	__inet_twsk_schedule(tw, timeo, true);
diff --git a/include/net/seg6_local.h b/include/net/seg6_local.h
index 3fab9dec2ec45..888c1ce6f5272 100644
--- a/include/net/seg6_local.h
+++ b/include/net/seg6_local.h
@@ -19,6 +19,7 @@ extern int seg6_lookup_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 extern bool seg6_bpf_has_valid_srh(struct sk_buff *skb);
 
 struct seg6_bpf_srh_state {
+	local_lock_t bh_lock;
 	struct ipv6_sr_hdr *srh;
 	u16 hdrlen;
 	bool valid;
diff --git a/include/net/sock.h b/include/net/sock.h
index 953c8dc4e259e..7d6784ebb26f5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -544,6 +544,11 @@ struct sock {
 	netns_tracker		ns_tracker;
 };
 
+struct sock_bh_locked {
+	struct sock *sock;
+	local_lock_t bh_lock;
+};
+
 enum sk_pacing {
 	SK_PACING_NONE		= 0,
 	SK_PACING_NEEDED	= 1,
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a8e34416e960f..068e994ed781a 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -79,8 +79,6 @@ struct bpf_cpu_map {
 	struct bpf_cpu_map_entry __rcu **cpu_map;
 };
 
-static DEFINE_PER_CPU(struct list_head, cpu_map_flush_list);
-
 static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 {
 	u32 value_size = attr->value_size;
@@ -240,12 +238,14 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 				int xdp_n, struct xdp_cpumap_stats *stats,
 				struct list_head *list)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int nframes;
 
 	if (!rcpu->prog)
 		return xdp_n;
 
 	rcu_read_lock_bh();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	nframes = cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
 
@@ -255,6 +255,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (unlikely(!list_empty(list)))
 		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
 
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
 
 	return nframes;
@@ -706,7 +707,7 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
  */
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 {
-	struct list_head *flush_list = this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq = this_cpu_ptr(rcpu->bulkq);
 
 	if (unlikely(bq->count == CPU_MAP_BULK_SIZE))
@@ -758,7 +759,7 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 
 void __cpu_map_flush(void)
 {
-	struct list_head *flush_list = this_cpu_ptr(&cpu_map_flush_list);
+	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq, *tmp;
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -772,20 +773,9 @@ void __cpu_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool cpu_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&cpu_map_flush_list)))
+	if (list_empty(bpf_net_ctx_get_cpu_map_flush_list()))
 		return false;
 	__cpu_map_flush();
 	return true;
 }
 #endif
-
-static int __init cpu_map_init(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(cpu_map_flush_list, cpu));
-	return 0;
-}
-
-subsys_initcall(cpu_map_init);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4e2cdbb5629f2..c8267ed580840 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -83,7 +83,6 @@ struct bpf_dtab {
 	u32 n_buckets;
 };
 
-static DEFINE_PER_CPU(struct list_head, dev_flush_list);
 static DEFINE_SPINLOCK(dev_map_lock);
 static LIST_HEAD(dev_map_list);
 
@@ -196,7 +195,14 @@ static void dev_map_free(struct bpf_map *map)
 	list_del_rcu(&dtab->list);
 	spin_unlock(&dev_map_lock);
 
-	bpf_clear_redirect_map(map);
+	/* bpf_redirect_info->map is assigned in __bpf_xdp_redirect_map()
+	 * during NAPI callback and cleared after the XDP redirect. There is no
+	 * explicit RCU read section which protects bpf_redirect_info->map but
+	 * local_bh_disable() also marks the beginning an RCU section. This
+	 * makes the complete softirq callback RCU protected. Thus after
+	 * following synchronize_rcu() there no bpf_redirect_info->map == map
+	 * assignment.
+	 */
 	synchronize_rcu();
 
 	/* Make sure prior __dev_map_entry_free() have completed. */
@@ -408,7 +414,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
  */
 void __dev_flush(void)
 {
-	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list = bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq, *tmp;
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -422,7 +428,7 @@ void __dev_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool dev_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&dev_flush_list)))
+	if (list_empty(bpf_net_ctx_get_dev_flush_list()))
 		return false;
 	__dev_flush();
 	return true;
@@ -453,7 +459,7 @@ static void *__dev_map_lookup_elem(struct bpf_map *map, u32 key)
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct list_head *flush_list = this_cpu_ptr(&dev_flush_list);
+	struct list_head *flush_list = bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
 
 	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
@@ -1156,15 +1162,11 @@ static struct notifier_block dev_map_notifier = {
 
 static int __init dev_map_init(void)
 {
-	int cpu;
-
 	/* Assure tracepoint shadow struct _bpf_dtab_netdev is in sync */
 	BUILD_BUG_ON(offsetof(struct bpf_dtab_netdev, dev) !=
 		     offsetof(struct _bpf_dtab_netdev, dev));
 	register_netdevice_notifier(&dev_map_notifier);
 
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(dev_flush_list, cpu));
 	return 0;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d83..f314bdd7e6108 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2355,6 +2355,7 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx = NULL;
 #endif
+	p->bpf_net_context =  NULL;
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 8475a0794f8c5..438c6086d540e 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -413,3 +413,11 @@ notrace int in_lock_functions(unsigned long addr)
 	&& addr < (unsigned long)__lock_text_end;
 }
 EXPORT_SYMBOL(in_lock_functions);
+
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_PREEMPT_RT)
+void notrace lockdep_assert_in_softirq_func(void)
+{
+	lockdep_assert_in_softirq();
+}
+EXPORT_SYMBOL(lockdep_assert_in_softirq_func);
+#endif
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 467a0b1dccbb1..48c3564f95ebe 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -85,6 +85,8 @@ bool printk_percpu_data_ready(void);
 
 void defer_console_output(void);
 
+bool is_printk_deferred(void);
+
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 void console_lock_spinning_enable(void);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 99818b819e417..bb9689f94d302 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -839,20 +839,20 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
 /**
- * nbcon_reacquire - Reacquire a console after losing ownership
- * @wctxt:	The write context that was handed to the write function
+ * nbcon_reacquire - Reacquire a console after losing ownership while printing
+ * @wctxt:	The write context that was handed to the write callback
  *
  * Since ownership can be lost at any time due to handover or takeover, a
- * printing context _should_ be prepared to back out immediately and
- * carefully. However, there are many scenarios where the context _must_
+ * printing context _must_ be prepared to back out immediately and
+ * carefully. However, there are scenarios where the printing context must
  * reacquire ownership in order to finalize or revert hardware changes.
  *
- * This function allows a context to reacquire ownership using the same
- * priority as its previous ownership.
+ * This function allows a printing context to reacquire ownership using the
+ * same priority as its previous ownership.
  *
- * Note that for printing contexts, after a successful reacquire the
- * context will have no output buffer because that has been lost. This
- * function cannot be used to resume printing.
+ * Note that after a successful reacquire the printing context will have no
+ * output buffer because that has been lost. This function cannot be used to
+ * resume printing.
  */
 void nbcon_reacquire(struct nbcon_write_context *wctxt)
 {
@@ -873,7 +873,7 @@ EXPORT_SYMBOL_GPL(nbcon_reacquire);
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
- * @use_atomic:	True if the write_atomic callback is to be used
+ * @use_atomic:	True if the write_atomic() callback is to be used
  *
  * Return:	True if this context still owns the console. False if
  *		ownership was handed over or taken.
@@ -980,7 +980,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	if (!wctxt->outbuf) {
 		/*
 		 * Ownership was lost and reacquired by the driver.
-		 * Handle it as if ownership was lost and try to continue.
+		 * Handle it as if ownership was lost.
 		 */
 		nbcon_context_release(ctxt);
 		return false;
@@ -1014,8 +1014,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 /**
  * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
  * @con:	Console to operate on
- * @ctxt:	The acquire context that contains the state
- *		at console_acquire()
+ * @ctxt:	The nbcon context from nbcon_context_try_acquire()
  *
  * Return:	True if the thread should shutdown or if the console is
  *		allowed to print and a record is available. False otherwise.
@@ -1049,6 +1048,8 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 /**
  * nbcon_kthread_func - The printer thread function
  * @__console:	Console to operate on
+ *
+ * Return:	0
  */
 static int nbcon_kthread_func(void *__console)
 {
@@ -1058,7 +1059,6 @@ static int nbcon_kthread_func(void *__console)
 		.ctxt.prio	= NBCON_PRIO_NORMAL,
 	};
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	unsigned long flags;
 	short con_flags;
 	bool backlog;
 	int cookie;
@@ -1094,7 +1094,9 @@ static int nbcon_kthread_func(void *__console)
 		con_flags = console_srcu_read_flags(con);
 
 		if (console_is_usable(con, con_flags, false)) {
-			con->device_lock(con, &flags);
+			unsigned long lock_flags;
+
+			con->device_lock(con, &lock_flags);
 
 			/*
 			 * Ensure this stays on the CPU to make handover and
@@ -1113,7 +1115,7 @@ static int nbcon_kthread_func(void *__console)
 				}
 			}
 
-			con->device_unlock(con, flags);
+			con->device_unlock(con, lock_flags);
 		}
 
 		console_srcu_read_unlock(cookie);
@@ -1227,7 +1229,7 @@ enum nbcon_prio nbcon_get_default_prio(void)
  * nbcon_emit_one - Print one record for an nbcon console using the
  *			specified callback
  * @wctxt:	An initialized write context struct to use for this context
- * @use_atomic:	True if the write_atomic callback is to be used
+ * @use_atomic:	True if the write_atomic() callback is to be used
  *
  * Return:	True, when a record has been printed and there are still
  *		pending records. The caller might want to continue flushing.
@@ -1272,7 +1274,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
  *		both the console_lock and the SRCU read lock. Otherwise it
  *		is set to false.
  * @cookie:	The cookie from the SRCU read lock.
- * @use_atomic:	True if the write_atomic callback is to be used
+ * @use_atomic:	True if the write_atomic() callback is to be used
  *
  * Context:	Any context except NMI.
  * Return:	True, when a record has been printed and there are still
@@ -1373,6 +1375,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 			return -EAGAIN;
 
 		if (!ctxt->backlog) {
+			/* Are there reserved but not yet finalized records? */
 			if (nbcon_seq_read(con) < stop_seq)
 				err = -ENOENT;
 			break;
@@ -1415,19 +1418,26 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	local_irq_restore(flags);
 
 	/*
-	 * If flushing was successful but more records are available this
-	 * context must flush those remaining records if the printer thread
-	 * is not available to do it.
+	 * If there was a new owner (-EPERM, -EAGAIN), that context is
+	 * responsible for completing.
+	 *
+	 * Do not wait for records not yet finalized (-ENOENT) to avoid a
+	 * possible deadlock. They will either get flushed by the writer or
+	 * eventually skipped on panic CPU.
 	 */
-	if (!err && !con->kthread && prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+	if (err)
+		return;
+
+	/*
+	 * If flushing was successful but more records are available, this
+	 * context must flush those remaining records if the printer thread
+	 * is not available do it.
+	 */
+	if ((!con->kthread || (system_state > SYSTEM_RUNNING)) &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		stop_seq = prb_next_reserve_seq(prb);
 		goto again;
 	}
-
-	/*
-	 * If there was a new owner, that context is responsible for
-	 * completing the flush.
-	 */
 }
 
 /**
@@ -1532,13 +1542,25 @@ void nbcon_cpu_emergency_exit(void)
 	 */
 	if (*cpu_emergency_nesting == 1) {
 		nbcon_atomic_flush_pending();
+
+		/*
+		 * Safely attempt to flush the legacy consoles in this
+		 * context. Otherwise an irq_work context is triggered
+		 * to handle it.
+		 */
 		do_trigger_flush = true;
+		if (!force_printkthreads() &&
+		    printing_via_unlock &&
+		    !is_printk_deferred()) {
+			if (console_trylock()) {
+				do_trigger_flush = false;
+				console_unlock();
+			}
+		}
 	}
 
-	(*cpu_emergency_nesting)--;
-
-	if (WARN_ON_ONCE(*cpu_emergency_nesting < 0))
-		*cpu_emergency_nesting = 0;
+	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
+		(*cpu_emergency_nesting)--;
 
 	preempt_enable();
 
@@ -1559,13 +1581,26 @@ void nbcon_cpu_emergency_exit(void)
  */
 void nbcon_cpu_emergency_flush(void)
 {
+	bool is_emergency;
+
+	/*
+	 * If this context is not an emergency context, preemption might be
+	 * enabled. To be sure, disable preemption when checking if this is
+	 * an emergency context.
+	 */
+	preempt_disable();
+	is_emergency = (*nbcon_get_cpu_emergency_nesting() != 0);
+	preempt_enable();
+
 	/* The explicit flush is needed only in the emergency context. */
-	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
+	if (!is_emergency)
 		return;
 
 	nbcon_atomic_flush_pending();
 
-	if (printing_via_unlock && !in_nmi()) {
+	if (!force_printkthreads() &&
+	    printing_via_unlock &&
+	    !is_printk_deferred()) {
 		if (console_trylock())
 			console_unlock();
 	}
@@ -1715,12 +1750,13 @@ void nbcon_free(struct console *con)
 }
 
 /**
- * nbcon_driver_try_acquire - Try to acquire nbcon console and enter unsafe
+ * nbcon_device_try_acquire - Try to acquire nbcon console and enter unsafe
  *				section
  * @con:	The nbcon console to acquire
  *
  * Context:	Under the locking mechanism implemented in
  *		@con->device_lock() including disabling migration.
+ * Return:	True if the console was acquired. False otherwise.
  *
  * Console drivers will usually use their own internal synchronization
  * mechasism to synchronize between console printing and non-printing
@@ -1732,9 +1768,9 @@ void nbcon_free(struct console *con)
  * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
  * and marks it unsafe for handover/takeover.
  */
-bool nbcon_driver_try_acquire(struct console *con)
+bool nbcon_device_try_acquire(struct console *con)
 {
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_driver_ctxt);
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
 
 	cant_migrate();
 
@@ -1750,15 +1786,15 @@ bool nbcon_driver_try_acquire(struct console *con)
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(nbcon_driver_try_acquire);
+EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 
 /**
- * nbcon_driver_release - Exit unsafe section and release the nbcon console
- * @con:	The nbcon console acquired in nbcon_driver_try_acquire()
+ * nbcon_device_release - Exit unsafe section and release the nbcon console
+ * @con:	The nbcon console acquired in nbcon_device_try_acquire()
  */
-void nbcon_driver_release(struct console *con)
+void nbcon_device_release(struct console *con)
 {
-	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_driver_ctxt);
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
 	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
@@ -1773,13 +1809,13 @@ void nbcon_driver_release(struct console *con)
 	 */
 	cookie = console_srcu_read_lock();
 	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
-	    !con->kthread &&
+	    (!con->kthread || (system_state > SYSTEM_RUNNING)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 	}
 	console_srcu_read_unlock(cookie);
 }
-EXPORT_SYMBOL_GPL(nbcon_driver_release);
+EXPORT_SYMBOL_GPL(nbcon_device_release);
 
 /**
  * printk_kthread_shutdown - shutdown all threaded printers
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 10f305557e67d..f2ac7aaab2342 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2356,8 +2356,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	bool do_trylock_unlock = printing_via_unlock &&
-				 !force_printkthreads();
+	bool do_trylock_unlock = !force_printkthreads() &&
+				 printing_via_unlock;
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
@@ -2782,8 +2782,9 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen && printing_via_unlock &&
-	    !force_printkthreads()) {
+	if (!force_printkthreads() &&
+	    !cpuhp_tasks_frozen &&
+	    printing_via_unlock) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -3493,10 +3494,10 @@ EXPORT_SYMBOL(console_stop);
 void console_start(struct console *console)
 {
 	short flags;
+	int cookie;
 
 	console_list_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
-	flags = console->flags;
 	console_list_unlock();
 
 	/*
@@ -3506,10 +3507,13 @@ void console_start(struct console *console)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	cookie = console_srcu_read_lock();
+	flags = console_srcu_read_flags(console);
 	if (flags & CON_NBCON)
 		nbcon_kthread_wake(console);
 	else
 		wake_up_legacy_kthread();
+	console_srcu_read_unlock(cookie);
 
 	__pr_flush(console, 1000, true);
 }
@@ -3537,7 +3541,7 @@ static bool printer_should_wake(void)
 		if ((flags & CON_NBCON) && con->kthread)
 			continue;
 
-		if (!console_is_usable(con, flags, true))
+		if (!console_is_usable(con, flags, false))
 			continue;
 
 		if (flags & CON_NBCON) {
@@ -3806,9 +3810,10 @@ static int unregister_console_locked(struct console *console);
  */
 void register_console(struct console *newcon)
 {
-	struct console *con;
+	bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;
 	bool bootcon_registered = false;
 	bool realcon_registered = false;
+	struct console *con;
 	unsigned long flags;
 	u64 init_seq;
 	int err;
@@ -3912,7 +3917,7 @@ void register_console(struct console *newcon)
 	 * Use the driver synchronization to ensure that the hardware is not
 	 * in use while this new console transitions to being registered.
 	 */
-	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+	if (use_device_lock)
 		newcon->device_lock(newcon, &flags);
 
 	/*
@@ -3940,7 +3945,7 @@ void register_console(struct console *newcon)
 	 */
 
 	/* This new console is now registered. */
-	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
+	if (use_device_lock)
 		newcon->device_unlock(newcon, flags);
 
 	console_sysfs_notify();
@@ -3971,6 +3976,7 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
 	bool is_boot_con = (console->flags & CON_BOOT);
 	bool found_legacy_con = false;
 	bool found_nbcon_con = false;
@@ -3999,12 +4005,12 @@ static int unregister_console_locked(struct console *console)
 	 * Use the driver synchronization to ensure that the hardware is not
 	 * in use while this console transitions to being unregistered.
 	 */
-	if ((console->flags & CON_NBCON) && console->write_atomic)
+	if (use_device_lock)
 		console->device_lock(console, &flags);
 
 	hlist_del_init_rcu(&console->node);
 
-	if ((console->flags & CON_NBCON) && console->write_atomic)
+	if (use_device_lock)
 		console->device_unlock(console, flags);
 
 	/*
@@ -4233,7 +4239,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	 * Otherwise this function will just wait for the threaded printers
 	 * to print up to @seq.
 	 */
-	if (printing_via_unlock && !force_printkthreads()) {
+	if (printing_via_unlock) {
 		console_lock();
 		console_unlock();
 	}
@@ -4765,18 +4771,19 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 /**
- * console_replay_all - replay kernel log on consoles
+ * console_try_replay_all - try to replay kernel log on consoles
  *
  * Try to obtain lock on console subsystem and replay all
  * available records in printk buffer on the consoles.
  * Does nothing if lock is not obtained.
  *
- * Context: Any context.
+ * Context: Any, except for NMI.
  */
-void console_replay_all(void)
+void console_try_replay_all(void)
 {
 	if (console_trylock()) {
 		__console_rewind_all();
+		nbcon_wake_threads();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 4421ccac31133..f47fef7012652 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,6 +38,15 @@ void __printk_deferred_exit(void)
 	__printk_safe_exit();
 }
 
+bool is_printk_deferred(void)
+{
+	/*
+	 * The per-CPU variable @printk_context can be read safely in any
+	 * context. The CPU migration always disabled when set.
+	 */
+	return (this_cpu_read(printk_context) || in_nmi());
+}
+
 asmlinkage int vprintk(const char *fmt, va_list args)
 {
 #ifdef CONFIG_KGDB_KDB
@@ -50,7 +59,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi())
+	if (is_printk_deferred())
 		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 923f80159315c..6ece151d0aa2a 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -616,7 +616,6 @@ static void synchronize_rcu_expedited_wait(void)
 			}
 			pr_cont("\n");
 		}
-		nbcon_cpu_emergency_flush();
 		rcu_for_each_leaf_node(rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
@@ -625,6 +624,7 @@ static void synchronize_rcu_expedited_wait(void)
 				preempt_disable(); // For smp_processor_id() in dump_cpu_task().
 				dump_cpu_task(cpu);
 				preempt_enable();
+				nbcon_cpu_emergency_flush();
 			}
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f6aad4ed2ab2f..600cc8e428c1a 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -283,9 +283,10 @@ static int xdp_recv_frames(struct xdp_frame **frames, int nframes,
 static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 			      u32 repeat)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int err = 0, act, ret, i, nframes = 0, batch_sz;
 	struct xdp_frame **frames = xdp->frames;
+	struct bpf_redirect_info *ri;
 	struct xdp_page_head *head;
 	struct xdp_frame *frm;
 	bool redirect = false;
@@ -295,6 +296,8 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	batch_sz = min_t(u32, repeat, xdp->batch_size);
 
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
 	xdp_set_return_frame_no_direct();
 
 	for (i = 0; i < batch_sz; i++) {
@@ -359,6 +362,7 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
 	}
 
 	xdp_clear_return_frame_no_direct();
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 	return err;
 }
@@ -394,6 +398,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 			u32 *retval, u32 *time, bool xdp)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
@@ -419,10 +424,14 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	do {
 		run_ctx.prog_item = &item;
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 		if (xdp)
 			*retval = bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval = bpf_prog_run(prog, ctx);
+
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, time));
 	bpf_reset_run_ctx(old_ctx);
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index bf30c50b56895..9596ad19224ad 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -137,6 +137,7 @@ static inline bool is_pppoe_ipv6(const struct sk_buff *skb,
 #define NF_BRIDGE_MAX_MAC_HEADER_LENGTH (PPPOE_SES_HLEN + ETH_HLEN)
 
 struct brnf_frag_data {
+	local_lock_t bh_lock;
 	char mac[NF_BRIDGE_MAX_MAC_HEADER_LENGTH];
 	u8 encap_size;
 	u8 size;
@@ -144,7 +145,9 @@ struct brnf_frag_data {
 	__be16 vlan_proto;
 };
 
-static DEFINE_PER_CPU(struct brnf_frag_data, brnf_frag_data_storage);
+static DEFINE_PER_CPU(struct brnf_frag_data, brnf_frag_data_storage) = {
+	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
+};
 
 static void nf_bridge_info_free(struct sk_buff *skb)
 {
@@ -882,6 +885,7 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
+		guard(local_lock_nested_bh)(&brnf_frag_data_storage.bh_lock);
 		data = this_cpu_ptr(&brnf_frag_data_storage);
 
 		if (skb_vlan_tag_present(skb)) {
@@ -909,6 +913,7 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
+		guard(local_lock_nested_bh)(&brnf_frag_data_storage.bh_lock);
 		data = this_cpu_ptr(&brnf_frag_data_storage);
 		data->encap_size = nf_bridge_encap_header_len(skb);
 		data->size = ETH_HLEN + data->encap_size;
diff --git a/net/core/dev.c b/net/core/dev.c
index e1bb6d7856d92..363dfa7a7986d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -229,7 +229,7 @@ static inline void backlog_lock_irq_save(struct softnet_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_save(*flags);
 }
 
@@ -237,7 +237,7 @@ static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_disable();
 }
 
@@ -246,7 +246,7 @@ static inline void backlog_unlock_irq_restore(struct softnet_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_restore(*flags);
 }
 
@@ -254,7 +254,7 @@ static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_enable();
 }
 
@@ -449,7 +449,9 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
  *	queue in the local softnet handler.
  */
 
-DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data) = {
+	.process_queue_bh_lock = INIT_LOCAL_LOCK(process_queue_bh_lock),
+};
 EXPORT_PER_CPU_SYMBOL(softnet_data);
 
 /* Page_pool has a lockless array/stack to alloc/recycle pages.
@@ -4028,11 +4030,15 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
+	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) = NULL;
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
+	struct bpf_net_context __bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
+
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	if (*pt_prev) {
 		*ret = deliver_skb(skb, *pt_prev, orig_dev);
 		*pt_prev = NULL;
@@ -4083,13 +4089,17 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 static __always_inline struct sk_buff *
 sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
+	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) = NULL;
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
+	struct bpf_net_context __bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -5934,6 +5944,7 @@ static void flush_backlog(struct work_struct *work)
 	}
 	backlog_unlock_irq_enable(sd);
 
+	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
@@ -5941,6 +5952,7 @@ static void flush_backlog(struct work_struct *work)
 			rps_input_queue_head_incr(sd);
 		}
 	}
+	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
 }
 
@@ -6062,7 +6074,9 @@ static int process_backlog(struct napi_struct *napi, int quota)
 	while (again) {
 		struct sk_buff *skb;
 
+		local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 		while ((skb = __skb_dequeue(&sd->process_queue))) {
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
@@ -6071,7 +6085,9 @@ static int process_backlog(struct napi_struct *napi, int quota)
 				return work;
 			}
 
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 		}
+		local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 
 		backlog_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
@@ -6086,8 +6102,10 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			napi->state &= NAPIF_STATE_THREADED;
 			again = false;
 		} else {
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 		}
 		backlog_unlock_irq_enable(sd);
 	}
@@ -6348,11 +6366,11 @@ static void __napi_busy_loop(unsigned int napi_id,
 {
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	void *have_poll_lock = NULL;
 	struct napi_struct *napi;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
-
 restart:
 	napi_poll = NULL;
 
@@ -6366,6 +6384,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		int work = 0;
 
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		if (!napi_poll) {
 			unsigned long val = READ_ONCE(napi->state);
 
@@ -6396,6 +6415,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
 		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
 		if (!loop_end || loop_end(loop_end_arg, start_time))
@@ -6823,6 +6843,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 
 static void napi_threaded_poll_loop(struct napi_struct *napi)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
 	unsigned long last_qs = jiffies;
 
@@ -6831,6 +6852,8 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		void *have;
 
 		local_bh_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+
 		sd = this_cpu_ptr(&softnet_data);
 		sd->in_napi_threaded_poll = true;
 
@@ -6846,6 +6869,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 			net_rps_action_and_irq_enable(sd);
 		}
 		skb_defer_free_flush(sd);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
 		if (!repoll)
@@ -6868,13 +6892,16 @@ static int napi_threaded_poll(void *data)
 
 static __latent_entropy void net_rx_action(struct softirq_action *h)
 {
+	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) = NULL;
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies +
 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
 	int budget = READ_ONCE(net_hotdata.netdev_budget);
+	struct bpf_net_context __bpf_net_ctx;
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 start:
 	sd->in_net_rx_action = true;
 	local_irq_disable();
diff --git a/net/core/dev.h b/net/core/dev.h
index b7b518bc2be55..2f96d63053ad0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,6 +150,25 @@ struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
+
+#ifdef CONFIG_PREEMPT_RT
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(current->net_xmit_recursion > XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	current->net_xmit_recursion++;
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	current->net_xmit_recursion--;
+}
+
+#else
+
 static inline bool dev_xmit_recursion(void)
 {
 	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
@@ -165,5 +184,6 @@ static inline void dev_xmit_recursion_dec(void)
 {
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
+#endif
 
 #endif
diff --git a/net/core/filter.c b/net/core/filter.c
index 2510464692af0..64a1696a52920 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1658,9 +1658,12 @@ struct bpf_scratchpad {
 		__be32 diff[MAX_BPF_STACK / sizeof(__be32)];
 		u8     buff[MAX_BPF_STACK];
 	};
+	local_lock_t	bh_lock;
 };
 
-static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp);
+static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp) = {
+	.bh_lock	= INIT_LOCAL_LOCK(bh_lock),
+};
 
 static inline int __bpf_try_make_writable(struct sk_buff *skb,
 					  unsigned int write_len)
@@ -2029,6 +2032,7 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
 		     diff_size > sizeof(sp->diff)))
 		return -EINVAL;
 
+	guard(local_lock_nested_bh)(&bpf_sp.bh_lock);
 	for (i = 0; i < from_size / sizeof(__be32); i++, j++)
 		sp->diff[j] = ~from[i];
 	for (i = 0; i <   to_size / sizeof(__be32); i++, j++)
@@ -2471,9 +2475,6 @@ static const struct bpf_func_proto bpf_clone_redirect_proto = {
 	.arg3_type      = ARG_ANYTHING,
 };
 
-DEFINE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
-EXPORT_PER_CPU_SYMBOL_GPL(bpf_redirect_info);
-
 static struct net_device *skb_get_peer_dev(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
@@ -2486,7 +2487,7 @@ static struct net_device *skb_get_peer_dev(struct net_device *dev)
 
 int skb_do_redirect(struct sk_buff *skb)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct net *net = dev_net(skb->dev);
 	struct net_device *dev;
 	u32 flags = ri->flags;
@@ -2519,7 +2520,7 @@ int skb_do_redirect(struct sk_buff *skb)
 
 BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return TC_ACT_SHOT;
@@ -2540,7 +2541,7 @@ static const struct bpf_func_proto bpf_redirect_proto = {
 
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags))
 		return TC_ACT_SHOT;
@@ -2562,7 +2563,7 @@ static const struct bpf_func_proto bpf_redirect_peer_proto = {
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, params,
 	   int, plen, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely((plen && plen < sizeof(*params)) || flags))
 		return TC_ACT_SHOT;
@@ -4288,30 +4289,13 @@ void xdp_do_check_flushed(struct napi_struct *napi)
 }
 #endif
 
-void bpf_clear_redirect_map(struct bpf_map *map)
-{
-	struct bpf_redirect_info *ri;
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		ri = per_cpu_ptr(&bpf_redirect_info, cpu);
-		/* Avoid polluting remote cacheline due to writes if
-		 * not needed. Once we pass this test, we need the
-		 * cmpxchg() to make sure it hasn't been changed in
-		 * the meantime by remote CPU.
-		 */
-		if (unlikely(READ_ONCE(ri->map) == map))
-			cmpxchg(&ri->map, map, NULL);
-	}
-}
-
 DEFINE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
 EXPORT_SYMBOL_GPL(bpf_master_redirect_enabled_key);
 
 u32 xdp_master_redirect(struct xdp_buff *xdp)
 {
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct net_device *master, *slave;
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 
 	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
 	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
@@ -4383,7 +4367,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 			map = READ_ONCE(ri->map);
 
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err = -ENOENT;
@@ -4428,7 +4412,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 		    struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
@@ -4442,7 +4426,7 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect);
 int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
 			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 
 	if (map_type == BPF_MAP_TYPE_XSKMAP)
@@ -4459,7 +4443,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 				       enum bpf_map_type map_type, u32 map_id,
 				       u32 flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	struct bpf_map *map;
 	int err;
 
@@ -4471,7 +4455,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 			map = READ_ONCE(ri->map);
 
 			/* The map pointer is cleared when the map is being torn
-			 * down by bpf_clear_redirect_map()
+			 * down by dev_map_free()
 			 */
 			if (unlikely(!map)) {
 				err = -ENOENT;
@@ -4513,7 +4497,7 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
 int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 	enum bpf_map_type map_type = ri->map_type;
 	void *fwd = ri->tgt_value;
 	u32 map_id = ri->map_id;
@@ -4549,7 +4533,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {
-	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
+	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
 	if (unlikely(flags))
 		return XDP_ABORTED;
@@ -6450,6 +6434,7 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
 	void *srh_tlvs, *srh_end, *ptr;
 	int srhoff = 0;
 
+	lockdep_assert_held(&srh_state->bh_lock);
 	if (srh == NULL)
 		return -EINVAL;
 
@@ -6506,6 +6491,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 	int hdroff = 0;
 	int err;
 
+	lockdep_assert_held(&srh_state->bh_lock);
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_X:
 		if (!seg6_bpf_has_valid_srh(skb))
@@ -6582,6 +6568,7 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 	int srhoff = 0;
 	int ret;
 
+	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh == NULL))
 		return -EINVAL;
 
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 4a0797f0a154b..afb05f58b64c5 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -38,13 +38,14 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int ret;
 
-	/* Migration disable and BH disable are needed to protect per-cpu
-	 * redirect_info between BPF prog and skb_do_redirect().
+	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
+	 * BPF prog and skb_do_redirect().
 	 */
-	migrate_disable();
 	local_bh_disable();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
 
@@ -77,8 +78,8 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		break;
 	}
 
+	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
-	migrate_enable();
 
 	return ret;
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e6..b33bae4ba78b6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -277,6 +277,7 @@ static void *page_frag_alloc_1k(struct page_frag_1k *nc, gfp_t gfp_mask)
 #endif
 
 struct napi_alloc_cache {
+	local_lock_t bh_lock;
 	struct page_frag_cache page;
 	struct page_frag_1k page_small;
 	unsigned int skb_count;
@@ -284,7 +285,9 @@ struct napi_alloc_cache {
 };
 
 static DEFINE_PER_CPU(struct page_frag_cache, netdev_alloc_cache);
-static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache);
+static DEFINE_PER_CPU(struct napi_alloc_cache, napi_alloc_cache) = {
+	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
+};
 
 /* Double check that napi_get_frags() allocates skbs with
  * skb->head being backed by slab, not a page fragment.
@@ -308,6 +311,7 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 
 	fragsz = SKB_DATA_ALIGN(fragsz);
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 
 	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
 				       align_mask);
@@ -318,19 +322,15 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 {
 	void *data;
 
-	fragsz = SKB_DATA_ALIGN(fragsz);
 	if (in_hardirq() || irqs_disabled()) {
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
+		fragsz = SKB_DATA_ALIGN(fragsz);
 		data = __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
 					       align_mask);
 	} else {
-		struct napi_alloc_cache *nc;
-
 		local_bh_disable();
-		nc = this_cpu_ptr(&napi_alloc_cache);
-		data = __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
-					       align_mask);
+		data = __napi_alloc_frag_align(fragsz, align_mask);
 		local_bh_enable();
 	}
 	return data;
@@ -342,6 +342,7 @@ static struct sk_buff *napi_skb_cache_get(void)
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
 
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
 						      GFP_ATOMIC,
@@ -744,9 +745,13 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 		pfmemalloc = nc->pfmemalloc;
 	} else {
 		local_bh_disable();
+		local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+
 		nc = this_cpu_ptr(&napi_alloc_cache.page);
 		data = page_frag_alloc(nc, len, gfp_mask);
 		pfmemalloc = nc->pfmemalloc;
+
+		local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 		local_bh_enable();
 	}
 
@@ -810,11 +815,11 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 		goto skb_success;
 	}
 
-	nc = this_cpu_ptr(&napi_alloc_cache);
-
 	if (sk_memalloc_socks())
 		gfp_mask |= __GFP_MEMALLOC;
 
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+	nc = this_cpu_ptr(&napi_alloc_cache);
 	if (NAPI_HAS_SMALL_PAGE_FRAG && len <= SKB_WITH_OVERHEAD(1024)) {
 		/* we are artificially inflating the allocation size, but
 		 * that is not as bad as it may look like, as:
@@ -836,6 +841,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 		data = page_frag_alloc(&nc->page, len, gfp_mask);
 		pfmemalloc = nc->page.pfmemalloc;
 	}
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 
 	if (unlikely(!data))
 		return NULL;
@@ -1433,6 +1439,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	if (!kasan_mempool_poison_object(skb))
 		return;
 
+	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 	nc->skb_cache[nc->skb_count++] = skb;
 
 	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
index 251a57cf58223..deb52d7d31b48 100644
--- a/net/dccp/minisocks.c
+++ b/net/dccp/minisocks.c
@@ -59,11 +59,10 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
-		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
+		inet_twsk_hashdance_schedule(tw, sk, &dccp_hashinfo, timeo);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e28075f0006e3..a70a3a16eea0b 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -92,13 +92,22 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
 	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
+static void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
+{
+	__inet_twsk_schedule(tw, timeo, false);
+}
+
 /*
  * Enter the time wait state. This is called with locally disabled BH.
  * Essentially we whip up a timewait bucket, copy the relevant info into it
  * from the SK, and mess with hash chains and list linkage.
+ *
+ * The caller must not access @tw anymore after this function returns.
  */
-void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
-			   struct inet_hashinfo *hashinfo)
+void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
+				  struct sock *sk,
+				  struct inet_hashinfo *hashinfo,
+				  int timeo)
 {
 	const struct inet_sock *inet = inet_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
@@ -129,26 +138,33 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
+	/* Step 2: Hash TW into tcp ehash chain */
 	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 
-	spin_unlock(lock);
 
+	/* Ensure above writes are committed into memory before updating the
+	 * refcount.
+	 * Provides ordering vs later refcount_inc().
+	 */
+	smp_wmb();
 	/* tw_refcnt is set to 3 because we have :
 	 * - one reference for bhash chain.
 	 * - one reference for ehash chain.
 	 * - one reference for timer.
-	 * We can use atomic_set() because prior spin_lock()/spin_unlock()
-	 * committed into memory all tw fields.
 	 * Also note that after this point, we lost our implicit reference
 	 * so we are not allowed to use tw anymore.
 	 */
 	refcount_set(&tw->tw_refcnt, 3);
+
+	inet_twsk_schedule(tw, timeo);
+
+	spin_unlock(lock);
 }
-EXPORT_SYMBOL_GPL(inet_twsk_hashdance);
+EXPORT_SYMBOL_GPL(inet_twsk_hashdance_schedule);
 
 static void tw_timer_handler(struct timer_list *t)
 {
@@ -192,7 +208,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		tw->tw_prot	    = sk->sk_prot_creator;
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
-		timer_setup(&tw->tw_timer, tw_timer_handler, TIMER_PINNED);
+		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
@@ -217,7 +233,34 @@ EXPORT_SYMBOL_GPL(inet_twsk_alloc);
  */
 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
 {
-	if (del_timer_sync(&tw->tw_timer))
+	struct inet_hashinfo *hashinfo = tw->tw_dr->hashinfo;
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+
+	/* inet_twsk_purge() walks over all sockets, including tw ones,
+	 * and removes them via inet_twsk_deschedule_put() after a
+	 * refcount_inc_not_zero().
+	 *
+	 * inet_twsk_hashdance_schedule() must (re)init the refcount before
+	 * arming the timer, i.e. inet_twsk_purge can obtain a reference to
+	 * a twsk that did not yet schedule the timer.
+	 *
+	 * The ehash lock synchronizes these two:
+	 * After acquiring the lock, the timer is always scheduled (else
+	 * timer_shutdown returns false), because hashdance_schedule releases
+	 * the ehash lock only after completing the timer initialization.
+	 *
+	 * Without grabbing the ehash lock, we get:
+	 * 1) cpu x sets twsk refcount to 3
+	 * 2) cpu y bumps refcount to 4
+	 * 3) cpu y calls inet_twsk_deschedule_put() and shuts timer down
+	 * 4) cpu x tries to start timer, but mod_timer is a noop post-shutdown
+	 * -> timer refcount is never decremented.
+	 */
+	spin_lock(lock);
+	/*  Makes sure hashdance_schedule() has completed */
+	spin_unlock(lock);
+
+	if (timer_shutdown_sync(&tw->tw_timer))
 		inet_twsk_kill(tw);
 	inet_twsk_put(tw);
 }
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b710958393e64..40227a9643966 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -93,7 +93,9 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 struct inet_hashinfo tcp_hashinfo;
 EXPORT_SYMBOL(tcp_hashinfo);
 
-static DEFINE_PER_CPU(struct sock *, ipv4_tcp_sk);
+static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) = {
+	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
+};
 
 static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 {
@@ -885,7 +887,9 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	arg.tos = ip_hdr(skb)->tos;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ctl_sk = this_cpu_read(ipv4_tcp_sk);
+	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
+	ctl_sk = this_cpu_read(ipv4_tcp_sk.sock);
+
 	sock_net_set(ctl_sk, net);
 	if (sk) {
 		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
@@ -910,6 +914,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
+	local_unlock_nested_bh(&ipv4_tcp_sk.bh_lock);
 	local_bh_enable();
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -1005,7 +1010,8 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	arg.tos = tos;
 	arg.uid = sock_net_uid(net, sk_fullsock(sk) ? sk : NULL);
 	local_bh_disable();
-	ctl_sk = this_cpu_read(ipv4_tcp_sk);
+	local_lock_nested_bh(&ipv4_tcp_sk.bh_lock);
+	ctl_sk = this_cpu_read(ipv4_tcp_sk.sock);
 	sock_net_set(ctl_sk, net);
 	ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
 			   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
@@ -1020,6 +1026,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 
 	sock_net_set(ctl_sk, &init_net);
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
+	local_unlock_nested_bh(&ipv4_tcp_sk.bh_lock);
 	local_bh_enable();
 }
 
@@ -3620,7 +3627,7 @@ void __init tcp_v4_init(void)
 		 */
 		inet_sk(sk)->pmtudisc = IP_PMTUDISC_DO;
 
-		per_cpu(ipv4_tcp_sk, cpu) = sk;
+		per_cpu(ipv4_tcp_sk.sock, cpu) = sk;
 	}
 	if (register_pernet_subsys(&tcp_sk_ops))
 		panic("Failed to create the TCP control socket.\n");
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 538c06f95918d..47de6f3efc857 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -344,11 +344,10 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		 * we complete the initialization.
 		 */
 		local_bh_disable();
-		inet_twsk_schedule(tw, timeo);
 		/* Linkage updates.
 		 * Note that access to tw after this point is illegal.
 		 */
-		inet_twsk_hashdance(tw, sk, net->ipv4.tcp_death_row.hashinfo);
+		inet_twsk_hashdance_schedule(tw, sk, net->ipv4.tcp_death_row.hashinfo, timeo);
 		local_bh_enable();
 	} else {
 		/* Sorry, if we're out of memory, just CLOSE this
diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
index 8512cb09ebc09..d8a4f192873a2 100644
--- a/net/ipv4/tcp_sigpool.c
+++ b/net/ipv4/tcp_sigpool.c
@@ -10,7 +10,14 @@
 #include <net/tcp.h>
 
 static size_t __scratch_size;
-static DEFINE_PER_CPU(void __rcu *, sigpool_scratch);
+struct sigpool_scratch {
+	local_lock_t bh_lock;
+	void __rcu *pad;
+};
+
+static DEFINE_PER_CPU(struct sigpool_scratch, sigpool_scratch) = {
+	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
+};
 
 struct sigpool_entry {
 	struct crypto_ahash	*hash;
@@ -72,7 +79,7 @@ static int sigpool_reserve_scratch(size_t size)
 			break;
 		}
 
-		old_scratch = rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
+		old_scratch = rcu_replace_pointer(per_cpu(sigpool_scratch.pad, cpu),
 					scratch, lockdep_is_held(&cpool_mutex));
 		if (!cpu_online(cpu) || !old_scratch) {
 			kfree(old_scratch);
@@ -93,7 +100,7 @@ static void sigpool_scratch_free(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		kfree(rcu_replace_pointer(per_cpu(sigpool_scratch, cpu),
+		kfree(rcu_replace_pointer(per_cpu(sigpool_scratch.pad, cpu),
 					  NULL, lockdep_is_held(&cpool_mutex)));
 	__scratch_size = 0;
 }
@@ -277,7 +284,8 @@ int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acquires(RC
 	/* Pairs with tcp_sigpool_reserve_scratch(), scratch area is
 	 * valid (allocated) until tcp_sigpool_end().
 	 */
-	c->scratch = rcu_dereference_bh(*this_cpu_ptr(&sigpool_scratch));
+	local_lock_nested_bh(&sigpool_scratch.bh_lock);
+	c->scratch = rcu_dereference_bh(*this_cpu_ptr(&sigpool_scratch.pad));
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_sigpool_start);
@@ -286,6 +294,7 @@ void tcp_sigpool_end(struct tcp_sigpool *c) __releases(RCU_BH)
 {
 	struct crypto_ahash *hash = crypto_ahash_reqtfm(c->req);
 
+	local_unlock_nested_bh(&sigpool_scratch.bh_lock);
 	rcu_read_unlock_bh();
 	ahash_request_free(c->req);
 	crypto_free_ahash(hash);
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 24e2b4b494cb0..c4828c6620f07 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1380,7 +1380,9 @@ static int input_action_end_b6_encap(struct sk_buff *skb,
 	return err;
 }
 
-DEFINE_PER_CPU(struct seg6_bpf_srh_state, seg6_bpf_srh_states);
+DEFINE_PER_CPU(struct seg6_bpf_srh_state, seg6_bpf_srh_states) = {
+	.bh_lock	= INIT_LOCAL_LOCK(bh_lock),
+};
 
 bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
 {
@@ -1388,6 +1390,7 @@ bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
 		this_cpu_ptr(&seg6_bpf_srh_states);
 	struct ipv6_sr_hdr *srh = srh_state->srh;
 
+	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh == NULL))
 		return false;
 
@@ -1408,8 +1411,7 @@ bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
 static int input_action_end_bpf(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
-	struct seg6_bpf_srh_state *srh_state =
-		this_cpu_ptr(&seg6_bpf_srh_states);
+	struct seg6_bpf_srh_state *srh_state;
 	struct ipv6_sr_hdr *srh;
 	int ret;
 
@@ -1420,10 +1422,14 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	}
 	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
 
-	/* preempt_disable is needed to protect the per-CPU buffer srh_state,
-	 * which is also accessed by the bpf_lwt_seg6_* helpers
+	/* The access to the per-CPU buffer srh_state is protected by running
+	 * always in softirq context (with disabled BH). On PREEMPT_RT the
+	 * required locking is provided by the following local_lock_nested_bh()
+	 * statement. It is also accessed by the bpf_lwt_seg6_* helpers via
+	 * bpf_prog_run_save_cb().
 	 */
-	preempt_disable();
+	local_lock_nested_bh(&seg6_bpf_srh_states.bh_lock);
+	srh_state = this_cpu_ptr(&seg6_bpf_srh_states);
 	srh_state->srh = srh;
 	srh_state->hdrlen = srh->hdrlen << 3;
 	srh_state->valid = true;
@@ -1446,15 +1452,15 @@ static int input_action_end_bpf(struct sk_buff *skb,
 
 	if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 		goto drop;
+	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 
-	preempt_enable();
 	if (ret != BPF_REDIRECT)
 		seg6_lookup_nexthop(skb, NULL, 0);
 
 	return dst_input(skb);
 
 drop:
-	preempt_enable();
+	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 	kfree_skb(skb);
 	return -EINVAL;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 727aa20be4bde..8b0b557408fc2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -35,8 +35,6 @@
 #define TX_BATCH_SIZE 32
 #define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
 
-static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
-
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
 {
 	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
@@ -375,7 +373,7 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	struct list_head *flush_list = this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list = bpf_net_ctx_get_xskmap_flush_list();
 	int err;
 
 	err = xsk_rcv(xs, xdp);
@@ -390,7 +388,7 @@ int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 
 void __xsk_map_flush(void)
 {
-	struct list_head *flush_list = this_cpu_ptr(&xskmap_flush_list);
+	struct list_head *flush_list = bpf_net_ctx_get_xskmap_flush_list();
 	struct xdp_sock *xs, *tmp;
 
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
@@ -402,7 +400,7 @@ void __xsk_map_flush(void)
 #ifdef CONFIG_DEBUG_NET
 bool xsk_map_check_flush(void)
 {
-	if (list_empty(this_cpu_ptr(&xskmap_flush_list)))
+	if (list_empty(bpf_net_ctx_get_xskmap_flush_list()))
 		return false;
 	__xsk_map_flush();
 	return true;
@@ -1775,7 +1773,7 @@ static struct pernet_operations xsk_net_ops = {
 
 static int __init xsk_init(void)
 {
-	int err, cpu;
+	int err;
 
 	err = proto_register(&xsk_proto, 0 /* no slab */);
 	if (err)
@@ -1793,8 +1791,6 @@ static int __init xsk_init(void)
 	if (err)
 		goto out_pernet;
 
-	for_each_possible_cpu(cpu)
-		INIT_LIST_HEAD(&per_cpu(xskmap_flush_list, cpu));
 	return 0;
 
 out_pernet:
