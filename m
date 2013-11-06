From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UDP jitter
Date: Wed, 6 Nov 2013 20:07:47 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-27229125-1383764867=:23353"
Cc: eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-2?Q?Neboj=B9a_=C6osi=E6?= <nebojsa@asnn.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46986 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab3KFTHv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Nov 2013 14:07:51 -0500
In-Reply-To: <20131106125709.2e091182@sth491dt.servo.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-27229125-1383764867=:23353
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 6 Nov 2013, Nebojša Ćosić wrote:
> You can try with this patch. I am quite sure that same problem persists
> on all newer kernels (I am using 2.6.33), but never had a time to create
> simple test to prove it.

I'm looking forward to your detailed analysis ....

> Index: net/sched/sch_generic.c
> ===================================================================
> --- net/sched/sch_generic.c	(revision 1709)
> +++ net/sched/sch_generic.c	(revision 1710)
> @@ -120,16 +120,18 @@
>  	int ret = NETDEV_TX_BUSY;
>  
>  	/* And release qdisc */
> -	spin_unlock(root_lock);
> +/*	spin_unlock(root_lock);
>  
>  	HARD_TX_LOCK(dev, txq);
> +*/

Do you really think this locking scheme is just for fun? qdisk_lock,
i.e. root_lock and the netif_tx_lock are mutually exclusive for a
reason. Reading the documentation and comments of code is optional,
right?

> > > When transmit queue is empty, thread wanting to send a message
> > > comes directly to sch_direct_xmit, without changing context. It
> > > then releases spin lock, and than takes another. So far so good.
> > > If this starting thread is of lower priority, it can be
> > > preempted by another thread, while still being in
> > > dev_hard_start_xmit function This thread will check if
> > > HARD_TX_LOCK is taken, and if so, go on and queue its own
> > > message.  If there are enough higher priority tasks, tx can be
> > > stalled indefinitely. [..]

Utter nonsense.

The code (sch_direct_xmit) you are modifying is called from exactly
two places:

1) __dev_xmit_skb

2) __qdisc_run()

   Which in turn two call sites:

   1) __dev_xmit_skb() either directly or via qdisc_run()

   2) net_tx_action() which is the NET_TX softirq action

None of those calls does a trylock on the xmit lock. So what the heck
are you talking about?

Thanks,

	tglx
--8323329-27229125-1383764867=:23353--
