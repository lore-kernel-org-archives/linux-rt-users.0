From: eg Engleder Gerhard <eg@keba.com>
Subject: AW: UDP jitter
Date: Thu, 7 Nov 2013 09:00:34 +0100
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at>
References: <20130429222238.2b440d8c@sanja.asnn.org>
 <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
 <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xlspam03.mdcs.at ([217.13.183.27]:36092 "EHLO xlspam03.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab3KGIAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Nov 2013 03:00:38 -0500
In-Reply-To: <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> On Wed, 6 Nov 2013, Neboj=B9a =C6osi=E6 wrote:
> > You can try with this patch. I am quite sure that same problem=20
> > persists on all newer kernels (I am using 2.6.33), but never had a=20
> > time to create simple test to prove it.
>=20
> I'm looking forward to your detailed analysis ....
>=20
> > Index: net/sched/sch_generic.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- net/sched/sch_generic.c	(revision 1709)
> > +++ net/sched/sch_generic.c	(revision 1710)
> > @@ -120,16 +120,18 @@
> >  	int ret =3D NETDEV_TX_BUSY;
> > =20
> >  	/* And release qdisc */
> > -	spin_unlock(root_lock);
> > +/*	spin_unlock(root_lock);
> > =20
> >  	HARD_TX_LOCK(dev, txq);
> > +*/
>=20
> Do you really think this locking scheme is just for fun?=20
> qdisk_lock, i.e. root_lock and the netif_tx_lock are mutually=20
> exclusive for a reason. Reading the documentation and=20
> comments of code is optional, right?
>=20
> > > > When transmit queue is empty, thread wanting to send a message=20
> > > > comes directly to sch_direct_xmit, without changing context. It=
=20
> > > > then releases spin lock, and than takes another. So far so good=
=2E
> > > > If this starting thread is of lower priority, it can be=20
> preempted=20
> > > > by another thread, while still being in dev_hard_start_xmit=20
> > > > function This thread will check if HARD_TX_LOCK is=20
> taken, and if=20
> > > > so, go on and queue its own message.  If there are=20
> enough higher=20
> > > > priority tasks, tx can be stalled indefinitely. [..]
>=20
> Utter nonsense.

In my situation if a first thread is preempted in dev_hard_start_xmit, =
then a second
thread which transmits over the same interface sees a none empty queue =
and
just enqueue the skb in the queue. No transmit (HARD_TX_LOCK) is necess=
ary
because the first thread is already working on the queue. Please correc=
t me if I'm
not right.
=46or my case the first thread does normal SSH communication and the se=
cond
thread does real-time UDP communication. This results in a priority inv=
ersion for
the transmission of skb's over the same network interface.
Is there any chance to get rid of this priority inversion? Maybe with p=
riority qdisc?

> The code (sch_direct_xmit) you are modifying is called from=20
> exactly two places:
>=20
> 1) __dev_xmit_skb
>=20
> 2) __qdisc_run()
>=20
>    Which in turn two call sites:
>=20
>    1) __dev_xmit_skb() either directly or via qdisc_run()
>=20
>    2) net_tx_action() which is the NET_TX softirq action
>=20
> None of those calls does a trylock on the xmit lock. So what=20
> the heck are you talking about?
>=20
> Thanks,
>=20
> 	tglx

regards, gerhard--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
