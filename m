From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: Re: UDP jitter
Date: Wed, 6 Nov 2013 12:57:09 +0100
Message-ID: <20131106125709.2e091182@sth491dt.servo.net>
References: <20130429222238.2b440d8c@sanja.asnn.org>
	<517FE1A5.1090702@osadl.org>
	<20130430192653.5c6c08b6@sanja.asnn.org>
	<12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: eg Engleder Gerhard <eg@keba.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:56490 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179Ab3KFMZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Nov 2013 07:25:49 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 01008E8567
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Nov 2013 12:57:20 +0100 (CET)
In-Reply-To: <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Hello Neboj=C5=A1a,
>=20
> I have a similar problem now with 3.2.51-rt72. Did
> you find any solution?
>=20
> regards, gerhard
>=20
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: linux-rt-users-owner@vger.kernel.org=20
> > [mailto:linux-rt-users-owner@vger.kernel.org] Im Auftrag von=20
> > Neboj=C5=A1a Cosic
> > Gesendet: Dienstag, 30. April 2013 19:27
> > An: Carsten Emde
> > Cc: linux-rt-users
> > Betreff: Re: UDP jitter
> >=20
> >=20
> > > Hi Neboj=C5=A1a,
> > Hi Carsten
> > >=20
> > > > I am doing some work on a product running kernel 2.6.33.7.2-rt3=
0.
> > > > Applications running on this kernel are a bit specific,=20
> > meaning that=20
> > > > there are a number of threads running on a different priorities=
=2E
> > > > For a several months I was haunted with spurious jitter,=20
> > detected on=20
> > > > UDP messages - multicast UDP messages where received on=20
> > originating=20
> > > > node without any delay, but on other nodes a delay in=20
> > range of 10s=20
> > > > of milliseconds was detected. Simply, it looked like a=20
> > message was=20
> > > > stuck in kernel before finally getting transmitted.
> > > > Finally, thanks to LTTng tool, I was able to locate the=20
> > problem down=20
> > > > to this peace of code in net/sched/sch_generic.c:
> > > >
> > > > int sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
> > > >                      struct net_device *dev, struct=20
> > netdev_queue *txq,
> > > >                      spinlock_t *root_lock) {
> > > >          int ret =3D NETDEV_TX_BUSY;
> > > >
> > > >          /* And release qdisc */
> > > >          spin_unlock(root_lock);
> > > >
> > > >          HARD_TX_LOCK(dev, txq);
> > > >
> > > >          if (!netif_tx_queue_stopped(txq) &&=20
> > !netif_tx_queue_frozen(txq))
> > > >                  ret =3D dev_hard_start_xmit(skb, dev, txq);
> > > >
> > > >
> > > >          HARD_TX_UNLOCK(dev, txq);
> > > >
> > > >          spin_lock(root_lock);
> > > > ...
> > > >
> > > > When transmit queue is empty, thread wanting to send a=20
> > message comes=20
> > > > directly to sch_direct_xmit, without changing context. It then=20
> > > > releases spin lock, and than takes another. So far so good.
> > > > If this starting thread is of lower priority, it can be=20
> > preempted by=20
> > > > another thread, while still being in dev_hard_start_xmit functi=
on=20
> > > > This thread will check if HARD_TX_LOCK is taken, and if so, go =
on=20
> > > > and queue its own message.
> > > > If there are enough higher priority tasks, tx can be stalled=20
> > > > indefinitely. [..]
> > > Did you increase the priority of the related sirq-net-tx and=20
> > > sirq-net-rx kernel threads appropriately? Some more details on=20
> > > enabling real-time Ethernet are given here ->=20
> > https://www.osadl.org/?id=3D930.
> > Thanks for the link, I was aware of it.
> > I did try to increase sirq-net-tx and rx, even to get tx=20
> > higher than rx (in case incoming traffic was creating=20
> > problems), but it didn't make any difference.=20
> > I was trying to isolate problem by running iperf, but it=20
> > worked perfectly well when run on it's own. No wonder,=20
> > because it generates traffic from the same priority, and to=20
> > trigger this behaviour, one need traffic from at least two=20
> > levels of priority, and a busy CPU (so that low priority=20
> > thread can get blocked in driver for a noticeable period of time ).
> > I suppose that running two iperf processes at different=20
> > priorities can demonstrate the problem.
> >=20
> > >=20
> > > 	-Carsten.
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe=20
> > > linux-rt-users" in the body of a message to=20
> > majordomo@vger.kernel.org=20
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >=20
> > --
> > Neboj=C5=A1a
> > --
> > To unsubscribe from this list: send the line "unsubscribe=20
> > linux-rt-users" in the body of a message to=20
> > majordomo@vger.kernel.org More majordomo info at =20
> > http://vger.kernel.org/majordomo-info.html
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

You can try with this patch. I am quite sure that same problem persists
on all newer kernels (I am using 2.6.33), but never had a time to creat=
e
simple test to prove it.

Index: net/sched/sch_generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- net/sched/sch_generic.c	(revision 1709)
+++ net/sched/sch_generic.c	(revision 1710)
@@ -120,16 +120,18 @@
 	int ret =3D NETDEV_TX_BUSY;
=20
 	/* And release qdisc */
-	spin_unlock(root_lock);
+/*	spin_unlock(root_lock);
=20
 	HARD_TX_LOCK(dev, txq);
+*/
 	if (!netif_tx_queue_stopped(txq)
&& !netif_tx_queue_frozen(txq)) ret =3D dev_hard_start_xmit(skb, dev,
txq);=20
+/*
 	HARD_TX_UNLOCK(dev, txq);
=20
 	spin_lock(root_lock);
