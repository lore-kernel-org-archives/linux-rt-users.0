From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Mon, 21 Aug 2017 15:12:54 +0200
Message-ID: <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
 <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbdHUNM4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Aug 2017 09:12:56 -0400
Content-Disposition: inline
In-Reply-To: <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-20 16:48:24 [+0200], Jacek Konieczny wrote:
> Does this help?

yup, the following patch should make it go away.

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 55c5f068d986..8bbb8f967614 100644
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


> The system has not crashed yet, I may catch something more.

okay.

> Jacek

Sebastian
