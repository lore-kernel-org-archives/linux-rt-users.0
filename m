From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: debian RT kernel
Date: Wed, 20 May 2015 01:25:34 +0100
Message-ID: <1432081534.12412.37.camel@decadent.org.uk>
References: <CAG_ZyaA83dFKKvEsNhzyGkjrbsY=_mFBGjmg+M1-+MPo=-hOUw@mail.gmail.com>
	 <20150519115633.55ec7739@gandalf.local.home>
	 <1432054729.12412.26.camel@decadent.org.uk>
	 <CAG_ZyaDHeu11MYGRveTcaEz+QyRR7=ZcuuN4ke4RJV3EfVNKnQ@mail.gmail.com>
	 <20150519150621.128ecdb7@gandalf.local.home>
	 <CAG_ZyaCQrW3xQzXw82qeL0U2JGjg5Wv7cX061_Vw+HJU5tZfVw@mail.gmail.com>
	 <20150519181055.27fbfca4@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-dVBaD/2OKaScHQ9qhL1T"
Cc: =?UTF-8?Q?Jarom=C3=ADr_Mike=C5=A1?= <mira.mikes@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41148 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126AbbETAZx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2015 20:25:53 -0400
In-Reply-To: <20150519181055.27fbfca4@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-dVBaD/2OKaScHQ9qhL1T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-05-19 at 18:10 -0400, Steven Rostedt wrote:
> On Wed, 20 May 2015 00:03:32 +0200
> Jarom=C3=ADr Mike=C5=A1 <mira.mikes@gmail.com> wrote:
>=20
> > 2015-05-19 21:06 GMT+02:00 Steven Rostedt <rostedt@goodmis.org>:
> > > On Tue, 19 May 2015 20:45:58 +0200
> > > Jarom=C3=ADr Mike=C5=A1 <mira.mikes@gmail.com> wrote:
> > >
> > >> Do you (rt devs) plan make patches again for latest kernels as you
> > >> have done before?
> > >
> > > Ideally, we will get RT into mainline. There's still a lot of work to
> > > do, and that's somewhat where the focus is.
> >=20
> > Yes, but as I understand this process could last for years and some RT
> > patches will be always maintained out of mainline.
> > Or something changed?
> > What should do user which need RT kernel now?
>=20
> Well, 4.0-rt has just been released :-)

...and now imported into the Debian packaging repo.

Ben.

--=20
Ben Hutchings
I'm not a reverse psychological virus.  Please don't copy me into your sig.

--=-dVBaD/2OKaScHQ9qhL1T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVVvUiOe/yOyVhhEJAQocZA//Sh4ipYMuaO5x9/60tYPzGDLLi4+tdWzf
iIEppQu7w7Vs1P8+2WBAhMiYkU6lL40MdSUvmlgIZp4bwav6/nNrOLailjA4F6F/
Iuek4q7umBTL4uK7rjXOPvB/ppcfV4YwXm6Xnlp716aX5/LzCtnq6A1qpX2lzsa4
HW+cleDaxNQjL5kohkvLt+FNN04LOOyfM16n+D/cO6yFIUtD3Lf5Cv93urx+/pdM
3O8h8n7yHKqKePwzzWZYg9JVnfPhvE03lwgnbv23L0tzaKTejGf+HLeE3VBkgq9k
OlypvwlfVCMGGcN/N9kiqG6JVRIMvz+2lAzCF1VFodvQ5qfaMFA+gAV5nduQOP++
8SOohXoRswB93W29Q9iQ9cZLB94kCxElzFdiTnCvsX+L/v2lSV10H3M3EPq/2q44
7qM885Bp864MWFXZF6j/QWYa9OFWxVU3uF8LcoHpevz4NuyQf+PQsqj1uUCEeWvh
Y4xYXyt0krbWkFRrECmrmSdIpmPFQD485yEcchGzNOZU0g/oG0f0xzPK5iLSjW+N
JMnW2wm4Kk3ZW5S63daC43nKipWsO1wDBbLZ4izFftWvUZ+ti0QVvlNyN8egTFrG
0NguqjFrNqFEXZ1wBUDLgYWFbrLSq7GFQNrpTegmEaFrVpjEp4WgGYKCV6Ql/JIo
hZ0Mi0C/cKI=
=Zy2k
-----END PGP SIGNATURE-----

--=-dVBaD/2OKaScHQ9qhL1T--
