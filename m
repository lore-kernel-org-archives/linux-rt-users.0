Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B23CC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF40613A3
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 14:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhKSOoj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:44:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:44867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235994AbhKSOoi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 09:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637332886;
        bh=gprpuNYqUQO8OIsaLrzKaEbvenRTYintoS1tGXrXIx8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=B7wwTrEqky0POeIZ1spyiPi02LRCDOV5zUwRFNs9lv4QuCo3HKQthTcdSMP71tWBZ
         Y0v0ifB66+asVKalKg80q4mIrFNXd/7Fg69m2tzQHAzEeG6jpYQrgYaJu3+Ecm7GsJ
         ZabBKOoLUV2BC42QBvfp/e5pnRyUGyvlx4pdL0eY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1mZNgJ1vs5-015Ynp; Fri, 19
 Nov 2021 15:41:26 +0100
Message-ID: <773fd8246a1ec4ef79142d9e31b8ba4163a0d496.camel@gmx.de>
Subject: [rcf/patch] netpoll: Make it RT friendly
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Fri, 19 Nov 2021 15:41:25 +0100
In-Reply-To: <20211118163405.adczki7ibk22bw7e@linutronix.de>
References: <20211118163405.adczki7ibk22bw7e@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0lSg2JwzH1lKm0v2RwM4/NELr3hi4Ha30a1II/3jff58Yht5SIs
 Gl0adr7GDnHN1zNwYkVZ6LqgCQfYizQLRo500+DNMqjeByACuDmB77od5OnqpULiBfy0GS0
 pyhXqL5oLwQRwnCDl8VRHWXd+GxjvMF4lTp3Pxv9U4ioFJmJyXxKabOlCRAGPMLVPHEv24E
 K87a/MJksWd4Wqa+FmerQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4iG0Y9G663k=:20/S1t4zfqhKamEzyLnGYQ
 ZyOMkk9iU3NF/omrIDTRzHGBw9F4u/7vk+F6EWQLTJ/1De9BHlWDcd7+UM1LDIZoPdPRcJOSa
 z6xvBBJT98MAYn72cGY23Nq4e9UiqewLemqSszW415ks4h2mxqyLTXXoeREF0jUo6u3xuKyqs
 2r1sz9UTJsdtyZmnR2YuAAvO6GvwKlBITD6Nj6i6rRm0v45VrxkQhz+eRXz2X1OeGBm+Sh7Ng
 LppT8RO4JuBDCHLXd0XbyW7/x7RPrBK/Q2PGjlyP1/lP9n/c9Z+kdJljn7lxmqFsOWz/rXjqI
 TnkNKk/+e7rWNF8r9d75Kl0a/Xxic07oM98v40/MNgSgJK0WV9X2S8gnMAyenAHZRojdmHqmX
 U9IxXnUT/ycRqTfkVVoWacagZQlJwBs7IAnF1VborBbIuJ+lnZgLlN8qrVxbnIjOsfU3ZBD1i
 y9PNiTOWfTw0riOlAPuhUX2QhKipLja8uA+4TaSUsKZGvXXQLepPyQCq4c6IpepxmeS/T6Ync
 zG2fVe04iz/sEds9wghFSaIEg2ZMurqkVKEG9ku/iYdpyZrQSZL8FJRR+bS1e+DATIIRfiatL
 vQRVzddB66j2J9o+aVnfcYoTs8JdIfdQI3TwEd6pgsC+CfSV4XCcdVITKl0tGb+IErzKRLk6Z
 5nrRA9udkzidmHriVHMNNsi6irdKTTk8HuBicRKYx7KdJyvh5HXidTBMyhNmmijzKj/kWhOYh
 dAYFYBNRnOYWh/MpGAtS17+wHmD+O72rA4qTYm+rv5VGAtUk8dlj2GMFrv2OV3ZtbnYvcM1fE
 9RLmk1bfnDoHGkRIiVHqv1E6zY64Vw5ovHdEVkrUyGwn503tWM7+9UQ8CKpWZl3hktwLiaeL5
 kbl+SfZ7UWquXRBwyy//UhI/1pSN/HGJVX4Og6gzz0cAPHNPwjy0uA5TA4Z/VBSzWUw425FoJ
 4eyMlgHF99HNLGliTL/CMIXbE3PgvlLuyux2JJVxVySfQBPcy0vOKSQtLwCJHIK6JzQacYgis
 nHeKPylDNRo9sBZKU53ssnSpjrstOSS+RiHKKxR5ajbKqswEPVnesWto8xy7Wdj+0LFPfzOrY
 QSpnUArVrWhwaE=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-11-18 at 17:34 +0100, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
>
> I'm pleased to announce the v5.16-rc1-rt2 patch set.
>
> Changes since v5.16-rc1-rt1:
>
> =C2=A0 - Redo the delayed deallocation of the task-stack.
>
> Known issues
> =C2=A0=C2=A0=C2=A0=C2=A0 - netconsole triggers WARN.

The below seems to do the trick for netconsole in master.today-rt.

netpoll: Make it RT friendly

PREEMPT_RT cannot alloc/free memory when not preemptible, making
zap_completion_queue() disabling preemption across kfree() an
issue, as well as disabling IRQs asross __netpoll_send_skb(),
which leads to zap_completion_queue() and our pesky kfree().

We can let rcu_read_lock_bh() provide local exclusion for RT across
__netpoll_send_skb() (via softirq_ctrl.lock) instead of disabling
IRQs, and since zap_completion_queue() replaces sd->completion_queue
with IRQs disabled and makes a private copy, there's no need to
keep preemption disabled during traversal/freeing, so put_cpu_var()
before doing so.  Disable a couple warnings for RT, and we're done.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 net/core/netpoll.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

=2D-- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -252,6 +252,7 @@ static void zap_completion_queue(void)
 		clist =3D sd->completion_queue;
 		sd->completion_queue =3D NULL;
 		local_irq_restore(flags);
+		put_cpu_var(softnet_data);

 		while (clist !=3D NULL) {
 			struct sk_buff *skb =3D clist;
@@ -263,9 +264,8 @@ static void zap_completion_queue(void)
 				__kfree_skb(skb);
 			}
 		}
-	}
-
-	put_cpu_var(softnet_data);
+	} else
+		put_cpu_var(softnet_data);
 }

 static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
@@ -314,7 +314,8 @@ static netdev_tx_t __netpoll_send_skb(st
 	/* It is up to the caller to keep npinfo alive. */
 	struct netpoll_info *npinfo;

-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		lockdep_assert_irqs_disabled();

 	dev =3D np->dev;
 	npinfo =3D rcu_dereference_bh(dev->npinfo);
@@ -350,7 +351,7 @@ static netdev_tx_t __netpoll_send_skb(st
 			udelay(USEC_PER_POLL);
 		}

-		WARN_ONCE(!irqs_disabled(),
+		WARN_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT) && !irqs_disabled(),
 			"netpoll_send_skb_on_dev(): %s enabled interrupts in poll (%pS)\n",
 			dev->name, dev->netdev_ops->ndo_start_xmit);

@@ -365,16 +366,22 @@ static netdev_tx_t __netpoll_send_skb(st

 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
-	unsigned long flags;
+	unsigned long __maybe_unused flags;
 	netdev_tx_t ret;

 	if (unlikely(!np)) {
 		dev_kfree_skb_irq(skb);
 		ret =3D NET_XMIT_DROP;
 	} else {
-		local_irq_save(flags);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_save(flags);
+		else
+			rcu_read_lock_bh();
 		ret =3D __netpoll_send_skb(np, skb);
-		local_irq_restore(flags);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_restore(flags);
+		else
+			rcu_read_unlock_bh();
 	}
 	return ret;
 }


