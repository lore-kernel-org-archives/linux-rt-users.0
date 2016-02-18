From: Jakub Kicinski <moorray3@wp.pl>
Subject: Re: [PATCH] sc16is7xx: switch to threaded irq for fixing RT issues
Date: Thu, 18 Feb 2016 08:46:34 +0000
Message-ID: <20160218084634.017c3ab4@laptop>
References: <1455523133-29895-1-git-send-email-sean.nyekjaer@prevas.dk>
	<20160215220810.11529101@laptop>
	<56C2D1A7.1030908@prevas.dk>
	<20160216210250.34c2f07f@laptop>
	<56C41FA5.4010605@prevas.dk>
	<20160217215427.0263dbbc@laptop>
	<20160217232546.GA4009@jcartwri.amer.corp.natinst.com>
	<56C572E4.20906@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Josh Cartwright <joshc@ni.com>, <linux-serial@vger.kernel.org>,
	<kubakici@wp.pl>, <linux-rt-users@vger.kernel.org>
To: Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean.nyekjaer@prevas.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.10]:17092 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424633AbcBRIqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Feb 2016 03:46:38 -0500
In-Reply-To: <56C572E4.20906@prevas.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 18 Feb 2016 08:29:40 +0100, Sean Nyekj=C3=A6r wrote:
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc=
16is7xx.c
> > index e78fa99..1bb5c0e 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1257,7 +1257,7 @@ static int sc16is7xx_probe(struct device *dev=
,
> >  =20
> >   	/* Setup interrupt */
> >   	ret =3D devm_request_irq(dev, irq, sc16is7xx_irq,
> > -			       IRQF_ONESHOT | flags, dev_name(dev), s);
> > +			       flags, dev_name(dev), s);
> >   	if (!ret)
> >   		return 0;
> > =20
> Wow, nice that you CC'd the RT guys :-)
>=20
> Josh that was it, it runs without deadlocks now :-D
>=20
> Thank you.
>=20
> Jakub, is this fix ok? Who is making this into a PATCH?

Yes, in fact similar patch circulated at some point but the author
flaked out before it was ready for merging.

Josh could you submit officially?  Please CC stable for 4.1+.
=46ixes: 9e6f4ca3e567 ("sc16is7xx: use kthread_worker for tx_work and i=
rq")

Thanks a lot!
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
