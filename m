From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.112-rt144
Date: Mon, 3 Oct 2016 18:05:39 -0400
Message-ID: <20161003180539.4d15c869@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:32832 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753353AbcJCWFn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Oct 2016 18:05:43 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.4.112-rt144 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.4-rt
  Head SHA1: 4a9c0c15edbde9dffad4ad8677ef71003ef08445


Or to build 3.4.112-rt144 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.112.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.112-rt144.patch.xz



You can also build from 3.4.112-rt143 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.112-rt143-rt144.patch.xz



Enjoy,

-- Steve


Changes from v3.4.112-rt143:

---

Sebastian Andrzej Siewior (6):
      timers: wakeup all timer waiters
      timers: wakeup all timer waiters without holding the base lock
      net: add back the missing serialization in ip_send_unicast_reply()
      net: add a lock around icmp_sk()
      fs/dcache: resched/chill only if we make no progress
      fs/dcache: incremental fixup of the retry routine

Steven Rostedt (Red Hat) (1):
      Linux 3.4.112-rt144

----
 fs/dcache.c         | 17 +++++++++++++++--
 kernel/timer.c      |  4 ++--
 localversion-rt     |  2 +-
 net/ipv4/icmp.c     |  8 ++++++++
 net/ipv4/tcp_ipv4.c |  7 +++++++
 5 files changed, 33 insertions(+), 5 deletions(-)
---------------------------
diff --git a/fs/dcache.c b/fs/dcache.c
index 67a137772f13..e0a439c13318 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -527,6 +527,8 @@ relock:
  */
 void dput(struct dentry *dentry)
 {
+	struct dentry *parent;
+
 	if (!dentry)
 		return;
 
@@ -564,9 +566,20 @@ repeat:
 	return;
 
 kill_it:
-	dentry = dentry_kill(dentry, 1);
-	if (dentry)
+	parent = dentry_kill(dentry, 1);
+	if (parent) {
+		int r;
+
+		if (parent == dentry) {
+			/* the task with the highest priority won't schedule */
+			r = cond_resched();
+			if (!r)
+				cpu_chill();
+		} else {
+			dentry = parent;
+		}
 		goto repeat;
+	}
 }
 EXPORT_SYMBOL(dput);
 
diff --git a/kernel/timer.c b/kernel/timer.c
index c9b100922747..d94b2c463d9b 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -978,7 +978,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 			   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
@@ -1235,8 +1235,8 @@ static inline void __run_timers(struct tvec_base *base)
 			spin_lock_irq(&base->lock);
 		}
 	}
-	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
+	wakeup_timer_waiters(base);
 }
 
 #ifdef CONFIG_NO_HZ
diff --git a/localversion-rt b/localversion-rt
index a7cc5d609b19..b479c897962f 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt143
+-rt144
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 9a37732e8f32..a0d96df4cd2d 100644
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
@@ -203,6 +204,8 @@ static const struct icmp_control icmp_pointers[NR_ICMP_TYPES+1];
  *
  *	On SMP we have one ICMP socket per-cpu.
  */
+static DEFINE_LOCAL_IRQ_LOCK(icmp_sk_lock);
+
 static struct sock *icmp_sk(struct net *net)
 {
 	return net->ipv4.icmp_sk[smp_processor_id()];
@@ -214,12 +217,14 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 
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
@@ -229,6 +234,7 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 static inline void icmp_xmit_unlock(struct sock *sk)
 {
 	spin_unlock_bh(&sk->sk_lock.slock);
+	local_unlock(icmp_sk_lock);
 }
 
 /*
@@ -299,6 +305,7 @@ static void icmp_push_reply(struct icmp_bxm *icmp_param,
 	struct sock *sk;
 	struct sk_buff *skb;
 
+	local_lock(icmp_sk_lock);
 	sk = icmp_sk(dev_net((*rt)->dst.dev));
 	if (ip_append_data(sk, fl4, icmp_glue_bits, icmp_param,
 			   icmp_param->data_len+icmp_param->head_len,
@@ -321,6 +328,7 @@ static void icmp_push_reply(struct icmp_bxm *icmp_param,
 		skb->ip_summed = CHECKSUM_NONE;
 		ip_push_pending_frames(sk, fl4);
 	}
+	local_unlock(icmp_sk_lock);
 }
 
 /*
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 727678dc7968..0981d537d8dd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -62,6 +62,7 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
+#include <linux/locallock.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -569,6 +570,7 @@ int tcp_v4_gso_send_check(struct sk_buff *skb)
 	return 0;
 }
 
+static DEFINE_LOCAL_IRQ_LOCK(tcp_sk_lock);
 /*
  *	This routine will send an RST to the other tcp.
  *
@@ -686,8 +688,11 @@ static void tcp_v4_send_reset(struct sock *sk, struct sk_buff *skb)
 
 	net = dev_net(skb_dst(skb)->dev);
 	arg.tos = ip_hdr(skb)->tos;
+
+	local_lock(tcp_sk_lock);
 	ip_send_reply(net->ipv4.tcp_sock, skb, ip_hdr(skb)->saddr,
 		      &arg, arg.iov[0].iov_len);
+	local_unlock(tcp_sk_lock);
 
 	TCP_INC_STATS_BH(net, TCP_MIB_OUTSEGS);
 	TCP_INC_STATS_BH(net, TCP_MIB_OUTRSTS);
@@ -769,8 +774,10 @@ static void tcp_v4_send_ack(struct sk_buff *skb, u32 seq, u32 ack,
 	if (oif)
 		arg.bound_dev_if = oif;
 	arg.tos = tos;
+	local_lock(tcp_sk_lock);
 	ip_send_reply(net->ipv4.tcp_sock, skb, ip_hdr(skb)->saddr,
 		      &arg, arg.iov[0].iov_len);
+	local_unlock(tcp_sk_lock);
 
 	TCP_INC_STATS_BH(net, TCP_MIB_OUTSEGS);
 }
