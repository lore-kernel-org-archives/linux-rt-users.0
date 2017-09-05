From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Tue, 5 Sep 2017 11:17:13 +0200
Message-ID: <20170905091712.koywolqt5qwaslpk@linutronix.de>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
 <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
 <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
 <52e67cfd-0bb3-ce97-7b28-f2afb1d3c1cb@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44531 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdIEJRO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 05:17:14 -0400
Content-Disposition: inline
In-Reply-To: <52e67cfd-0bb3-ce97-7b28-f2afb1d3c1cb@jajcus.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-23 19:04:20 [+0200], Jacek Konieczny wrote:
> On 2017-08-21 15:12, Sebastian Andrzej Siewior wrote:
> > On 2017-08-20 16:48:24 [+0200], Jacek Konieczny wrote:
> >> Does this help?
> > 
> > yup, the following patch should make it go away.
> > 
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> [...]
> 
> I have applied the patch, no crash since then, but I got another problem
> detected:
I'm sorry, I missed that. What about this on-top?

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index eeb1a66df402..298afcd8e219 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -61,6 +61,9 @@ static inline int __local_trylock(struct local_irq_lock *lv)
 		lv->owner = current;
 		lv->nestcnt = 1;
 		return 1;
+	} else if (lv->owner == current) {
+		lv->nestcnt++;
+		return 1;
 	}
 	return 0;
 }
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 8ea63314f196..169b27596bc7 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -218,12 +218,16 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 {
 	struct sock *sk;
 
+	if (!local_trylock(icmp_sk_lock))
+		return NULL;
+
 	sk = icmp_sk(net);
 
 	if (unlikely(!spin_trylock(&sk->sk_lock.slock))) {
 		/* This can happen if the output path signals a
 		 * dst_link_failure() for an outgoing ICMP packet.
 		 */
+		local_unlock(icmp_sk_lock);
 		return NULL;
 	}
 	return sk;
@@ -232,6 +236,7 @@ static inline struct sock *icmp_xmit_lock(struct net *net)
 static inline void icmp_xmit_unlock(struct sock *sk)
 {
 	spin_unlock(&sk->sk_lock.slock);
+	local_unlock(icmp_sk_lock);
 }
 
 int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
@@ -421,7 +426,6 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 
 	/* Needed by both icmp_global_allow and icmp_xmit_lock */
 	local_bh_disable();
-	local_lock(icmp_sk_lock);
 
 	/* global icmp_msgs_per_sec */
 	if (!icmpv4_global_allow(net, type, code))
@@ -466,7 +470,6 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 out_unlock:
 	icmp_xmit_unlock(sk);
 out_bh_enable:
-	local_unlock(icmp_sk_lock);
 	local_bh_enable();
 }
 
@@ -679,7 +682,6 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 
 	/* Needed by both icmp_global_allow and icmp_xmit_lock */
 	local_bh_disable();
-	local_lock(icmp_sk_lock);
 
 	/* Check global sysctl_icmp_msgs_per_sec ratelimit, unless
 	 * incoming dev is loopback.  If outgoing dev change to not be
@@ -768,7 +770,6 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 out_unlock:
 	icmp_xmit_unlock(sk);
 out_bh_enable:
-	local_unlock(icmp_sk_lock);
 	local_bh_enable();
 out:;
 }
> 
> Jacek

Sebastian
