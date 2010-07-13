From: "Darcy L. Watkins" <dwatkins@tranzeo.com>
Subject: Re: [ANNOUNCE] 2.6.33.6-rt26
Date: Tue, 13 Jul 2010 12:13:14 -0700
Message-ID: <1279048394.20528.6.camel@localhost.localdomain>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>
	 <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain>
	 <alpine.LFD.2.00.1003121124120.22855@localhost.localdomain>
	 <alpine.LFD.2.00.1003211158130.3147@localhost.localdomain>
	 <alpine.LFD.2.00.1004071619490.32352@localhost.localdomain>
	 <alpine.LFD.2.00.1004271744280.2951@localhost.localdomain>
	 <alpine.LFD.2.00.1004301156590.2951@localhost.localdomain>
	 <alpine.LFD.2.00.1005022109150.25342@localhost.localdomain>
	 <alpine.LFD.2.00.1006091837410.2933@localhost.localdomain>
	 <alpine.LFD.2.00.1007131745230.3321@localhost.localdomain>
	 <1279042118-sup-7239@eris>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Philipp =?ISO-8859-1?Q?=DCberbacher?= <hollunder@lavabit.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail2.tranzeo.com ([64.114.87.10]:11583 "EHLO mail2.tranzeo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab0GMTNP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Jul 2010 15:13:15 -0400
In-Reply-To: <1279042118-sup-7239@eris>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 2010-07-13 at 11:04 -0700, Philipp =C3=9Cberbacher wrote:
> Excerpts from Thomas Gleixner's message of 2010-07-13 17:54:35 +0200:
> > We are pleased to announce the next update to our new preempt-rt
> > series.
> >=20

--snip!--

> >
> > To build the 2.6.33.6-rt26 tree, the following patches should be
> > applied:
> >
> >
> http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.6.tar.bz2
> >
> http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.6-rt2=
6.bz2
> >
> > Enjoy !
> >
> >       tglx
>=20
Hi,

The patch applies OK to the kernel 2.6.33.5 tarball.  Either the patch
is just a misnamed RT patch update to 2.6.33.5 or it includes both this
and the 2.6.33.5-->2.6.33.6 incremental patch changes together and was
just generated against the wrong baseline.  So try it against 2.6.33.5
if you want to try something before the next patch is released.

Darcy


> Thanks Thomas,
> but I have a problem applying the patch.
> I get lots of ignored hunks and it ends and fails with:
>=20
> 2 out of 2 hunks ignored -- saving rejects to file
> sound/soc/codecs/wm8990.c.rej
> patching file virt/kvm/kvm_main.c
>=20
> I tried to build with my usual script, which just does:
> patch -Np1 -i ../patch-2.6.33.6-rt26
>=20
> Before that it applies the .6 patch, with the same command, without
> any hickup.
> I don't know whether something is wrong with the patch or whether I
> did
> something wrong.
> --
> Regards,
> Philipp
>=20
> --
> "Wir stehen selbst entt=C3=83=C2=A4uscht und sehn betroffen / Den Vor=
hang zu und
> alle Fragen offen." Bertolt Brecht, Der gute Mensch von Sezuan
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
