From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/10] net: add back the missing serialization in ip_send_unicast_reply()
Date: Thu, 22 Sep 2016 19:17:33 -0400
Message-ID: <20160922231741.932341705@goodmis.org>
References: <20160922231728.394180695@goodmis.org>
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
Received: from mail.kernel.org ([198.145.29.136]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757295AbcIVXRr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 19:17:47 -0400
Content-Disposition: inline; filename=0005-net-add-back-the-missing-serialization-in-ip_send_un.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.42-rt45-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Some time ago Sami Pietikainen reported a crash on -RT in
ip_send_unicast_reply() which was later fixed by Nicholas Mc Guire
(v3.12.8-rt11). Later (v3.18.8) the code was reworked and I dropped the
patch. As it turns out it was mistake.
I have reports that the same crash is possible with a similar backtrace.
It seems that vanilla protects access to this_cpu_ptr() via
local_bh_disable(). This does not work the on -RT since we can have
NET_RX and NET_TX running in parallel on the same CPU.
This is brings back the old locks.

|Unable to handle kernel NULL pointer dereference at virtual address 00000010
|PC is at __ip_make_skb+0x198/0x3e8
|[<c04e39d8>] (__ip_make_skb) from [<c04e3ca8>] (ip_push_pending_frames+0x20/0x40)
|[<c04e3ca8>] (ip_push_pending_frames) from [<c04e3ff0>] (ip_send_unicast_reply+0x210/0x22c)
|[<c04e3ff0>] (ip_send_unicast_reply) from [<c04fbb54>] (tcp_v4_send_reset+0x190/0x1c0)
|[<c04fbb54>] (tcp_v4_send_reset) from [<c04fcc1c>] (tcp_v4_do_rcv+0x22c/0x288)
|[<c04fcc1c>] (tcp_v4_do_rcv) from [<c0474364>] (release_sock+0xb4/0x150)
|[<c0474364>] (release_sock) from [<c04ed904>] (tcp_close+0x240/0x454)
|[<c04ed904>] (tcp_close) from [<c0511408>] (inet_release+0x74/0x7c)
|[<c0511408>] (inet_release) from [<c0470728>] (sock_release+0x30/0xb0)
|[<c0470728>] (sock_release) from [<c0470abc>] (sock_close+0x1c/0x24)
|[<c0470abc>] (sock_close) from [<c0115ec4>] (__fput+0xe8/0x20c)
|[<c0115ec4>] (__fput) from [<c0116050>] (____fput+0x18/0x1c)
|[<c0116050>] (____fput) from [<c0058138>] (task_work_run+0xa4/0xb8)
|[<c0058138>] (task_work_run) from [<c0011478>] (do_work_pending+0xd0/0xe4)
|[<c0011478>] (do_work_pending) from [<c000e740>] (work_pending+0xc/0x20)
|Code: e3530001 8a000001 e3a00040 ea000011 (e5973010)

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/ipv4/tcp_ipv4.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5d5390299277..7a9139da3854 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -62,6 +62,7 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
+#include <linux/locallock.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -562,6 +563,7 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_v4_send_check);
 
+static DEFINE_LOCAL_IRQ_LOCK(tcp_sk_lock);
 /*
  *	This routine will send an RST to the other tcp.
  *
@@ -683,10 +685,13 @@ static void tcp_v4_send_reset(struct sock *sk, struct sk_buff *skb)
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
@@ -768,10 +773,12 @@ static void tcp_v4_send_ack(struct sk_buff *skb, u32 seq, u32 ack,
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
-- 
2.8.1


