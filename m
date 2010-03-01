From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] install backfire.c to $(srcdir)/backfire/
Date: Mon, 1 Mar 2010 21:04:01 +0100
Message-ID: <20100301200401.GI16049@pengutronix.de>
References: <20100224165611.GA22159@pengutronix.de> <1267030688-12244-2-git-send-email-u.kleine-koenig@pengutronix.de> <520f0cf11003011132r64a7f337va877df4c81a662c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38259 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab0CAU0N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 15:26:13 -0500
Content-Disposition: inline
In-Reply-To: <520f0cf11003011132r64a7f337va877df4c81a662c1@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi John,

On Mon, Mar 01, 2010 at 08:32:08PM +0100, John Kacur wrote:
> 2010/2/24 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > =A0Makefile | =A0 =A01 +
> > =A01 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 043b747..99fbba4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -110,6 +110,7 @@ install: all
> > =A0 =A0 =A0 =A0install -m 755 src/hwlatdetect/hwlatdetect.py $(DEST=
DIR)$(PYLIB)/hwlatdetect.py
> > =A0 =A0 =A0 =A0ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/h=
wlatdetect"
> > =A0 =A0 =A0 =A0mkdir -p "$(DESTDIR)$(srcdir)/backfire"
> > + =A0 =A0 =A0 install -m 644 src/backfire/backfire.c "$(DESTDIR)$(s=
rcdir)/backfire/backfire.c"
> > =A0 =A0 =A0 =A0gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir=
)/man4/backfire.4.gz"
> > =A0 =A0 =A0 =A0gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(ma=
ndir)/man8/cyclictest.8.gz"
> > =A0 =A0 =A0 =A0gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandi=
r)/man8/pi_stress.8.gz"
> > --
> > 1.6.6.2
> >
>=20
> Hi Uwe
>=20
> What is the purpose of this patch?
the idea if that if $(make install) creates the directory
/usr/src/backfire it should add something below, too.  Installing
backfire.c seems reasonable.  Maybe installing even the Makefile would
make sence, doesn't it?

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
