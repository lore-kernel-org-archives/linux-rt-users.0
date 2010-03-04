From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Nvidia patches for 2.6.33-rt?
Date: Thu, 4 Mar 2010 09:42:17 +0100
Message-ID: <20100304084217.GC5011@pengutronix.de>
References: <4ccf65461003020059h272bccfay1c9200906995a9e2@mail.gmail.com> <loom.20100303T130614-97@post.gmane.org> <4ccf65461003031920x4384ab8cg2b89ba890009ea8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Ng Oon-Ee <ngoonee@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59382 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab0CDImT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Mar 2010 03:42:19 -0500
Content-Disposition: inline
In-Reply-To: <4ccf65461003031920x4384ab8cg2b89ba890009ea8f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> > I have absolutely no idea if this is the best way to handle the sem=
aphore_init
> > issue, I don't even know what a semaphore is, but I submitted a sim=
ple patch at
> > http://www.nvnews.net/vbulletin/showthread.php?t=3D148509 anyway. I=
t builds and
> > appears to be working, but I'd like some verification that sema_ini=
t(mutex,1) is
> > a valid substitute for semaphore_init(mutex).
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
> Works here as well (for nvidia 195.36.08). Many thanks, Jonathan. Suc=
h
> a simple patch compared to the previous one for 2.6.31-rt.
The patch is much easier now because the spinlock functions are
nicely wrapped in NV_... macros in nvidia's patch.
=20
> Would still appreciate information from someone who knows the code
> about sema_init(mutex,1) though =3D).
Well, it should work the same.  Still I wouldn't be surprised if this
should be a mutex instead, I havn't looked.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
