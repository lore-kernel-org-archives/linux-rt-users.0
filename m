Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215F200108;
	Fri,  2 Aug 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608873; cv=none; b=LmgaK1vmYsAcJBCVOAi+07YEDOPz23haltoiILjhv8csCA36fC1MpQRKeGRfbYUuJRnzICAa/1lKvJ+M5wh0lHv73CJQ4Gz+3VwKpWJwAQa4EdLafLCSpqQDtsvHUikKYCn4J9nzY2yoqoQqb2t3ZsPbM9daxPlUgz8D2wd9PQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608873; c=relaxed/simple;
	bh=c17kktDIScLWGmCv1xAuru2/t57MeH65ZTEyFoRhm0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=he8jeEEiweNomWsyve2pW8P5Y72p3EVM0utQ2Ra35sK7vz4F0xkN1leXq1wcQVZ0CRNLZP6F4pdUGsEbEBmodhHGFcBqu/qNKVJU8RDH5Dzj5J/snOQqAnLYC5w8sbgwYUnSfXrFWG2mq70udl1efB74Z+aCk3jHsgjqGz1ZNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKNqUNvp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oypRtE/I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKNqUNvp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oypRtE/I"
Date: Fri, 2 Aug 2024 16:27:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722608870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ajMjKygtNXRsRfzl0KgBpoFeYrdRIqEvv6AU3KOfmFU=;
	b=bKNqUNvp9QRMMHl62bD3lSdtQe/RLsDEquv5pnm2mCD1m0QXgeva3Du9AhGtwv7fQAl0He
	5vlunaNW+ZQg52FcmqDEWXFqAB3ER40gh2iPMXiloWuQtZrss8fnhLPD25VEkMQKZ79I9Q
	WXbspVv2RUvJy8VEyQ1M3QBwekXZrJW0x2YN4IEjs0cbD4M4jetlph3SLr0KwpFyi4Hr4r
	i4W7EkDAsoo+Uuyuo8wxIFFTPQ26XBke76LjrsEYY9iJGZd6azi0ahAj1V0j5Lo80MH86S
	+w1K6faxqAYkhIcy0YrAIeG+KD6wbi1hJUyEVPhtWH3U75V1I3GkPRiusKSmoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722608870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ajMjKygtNXRsRfzl0KgBpoFeYrdRIqEvv6AU3KOfmFU=;
	b=oypRtE/IXZ3z3k5rrJQUDQs3+1FsVmVDkCXdMwR2ZtlL49ScG/t924mLGiwQW/G4dahtRr
	sn+zlklK2VFSn3Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10.2-rt14
Message-ID: <20240802142748.bt1qvHxQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10.2-rt14 patch set. 

Changes since v6.10.2-rt13:

  - Replace the "seg6_state/ BPF" fixup introduced in v6.10-rc6-rt11
    with a the version, that has been merged upstream.

  - Add another hunk to the i915 to avoid disabling interrupts during
    cursor updates.

Known issues
    None.

The delta patch against v6.10.2-rt13 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/incr/patch-6.10.2-rt13-rt14.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10.2-rt14

The RT patch against v6.10.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10.2-rt14.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10.2-rt14.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 23a122ee20c98..b5676e667c1ff 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -797,13 +797,15 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 		 */
 		intel_psr_wait_for_idle_locked(crtc_state);
 
-		local_irq_disable();
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_disable();
 
 		intel_vblank_evade(&evade);
 
 		drm_crtc_vblank_put(&crtc->base);
 	} else {
-		local_irq_disable();
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_disable();
 	}
 
 	if (new_plane_state->uapi.visible) {
@@ -813,7 +815,8 @@ intel_legacy_cursor_update(struct drm_plane *_plane,
 		intel_plane_disable_arm(plane, crtc_state);
 	}
 
-	local_irq_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 
 	intel_psr_unlock(crtc_state);
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2b8503fecd026..b1d9bc714c987 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -739,7 +739,6 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
-#define BPF_RI_F_SEG6_STATE	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -857,29 +856,6 @@ static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_ma
 		*lh_xsk = lh;
 }
 
-static inline bool bpf_net_ctx_seg6_state_avail(void)
-{
-	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
-
-	if (!bpf_net_ctx)
-		return false;
-	return bpf_net_ctx->ri.kern_flags & BPF_RI_F_SEG6_STATE;
-}
-
-static inline void bpf_net_ctx_seg6_state_set(void)
-{
-	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
-
-	bpf_net_ctx->ri.kern_flags |= BPF_RI_F_SEG6_STATE;
-}
-
-static inline void bpf_net_ctx_seg6_state_clr(void)
-{
-	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
-
-	bpf_net_ctx->ri.kern_flags &= ~BPF_RI_F_SEG6_STATE;
-}
-
 /* Compute the linear packet data range [data, data_end) which
  * will be accessed by various program types (cls_bpf, act_bpf,
  * lwt, ...). Subsystems allowing direct data access must (!)
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
diff --git a/net/core/filter.c b/net/core/filter.c
index 9556453a8b564..5002f4cd9f18e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6459,8 +6459,6 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
 	void *srh_tlvs, *srh_end, *ptr;
 	int srhoff = 0;
 
-	if (!bpf_net_ctx_seg6_state_avail())
-		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (srh == NULL)
 		return -EINVAL;
@@ -6518,8 +6516,6 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 	int hdroff = 0;
 	int err;
 
-	if (!bpf_net_ctx_seg6_state_avail())
-		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_X:
@@ -6597,8 +6593,6 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 	int srhoff = 0;
 	int ret;
 
-	if (!bpf_net_ctx_seg6_state_avail())
-		return -EINVAL;
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh == NULL))
 		return -EINVAL;
@@ -11053,7 +11047,6 @@ const struct bpf_verifier_ops lwt_seg6local_verifier_ops = {
 };
 
 const struct bpf_prog_ops lwt_seg6local_prog_ops = {
-	.test_run		= bpf_prog_test_run_skb,
 };
 
 const struct bpf_verifier_ops cg_sock_verifier_ops = {
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 3e3a48b7266b5..c74705ead9849 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1429,7 +1429,6 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	 * bpf_prog_run_save_cb().
 	 */
 	local_lock_nested_bh(&seg6_bpf_srh_states.bh_lock);
-	bpf_net_ctx_seg6_state_set();
 	srh_state = this_cpu_ptr(&seg6_bpf_srh_states);
 	srh_state->srh = srh;
 	srh_state->hdrlen = srh->hdrlen << 3;
@@ -1453,7 +1452,6 @@ static int input_action_end_bpf(struct sk_buff *skb,
 
 	if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 		goto drop;
-	bpf_net_ctx_seg6_state_clr();
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 
 	if (ret != BPF_REDIRECT)
@@ -1462,7 +1460,6 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	return dst_input(skb);
 
 drop:
-	bpf_net_ctx_seg6_state_clr();
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 	kfree_skb(skb);
 	return -EINVAL;
