Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDEF7E8;
	Wed, 12 Jun 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203009; cv=none; b=cb85EIIJsN/3cf35UKnf41GOqvz31UXLS0OF6KiAVhJX5fBEO5o1d0ss+Fdu0v/sYjMphXfaJ+cqHZnP0cvq+GhSmwg8NlXokX7Wi3EucUhn9TFILa6kJ+6pvPZMsO7JFjSaX2dExtpyH+XR8y+DScj9/VjxcEHN/GGcuk0Jbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203009; c=relaxed/simple;
	bh=+Qrk02N38F2+EZhA+vwnf6upgFG4Ctsp/GWyrA4VMfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jBAVOjCN2sxI7tSO+gNIg1X7BNwBk1nKNIc7TZAgLDola3FRqEgjXpBUnzo50yec7TxEl6kWNJAC89ZbNQ1EK+maCdJs8EIGlR4mk+06mgpU5WpJPSvCS36ulOJY7hPrEdsbxwVaT2kxFi0kMDVfK6ayAg1xf+/U5STZ8VkNCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lWyzwDbD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VvXV3JZm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWyzwDbD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvXV3JZm"
Date: Wed, 12 Jun 2024 16:36:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718203004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=t5E+xGBN+bpnbjwDcIYFz6pf3iBLnA4uNjCCL/DqW2Y=;
	b=lWyzwDbDuv/JNfxlWrl2ByalhXQZINGguuPwsBxQfiHKM0sF1Ys7IcsGWATW+Ge2pEGN88
	6ufqeYtXVZEkE+XrNEw+Of1ynA5XDzikUauZEGauPzfrxwoQ1U0e0k63kKsMGVWmannLo5
	NZgDfLSCJEOZXn6ZbQfZrncg8Py0XaZ8RjCWR00l5jRYIYQaRvHUnyZTLRkxavP2DAsB2q
	2lczp6TIQTb5kxl5nVeEdHZawIrRvTIZDUFl5y30NjDYGa/HSeUMEmIKGKtoqxdNpugyte
	q4Q+XG0GJCyDaPtNrnyr1UH9zaRqFcFGpg3GG4ec53DZVFLZFfy2+yOq5B/0/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718203004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=t5E+xGBN+bpnbjwDcIYFz6pf3iBLnA4uNjCCL/DqW2Y=;
	b=VvXV3JZmhFmv7wHgO2AR8oAgbpPrrTZF5gzfpLZt1oTpOZlbAxVbVmHyHb8uQTEwgY9zWt
	6sOnUN2xWIKpd1AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10-rc3-rt5
Message-ID: <20240612143642.AADPqSwN@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10-rc3-rt5 patch set. 

Changes since v6.10-rc3-rt4:

  - Update the BH-locking series to the upcoming v6. This reworks
    locking within the series which avoids a case where pahole fails to
    process the BTF information. Reported by Clark Williams, Luis
    Claudio R. Goncalves and Kurt Kanzenbach.

Known issues
    None.

The delta patch against v6.10-rc3-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/incr/patch-6.10-rc3-rt4-rt5.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10-rc3-rt5

The RT patch against v6.10-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10-rc3-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10-rc3-rt5.tar.xz

Sebastian

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2fc16ce4a404b..62662ab99d1f4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -733,15 +733,22 @@ struct bpf_nh_params {
 	};
 };
 
+/* flags for bpf_redirect_info kern_flags */
+#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
+#define BPF_RI_F_RI_INIT	BIT(1)
+#define BPF_RI_F_CPU_MAP_INIT	BIT(2)
+#define BPF_RI_F_DEV_MAP_INIT	BIT(3)
+#define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+
 struct bpf_redirect_info {
 	u64 tgt_index;
 	void *tgt_value;
 	struct bpf_map *map;
 	u32 flags;
-	u32 kern_flags;
 	u32 map_id;
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
+	u32 kern_flags;
 };
 
 struct bpf_net_context {
@@ -757,14 +764,7 @@ static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bp
 
 	if (tsk->bpf_net_context != NULL)
 		return NULL;
-	memset(&bpf_net_ctx->ri, 0, sizeof(bpf_net_ctx->ri));
-
-	if (IS_ENABLED(CONFIG_BPF_SYSCALL)) {
-		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
-		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
-	}
-	if (IS_ENABLED(CONFIG_XDP_SOCKETS))
-		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+	bpf_net_ctx->ri.kern_flags = 0;
 
 	tsk->bpf_net_context = bpf_net_ctx;
 	return bpf_net_ctx;
@@ -785,6 +785,11 @@ static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
+		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_RI_INIT;
+	}
+
 	return &bpf_net_ctx->ri;
 }
 
@@ -792,6 +797,11 @@ static inline struct list_head *bpf_net_ctx_get_cpu_map_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_CPU_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_CPU_MAP_INIT;
+	}
+
 	return &bpf_net_ctx->cpu_map_flush_list;
 }
 
@@ -799,6 +809,11 @@ static inline struct list_head *bpf_net_ctx_get_dev_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_DEV_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_DEV_MAP_INIT;
+	}
+
 	return &bpf_net_ctx->dev_map_flush_list;
 }
 
@@ -806,14 +821,14 @@ static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
 {
 	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
 
+	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_XSK_MAP_INIT)) {
+		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
+		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_XSK_MAP_INIT;
+	}
+
 	return &bpf_net_ctx->xskmap_map_flush_list;
 }
 
-DEFINE_FREE(bpf_net_ctx_clear, struct bpf_net_context *, bpf_net_ctx_clear(_T));
-
-/* flags for bpf_redirect_info kern_flags */
-#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
-
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
  * lwt, ...). Subsystems allowing direct data access must (!)
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 9596ad19224ad..3c9f6538990ea 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -853,6 +853,7 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	unsigned int mtu, mtu_reserved;
+	int ret;
 
 	mtu_reserved = nf_bridge_mtu_reduction(skb);
 	mtu = skb->dev->mtu;
@@ -885,7 +886,7 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
-		guard(local_lock_nested_bh)(&brnf_frag_data_storage.bh_lock);
+		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
 		data = this_cpu_ptr(&brnf_frag_data_storage);
 
 		if (skb_vlan_tag_present(skb)) {
@@ -901,7 +902,9 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
 						 data->size);
 
-		return br_nf_ip_fragment(net, sk, skb, br_nf_push_frag_xmit);
+		ret = br_nf_ip_fragment(net, sk, skb, br_nf_push_frag_xmit);
+		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
+		return ret;
 	}
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV6) &&
 	    skb->protocol == htons(ETH_P_IPV6)) {
@@ -913,7 +916,7 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
-		guard(local_lock_nested_bh)(&brnf_frag_data_storage.bh_lock);
+		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
 		data = this_cpu_ptr(&brnf_frag_data_storage);
 		data->encap_size = nf_bridge_encap_header_len(skb);
 		data->size = ETH_HLEN + data->encap_size;
@@ -921,8 +924,12 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
 						 data->size);
 
-		if (v6ops)
-			return v6ops->fragment(net, sk, skb, br_nf_push_frag_xmit);
+		if (v6ops) {
+			ret = v6ops->fragment(net, sk, skb, br_nf_push_frag_xmit);
+			local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
+			return ret;
+		}
+		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
 
 		kfree_skb(skb);
 		return -EMSGSIZE;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0ff8b11c8ab6f..85702022c5cd4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4030,9 +4030,8 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
-	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) = NULL;
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
-	struct bpf_net_context __bpf_net_ctx;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
@@ -4067,10 +4066,12 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 			break;
 		}
 		*ret = NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_RX_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4080,8 +4081,10 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_RX_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -4089,10 +4092,9 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 static __always_inline struct sk_buff *
 sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
-	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) = NULL;
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
-	struct bpf_net_context __bpf_net_ctx;
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
@@ -4115,10 +4117,12 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret = NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_XMIT_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4128,8 +4132,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_XMIT_SUCCESS;
+		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
+	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -6372,6 +6378,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 	struct napi_struct *napi;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
+
 restart:
 	napi_poll = NULL;
 
@@ -6893,12 +6900,11 @@ static int napi_threaded_poll(void *data)
 
 static __latent_entropy void net_rx_action(struct softirq_action *h)
 {
-	struct bpf_net_context *bpf_net_ctx __free(bpf_net_ctx_clear) = NULL;
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies +
 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int budget = READ_ONCE(net_hotdata.netdev_budget);
-	struct bpf_net_context __bpf_net_ctx;
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
@@ -6955,7 +6961,8 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 		sd->in_net_rx_action = false;
 
 	net_rps_action_and_irq_enable(sd);
-end:;
+end:
+	bpf_net_ctx_clear(bpf_net_ctx);
 }
 
 struct netdev_adjacent {
diff --git a/net/core/filter.c b/net/core/filter.c
index 64a1696a52920..f00cc56123013 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2019,6 +2019,7 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
 	struct bpf_scratchpad *sp = this_cpu_ptr(&bpf_sp);
 	u32 diff_size = from_size + to_size;
 	int i, j = 0;
+	__wsum ret;
 
 	/* This is quite flexible, some examples:
 	 *
@@ -2032,13 +2033,15 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
 		     diff_size > sizeof(sp->diff)))
 		return -EINVAL;
 
-	guard(local_lock_nested_bh)(&bpf_sp.bh_lock);
+	local_lock_nested_bh(&bpf_sp.bh_lock);
 	for (i = 0; i < from_size / sizeof(__be32); i++, j++)
 		sp->diff[j] = ~from[i];
 	for (i = 0; i <   to_size / sizeof(__be32); i++, j++)
 		sp->diff[j] = to[i];
 
-	return csum_partial(sp->diff, diff_size, seed);
+	ret = csum_partial(sp->diff, diff_size, seed);
+	local_unlock_nested_bh(&bpf_sp.bh_lock);
+	return ret;
 }
 
 static const struct bpf_func_proto bpf_csum_diff_proto = {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b33bae4ba78b6..5000394a4f51a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -309,12 +309,16 @@ void napi_get_frags_check(struct napi_struct *napi)
 void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
+	void *data;
 
 	fragsz = SKB_DATA_ALIGN(fragsz);
-	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
 
-	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
+	data = __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
 				       align_mask);
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
+	return data;
+
 }
 EXPORT_SYMBOL(__napi_alloc_frag_align);
 
@@ -342,17 +346,20 @@ static struct sk_buff *napi_skb_cache_get(void)
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 	struct sk_buff *skb;
 
-	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	if (unlikely(!nc->skb_count)) {
 		nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
 						      GFP_ATOMIC,
 						      NAPI_SKB_CACHE_BULK,
 						      nc->skb_cache);
-		if (unlikely(!nc->skb_count))
+		if (unlikely(!nc->skb_count)) {
+			local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 			return NULL;
+		}
 	}
 
 	skb = nc->skb_cache[--nc->skb_count];
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 	kasan_mempool_unpoison_object(skb, kmem_cache_size(net_hotdata.skbuff_cache));
 
 	return skb;
@@ -1439,7 +1446,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 	if (!kasan_mempool_poison_object(skb))
 		return;
 
-	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
+	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 	nc->skb_cache[nc->skb_count++] = skb;
 
 	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
@@ -1451,6 +1458,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
 		nc->skb_count = NAPI_SKB_CACHE_HALF;
 	}
+	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 }
 
 void __napi_kfree_skb(struct sk_buff *skb, enum skb_drop_reason reason)
