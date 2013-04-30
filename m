From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: UDP jitter
Date: Tue, 30 Apr 2013 17:22:13 +0200
Message-ID: <517FE1A5.1090702@osadl.org>
References: <20130429222238.2b440d8c@sanja.asnn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:60199 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932930Ab3D3PdL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 11:33:11 -0400
In-Reply-To: <20130429222238.2b440d8c@sanja.asnn.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Neboj=C5=A1a,

> I am doing some work on a product running kernel 2.6.33.7.2-rt30.
> Applications running on this kernel are a bit specific, meaning that
> there are a number of threads running on a different priorities.
> For a several months I was haunted with spurious jitter, detected on
> UDP messages - multicast UDP messages where received on originating
> node without any delay, but on other nodes a delay in range of 10s of
> milliseconds was detected. Simply, it looked like a message was stuck
> in kernel before finally getting transmitted.
> Finally, thanks to LTTng tool, I was able to locate the problem down =
to
> this peace of code in net/sched/sch_generic.c:
>
> int sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
>                      struct net_device *dev, struct netdev_queue *txq=
,
>                      spinlock_t *root_lock)
> {
>          int ret =3D NETDEV_TX_BUSY;
>
>          /* And release qdisc */
>          spin_unlock(root_lock);
>
>          HARD_TX_LOCK(dev, txq);
>
>          if (!netif_tx_queue_stopped(txq) && !netif_tx_queue_frozen(t=
xq))
>                  ret =3D dev_hard_start_xmit(skb, dev, txq);
>
>
>          HARD_TX_UNLOCK(dev, txq);
>
>          spin_lock(root_lock);
> ...
>
> When transmit queue is empty, thread wanting to send a message comes
> directly to sch_direct_xmit, without changing context. It then releas=
es
> spin lock, and than takes another. So far so good.
> If this starting thread is of lower priority, it can be preempted by
> another thread, while still being in dev_hard_start_xmit function
> This thread will check if HARD_TX_LOCK is taken, and if so, go on and
> queue its own message.
> If there are enough higher priority tasks, tx can be stalled
> indefinitely. [..]
Did you increase the priority of the related sirq-net-tx and sirq-net-r=
x=20
kernel threads appropriately? Some more details on enabling real-time=20
Ethernet are given here -> https://www.osadl.org/?id=3D930.

	-Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
