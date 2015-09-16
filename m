From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH rt-tests 3/9] cyclictest: drop unnecessary
 numa_on_and_available() check
Date: Wed, 16 Sep 2015 14:47:28 -0500
Message-ID: <20150916194728.GH3126@jcartwri.amer.corp.natinst.com>
References: <cover.1441038216.git.joshc@ni.com>
 <787515a5a59861a892ac3a44b6c6c502cfc102fd.1441038216.git.joshc@ni.com>
 <alpine.LFD.2.20.1509152347280.13077@riemann.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:54173 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751689AbbIPTrb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Sep 2015 15:47:31 -0400
In-Reply-To: <alpine.LFD.2.20.1509152347280.13077@riemann.fritz.box>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 11:50:16PM +0200, John Kacur wrote:
> On Mon, 31 Aug 2015, Josh Cartwright wrote:
>=20
> > The condition that numa_on_and_available() checks is impossible to hit,
> > as it's already being checked during process_options().
> >=20
> > Removal of numa_on_and_available() also has the side effect of removing
> > the following warning during build:
> >=20
> > src/cyclictest/rt_numa.h:259:15: warning: implicit declaration of funct=
ion ???numa_available??? [-Wimplicit-function-declaration]
> >=20
> > Signed-off-by: Josh Cartwright <joshc@ni.com>

[..]

> We don't support building without numa libs anymore, although we of
> course support running on machines without numa. Never-the-less I
> created two versions of numa_on_and_available, one for if you build with
> the unsupported NUMA=3D0 and one for if you build with NUMA=3D1, which is
> the default.

:(.  You risk plenty of embedded folks who don't much care about NUMA.

> I would prefer not to drop this function, since I think it cleanly
> documents the fact that numa_available must be called before any other
> numa library functions are defined.
>=20
> As Josh Cartwright reported though, there was no need to call it from
> main() since it was already tested in process_options(), so I tested it
> there.
>=20
> Tested by building with NUMA=3D0, NUMA=3D1 and with the non-standard
> -Wimplicit-function-declaration
>=20
> Reported-by: Signed-off-by: Josh Cartwright <joshc@ni.com>

s/Signed-off-by: /

:)

> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c |  7 ++-----
>  src/cyclictest/rt_numa.h    | 18 +++++++++++++-----
>  2 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 213c527fd714..b3abfcc67407 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1451,12 +1451,11 @@ static void process_options (int argc, char *argv=
[], int max_cpus)
>  			setvbuf(stdout, NULL, _IONBF, 0); break;
>  		case 'U':
>  		case OPT_NUMA: /* NUMA testing */
> +			numa =3D 1;	/* Turn numa on */
>  			if (smp)
>  				fatal("numa and smp options are mutually exclusive\n");
> +			numa_on_and_available();

=2E..except numa is always on here.  So why check if NUMA is enabled
again?  Seems like a waste.

>  #ifdef NUMA
> -			if (numa_available() =3D=3D -1)
> -				fatal("NUMA functionality not available!");

Perhaps a middle ground should be to keep this check around and define a
static inline numa_available() in the NUMA:=3D0 case which unconditionally
returns -1.

Thanks for taking a look,
  Josh

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV+cdJAAoJEKp7ZBKwQFAr2B8IAIl97xFufjavfPkqC47saEMF
MJBcmGQ3+eajkMaKX9bhZcBc7lR65IUNSuY2jsjyd4rO96wDKqH6/ApdZQ+E/UpI
l0+s0BLHl/P+9A6n1o8CAaao3ATzda1eBwuDEgYBNqJr1VoCgWn8Emw3tdN3rgfl
jyQn2syLbG//3c0Dg33L6rPS8iOCVtX7UycQldYrhL2RT/bnTTUZy7x5qFexGoci
pz4RH5kZKV2m6Adtmmo5zKD208vqZEdhyIqtqEnob+hG2M9KZw/uAQHN7RfZ83fT
vNKCukdUbCR1N0jeBRJZqOqS+GCWVzgLONE+X9QVlU+unYoe9WJR/cch3B84IgQ=
=k6hr
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
