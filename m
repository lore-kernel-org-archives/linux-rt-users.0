From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: realtime kernel for Debian
Date: Fri, 2 Oct 2009 22:20:03 +0200
Message-ID: <20091002202003.GB30475@pengutronix.de>
References: <alpine.DEB.2.00.0903282331360.22173@wr-linux02> <49CF50D3.1080000@gmail.com> <49CFBDBE.5020408@gmail.com> <20090329185525.GB25154@pengutronix.de> <49CFC58D.4010803@gmail.com> <20090329195638.GA25453@pengutronix.de> <49DF05B6.6000603@gmail.com> <20090413195356.GA13942@pengutronix.de> <4A09CEBC.70207@gmail.com> <20090513093517.GA11278@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Debian Developers <debian-devel@lists.debian.org>,
	pkg-multimedia-maintainers@lists.alioth.debian.org,
	linux-rt-users@vger.kernel.org, 521893@bugs.debian.org
To: Grammostola Rosea <rosea.grammostola@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998AbZJBUUG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Oct 2009 16:20:06 -0400
Content-Disposition: inline
In-Reply-To: <20090513093517.GA11278@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Wed, May 13, 2009 at 11:35:17AM +0200, Uwe Kleine-K=F6nig wrote:
> Hi,
>=20
> >>> I was wondering about how far are we with implementing a RT kerne=
l in=20
> >>>  Debian... Some progress here? Would be nice.
> >>>    =20
> >> The patch I created that "fits" on Debian's vanilla kernel creates
> >> conflicts on the sources with the Debian patches.
> >> I hope to be able to clean that up by minimizing the -rt series (e=
=2Eg.
> >> the first broken out patch consists usually of various bits from t=
he
> >> -tip tree that are (AFAIK) not all needed.)
> >>
> >> So just have some more patience.
> >>
> >>  =20
> > How are things going? Just interest...
> Hhhm, well, I spottet a problem.  The thing is that linux-rt does man=
y
> deep changes in the kernel and I won't be able to support the harder
> problems.  And upstream probably won't help because the Debian rt-ker=
nel
> isn't a vanilla rt-kernel.  Moreover even the broken out rt-patch isn=
't
> nicely sorted (e.g. bisectable, some patches undo changes of other
> patches earier in the series etc. pp), so I fear the Debian kernel te=
am
> isn't filled with enthusiasm when asked to add an rt variant.
>=20
> I already thought about packaging debian-kernel + rt for Debian and
> vanilla-kernel + rt for a non-Debian package repository such that it'=
s
> easy for bug reporters to try out a vanilla kernel.  But that still n=
eeds
> more work.
OK, the vanilla-kernel + rt is done.  See

	http://mid.gmane.org/20090926171218.GD13150@pengutronix.de

for an announcment and=20

	http://www.pengutronix.de/software/linux-rt/debian_en.html

for the documentation how to install it.

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
