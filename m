Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9241419BA;
	Wed, 19 Jun 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810736; cv=none; b=Kh8soPd7uHEyi1GlT+kGJU32IBtVfgFKh3FvvTDrkj5B6qWWR0i9WSq07yNeaGLTUyHbFBCSsp3rQFU2pn/SPCSv7qsrAOqFNdKrvehiIKSG3BrjL9jIQIp84aR/4huKS/HU2ele3jLnATrg+Y+PM8v0KC/qu9jidJiqKmtyAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810736; c=relaxed/simple;
	bh=WzWDtNue3hRd2biGkJTRD00eZMjZrOqv7+jwWg0sAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nt5K348J9wN4aaFXp1X0eiWhGGzoLhf5+i8ikgWbN8jdqqi5M144BgYrYjVMZwZzx2xPKgRZhuaEdi/rtfg5yt9mvKMnMbGSdngYdcYfMlr5/pQQ86yS0lpeRNE+Pnl8jI4kz6X5zfFX+hR6wz8hzgTNfEp7KV9qO8hbpEc2DGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ytltaMUA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dats/ee+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ytltaMUA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dats/ee+"
Date: Wed, 19 Jun 2024 17:25:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718810732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JvTd++bxqB2tzJ/1TJMkxtwR2mcwlGeOghjVO6g9sbI=;
	b=ytltaMUAReaCQdmNEailem09qwRruemiMTzlhcuf+PDtSOi7ZmovR6kSZR8RXFrv/Hegjw
	GfeyR1k2TPE3tAetYhK5Q2XfSkx10RqQGoZxnFERpbM2BV9Z7JSu3EKwqch5ekMehLvuQ5
	hdItJVkB+F+JhQztX7+N8SpK31avjGI15u1Q0RYcuCekpEyhhOIxT9eCV9lyT8qF8js+gB
	YFSUJBAnz4QMFznc9OJ83qVHqCzuqKfFpje7Yea4LYmCMtsVn60fEY7kebx/luVAvqgMsp
	U043Vs6ti+uLBX+w+8HPoEw+eAdCgnSpJu2UAOk+QMjP8R7NPgcM8n8f4EWxZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718810732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JvTd++bxqB2tzJ/1TJMkxtwR2mcwlGeOghjVO6g9sbI=;
	b=Dats/ee+iRjMNLXOHghJ77767v0dxOU7zjgYgfM1JwFGBSP+uNK6sx8PvQ5xeAMa52N10s
	iFFLGM0LUZX6MGAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.10-rc4-rt7
Message-ID: <20240619152531.TtA4yAWo@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.10-rc4-rt7 patch set. 

Changes since v6.10-rc4-rt6:

  - Update the net/BH series to the last version that has been posted.

  - Update the i915 patches based on feedback.

Known issues
    None.

The delta patch against v6.10-rc4-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/incr/patch-6.10-rc4-rt6-rt7.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.10-rc4-rt7

The RT patch against v6.10-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patch-6.10-rc4-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.10/older/patches-6.10-rc4-rt7.tar.xz

Sebastian

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index 2ca54bc235925..12cbf04990182 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -273,7 +273,12 @@ wait_remaining_ms_from_jiffies(unsigned long timestamp_jiffies, int to_wait_ms)
 						   (Wmax))
 #define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
 
-/* If CONFIG_PREEMPT_COUNT is disabled, in_atomic() always reports false. */
+/*
+ * If CONFIG_PREEMPT_COUNT is disabled, in_atomic() always reports false.
+ * On PREEMPT_RT the context isn't becoming atomic because it is used in an
+ * interrupt handler or because a spinlock_t is acquired. This leads to
+ * warnings which don't occur otherwise and therefore the check is disabled.
+ */
 #if defined(CONFIG_DRM_I915_DEBUG) && defined(CONFIG_PREEMPT_COUNT) && !defined(CONFIG_PREEMPT_RT)
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) WARN_ON_ONCE((ATOMIC) && !in_atomic())
 #else
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f0ab89caf3cc2..883d55005362c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -43,6 +43,7 @@
 
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
+#include <linux/netdevice_xmit.h>
 #include <uapi/linux/netdevice.h>
 #include <uapi/linux/if_bonding.h>
 #include <uapi/linux/pkt_cls.h>
@@ -3223,15 +3224,7 @@ struct softnet_data {
 	struct sk_buff_head	xfrm_backlog;
 #endif
 	/* written and read only by owning cpu: */
-	struct {
-#ifndef CONFIG_PREEMPT_RT
-		u16 recursion;
-#endif
-		u8  more;
-#ifdef CONFIG_NET_EGRESS
-		u8  skip_txqueue;
-#endif
-	} xmit;
+	struct netdev_xmit xmit;
 #ifdef CONFIG_RPS
 	/* input_queue_head should be written by cpu owning this struct,
 	 * and only read by other cpus. Worth using a cache line.
@@ -3259,18 +3252,17 @@ struct softnet_data {
 
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
 
-#ifdef CONFIG_PREEMPT_RT
-static inline int dev_recursion_level(void)
-{
-	return current->net_xmit_recursion;
-}
-
-#else
-
+#ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
+#else
+static inline int dev_recursion_level(void)
+{
+	return current->net_xmit.recursion;
+}
+
 #endif
 
 void __netif_schedule(struct Qdisc *q);
@@ -4886,18 +4878,35 @@ static inline ktime_t netdev_get_tstamp(struct net_device *dev,
 	return hwtstamps->hwtstamp;
 }
 
-static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
-					      struct sk_buff *skb, struct net_device *dev,
-					      bool more)
+#ifndef CONFIG_PREEMPT_RT
+static inline void netdev_xmit_set_more(bool more)
 {
 	__this_cpu_write(softnet_data.xmit.more, more);
-	return ops->ndo_start_xmit(skb, dev);
 }
 
 static inline bool netdev_xmit_more(void)
 {
 	return __this_cpu_read(softnet_data.xmit.more);
 }
+#else
+static inline void netdev_xmit_set_more(bool more)
+{
+	current->net_xmit.more = more;
+}
+
+static inline bool netdev_xmit_more(void)
+{
+	return current->net_xmit.more;
+}
+#endif
+
+static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
+					      struct sk_buff *skb, struct net_device *dev,
+					      bool more)
+{
+	netdev_xmit_set_more(more);
+	return ops->ndo_start_xmit(skb, dev);
+}
 
 static inline netdev_tx_t netdev_start_xmit(struct sk_buff *skb, struct net_device *dev,
 					    struct netdev_queue *txq, bool more)
diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
new file mode 100644
index 0000000000000..38325e0702968
--- /dev/null
+++ b/include/linux/netdevice_xmit.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_NETDEVICE_XMIT_H
+#define _LINUX_NETDEVICE_XMIT_H
+
+struct netdev_xmit {
+	u16 recursion;
+	u8  more;
+#ifdef CONFIG_NET_EGRESS
+	u8  skip_txqueue;
+#endif
+};
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bd2a568b22d05..34c6169f631eb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -36,6 +36,7 @@
 #include <linux/signal_types.h>
 #include <linux/syscall_user_dispatch_types.h>
 #include <linux/mm_types_task.h>
+#include <linux/netdevice_xmit.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
@@ -977,7 +978,7 @@ struct task_struct {
 	unsigned                        in_thrashing:1;
 #endif
 #ifdef CONFIG_PREEMPT_RT
-	u8				net_xmit_recursion;
+	struct netdev_xmit		net_xmit;
 #endif
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/net/core/dev.c b/net/core/dev.c
index 85702022c5cd4..7d59afa862630 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3942,6 +3942,7 @@ netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
 	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
 }
 
+#ifndef CONFIG_PREEMPT_RT
 static bool netdev_xmit_txqueue_skipped(void)
 {
 	return __this_cpu_read(softnet_data.xmit.skip_txqueue);
@@ -3952,6 +3953,19 @@ void netdev_xmit_skip_txqueue(bool skip)
 	__this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
 }
 EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
+
+#else
+static bool netdev_xmit_txqueue_skipped(void)
+{
+	return current->net_xmit.skip_txqueue;
+}
+
+void netdev_xmit_skip_txqueue(bool skip)
+{
+	current->net_xmit.skip_txqueue = skip;
+}
+EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
+#endif
 #endif /* CONFIG_NET_EGRESS */
 
 #ifdef CONFIG_NET_XGRESS
diff --git a/net/core/dev.h b/net/core/dev.h
index 2f96d63053ad0..4984dd9b334bc 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -151,24 +151,7 @@ void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
 
-#ifdef CONFIG_PREEMPT_RT
-static inline bool dev_xmit_recursion(void)
-{
-	return unlikely(current->net_xmit_recursion > XMIT_RECURSION_LIMIT);
-}
-
-static inline void dev_xmit_recursion_inc(void)
-{
-	current->net_xmit_recursion++;
-}
-
-static inline void dev_xmit_recursion_dec(void)
-{
-	current->net_xmit_recursion--;
-}
-
-#else
-
+#ifndef CONFIG_PREEMPT_RT
 static inline bool dev_xmit_recursion(void)
 {
 	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
@@ -184,6 +167,21 @@ static inline void dev_xmit_recursion_dec(void)
 {
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
+#else
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(current->net_xmit.recursion > XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	current->net_xmit.recursion++;
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	current->net_xmit.recursion--;
+}
 #endif
 
 #endif
