From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH rt-tests 4/9] signaltest: drop unused tsnorm()
Date: Wed, 16 Sep 2015 14:48:28 -0500
Message-ID: <20150916194828.GI3126@jcartwri.amer.corp.natinst.com>
References: <cover.1441038216.git.joshc@ni.com>
 <ce9b5fb3e680b9a355142dd91d54ce1fb02ae664.1441038216.git.joshc@ni.com>
 <alpine.LFD.2.20.1509152356090.13077@riemann.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:44389 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753347AbbIPTsa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Sep 2015 15:48:30 -0400
In-Reply-To: <alpine.LFD.2.20.1509152356090.13077@riemann.fritz.box>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2015 at 12:00:10AM +0200, John Kacur wrote:
> On Mon, 31 Aug 2015, Josh Cartwright wrote:
>=20
> > tsnorm() is not used at all in signaltest.  Remove it.
> >=20
> > Signed-off-by: Josh Cartwright <joshc@ni.com>
> > ---
> >  src/signaltest/signaltest.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >=20
> > diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> > index 9454a26..c6d1cfd 100644
> > --- a/src/signaltest/signaltest.c
> > +++ b/src/signaltest/signaltest.c
> > @@ -69,14 +69,6 @@ static int shutdown;
> >  static int tracelimit =3D 0;
> >  static int oldtrace =3D 0;
> > =20
> > -static inline void tsnorm(struct timespec *ts)
> > -{
> > -	while (ts->tv_nsec >=3D NSEC_PER_SEC) {
> > -		ts->tv_nsec -=3D NSEC_PER_SEC;
> > -		ts->tv_sec++;
> > -	}
> > -}
> > -
> >  static inline long calcdiff(struct timespec t1, struct timespec t2)
> >  {
> >  	long diff;
> > --=20
> > 2.5.0
> >=20
> > --
>=20
> As you can see, many of the programs in this suite are modeled after=20
> cyclictest, but many of them don't unfortunately receive nearly the=20
> amount of testing that cyclictest does. Now the fact that this function=
=20
> was copied from cyclictest, but not used, sends off alarm bells in my=20
> head. We have various struct timespec in signaltest, could the fact that=
=20
> we are not calling tsnorm mean that there are some hidden potential=20
> defects? Rather than removing this function, I'd like to spend some time=
=20
> auditing the use of timespec here until I'm convinced.

Yeah, I did the cheap-and-easy thing here; but you raise a good point,
we should audit signaltest to see where any timespec math is done to
ensure proper normalization.

  Josh

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+ceLAAoJEKp7ZBKwQFAr+GMH/2sUjS37rGv/XM5zwbd1qPia
S0L3slJRCq1mh1YG517YN7z44ADKWW3rJis09mnZr0eED+/5oF+s9WoUS81Q5Ca6
fM1VgUp6sOQ9moL9BuftqmPdmZpI4PMFnxg1WbdcoiX8qTONQBlxWcYKbTI1pqQI
6grilJr2HNg48F+oOSdrVxngxLYBmhCa6m2f34oJZySF5vQxWSlkMSOvmufm0Fh0
ZFRMeFUR1laYzRy6vP7gbE3eCazLd0nskBEV2HxqIjHHtA+m8y90CHWStpra0VUu
iUIBlmOa8ThBeuGLV5UGLuKt0sEZwT3ZqYtvs1+tOJINEQgKbiP/A3L6E03Q4vw=
=xynv
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
