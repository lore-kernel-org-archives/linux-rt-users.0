From: Clark Williams <williams@redhat.com>
Subject: Re: Determining latest stable release.
Date: Wed, 28 Mar 2012 15:34:50 -0500
Message-ID: <20120328153450.52c62ab8@redhat.com>
References: <CAOHJ0jTVxzgfBK=GSEr14YrpFZEqFE_qDqftaUgGWDgm344NNg@mail.gmail.com>
	<CAOHJ0jQphT30v-y1HMiHYOnFVumovkccCV43mDJjBx=fko=GUg@mail.gmail.com>
	<20120328140022.2998bfbc@redhat.com>
	<op.wbwdrtr2uqv2j3@woifes-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/dEP/Bv6QKAXlBhH6KvFQIj6"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org, Carsten Emde <ce@ceag.ch>
To: "Wolfgang Wallner" <wolfgang-wallner@gmx.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32778 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758562Ab2C1Ue5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Mar 2012 16:34:57 -0400
In-Reply-To: <op.wbwdrtr2uqv2j3@woifes-laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/dEP/Bv6QKAXlBhH6KvFQIj6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Mar 2012 22:27:19 +0200
"Wolfgang Wallner" <wolfgang-wallner@gmx.at> wrote:

>=20
> What is the relation between these stable releases and what the OSADL =20
> calls 'latest stable'? [1]
>=20
> Regards, Wolfgang
>=20
>=20
> [1] =20
> https://www.osadl.org/Latest-Stable-Realtime.latest-stable-realtime-linux=
.0.html
>=20
>=20
>=20
> On Wed, 28 Mar 2012 21:00:22 +0200, Clark Williams <williams@redhat.com> =
=20
> wrote:
>=20
> > On Tue, 27 Mar 2012 15:59:31 -0500
> > Robert Barrows <Robert.Barrows@metriainnovation.com> wrote:
> >
> >> Does the PREEMPT_RT patch have a method of determining latest stable
> >> release?
> >>
> >> I notice that 3.0.35 goes up to rt44 was declared a stable release but
> >> so was rt43
> >> Now 3.2.12 goes up to rt22, and that was updated March 23rd with =20
> >> 3.0.35-rt44.
> >>
> >> Is there a reason to think that 3.0.35-rt44 is more stable than =20
> >> 3.2.12-rt22?
> >> The real question is: is there a rule of thumb on how you would choose
> >> a rt patched kernel for a production machine?
> >>
> >> Thanks.
> >>
> >> -Robb Barrows
> >> --
> >>
> >
> > The stuff that Steven releases is the stable series, while Thomas
> > does the devel releases. So if you're not looking for the latest and
> > greatest, I'd stick to what Steven releases.
> >
> > Clark


I think we'll have to ask Carsten about his stable release criteria. It
may be that he's being more conservative than us and staying on a 2.6
kernel.=20

Clark

--Sig_/dEP/Bv6QKAXlBhH6KvFQIj6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9zdeoACgkQHyuj/+TTEp1HHACfa3l93eRWDCnw/67j8XujJwN/
BowAoMt5QYn3HAp6J51c4wS5m6JHFpCA
=TUz7
-----END PGP SIGNATURE-----

--Sig_/dEP/Bv6QKAXlBhH6KvFQIj6--
