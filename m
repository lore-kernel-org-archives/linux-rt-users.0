From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.21-rt31
Date: Mon, 3 Oct 2016 18:03:07 -0400
Message-ID: <20161003180307.00671e3b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.4.21-rt31 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: f66e5df837eee446efdc8207b4e6bc93b2b83c02


Or to build 4.4.21-rt31 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.21.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.21-rt31.patch.xz



You can also build from 4.4.21-rt30 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.21-rt30-rt31.patch.xz



Enjoy,

-- Steve


Changes from v4.4.21-rt30:

---

Mike Galbraith (1):
      scsi/fcoe: Fix get_cpu()/put_cpu_light() imbalance in fcoe_recv_frame()

Sebastian Andrzej Siewior (8):
      timers: wakeup all timer waiters
      timers: wakeup all timer waiters without holding the base lock
      sched: lazy_preempt: avoid a warning in the !RT case
      net: add back the missing serialization in ip_send_unicast_reply()
      net: add a lock around icmp_sk()
      fs/dcache: resched/chill only if we make no progress
      x86/preempt-lazy: fixup should_resched()
      fs/dcache: incremental fixup of the retry routine

Steven Rostedt (Red Hat) (1):
      Linux 4.4.21-rt31

----
 arch/x86/include/asm/preempt.h | 17 +++++++++++++++--
 drivers/scsi/fcoe/fcoe.c       |  2 +-
 fs/dcache.c                    | 18 ++++++++++++------
 kernel/sched/core.c            |  2 +-
 kernel/time/timer.c            |  4 ++--
 localversion-rt                |  2 +-
 net/ipv4/icmp.c                |  8 ++++++++
 net/ipv4/tcp_ipv4.c            |  7 +++++++
 8 files changed, 47 insertions(+), 13 deletions(-)
---------------------------
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 5dbd2d0f91e0..6f432adc55cd 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -89,6 +89,8 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 	if (____preempt_count_dec_and_test())
 		return true;
 #ifdef CONFIG_PREEMPT_LAZY
+	if (current_thread_info()->preempt_lazy_count)
+		return false;
 	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
 #else
 	return false;
@@ -101,8 +103,19 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 static __always_inline bool should_resched(int preempt_offset)
 {
 #ifdef CONFIG_PREEMPT_LAZY
-	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset ||
-			test_thread_flag(TIF_NEED_RESCHED_LAZY));
+	u32 tmp;
+
+	tmp = raw_cpu_read_4(__preempt_count);
+	if (tmp == preempt_offset)
+		return true;
+
+	/* preempt count == 0 ? */
+	tmp &= ~PREEMPT_NEED_RESCHED;
+	if (tmp)
+		return false;
+	if (current_thread_info()->preempt_lazy_count)
+		return false;
+	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
 #else
 	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
 #endif
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f1622a05854b..cbbbebd86c6e 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1814,7 +1814,7 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 	 */
 	hp = (struct fcoe_hdr *) skb_network_header(skb);
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
+	stats = per_cpu_ptr(lport->stats, get_cpu_light());
 	if (unlikely(FC_FCOE_DECAPS_VER(hp) != FC_FCOE_VER)) {
 		if (stats->ErrorFrames < 5)
 			printk(KERN_WARNING "fcoe: FCoE version "
diff --git a/fs/dcache.c b/fs/dcache.c
index 76f007eb28f8..e80471cbfc19 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -748,6 +748,8 @@ static inline bool fast_dput(struct dentry *dentry)
  */
 void dput(struct dentry *dentry)
 {
+	struct dentry *parent;
+
 	if (unlikely(!dentry))
 		return;
 
@@ -784,14 +786,18 @@ repeat:
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
+			if (!r)
+				cpu_chill();
+		} else {
+			dentry = parent;
+		}
 		goto repeat;
 	}
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ec35352b06b..8bad7e2d363c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3474,7 +3474,7 @@ static __always_inline int preemptible_lazy(void)
 
 #else
 
-static int preemptible_lazy(void)
+static inline int preemptible_lazy(void)
 {
 	return 1;
 }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fee8682c209e..603699ff9411 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1051,7 +1051,7 @@ static void wait_for_running_timer(struct timer_list *timer)
 		   base->running_timer != timer);
 }
 
-# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
+# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)
 #else
 static inline void wait_for_running_timer(struct timer_list *timer)
 {
@@ -1313,8 +1313,8 @@ static inline void __run_timers(struct tvec_base *base)
 			}
 		}
 	}
-	wakeup_timer_waiters(base);
 	spin_unlock_irq(&base->lock);
+	wakeup_timer_waiters(base);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/localversion-rt b/localversion-rt
index b72862e06be4..a68b4337d4ce 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt30
+-rt31
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 74314d95d0f8..ff2593269089 100644
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
index 048418b049d8..7fcd8b60d751 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -62,6 +62,7 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
+#include <linux/locallock.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -566,6 +567,7 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_send_check);
 
+static DEFINE_LOCAL_IRQ_LOCK(tcp_sk_lock);
 /*
  *	This routine will send an RST to the other tcp.
  *
@@ -687,10 +689,13 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 		arg.bound_dev_if = sk->sk_bound_dev_if;
 
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
@@ -772,10 +777,12 @@ static void tcp_v4_send_ack(struct net *net,
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
