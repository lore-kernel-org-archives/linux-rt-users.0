From: Clark Williams <clark.williams@gmail.com>
Subject: Re: Changing real time priority of interrupt handler thread
Date: Tue, 25 May 2010 08:50:19 -0500
Message-ID: <20100525085019.11ab10bc@torg>
References: <20100525130254.GA1715@rivendell>
	<1274793941.22648.207.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/7Fr9/wLstHQA.DwI0ZzM_mo"; protocol="application/pgp-signature"
Cc: rostedt@goodmis.org, linux-rt-users@vger.kernel.org
To: Raphael Hertzog <raphael@ouaza.com>,
	Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:49960 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0EYNub (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 May 2010 09:50:31 -0400
Received: by qyk13 with SMTP id 13so7276413qyk.1
        for <linux-rt-users@vger.kernel.org>; Tue, 25 May 2010 06:50:30 -0700 (PDT)
In-Reply-To: <1274793941.22648.207.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/7Fr9/wLstHQA.DwI0ZzM_mo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 25 May 2010 09:25:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 2010-05-25 at 15:02 +0200, Raphael Hertzog wrote:
> > Hi,
> >=20
> > Le mercredi 05 mai 2010, Nivedita Singhvi a =E9crit :
> > > Raphael Hertzog wrote:
> > >=20
> > > >In case it was not clear, I want to run the IRQ handler of the serial
> > > >ports at a higher priority than the other ones (like network, disk,
> > > >etc.) to avoid buffer overruns.
> > >=20
> > > Have you tried using the rtctl utility and the /etc/rtgroups file?
> >=20
> > Nope, not yet. I was not aware of it.
> >=20
> > Le jeudi 06 mai 2010, Steven Rostedt a =E9crit :
> > > Also try out tuna. If you have fedora:
> > >=20
> > >  yum install tuna
> >=20
> > I have Debian and none of the two tools quoted above seem to be package=
d.
> > But thanks for your answers, I will check them out.
> >=20
>=20
> I have installed and used tuna on a Debian machine. It takes a bit to
> get all the dependencies straight, but it is possible.
>=20
> > BTW I can't find a "rtctl" project, are the SRPM the official upstream
> > sources? For tuna there's a least a git repo.
>=20
> I added Clark Williams to the Cc. He should be able to answer that
> question.
>

Hey Niv and Raphael,

Yeah  the official upstream for rtctl is currently the SRPM. Never
really anticipated that anyone would want it :)

Clark

--Sig_/7Fr9/wLstHQA.DwI0ZzM_mo
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkv71Z8ACgkQqA4JVb61b9dVQQCcCJ39qipRIIUO/54Gtw4EtQXS
+98Ani+uk5sZ/1VcnSTv73z/hlHElrUS
=1Z64
-----END PGP SIGNATURE-----

--Sig_/7Fr9/wLstHQA.DwI0ZzM_mo--
