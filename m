From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/7] net: add a lock around icmp_sk()
Date: Fri, 23 Sep 2016 12:48:04 -0400
Message-ID: <20160923164809.726400219@goodmis.org>
References: <20160923164800.627094159@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760918AbcIWQsO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 12:48:14 -0400
Content-Disposition: inline; filename=0004-net-add-a-lock-around-icmp_sk.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.4.112-rt144-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

It looks like the this_cpu_ptr() access in icmp_sk() is protected with
local_bh_disable(). To avoid missing serialization in -RT I am adding
here a local lock. No crash has been observed, this is just precaution.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/ipv4/icmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
-- 
2.8.1


