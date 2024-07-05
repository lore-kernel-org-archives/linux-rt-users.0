Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B014885C;
	Fri,  5 Jul 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189268; cv=none; b=BMuwF2b3QCm1VcseG0hWgVvEVvMoNFs5E5TZ9tE1fSPfKaER5eNRTvmV8E4SSAhTCZZgy2VHVodx9VWbDuPR97mWYLW5XKNAAgQjem4/misgvFPwPyZ6IYwT1hBv8XOpAnb0DFewBBgI5TGqmM8Ab/3XBeXjs8eOQuVO2zm16RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189268; c=relaxed/simple;
	bh=uDLXbtB/x0vGi2JdKTBNWRW3iNDNFeA0GfCXaogTBIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tUQWlSh8obWfH6BQ8XW9rsmcxsDUxNgwBL+7ALSh9Ugug1iCFGTcOv61UZElSqf92b61iH2TCZ+yuudDEVa7Dc40os+SRDsEjKKSke8aMLzThgYKXTjeLAADSgt+E2u537c5qv57xgwmRtxmxsmPM83Eae11aOeNMYktzdhS7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lL6IAt+P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uyg7HIYB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lL6IAt+P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uyg7HIYB"
Date: Fri, 5 Jul 2024 16:21:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720189264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=vbbU0oqG3pnxjKIgVo3RIpoFwHC5RQgAhbh1Zxq3lZI=;
	b=lL6IAt+Pewbw+mOtg7CrVlDIM8DsksA2m/YFpnfb62H2jahbYyrHGdtGms/LiMgh6pJuNV
	hfEkcwxfpM69O6+Mw7hQm24IhMe3F7tIhDkuHfoYCUl2bgmikqDnOIk/JoWSeLz3cLPwky
	6mNfwKOc9ar3AmBBPM2f0l/DUInO3UVqsmaa+0mHt6SVDzwZ4pdOoWSxiuCL1nVEltl07u
	4mLhMluc3xocOXdmDkmzy65lrCEWDsagukDheROBO3dHFmwokSAxk1LJIC+18pvkEddiQd
	MFIADowmIlM/MkiXadhvkxVDbGW4T37cSnOMFfCh1GeghSasH9BcNxWE0VQIGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720189264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=vbbU0oqG3pnxjKIgVo3RIpoFwHC5RQgAhbh1Zxq3lZI=;
	b=Uyg7HIYBuw2R+6uB582DmxlUYM7oM/QDi2+8J1P7T2iKv3OnVG0hMHfaWpZlZUwYQd4Pt7
	oBL6uuyrP7c+r/DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10-rc6-rt11
Message-ID: <20240705142103.JffNrDYN@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10-rc6-rt11 patch set. 

Changes since v6.10-rc6-rt10:

  - Update the series to fix "perf test sigtrap" to v5.

  - As a follow-up to the net/BH series:

    - Add an optimisation to lazy initialize the flush lists.

    - Initialize the BPF context within the tun driver and others using
      the generic-XDP to avoid crash.

    - Add a check to the seg6_state/ BPF code to only use it within the
      "expected" call path.

Known issues
    None.

The delta patch against v6.10-rc6-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/incr/patch-6.10-rc6-rt10-rt11.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10-rc6-rt11

The RT patch against v6.10-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10-rc6-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10-rc6-rt11.tar.xz

Sebastian

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9254bca2813dc..9b24861464bc6 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1661,6 +1661,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag = &current->task_frag;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	char *buf;
@@ -1700,6 +1701,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 	local_bh_disable();
 	rcu_read_lock();
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		struct xdp_buff xdp;
@@ -1728,12 +1730,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 
 	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
 
 out:
+	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 	return NULL;
@@ -2566,6 +2570,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
 	    ctl && ctl->type == TUN_MSG_PTR) {
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		struct tun_page tpage;
 		int n = ctl->num;
 		int flush = 0, queued = 0;
@@ -2574,6 +2579,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 		local_bh_disable();
 		rcu_read_lock();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
@@ -2588,6 +2594,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		if (tfile->napi_enabled && queued > 0)
 			napi_schedule(&tfile->napi);
 
+		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e694a308081a..ff261349b5ed3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2492,7 +2492,7 @@ struct sk_buff;
 struct bpf_dtab_netdev;
 struct bpf_cpu_map_entry;
 
-void __dev_flush(void);
+void __dev_flush(struct list_head *flush_list);
 int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
 int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
@@ -2505,7 +2505,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 			   struct bpf_prog *xdp_prog, struct bpf_map *map,
 			   bool exclude_ingress);
 
-void __cpu_map_flush(void);
+void __cpu_map_flush(struct list_head *flush_list);
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
 		    struct net_device *dev_rx);
 int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
@@ -2642,8 +2642,6 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 
-bool dev_check_flush(void);
-bool cpu_map_check_flush(void);
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -2731,7 +2729,7 @@ static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline void __dev_flush(void)
+static inline void __dev_flush(struct list_head *flush_list)
 {
 }
 
@@ -2777,7 +2775,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
-static inline void __cpu_map_flush(void)
+static inline void __cpu_map_flush(struct list_head *flush_list)
 {
 }
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 13bed50194237..2b8503fecd026 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -739,6 +739,7 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_SEG6_STATE	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -829,6 +830,56 @@ static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
 	return &bpf_net_ctx->xskmap_map_flush_list;
 }
 
+static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_map,
+							struct list_head **lh_dev,
+							struct list_head **lh_xsk)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+	u32 kern_flags = bpf_net_ctx->ri.kern_flags;
+	struct list_head *lh;
+
+	*lh_map = *lh_dev = *lh_xsk = NULL;
+
+	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
+		return;
+
+	lh = &bpf_net_ctx->dev_map_flush_list;
+	if (kern_flags & BPF_RI_F_DEV_MAP_INIT && !list_empty(lh))
+		*lh_dev = lh;
+
+	lh = &bpf_net_ctx->cpu_map_flush_list;
+	if (kern_flags & BPF_RI_F_CPU_MAP_INIT && !list_empty(lh))
+		*lh_map = lh;
+
+	lh = &bpf_net_ctx->xskmap_map_flush_list;
+	if (IS_ENABLED(CONFIG_XDP_SOCKETS) &&
+	    kern_flags & BPF_RI_F_XSK_MAP_INIT && !list_empty(lh))
+		*lh_xsk = lh;
+}
+
+static inline bool bpf_net_ctx_seg6_state_avail(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	if (!bpf_net_ctx)
+		return false;
+	return bpf_net_ctx->ri.kern_flags & BPF_RI_F_SEG6_STATE;
+}
+
+static inline void bpf_net_ctx_seg6_state_set(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	bpf_net_ctx->ri.kern_flags |= BPF_RI_F_SEG6_STATE;
+}
+
+static inline void bpf_net_ctx_seg6_state_clr(void)
+{
+	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
+
+	bpf_net_ctx->ri.kern_flags &= ~BPF_RI_F_SEG6_STATE;
+}
+
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
  * lwt, ...). Subsystems allowing direct data access must (!)
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 26b8a47f41fca..cf5e7e891a776 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -18,6 +18,7 @@ enum task_work_notify_mode {
 	TWA_RESUME,
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
+	TWA_NMI_CURRENT,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3d54de168a6d9..bfe625b55d55d 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -121,7 +121,7 @@ struct xsk_tx_metadata_ops {
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
-void __xsk_map_flush(void);
+void __xsk_map_flush(struct list_head *flush_list);
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
@@ -206,7 +206,7 @@ static inline int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 	return -EOPNOTSUPP;
 }
 
-static inline void __xsk_map_flush(void)
+static inline void __xsk_map_flush(struct list_head *flush_list)
 {
 }
 
@@ -228,14 +228,4 @@ static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
 }
 
 #endif /* CONFIG_XDP_SOCKETS */
-
-#if defined(CONFIG_XDP_SOCKETS) && defined(CONFIG_DEBUG_NET)
-bool xsk_map_check_flush(void);
-#else
-static inline bool xsk_map_check_flush(void)
-{
-	return false;
-}
-#endif
-
 #endif /* _LINUX_XDP_SOCK_H */
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 068e994ed781a..fbdf5a1aabfe4 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -707,7 +707,6 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
  */
 static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 {
-	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq = this_cpu_ptr(rcpu->bulkq);
 
 	if (unlikely(bq->count == CPU_MAP_BULK_SIZE))
@@ -724,8 +723,11 @@ static void bq_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf)
 	 */
 	bq->q[bq->count++] = xdpf;
 
-	if (!bq->flush_node.prev)
+	if (!bq->flush_node.prev) {
+		struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
+
 		list_add(&bq->flush_node, flush_list);
+	}
 }
 
 int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
@@ -757,9 +759,8 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 	return ret;
 }
 
-void __cpu_map_flush(void)
+void __cpu_map_flush(struct list_head *flush_list)
 {
-	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
 	struct xdp_bulk_queue *bq, *tmp;
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -769,13 +770,3 @@ void __cpu_map_flush(void)
 		wake_up_process(bq->obj->kthread);
 	}
 }
-
-#ifdef CONFIG_DEBUG_NET
-bool cpu_map_check_flush(void)
-{
-	if (list_empty(bpf_net_ctx_get_cpu_map_flush_list()))
-		return false;
-	__cpu_map_flush();
-	return true;
-}
-#endif
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 317ac2d66ebd1..b18d4a14a0a70 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -412,9 +412,8 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
  * driver before returning from its napi->poll() routine. See the comment above
  * xdp_do_flush() in filter.c.
  */
-void __dev_flush(void)
+void __dev_flush(struct list_head *flush_list)
 {
-	struct list_head *flush_list = bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq, *tmp;
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
@@ -425,16 +424,6 @@ void __dev_flush(void)
 	}
 }
 
-#ifdef CONFIG_DEBUG_NET
-bool dev_check_flush(void)
-{
-	if (list_empty(bpf_net_ctx_get_dev_flush_list()))
-		return false;
-	__dev_flush();
-	return true;
-}
-#endif
-
 /* Elements are kept alive by RCU; either by rcu_read_lock() (from syscall) or
  * by local_bh_disable() (from XDP calls inside NAPI). The
  * rcu_read_lock_bh_held() below makes lockdep accept both.
@@ -459,7 +448,6 @@ static void *__dev_map_lookup_elem(struct bpf_map *map, u32 key)
 static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 		       struct net_device *dev_rx, struct bpf_prog *xdp_prog)
 {
-	struct list_head *flush_list = bpf_net_ctx_get_dev_flush_list();
 	struct xdp_dev_bulk_queue *bq = this_cpu_ptr(dev->xdp_bulkq);
 
 	if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
@@ -473,6 +461,8 @@ static void bq_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	 * are only ever modified together.
 	 */
 	if (!bq->dev_rx) {
+		struct list_head *flush_list = bpf_net_ctx_get_dev_flush_list();
+
 		bq->dev_rx = dev_rx;
 		bq->xdp_prog = xdp_prog;
 		list_add(&bq->flush_node, flush_list);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8bba63ea9c686..0acf6ee4df528 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9729,26 +9729,21 @@ static int __perf_event_overflow(struct perf_event *event,
 		 */
 		bool valid_sample = sample_is_allowed(event, regs);
 		unsigned int pending_id = 1;
+		enum task_work_notify_mode notify_mode;
 
 		if (regs)
 			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
 
+		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
+
 		if (!event->pending_work &&
-		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
+		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_pending);
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 				event->pending_addr = data->addr;
-			/*
-			 * The NMI path returns directly to userland. The
-			 * irq_work is raised as a dummy interrupt to ensure
-			 * regular return path to user is taken and task_work
-			 * is processed.
-			 */
-			if (in_nmi())
-				irq_work_queue(&event->pending_disable_irq);
 
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
diff --git a/kernel/fork.c b/kernel/fork.c
index f314bdd7e6108..99076dbe27d83 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2355,7 +2355,6 @@ __latent_entropy struct task_struct *copy_process(
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx = NULL;
 #endif
-	p->bpf_net_context =  NULL;
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 2134ac8057a94..05fb41fe09f5d 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -1,10 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/irq_work.h>
 #include <linux/spinlock.h>
 #include <linux/task_work.h>
 #include <linux/resume_user_mode.h>
+#include <trace/events/ipi.h>
 
 static struct callback_head work_exited; /* all we need is ->next == NULL */
 
+static void task_work_set_notify_irq(struct irq_work *entry)
+{
+	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+}
+static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =
+	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
+
 /**
  * task_work_add - ask the @task to execute @work->func()
  * @task: the task which should run the callback
@@ -12,7 +21,7 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * @notify: how to notify the targeted task
  *
  * Queue @work for task_work_run() below and notify the @task if @notify
- * is @TWA_RESUME, @TWA_SIGNAL, or @TWA_SIGNAL_NO_IPI.
+ * is @TWA_RESUME, @TWA_SIGNAL, @TWA_SIGNAL_NO_IPI or @TWA_NMI_CURRENT.
  *
  * @TWA_SIGNAL works like signals, in that the it will interrupt the targeted
  * task and run the task_work, regardless of whether the task is currently
@@ -24,6 +33,8 @@ static struct callback_head work_exited; /* all we need is ->next == NULL */
  * kernel anyway.
  * @TWA_RESUME work is run only when the task exits the kernel and returns to
  * user mode, or before entering guest mode.
+ * @TWA_NMI_CURRENT works like @TWA_RESUME, except it can only be used for the
+ * current @task and if the current context is NMI.
  *
  * Fails if the @task is exiting/exited and thus it can't process this @work.
  * Otherwise @work->func() will be called when the @task goes through one of
@@ -44,8 +55,13 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 {
 	struct callback_head *head;
 
-	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack(work);
+	if (notify == TWA_NMI_CURRENT) {
+		if (WARN_ON_ONCE(task != current))
+			return -EINVAL;
+	} else {
+		/* record the work call stack in order to print it in KASAN reports */
+		kasan_record_aux_stack(work);
+	}
 
 	head = READ_ONCE(task->task_works);
 	do {
@@ -66,6 +82,9 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 	case TWA_SIGNAL_NO_IPI:
 		__set_notify_signal(task);
 		break;
+	case TWA_NMI_CURRENT:
+		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/net/core/dev.c b/net/core/dev.c
index db54959a26668..78184fe9e3882 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5126,11 +5126,14 @@ static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 {
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+
 	if (xdp_prog) {
 		struct xdp_buff xdp;
 		u32 act;
 		int err;
 
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
 		if (act != XDP_PASS) {
 			switch (act) {
@@ -5144,11 +5147,13 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 				generic_xdp_tx(*pskb, xdp_prog);
 				break;
 			}
+			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
 	}
 	return XDP_PASS;
 out_redir:
+	bpf_net_ctx_clear(bpf_net_ctx);
 	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index a8dd866edec9e..9556453a8b564 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4277,22 +4277,39 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
  */
 void xdp_do_flush(void)
 {
-	__dev_flush();
-	__cpu_map_flush();
-	__xsk_map_flush();
+	struct list_head *lh_map, *lh_dev, *lh_xsk;
+
+	bpf_net_ctx_get_all_used_flush_lists(&lh_map, &lh_dev, &lh_xsk);
+	if (lh_dev)
+		__dev_flush(lh_dev);
+	if (lh_map)
+		__cpu_map_flush(lh_map);
+	if (lh_xsk)
+		__xsk_map_flush(lh_xsk);
 }
 EXPORT_SYMBOL_GPL(xdp_do_flush);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
 void xdp_do_check_flushed(struct napi_struct *napi)
 {
-	bool ret;
+	struct list_head *lh_map, *lh_dev, *lh_xsk;
+	bool missed = false;
 
-	ret = dev_check_flush();
-	ret |= cpu_map_check_flush();
-	ret |= xsk_map_check_flush();
+	bpf_net_ctx_get_all_used_flush_lists(&lh_map, &lh_dev, &lh_xsk);
+	if (lh_dev) {
+		__dev_flush(lh_dev);
+		missed = true;
+	}
+	if (lh_map) {
+		__cpu_map_flush(lh_map);
+		missed = true;
+	}
+	if (lh_xsk) {
+		__xsk_map_flush(lh_xsk);
+		missed = true;
+	}
 
-	WARN_ONCE(ret, "Missing xdp_do_flush() invocation after NAPI by %ps\n",
+	WARN_ONCE(missed, "Missing xdp_do_flush() invocation after NAPI by %ps\n",
 		  napi->poll);
 }
 #endif
@@ -6442,6 +6459,8 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
 	void *srh_tlvs, *srh_end, *ptr;
 	int srhoff = 0;
 
+	if (!bpf_net_ctx_seg6_state_avail())
+		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (srh == NULL)
 		return -EINVAL;
@@ -6499,6 +6518,8 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 	int hdroff = 0;
 	int err;
 
+	if (!bpf_net_ctx_seg6_state_avail())
+		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_X:
@@ -6576,6 +6597,8 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 	int srhoff = 0;
 	int ret;
 
+	if (!bpf_net_ctx_seg6_state_avail())
+		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh == NULL))
 		return -EINVAL;
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index c74705ead9849..3e3a48b7266b5 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1429,6 +1429,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	 * bpf_prog_run_save_cb().
 	 */
 	local_lock_nested_bh(&seg6_bpf_srh_states.bh_lock);
+	bpf_net_ctx_seg6_state_set();
 	srh_state = this_cpu_ptr(&seg6_bpf_srh_states);
 	srh_state->srh = srh;
 	srh_state->hdrlen = srh->hdrlen << 3;
@@ -1452,6 +1453,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 
 	if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 		goto drop;
+	bpf_net_ctx_seg6_state_clr();
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 
 	if (ret != BPF_REDIRECT)
@@ -1460,6 +1462,7 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	return dst_input(skb);
 
 drop:
+	bpf_net_ctx_seg6_state_clr();
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 	kfree_skb(skb);
 	return -EINVAL;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ed062e0383896..7e16336044b2d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -370,22 +370,23 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	struct list_head *flush_list = bpf_net_ctx_get_xskmap_flush_list();
 	int err;
 
 	err = xsk_rcv(xs, xdp);
 	if (err)
 		return err;
 
-	if (!xs->flush_node.prev)
+	if (!xs->flush_node.prev) {
+		struct list_head *flush_list = bpf_net_ctx_get_xskmap_flush_list();
+
 		list_add(&xs->flush_node, flush_list);
+	}
 
 	return 0;
 }
 
-void __xsk_map_flush(void)
+void __xsk_map_flush(struct list_head *flush_list)
 {
-	struct list_head *flush_list = bpf_net_ctx_get_xskmap_flush_list();
 	struct xdp_sock *xs, *tmp;
 
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
@@ -394,16 +395,6 @@ void __xsk_map_flush(void)
 	}
 }
 
-#ifdef CONFIG_DEBUG_NET
-bool xsk_map_check_flush(void)
-{
-	if (list_empty(bpf_net_ctx_get_xskmap_flush_list()))
-		return false;
-	__xsk_map_flush();
-	return true;
-}
-#endif
-
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
 	xskq_prod_submit_n(pool->cq, nb_entries);
