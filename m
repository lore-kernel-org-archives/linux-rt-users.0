From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v2] rt-tests: printf format compile warning
Date: Thu, 3 May 2012 16:26:33 -0500
Message-ID: <20120503162633.788367b0@redhat.com>
References: <4FA2E120.1020909@am.sony.com>
	<4FA2F514.5070104@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/wEHcJoa7eeZcXCR.pTp+WcG"; protocol="application/pgp-signature"
Cc: frank.rowand@am.sony.com,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	jkacur@redhat.com
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382Ab2ECV0i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 17:26:38 -0400
In-Reply-To: <4FA2F514.5070104@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/wEHcJoa7eeZcXCR.pTp+WcG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 03 May 2012 14:13:56 -0700
Darren Hart <dvhart@linux.intel.com> wrote:

>=20
>=20
> On 05/03/2012 12:48 PM, Frank Rowand wrote:
> >=20
> > V2: use type casting instead of ugly constant in format string
> >=20
> >=20
> > Fix printf format string to fix compile warning for ARM 32 bit target.
> >=20
>=20
> Oh much better. :-)
>=20
> > Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> > ---
> >  src/cyclictest/cyclictest.c |    2 	1 +	1 -	0 !
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Index: b/src/cyclictest/cyclictest.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1575,7 +1575,7 @@ int main(int argc, char **argv)
> >  		print_tids(parameters, num_threads);
> >  		if (break_thread_id) {
> >  			printf("# Break thread: %d\n", break_thread_id);
> > -			printf("# Break value: %lu\n", break_thread_value);
> > +			printf("# Break value: %llu\n", (unsigned long long)break_thread_va=
lue);
> >  		}
> >  	}
> >  =09
> >=20
>=20
>

Yes, I like this better. I pulled the original and applied this.


--Sig_/wEHcJoa7eeZcXCR.pTp+WcG
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+i+AkACgkQHyuj/+TTEp3kPgCg4cGV/REY9Sm06M8lQMh3ini/
oI8AoNw5pFZDESGNbNP1ChmfatE16W42
=3mWk
-----END PGP SIGNATURE-----

--Sig_/wEHcJoa7eeZcXCR.pTp+WcG--
