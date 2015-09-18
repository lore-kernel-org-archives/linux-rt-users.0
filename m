From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH 6/7] rt_test.h: add numa_available() for !NUMA
Date: Fri, 18 Sep 2015 16:27:07 -0500
Message-ID: <20150918212707.GG31303@jcartwri.amer.corp.natinst.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
 <1442595170-6229-7-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:42888 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753311AbbIRV1K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 17:27:10 -0400
In-Reply-To: <1442595170-6229-7-git-send-email-haustad@cisco.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 06:52:49PM +0200, Henrik Austad wrote:
> Code will snould not call numa_available(), but compiler will complain

snould -> should.

Why should it not call it?

> with:
>=20
>   src/cyclictest/rt_numa.h:263: warning: implicit declaration of function=
 ???numa_available???
>=20
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  src/cyclictest/rt_numa.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
> index 06c9420..172d9b2 100644
> --- a/src/cyclictest/rt_numa.h
> +++ b/src/cyclictest/rt_numa.h
> @@ -200,6 +200,7 @@ struct bitmask {
>  };
>  #define BITS_PER_LONG    (8*sizeof(long))
> =20
> +static inline int numa_available(void) { return 0; }

I would have expected this to return -1, as libnuma isn't available...

John and I were talking about this earlier this week:

http://lkml.kernel.org/r/787515a5a59861a892ac3a44b6c6c502cfc102fd.144103821=
6.git.joshc@ni.com

  Josh

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV/IGoAAoJEKp7ZBKwQFArVOoH/23gisiNtEwJW8ZnANYiLmGV
S1vQ71nnQ7civTwJXVAKt/PKth6S78T2RGKclKgPlWgPjOFZh+6K1a/q8TkRpUmS
PBkF3QZYefuCJqiu0zRa9jXMw/VTVTMTTAiZsZAbPCVNiVGSUnvOtW4pLavF1H1z
kSINAwDRMeYcLd7AGutVon1sc1GvmcCnTUKsBdb9R9EtZhsZdaiEkSfoWE3TFE3r
q5dFujNfStXmZ4lrv5VeP8UldJMoypHd5GtvW3yQYImHqxeoFT4z9ug5SDhckg/3
rxapnlRzVtw+9uqhb0R69FEdegQoY+8EIsWbuJ2lfgtnunrR/caMpxlni27x114=
=9ml1
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
