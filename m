From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.6.7-rt12
Date: Thu, 8 Sep 2016 21:00:27 +0200
Message-ID: <20160908190027.akgbp32hs6l5y5i6@linutronix.de>
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

I'm pleased to announce the v4.6.7-rt12 patch set. 

Changes since v4.6.7-rt11:

  - The update to v4.6.7-rt11 introduced a performance regression
    especially visible when compiling a kernel on /dev/shm. It is fixed
    by invoking less often the "chill" function. Reported by Joakim
    Hernberg.
  
  - We had a fix in v3.12.8-rt11 for ip_send_unicast_reply() which I
    dropped in v3.18.8 based -RT due code change and I assumed the need
    for extra serialization is no longer required. As it turns out it is
    still required :)

  - While looking around a similar serialisation might be required in
    icmp_sk(). No crash has been observed, this is just precaution.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.6.7-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/incr/patch-4.6.7-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.6.7-rt12

The RT patch against 4.6.5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patch-4.6.7-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.6/patches-4.6.7-rt12.tar.xz

Sebastian

diff --git a/fs/dcache.c b/fs/dcache.c
index 32c0bfecc920..aa418c1bdcb5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -40,6 +40,8 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/kasan.h>
+#include <linux/sched/rt.h>
+#include <linux/sched/deadline.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -748,6 +750,8 @@ static inline bool fast_dput(struct dentry *dentry)
  */
 void dput(struct dentry *dentry)
 {
+	struct dentry *parent;
+
 	if (unlikely(!dentry))
 		return;
 
@@ -784,14 +788,17 @@ void dput(struct dentry *dentry)
 	return;
 
 kill_it:
-	dentry = dentry_kill(dentry);
-	if (dentry) {
+	parent = dentry_kill(dentry);
+	if (parent) {
 		int r;
 
-		/* the task with the highest priority won't schedule */
-		r = cond_resched();
-		if (!r)
-			cpu_chill();
+		if (parent == dentry) {
+			/* the task with the highest priority won't schedule */
+			r = cond_resched();
+			if (!r && (rt_task(current) || dl_task(current)))
+				cpu_chill();
+		} else
+			dentry = parent;
 		goto repeat;
 	}
 }
diff --git a/localversion-rt b/localversion-rt
index 05c35cb58077..6e44e540b927 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index c1f1d5030d37..63731fd6af3e 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -78,6 +78,7 @@
 #include <linux/string.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/slab.h>
+#include <linux/locallock.h>
 #include <net/snmp.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -205,6 +206,8 @@ static const struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
+static DEFINE_LOCAL_IRQ_LOCK(icmp_sk_lock);
+
 static struct sock *icmp_sk(struct net *net)
 {
 	return *this_cpu_ptr(net->ipv4.icmp_sk);
@@ -216,12 +219,14 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 
 	local_bh_disable();
 
+	local_lock(icmp_sk_lock);
 	sk = icmp_sk(net);
 
 	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
 		/* This can happen if the output path signals a
 		 * dst_link_failure() for an outgoing ICMP packet.
 		 */
+		local_unlock(icmp_sk_lock);
 		local_bh_enable();
 		return NULL;
 	}
@@ -231,6 +236,7 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 static inline void icmp_xmit_unlock(struct sock *sk)
 {
 	spin_unlock_bh(&sk->sk_lock.slock);
+	local_unlock(icmp_sk_lock);
 }
 
 int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
@@ -359,6 +365,7 @@ static void icmp_push_reply(struct icmp_bxm *icmp_param,
 	struct sock *sk;
 	struct sk_buff *skb;
 
+	local_lock(icmp_sk_lock);
 	sk = icmp_sk(dev_net((*rt)->dst.dev));
 	if (ip_append_data(sk, fl4, icmp_glue_bits, icmp_param,
 			   icmp_param->data_len+icmp_param->head_len,
@@ -381,6 +388,7 @@ static void icmp_push_reply(struct icmp_bxm *icmp_param,
 		skb->ip_summed = CHECKSUM_NONE;
 		ip_push_pending_frames(sk, fl4);
 	}
+	local_unlock(icmp_sk_lock);
 }
 
 /*
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ad450509029b..c5521d1f1263 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -62,6 +62,7 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
+#include <linux/locallock.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -565,6 +566,7 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_send_check);
 
+static DEFINE_LOCAL_IRQ_LOCK(tcp_sk_lock);
 /*
  *	This routine will send an RST to the other tcp.
  *
@@ -689,10 +691,13 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
 
 	arg.tos = ip_hdr(skb)->tos;
+
+	local_lock(tcp_sk_lock);
 	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len);
+	local_unlock(tcp_sk_lock);
 
 	TCP_INC_STATS_BH(net, TCP_MIB_OUTSEGS);
 	TCP_INC_STATS_BH(net, TCP_MIB_OUTRSTS);
@@ -774,10 +779,12 @@ static void tcp_v4_send_ack(struct net *net,
 	if (oif)
 		arg.bound_dev_if = oif;
 	arg.tos = tos;
+	local_lock(tcp_sk_lock);
 	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len);
+	local_unlock(tcp_sk_lock);
 
 	TCP_INC_STATS_BH(net, TCP_MIB_OUTSEGS);
 }
