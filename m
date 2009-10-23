From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org (v2)
Date: Fri, 23 Oct 2009 09:20:23 -0400
Message-ID: <1256304023.20866.827.camel@gandalf.stny.rr.com>
References: <20091022120832.4bfd29e2@torg> <20091022152539.04e2787a@torg>
	 <1256246328.20866.805.camel@gandalf.stny.rr.com>
	 <20091023081100.GB19418@pengutronix.de>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:50001 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZJWNUU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Oct 2009 09:20:20 -0400
In-Reply-To: <20091023081100.GB19418@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-10-23 at 10:11 +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> > > In addition to changing kernel locking, interrupts have been thre=
aded,
> > > meaning that instead of handling interrupts in a special "interru=
pt
> > > context", each interrupt number has a dedicated thread for runnin=
g its
> >=20
> > s/interrupt number/interrupt line/
> IIRC since .31-rt shared irqs even have one thread for each irq handl=
er.
> I'm not sure this is worth to be metioned though.

Well, that is going mainline too. We can mention that it is on its way,
but only drivers that implement it have it.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
