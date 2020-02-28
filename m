Return-Path: <SRS0=Vn5z=4Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDEDC3F2D3
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Feb 2020 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80720246A0
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Feb 2020 18:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1SKs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:10:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1SKr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Feb 2020 13:10:47 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j7k5y-0004PG-5c; Fri, 28 Feb 2020 19:10:42 +0100
Date:   Fri, 28 Feb 2020 19:10:42 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.22-rt13
Message-ID: <20200228181042.iokqryoi7wxmm2pr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.22-rt13 patch set. 

Changes since v5.4.22-rt12:

  - Update the BPF series to v3 including fixes posted to the mailing list.
    The BPF functionality is no longer disabled on -RT. Testing is welcome.

  - The field order in the trace has been changed. It shrunk by 4 bytes and the
    "preempt lazy" counter should now properly visible to tool. Reported by
    Jiri Olsa.

  - There should be no more "scheduling while atomic" warning issued by the
    vmwgfx driver. Reported in the bugzilla as #206591 by ciwei100000.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.4.22-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.22-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.22-rt13

The RT patch against v5.4.22 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.22-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.22-rt13.tar.xz

Sebastian
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
index e5252ef3812f0..6941689085ed3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
@@ -169,10 +169,8 @@ void vmw_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason)
 {
 	u32 *fifo_mem = dev_priv->mmio_virt;
 
-	preempt_disable();
 	if (cmpxchg(fifo_mem + SVGA_FIFO_BUSY, 0, 1) == 0)
 		vmw_write(dev_priv, SVGA_REG_SYNC, reason);
-	preempt_enable();
 }
 
 void vmw_fifo_release(struct vmw_private *dev_priv, struct vmw_fifo_state *fifo)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3e6744c7122d6..f4de2a6a0bb33 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -617,6 +617,36 @@ _out:							\
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 
+/*
+ * Block execution of BPF programs attached to instrumentation (perf,
+ * kprobes, tracepoints) to prevent deadlocks on map operations as any of
+ * these events can happen inside a region which holds a map bucket lock
+ * and can deadlock on it.
+ *
+ * Use the preemption safe inc/dec variants on RT because migrate disable
+ * is preemptible on RT and preemption in the middle of the RMW operation
+ * might lead to inconsistent state. Use the raw variants for non RT
+ * kernels as migrate_disable() maps to preempt_disable() so the slightly
+ * more expensive save operation can be avoided.
+ */
+static inline void bpf_disable_instrumentation(void)
+{
+	migrate_disable();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		this_cpu_inc(bpf_prog_active);
+	else
+		__this_cpu_inc(bpf_prog_active);
+}
+
+static inline void bpf_enable_instrumentation(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		this_cpu_dec(bpf_prog_active);
+	else
+		__this_cpu_dec(bpf_prog_active);
+	migrate_enable();
+}
+
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 76ce2dcb52cba..73448cfebc432 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -571,22 +571,26 @@ DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 	ret; })
 
 /*
- * Use in preemptible and therefore /migratable context to make sure that
+ * Use in preemptible and therefore migratable context to make sure that
  * the execution of the BPF program runs on one CPU.
  *
- * This uses migrate_disable/enable() explicitely to document that the
+ * This uses migrate_disable/enable() explicitly to document that the
  * invocation of a BPF program does not require reentrancy protection
  * against a BPF program which is invoked from a preempting task.
  *
- * For non enabled RT kernels migrate_disable/enable() maps to
+ * For non RT enabled kernels migrate_disable/enable() maps to
  * preempt_disable/enable(), i.e. it disables also preemption.
  */
-#define BPF_PROG_RUN_PIN_ON_CPU(prog, ctx) ({				\
-	u32 ret;							\
-	migrate_disable();						\
-	ret = BPF_PROG_RUN(prog, ctx);					\
-	migrate_enable();						\
-	ret; })
+static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
+					  const void *ctx)
+{
+	u32 ret;
+
+	migrate_disable();
+	ret = BPF_PROG_RUN(prog, ctx);
+	migrate_enable();
+	return ret;
+}
 
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
@@ -706,7 +710,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	res = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
+	res = bpf_prog_run_pin_on_cpu(prog, skb);
 	return res;
 }
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index e1aab77564eeb..adb085fe31e43 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -238,30 +238,8 @@ static inline int __migrate_disabled(struct task_struct *p)
 }
 
 #else
-/**
- * migrate_disable - Prevent migration of the current task
- *
- * Maps to preempt_disable() which also disables preemption. Use
- * migrate_disable() to annotate that the intent is to prevent migration
- * but not necessarily preemption.
- *
- * Can be invoked nested like preempt_disable() and needs the corresponding
- * number of migrate_enable() invocations.
- */
-#define migrate_disable()	preempt_disable()
-
-/**
- * migrate_enable - Allow migration of the current task
- *
- * Counterpart to migrate_disable().
- *
- * As migrate_disable() can be invoked nested only the uttermost invocation
- * reenables migration.
- *
- * Currently mapped to preempt_enable().
- */
-#define migrate_enable()	preempt_enable()
-
+#define migrate_disable()		preempt_disable()
+#define migrate_enable()		preempt_enable()
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f3b1ef07e4a5f..10bbf986bc1d5 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,8 +62,7 @@ struct trace_entry {
 	unsigned char		flags;
 	unsigned char		preempt_count;
 	int			pid;
-	unsigned short		migrate_disable;
-	unsigned short		padding;
+	unsigned char		migrate_disable;
 	unsigned char		preempt_lazy_count;
 };
 
diff --git a/init/Kconfig b/init/Kconfig
index c9e5274d3704a..db06b61e4430c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1631,7 +1631,6 @@ config KALLSYMS_BASE_RELATIVE
 # syscall, maps, verifier
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
-	depends on !PREEMPT_RT
 	select BPF
 	select IRQ_WORK
 	default n
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c91ec298decad..196589165843b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -754,15 +754,7 @@ static void htab_elem_free_rcu(struct rcu_head *head)
 	struct htab_elem *l = container_of(head, struct htab_elem, rcu);
 	struct bpf_htab *htab = l->htab;
 
-	/* must increment bpf_prog_active to avoid kprobe+bpf triggering while
-	 * we're calling kfree, otherwise deadlock is possible if kprobes
-	 * are placed somewhere inside of slub
-	 */
-	migrate_disable();
-	__this_cpu_inc(bpf_prog_active);
 	htab_elem_free(htab, l);
-	__this_cpu_dec(bpf_prog_active);
-	migrate_enable();
 }
 
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e773c23b10a4b..3d848a40deddc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -794,8 +794,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto done;
 	}
 
-	migrate_disable();
-	this_cpu_inc(bpf_prog_active);
+	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
@@ -836,8 +835,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		}
 		rcu_read_unlock();
 	}
-	this_cpu_dec(bpf_prog_active);
-	migrate_enable();
+	bpf_enable_instrumentation();
 
 done:
 	if (err)
@@ -934,11 +932,7 @@ static int map_update_elem(union bpf_attr *attr)
 		goto out;
 	}
 
-	/* must increment bpf_prog_active to avoid kprobe+bpf triggering from
-	 * inside bpf map update or delete otherwise deadlocks are possible
-	 */
-	migrate_disable();
-	__this_cpu_inc(bpf_prog_active);
+	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_update(map, key, value, attr->flags);
@@ -969,8 +963,7 @@ static int map_update_elem(union bpf_attr *attr)
 		err = map->ops->map_update_elem(map, key, value, attr->flags);
 		rcu_read_unlock();
 	}
-	__this_cpu_dec(bpf_prog_active);
-	migrate_enable();
+	bpf_enable_instrumentation();
 	maybe_wait_bpf_programs(map);
 out:
 free_value:
@@ -1016,13 +1009,11 @@ static int map_delete_elem(union bpf_attr *attr)
 		goto out;
 	}
 
-	migrate_disable();
-	__this_cpu_inc(bpf_prog_active);
+	bpf_disable_instrumentation();
 	rcu_read_lock();
 	err = map->ops->map_delete_elem(map, key);
 	rcu_read_unlock();
-	__this_cpu_dec(bpf_prog_active);
-	migrate_enable();
+	bpf_enable_instrumentation();
 	maybe_wait_bpf_programs(map);
 out:
 	kfree(key);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b2817d0929b39..f3430d776a017 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7874,26 +7874,48 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
 	}
 }
 
+static bool is_preallocated_map(struct bpf_map *map)
+{
+	if (!check_map_prealloc(map))
+		return false;
+	if (map->inner_map_meta && !check_map_prealloc(map->inner_map_meta))
+		return false;
+	return true;
+}
+
 static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 					struct bpf_map *map,
 					struct bpf_prog *prog)
 
 {
-	/* Make sure that BPF_PROG_TYPE_PERF_EVENT programs only use
-	 * preallocated hash maps, since doing memory allocation
-	 * in overflow_handler can crash depending on where nmi got
-	 * triggered.
+	/*
+	 * Validate that trace type programs use preallocated hash maps.
+	 *
+	 * For programs attached to PERF events this is mandatory as the
+	 * perf NMI can hit any arbitrary code sequence.
+	 *
+	 * All other trace types using preallocated hash maps are unsafe as
+	 * well because tracepoint or kprobes can be inside locked regions
+	 * of the memory allocator or at a place where a recursion into the
+	 * memory allocator would see inconsistent state.
+	 *
+	 * On RT enabled kernels run-time allocation of all trace type
+	 * programs is strictly prohibited due to lock type constraints. On
+	 * !RT kernels it is allowed for backwards compatibility reasons for
+	 * now, but warnings are emitted so developers are made aware of
+	 * the unsafety and can fix their programs before this is enforced.
 	 */
-	if (prog->type == BPF_PROG_TYPE_PERF_EVENT) {
-		if (!check_map_prealloc(map)) {
+	if (is_tracing_prog_type(prog->type) && !is_preallocated_map(map)) {
+		if (prog->type == BPF_PROG_TYPE_PERF_EVENT) {
 			verbose(env, "perf_event programs can only use preallocated hash map\n");
 			return -EINVAL;
 		}
-		if (map->inner_map_meta &&
-		    !check_map_prealloc(map->inner_map_meta)) {
-			verbose(env, "perf_event programs can only use preallocated inner hash map\n");
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			verbose(env, "trace type programs can only use preallocated hash map\n");
 			return -EINVAL;
 		}
+		WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
+		verbose(env, "trace type programs with run-time allocated hash maps are unsafe. Switch to preallocated hash maps.\n");
 	}
 
 	if ((is_tracing_prog_type(prog->type) ||
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 25f9e00df9d44..70e09a36813cb 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -268,7 +268,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	 * value always takes priority (ignoring the DATA).
 	 */
 	for (; f; f = f->prev) {
-		u32 cur_ret = BPF_PROG_RUN_PIN_ON_CPU(f->prog, sd);
+		u32 cur_ret = bpf_prog_run_pin_on_cpu(f->prog, sd);
 
 		if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
 			ret = cur_ret;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e80abded7b7af..1f99c60263733 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -83,7 +83,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	if (in_nmi()) /* not supported yet */
 		return 1;
 
-	migrate_disable();
+	cant_sleep();
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		/*
@@ -115,11 +115,9 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 
  out:
 	__this_cpu_dec(bpf_prog_active);
-	migrate_enable();
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(trace_call_bpf);
 
 #ifdef CONFIG_BPF_KPROBE_OVERRIDE
 BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
@@ -1329,6 +1327,7 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
+	cant_sleep();
 	rcu_read_lock();
 	(void) BPF_PROG_RUN(prog, args);
 	rcu_read_unlock();
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index accaae59a7626..8bfb187cce65a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -181,8 +181,8 @@ static int trace_define_common_fields(void)
 	__common_field(unsigned char, flags);
 	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
-	__common_field(unsigned short, migrate_disable);
-	__common_field(unsigned short, padding);
+	__common_field(unsigned char, migrate_disable);
+	__common_field(unsigned char, preempt_lazy_count);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2619bc5ed520c..92f63e43c5ea7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1333,8 +1333,15 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	int size, esize;
 	int rctx;
 
-	if (bpf_prog_array_valid(call) && !trace_call_bpf(call, regs))
-		return;
+	if (bpf_prog_array_valid(call)) {
+		u32 ret;
+
+		preempt_disable();
+		ret = trace_call_bpf(call, regs);
+		preempt_enable();
+		if (!ret)
+			return;
+	}
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 7e2ae105d3b9d..e43e195ed287d 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -844,7 +844,7 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 		     (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
 	flow_keys->flags = flags;
 
-	result = BPF_PROG_RUN_PIN_ON_CPU(prog, ctx);
+	result = bpf_prog_run_pin_on_cpu(prog, ctx);
 
 	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
 	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 47e6af669d592..db5832674328e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -637,7 +637,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
-	ret = BPF_PROG_RUN_PIN_ON_CPU(prog, msg);
+	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
@@ -663,7 +663,7 @@ static int sk_psock_bpf_run(struct sk_psock *psock, struct bpf_prog *prog,
 
 	skb->sk = psock->sk;
 	bpf_compute_data_end_sk_skb(skb);
-	ret = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
+	ret = bpf_prog_run_pin_on_cpu(prog, skb);
 	/* strparser clones the skb before handing it to a upper layer,
 	 * meaning skb_orphan has been called. We NULL sk on the way out
 	 * to ensure we don't trigger a BUG_ON() in skb/sk operations
diff --git a/net/kcm/Kconfig b/net/kcm/Kconfig
index 20710110a716a..bf7e970fad656 100644
--- a/net/kcm/Kconfig
+++ b/net/kcm/Kconfig
@@ -3,7 +3,6 @@
 config AF_KCM
 	tristate "KCM sockets"
 	depends on INET
-	depends on !PREEMPT_RT
 	select BPF_SYSCALL
 	select STREAM_PARSER
 	---help---
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 4906c8f043afb..56fac24a627a5 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -380,7 +380,7 @@ static int kcm_parse_func_strparser(struct strparser *strp, struct sk_buff *skb)
 	struct bpf_prog *prog = psock->bpf_prog;
 	int res;
 
-	res = BPF_PROG_RUN_PIN_ON_CPU(prog, skb);
+	res = bpf_prog_run_pin_on_cpu(prog, skb);
 	return res;
 }
 
