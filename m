Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF91DF73C;
	Thu,  9 Oct 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023855; cv=none; b=u3L7jwILS7qHkFopOrXSa+gTo4jrNReSUIqeO8F9wsuShHgz9MX4eItVNc9V/pCewoZIL0ltace1ueC+ZE6HD5L0VkJRlS8ZptnRSL2fiUEMkPcb57cnujBYE244NYkTtZcUNpWV3XiNU2pA9fNuOmgK9U+C1IPCG8qwjTOKadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023855; c=relaxed/simple;
	bh=YHvg+UnwH7eiIfj58JCP2jWxiBZSzrITGQpq930Xtkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cp8kW+5rmfUH115LriIH2rTmTDgidMp0YXoPU4CaFb7djctkrc+eKFekFndi5tSx/XOfngR1QABr1kO+c/6hVAnowRmr49DPAWKfo+hbTdMk6xwgYLrLzZIOjbsI3n/yD7Ep5ZiHam+QxJfL0kj3G1feMm1plVATsE8UXvQWOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kAhsoOsL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KOHDwic+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kAhsoOsL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KOHDwic+"
Date: Thu, 9 Oct 2025 17:30:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760023850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=k/Atcw8FJK8QC24QJ8kPRtEJc6zGI4BdlyJuf9DRrH0=;
	b=kAhsoOsLPKItWTcHgXzBytQuDBua99s/rwyB3Q7Ka3/QpykIay4aqLkRV88enlMbV/gE7g
	tM3aB8avWUtV6YZ2Pwtrk7xiOI5gnLztsGSbAaPERYHQJQyK0rjMqGao+y0+yRoNKwO1pH
	iIUyVJ9JbVRwZuJKy3sevsejWayk59XSK5OiT/MmSTC6XrFDiyV4d8AdxrS+hLIbYo2imD
	U+eGZZwQ781uRcb6kSDV10uSYJJ6f9laX+C2xy+ZmynEWpwtgMbVIiyVHJZO+bgzAvfXF2
	919jojCZkx3g9i5XLR8pNHpRwZFFuxLv0yzM0UtcWbecQB+kqLv4Hov1cACd8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760023850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=k/Atcw8FJK8QC24QJ8kPRtEJc6zGI4BdlyJuf9DRrH0=;
	b=KOHDwic+oKTt90Nx/Hce3E5KdlfR48+Fz7I47ctNZCq3UJCgr9fiZFUctVIx6wgYOwyZCJ
	am7dFk8k7t8Ey2BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.17.1-rt5
Message-ID: <20251009153049.OC9WFY8_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.17.1-rt5 patch set. 

Changes since v6.17.1-rt4:

  - Update the workqueue patch for BH-worker to the version which
    merged.

  - Backport two patches for nft_set_pipapo from upstream which were
    marked for stable nd clash somehow with already made backport of
    nft_set_pipapo in order to drop the BH-lock.

  - syzbot report a failure in networking with GRO offloading caused by
    the removal of the BH-lock.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.17.1-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/incr/patch-6.17.1-rt4-rt5.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.17.1-rt5

The RT patch against v6.17.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patch-6.17.1-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patches-6.17.1-rt5.tar.xz

Sebastian

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 94e226f637992..d6c94ee8edfc5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4258,11 +4258,10 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 				if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 					struct worker_pool *pool;
 
-					mutex_lock(&wq_pool_mutex);
+					guard(rcu)();
 					pool = get_work_pool(work);
 					if (pool)
 						workqueue_callback_cancel_wait_running(pool);
-					mutex_unlock(&wq_pool_mutex);
 				} else {
 					cpu_relax();
 				}
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b7..b43911562f4d1 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -8,11 +8,13 @@
 struct gro_cell {
 	struct sk_buff_head	napi_skbs;
 	struct napi_struct	napi;
+	local_lock_t		bh_lock;
 };
 
 int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	bool have_bh_lock = false;
 	struct gro_cell *cell;
 	int res;
 
@@ -25,6 +27,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 		goto unlock;
 	}
 
+	local_lock_nested_bh(&gcells->cells->bh_lock);
+	have_bh_lock = true;
 	cell = this_cpu_ptr(gcells->cells);
 
 	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {
@@ -39,6 +43,9 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (skb_queue_len(&cell->napi_skbs) == 1)
 		napi_schedule(&cell->napi);
 
+	if (have_bh_lock)
+		local_unlock_nested_bh(&gcells->cells->bh_lock);
+
 	res = NET_RX_SUCCESS;
 
 unlock:
@@ -54,6 +61,7 @@ static int gro_cell_poll(struct napi_struct *napi, int budget)
 	struct sk_buff *skb;
 	int work_done = 0;
 
+	__local_lock_nested_bh(&cell->bh_lock);
 	while (work_done < budget) {
 		skb = __skb_dequeue(&cell->napi_skbs);
 		if (!skb)
@@ -64,6 +72,7 @@ static int gro_cell_poll(struct napi_struct *napi, int budget)
 
 	if (work_done < budget)
 		napi_complete_done(napi, work_done);
+	__local_unlock_nested_bh(&cell->bh_lock);
 	return work_done;
 }
 
@@ -79,6 +88,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net_device *dev)
 		struct gro_cell *cell = per_cpu_ptr(gcells->cells, i);
 
 		__skb_queue_head_init(&cell->napi_skbs);
+		local_lock_init(&cell->bh_lock);
 
 		set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 96aefa504f57a..337daa777c353 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -550,8 +550,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
  *
  * This function is called from the data path.  It will search for
  * an element matching the given key in the current active copy.
- * Unlike other set types, this uses NFT_GENMASK_ANY instead of
- * nft_genmask_cur().
+ * Unlike other set types, this uses 0 instead of nft_genmask_cur().
  *
  * This is because new (future) elements are not reachable from
  * priv->match, they get added to priv->clone instead.
@@ -561,8 +560,8 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
  * inconsistent state: matching old entries get skipped but thew
  * newly matching entries are unreachable.
  *
- * GENMASK will still find the 'now old' entries which ensures consistent
- * priv->match view.
+ * GENMASK_ANY doesn't work for the same reason: old-gen entries get
+ * skipped, new-gen entries are only reachable from priv->clone.
  *
  * nft_pipapo_commit swaps ->clone and ->match shortly after the
  * genbit flip.  As ->clone doesn't contain the old entries in the first
@@ -579,7 +578,7 @@ nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 	const struct nft_pipapo_elem *e;
 
 	m = rcu_dereference(priv->match);
-	e = pipapo_get_slow(m, (const u8 *)key, NFT_GENMASK_ANY, get_jiffies_64());
+	e = pipapo_get_slow(m, (const u8 *)key, 0, get_jiffies_64());
 
 	return e ? &e->ext : NULL;
 }
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 3e584dc4ad20e..9235efb10dd52 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1179,7 +1179,6 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 
 	nft_pipapo_avx2_prepare();
 
-next_match:
 	nft_pipapo_for_each_field(f, i, m) {
 		bool last = i == m->field_count - 1, first = !i;
 		int ret = 0;
@@ -1226,6 +1225,7 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 
 #undef NFT_SET_PIPAPO_AVX2_LOOKUP
 
+next_match:
 		if (ret < 0) {
 			scratch->map_index = map_index;
 			kernel_fpu_end();
@@ -1238,8 +1238,11 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 
 			e = f->mt[ret].e;
 			if (unlikely(__nft_set_elem_expired(&e->ext, tstamp) ||
-				     !nft_set_elem_active(&e->ext, genmask)))
+				     !nft_set_elem_active(&e->ext, genmask))) {
+				ret = pipapo_refill(res, f->bsize, f->rules,
+						    fill, f->mt, last);
 				goto next_match;
+			}
 
 			scratch->map_index = map_index;
 			kernel_fpu_end();
