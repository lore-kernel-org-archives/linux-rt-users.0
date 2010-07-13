From: =?utf-8?q?Philipp_=C3=9Cberbacher?= <hollunder@lavabit.com>
Subject: Re: [ANNOUNCE] 2.6.33.6-rt26
Date: Tue, 13 Jul 2010 21:23:17 +0200
Message-ID: <1279048823-sup-6465@eris>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain> <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain> <alpine.LFD.2.00.1003121124120.22855@localhost.localdomain> <alpine.LFD.2.00.1003211158130.3147@localhost.localdomain> <alpine.LFD.2.00.1004071619490.32352@localhost.localdomain> <alpine.LFD.2.00.1004271744280.2951@localhost.localdomain> <alpine.LFD.2.00.1004301156590.2951@localhost.localdomain> <alpine.LFD.2.00.1005022109150.25342@localhost.localdomain> <alpine.LFD.2.00.1006091837410.2933@localhost.localdomain> <alpine.LFD.2.00.1007131745230.3321@localhost.localdomain> <1279042118-sup-7239@eris> <1279048394.20528.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from karen.lavabit.com ([72.249.41.33]:38600 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0GMTXX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Jul 2010 15:23:23 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 73A4911B98F
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jul 2010 14:23:23 -0500 (CDT)
Received: from localhost (eris.mozart.uni-klu.ac.at [143.205.216.185])
	by lavabit.com with ESMTP id 4SQWX5F49E83
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jul 2010 14:23:19 -0500
In-reply-to: <1279048394.20528.6.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Excerpts from Darcy L. Watkins's message of 2010-07-13 21:13:14 +0200:
>=20
> On Tue, 2010-07-13 at 11:04 -0700, Philipp =C3=9Cberbacher wrote:
> > Excerpts from Thomas Gleixner's message of 2010-07-13 17:54:35 +020=
0:
> > > We are pleased to announce the next update to our new preempt-rt
> > > series.
> > >=20
>=20
> --snip!--
>=20
> > >
> > > To build the 2.6.33.6-rt26 tree, the following patches should be
> > > applied:
> > >
> > >
> > http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.6.tar.bz2
> > >
> > http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.6-r=
t26.bz2
> > >
> > > Enjoy !
> > >
> > >       tglx
> >=20
> Hi,
>=20
> The patch applies OK to the kernel 2.6.33.5 tarball.  Either the patc=
h
> is just a misnamed RT patch update to 2.6.33.5 or it includes both th=
is
> and the 2.6.33.5-->2.6.33.6 incremental patch changes together and wa=
s
> just generated against the wrong baseline.  So try it against 2.6.33.=
5
> if you want to try something before the next patch is released.
>=20
> Darcy

Ah, thanks Darcy.
It's don't urgently need it, so I'll just wait for Thomas' response,
whether he'll upload a version against .6 or not. Either way is fine fo=
r
me.
--=20
Regards,
Philipp

--
"Wir stehen selbst entt=C3=A4uscht und sehn betroffen / Den Vorhang zu =
und alle Fragen offen." Bertolt Brecht, Der gute Mensch von Sezuan

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
