From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH 3/7] Add a rebuild-switch to Makefile
Date: Fri, 18 Sep 2015 16:10:31 -0500
Message-ID: <20150918211031.GF31303@jcartwri.amer.corp.natinst.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
 <1442595170-6229-4-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:58660 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752120AbbIRVKj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 17:10:39 -0400
In-Reply-To: <1442595170-6229-4-git-send-email-haustad@cisco.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 06:52:46PM +0200, Henrik Austad wrote:
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index d4988c5..160547c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -129,6 +129,9 @@ RPMDIRS =3D BUILD BUILDROOT RPMS SRPMS SPECS
>  distclean: clean
>  	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
> =20
> +.PHONY: rebuild
> +rebuild: clean all

Does this actually work?  Make is free to execute 'clean' and 'all' at
the same time, with ... interesting side effects.

If you really want this (and I'm not sure you do):

=2EPHONY: rebuild
rebuild:
	$(MAKE) clean
	$(MAKE)

  Josh

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV/H3AAAoJEKp7ZBKwQFArJSoH/A1vE/fkJ6p+zpnkHLSRSL6O
XcZe4tFOGTW47HdJsYzoBO/pTEuFGNR9pC/veKGabmYgn8gxmbJ1xSqAxQAN0sjF
Mg8ra3k1CwbnLsTCTlUpFi+dQi3usrC1iDge1/l5p8Xo59IwS7qdjij7cVsuJTco
8IhfTRetS9Ap6lYdtpCRwyCeuQWm6TVkq1aQ/RvmiKml0Ns8PUOamOcu2p1Xx+Sz
8j+n8WJfj0Xm+lprJhdXbngSPWA6Q0MXx+Su3Uw+VrcwpTDTu6eil11aJIfixleQ
fxSoohfzaX1+UzS7v3TF3DEkL899Xtd7VXVdQ/vzjfH+NfCx77KpLPx5+inHvzM=
=e8l8
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
