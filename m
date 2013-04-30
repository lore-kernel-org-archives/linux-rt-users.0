From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: Re: UDP jitter
Date: Tue, 30 Apr 2013 19:26:53 +0200
Message-ID: <20130430192653.5c6c08b6@sanja.asnn.org>
References: <20130429222238.2b440d8c@sanja.asnn.org>
	<517FE1A5.1090702@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:39794 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab3D3R7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 13:59:08 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id D39A0E9DF9
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Apr 2013 19:26:57 +0200 (CEST)
In-Reply-To: <517FE1A5.1090702@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> Hi Neboj=C5=A1a,
Hi Carsten
>=20
> > I am doing some work on a product running kernel 2.6.33.7.2-rt30.
> > Applications running on this kernel are a bit specific, meaning tha=
t
> > there are a number of threads running on a different priorities.
> > For a several months I was haunted with spurious jitter, detected o=
n
> > UDP messages - multicast UDP messages where received on originating
> > node without any delay, but on other nodes a delay in range of 10s =
of
> > milliseconds was detected. Simply, it looked like a message was stu=
ck
> > in kernel before finally getting transmitted.
> > Finally, thanks to LTTng tool, I was able to locate the problem dow=
n to
> > this peace of code in net/sched/sch_generic.c:
> >
> > int sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
> >                      struct net_device *dev, struct netdev_queue *t=
xq,
> >                      spinlock_t *root_lock)
> > {
> >          int ret =3D NETDEV_TX_BUSY;
> >
> >          /* And release qdisc */
> >          spin_unlock(root_lock);
> >
> >          HARD_TX_LOCK(dev, txq);
> >
> >          if (!netif_tx_queue_stopped(txq) && !netif_tx_queue_frozen=
(txq))
> >                  ret =3D dev_hard_start_xmit(skb, dev, txq);
> >
> >
> >          HARD_TX_UNLOCK(dev, txq);
> >
> >          spin_lock(root_lock);
> > ...
> >
> > When transmit queue is empty, thread wanting to send a message come=
s
> > directly to sch_direct_xmit, without changing context. It then rele=
ases
> > spin lock, and than takes another. So far so good.
> > If this starting thread is of lower priority, it can be preempted b=
y
> > another thread, while still being in dev_hard_start_xmit function
> > This thread will check if HARD_TX_LOCK is taken, and if so, go on a=
nd
> > queue its own message.
> > If there are enough higher priority tasks, tx can be stalled
> > indefinitely. [..]
> Did you increase the priority of the related sirq-net-tx and sirq-net=
-rx=20
> kernel threads appropriately? Some more details on enabling real-time=
=20
> Ethernet are given here -> https://www.osadl.org/?id=3D930.
Thanks for the link, I was aware of it.
I did try to increase sirq-net-tx and rx, even to get tx higher than rx
(in case incoming traffic was creating problems), but it didn't make
any difference.=20
I was trying to isolate problem by running iperf, but it worked
perfectly well when run on it's own. No wonder, because it generates
traffic from the same priority, and to trigger this behaviour, one need
traffic from at least two levels of priority, and a busy CPU (so that
low priority thread can get blocked in driver for a noticeable period
of time ).
I suppose that running two iperf processes at different priorities can
demonstrate the problem.

>=20
> 	-Carsten.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Neboj=C5=A1a
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
