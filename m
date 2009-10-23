From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org (v2)
Date: Fri, 23 Oct 2009 10:11:00 +0200
Message-ID: <20091023081100.GB19418@pengutronix.de>
References: <20091022120832.4bfd29e2@torg> <20091022152539.04e2787a@torg> <1256246328.20866.805.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38544 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZJWIl7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Oct 2009 04:41:59 -0400
Content-Disposition: inline
In-Reply-To: <1256246328.20866.805.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

> > In addition to changing kernel locking, interrupts have been thread=
ed,
> > meaning that instead of handling interrupts in a special "interrupt
> > context", each interrupt number has a dedicated thread for running =
its
>=20
> s/interrupt number/interrupt line/
IIRC since .31-rt shared irqs even have one thread for each irq handler=
=2E
I'm not sure this is worth to be metioned though.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
