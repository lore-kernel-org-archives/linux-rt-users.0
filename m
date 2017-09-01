From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.11.12-rt11
Date: Fri, 1 Sep 2017 10:50:46 +0200
Message-ID: <20170901085046.m72jgetjo2iktipa@linutronix.de>
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

I'm pleased to announce the v4.11.12-rt11 patch set. 

Changes since v4.11.12-rt10:

  - Jacek Konieczny reported a lockdep splat of tcp_sk_lock vs softirq.

  - Mike Galbraith fixed a lockdep splat in the zcomp driver.

  - Mike Galbraith reported a locking problem in hrtimer during CPU
    hotplug.

Known issues
	- There was a report regarding a deadlock within the rtmutex code.

The delta patch against v4.11.12-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/incr/patch-4.11.12-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.11.12-rt11

The RT patch against v4.11.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patch-4.11.12-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.11/older/patches-4.11.12-rt11.tar.xz

Sebastian
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
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
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1391,7 +1391,7 @@ static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }
 
 #endif
 
-static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+static int __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	struct hrtimer_clock_base *base = cpu_base->clock_base;
 	unsigned int active = cpu_base->active_bases;
@@ -1432,8 +1432,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 				raise = 1;
 		}
 	}
-	if (raise)
-		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+	return raise;
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1447,6 +1446,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t expires_next, now, entry_time, delta;
 	int retries = 0;
+	int raise;
 
 	BUG_ON(!cpu_base->hres_active);
 	cpu_base->nr_events++;
@@ -1465,7 +1465,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	 */
 	cpu_base->expires_next = KTIME_MAX;
 
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 
 	/* Reevaluate the clock bases for the next expiry */
 	expires_next = __hrtimer_get_next_event(cpu_base);
@@ -1476,6 +1476,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	cpu_base->expires_next = expires_next;
 	cpu_base->in_hrtirq = 0;
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 
 	/* Reprogramming necessary ? */
 	if (!tick_program_event(expires_next, 0)) {
@@ -1555,6 +1557,7 @@ void hrtimer_run_queues(void)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	ktime_t now;
+	int raise;
 
 	if (__hrtimer_hres_active(cpu_base))
 		return;
@@ -1573,8 +1576,10 @@ void hrtimer_run_queues(void)
 
 	raw_spin_lock(&cpu_base->lock);
 	now = hrtimer_update_base(cpu_base);
-	__hrtimer_run_queues(cpu_base, now);
+	raise = __hrtimer_run_queues(cpu_base, now);
 	raw_spin_unlock(&cpu_base->lock);
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
 /*
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -713,8 +713,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	arg.tos = ip_hdr(skb)->tos;
 	arg.uid = sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
-	local_lock(tcp_sk_lock);
 	local_bh_disable();
+	local_lock(tcp_sk_lock);
 	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
@@ -722,8 +722,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
-	local_bh_enable();
 	local_unlock(tcp_sk_lock);
+	local_bh_enable();
 
 #ifdef CONFIG_TCP_MD5SIG
 out:
@@ -801,16 +801,16 @@ static void tcp_v4_send_ack(const struct sock *sk,
 		arg.bound_dev_if = oif;
 	arg.tos = tos;
 	arg.uid = sock_net_uid(net, sk_fullsock(sk) ? sk : NULL);
-	local_lock(tcp_sk_lock);
 	local_bh_disable();
+	local_lock(tcp_sk_lock);
 	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len);
 
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
-	local_bh_enable();
 	local_unlock(tcp_sk_lock);
+	local_bh_enable();
 }
 
 static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
