From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: [PATCH rt-tests] gitignore: add librttest.a to git ignore
Date: Thu, 18 Oct 2012 12:13:26 -0500
Message-ID: <20121018171326.GF11335@beefymiracle.amer.corp.natinst.com>
References: <20121018162359.GA27911@beefymiracle.amer.corp.natinst.com>
 <alpine.LFD.2.02.1210181229470.5341@tycho>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:50492 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199Ab2JRR0o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2012 13:26:44 -0400
In-Reply-To: <alpine.LFD.2.02.1210181229470.5341@tycho>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2012 at 12:32:19PM -0400, John Kacur wrote:
> On Thu, 18 Oct 2012, Josh Cartwright wrote:
>=20
> > Commit fb7ef61416b6b191a5186a715e51792847de883c introduced librttest.a
> > as a library, but did not add it to .gitignore.  Add it now.
> >=20
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > ---
> >  .gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index 047925c..f7ba1d0 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -27,6 +27,7 @@ SRPMS
> >  /pip_stress
> >  /hackbench
> >  /pmqtest
> > +librttest.a
> > =20
> >  rt-tests.spec
> >  tags
> > --=20
> > 1.7.12.3
> > --
>=20
> Oh, thanks, but I already have the following queued up for the next=20
> release
>=20
> commit d63f567c646e07da87d9ce3cce5e5add74c97e16
> Author: John Kacur <jkacur@redhat.com>
> Date:   Wed May 9 17:32:11 2012 +0200
>=20
>     rt-tests / gitignore: Exclude patches and .a libs too.
>    =20
>     Minor fix to make working with git nicer.
>     Now that we're building a lib, we need to exclude it from git status =
output.
>     Do the same for patches we generate or apply.
>    =20
>     Signed-off-by: John Kacur <jkacur@redhat.com>
>=20
> diff --git a/.gitignore b/.gitignore
> index 047925c..1924e73 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -3,6 +3,8 @@
>  *.o
>  *.tar.gz
>  *.d
> +*.patch
> +*.a

That works, too.  Thanks, John.

  Josh

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQgDi2AAoJEEef0niEbw+lNYIQAKOfPl1cNGwktSUfWtx8F7dp
p/KIs0voUAYcHum+6My8L+YMER4+ReTA8kpR3o+a8XCEeA2olZwFVPKqg/7b0yZ3
NpsEMQD+TCYUU42sbta7h6SOLufqaWjqxsIcLwixh1xyYMaVOLP9/qouXSjlib+i
KfdpDNKnyb7bRxnkgS8ns12l7A4wOEV6ct+CVhTpP21mJhp4PTOskNlPCAOPRC/j
SkDolGkqbj0H+Db5EUbH8cgUUt/emhsg7MaHlaG9GCBBW1eSGOv15KX0vN8tVNGA
5IJHx3MRM6TwiXHmPhd8LGT8QZKAgfuClBBvBEmaaqVr4/KmLHReEEqYW9eJXc8i
ZIv/mhaM8rjxjJWeAXPl18DxG78Cklr3dqrPSNWzIW667JJrUnaG/PkPKCJ2iHSG
TPwE+oYNLWi9HNMDoLe46khDgk7w1lbmiKJ5CaVNM9EyyWzOacu0D2XheUOh1YGS
X6dVB42IMznBz9piXrSRdMdH117Ao6AeALcoHclur2JL82PPskUsLsvMOPL3Q24X
snJIRsfHUjAjsTt8DxtBbCPb/hsfEqYmHYr/U8cEjtWGcjfRAoBc6I6ImW8LJCrC
h4D1HAG/WFmLQz9TTdZmyLqy4dbDe6Z+fh3Uc/oNSfz/lcGbZr6RzVoCrM2u/D24
KZHvpeIgvrr2HyH+kWJD
=peq5
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
