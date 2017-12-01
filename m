From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 08/15] net: take the tcp_sk_lock lock with BH disabled
Date: Fri, 01 Dec 2017 10:48:45 -0500
Message-ID: <20171201154912.631375175@goodmis.org>
References: <20171201154837.379265211@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        Jacek Konieczny <jajcus@jajcus.net>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0008-net-take-the-tcp_sk_lock-lock-with-BH-disabled.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Lockdep may complain about an unsafe locking scenario:
|      CPU0                    CPU1
|      ----                    ----
| lock((tcp_sk_lock).lock);
|                              lock(&per_cpu(local_softirq_locks[i], __cpu).lock);
|                              lock((tcp_sk_lock).lock);
| lock(&per_cpu(local_softirq_locks[i], __cpu).lock);

in the call paths:
	do_current_softirqs -> tcp_v4_send_ack()
vs
	tcp_v4_send_reset -> do_current_softirqs().

This should not happen since local_softirq_locks is per CPU. Reversing
the order makes lockdep happy.

Reported-by: Jacek Konieczny <jajcus@jajcus.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/ipv4/tcp_ipv4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3336e1534bc5..3b7298459c87 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -698,8 +698,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	arg.tos = ip_hdr(skb)->tos;
 
-	local_lock(tcp_sk_lock);
 	local_bh_disable();
+	local_lock(tcp_sk_lock);
 	ip_send_unicast_reply(*this_cpu_ptr(net->ipv4.tcp_sk),
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
@@ -707,8 +707,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	__TCP_INC_STATS(net, TCP_MIB_OUTSEGS);
 	__TCP_INC_STATS(net, TCP_MIB_OUTRSTS);
-	local_bh_enable();
 	local_unlock(tcp_sk_lock);
+	local_bh_enable();
 
 #ifdef CONFIG_TCP_MD5SIG
 out:
@@ -784,16 +784,16 @@ static void tcp_v4_send_ack(struct net *net,
 	if (oif)
 		arg.bound_dev_if = oif;
 	arg.tos = tos;
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
-- 
2.13.2
