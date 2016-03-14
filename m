From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like
 handling
Date: Mon, 14 Mar 2016 09:48:32 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603140946450.3657@nanos>
References: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk> <alpine.DEB.2.11.1603131103020.3657@nanos> <56E6585A.3060203@prevas.dk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-492379229-1457945313=:3657"
Cc: linux-serial@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rt-users@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>
To: =?ISO-8859-15?Q?Sean_Nyekj=E6r?= <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45553 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228AbcCNIuB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Mar 2016 04:50:01 -0400
In-Reply-To: <56E6585A.3060203@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-492379229-1457945313=:3657
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Mon, 14 Mar 2016, Sean Nyekjær wrote:
> On 2016-03-13 11:25, Thomas Gleixner wrote:
> > On Fri, 11 Mar 2016, Sean Nyekjaer wrote:
> > 
> > >   static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
> > >   {
> > >   	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < s->devtype->nr_uart; ++i)
> > > +		disable_irq_nosync(s->p[i].port.irq);
> > Aside of the lack of a changelog. This is completely bogus. You disable the
> > same interrupt a gazillion of times.
> I can't see why the interrupt is disabled a gazillion times.
> When the irq is disabled the function will not be called before it's enabled
> again... Or have i missed something?

> > > +	for (i = 0; i < s->devtype->nr_uart; ++i)
> > > +		disable_irq_nosync(s->p[i].port.irq);

port.irq is the same for all ports at least according to the init function. It
is actually @irq, the handler function argument.

Thanks,

	tglx
--8323329-492379229-1457945313=:3657--
