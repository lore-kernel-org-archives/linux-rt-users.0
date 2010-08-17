From: Clark Williams <williams@redhat.com>
Subject: Re: 2.6.35 RT support roadmap
Date: Tue, 17 Aug 2010 12:00:31 -0500
Message-ID: <20100817120031.4b1f779f@riff>
References: <CD8FEF6F82F55744AA1ED2BE5E7D8FD2015184EE0B@dnce01.ent.ti.com>
	<AANLkTimmCqNz+ZhSCqMGhaiCmW38hnjfkLV0ZU+e2gkX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/hjTy6UlirbyeS7+CEHgoecc"; protocol="application/pgp-signature"
Cc: "Walzer, Frank" <f-walzer@ti.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Xianghua Xiao <xiaoxianghua@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51595 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757510Ab0HQRAo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 13:00:44 -0400
In-Reply-To: <AANLkTimmCqNz+ZhSCqMGhaiCmW38hnjfkLV0ZU+e2gkX@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/hjTy6UlirbyeS7+CEHgoecc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Aug 2010 09:38:18 -0500
Xianghua Xiao <xiaoxianghua@gmail.com> wrote:

> On Tue, Aug 10, 2010 at 2:43 AM, Walzer, Frank <f-walzer@ti.com> wrote:
> > Hi Folks,
> >
> > What is the plan for kernel 2.6.35 support with the RT patch?
> >
> > I know this is a difficult (and unliked) question but I would like at l=
east to get some idea. My management is pushing me for dates when we could =
run some trials.
> > If nobody is looking at that we have to come up with some other plan.
> >
> > Thanks a lot.
> >
> > Frank
> >
> >
> > Texas Instruments Deutschland GmbH, Haggertystr. 1, D-85356 Freising. A=
mtsgericht M=FCnchen HRB 40960. Gesch=E4ftsf=FChrer: Dr. Wolfram Tietscher.=
 Vorsitzender des Aufsichtsrates: Edgar Frank
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
>=20
> Yes it would be great if we can know which kernel release will have rt
> patch for it. So far it seems to like a myth.

When I last talked with Thomas (a bit over a week ago) the plan was to
release an rt patch for the 2.6.35 tree. My guess is that when Thomas
gets back (he's on vacation this week), he will forward port the current
2.6.33.7-rt29 to 2.6.35 and we'll have a new -rt patch.

Clark

--Sig_/hjTy6UlirbyeS7+CEHgoecc
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkxqwDcACgkQHyuj/+TTEp1bfACgtbrVPguLbVW44kLdItS42WsO
XhgAnRp5FI1RYYkzIEU4Rz+5KbgRvQUK
=VgvL
-----END PGP SIGNATURE-----

--Sig_/hjTy6UlirbyeS7+CEHgoecc--
