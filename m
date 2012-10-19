From: Clark Williams <williams@redhat.com>
Subject: Re: Don't reference non-standard realtime group
Date: Thu, 18 Oct 2012 21:12:05 -0500
Message-ID: <20121018211205.21f5f908@redhat.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20120902194911.GT28643@pengutronix.de>
	<alpine.LFD.2.02.1210160107520.6335@tycho>
	<20121018161321.GE11335@beefymiracle.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/vgGrMIrdWoy7C+513G8//0x"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>,
	Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: Josh Cartwright <josh.cartwright@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196Ab2JSCMr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2012 22:12:47 -0400
In-Reply-To: <20121018161321.GE11335@beefymiracle.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/vgGrMIrdWoy7C+513G8//0x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Oct 2012 11:13:21 -0500
Josh Cartwright <josh.cartwright@ni.com> wrote:

> On Tue, Oct 16, 2012 at 01:13:35AM +0200, John Kacur wrote:
> >=20
> >=20
> > On Sun, 2 Sep 2012, Uwe Kleine-K=C3=B6nig wrote:
> >=20
> > > On Wed, Jul 13, 2011 at 10:48:31PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > There is no dedicated realtime group in most distributions. So make=
 the
> > > > error message a bit more understandable for people not running Redh=
at
> > > > MRG.
> >=20
> > I thought we rejected this (via irc) the first time you sent it. The id=
ea=20
> > of a realtime group is pretty generic, but sure, it isn't there by defa=
ult=20
> > if you don't create it. However, the worse thing about this patch is th=
at=20
> > your message is in no way clearer than the original. It's longer though.
>=20
> How do you feel about this wording?
>=20
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
>=20
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index f4da4b3..e799c15 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -264,8 +264,11 @@ int check_privs(void)
>  	/* try to change to SCHED_FIFO */
>  	param.sched_priority =3D 1;
>  	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
> -		fprintf(stderr, "Unable to change scheduling policy!\n");
> -		fprintf(stderr, "either run as root or join realtime group\n");
> +		fprintf(stderr, "Unable to change scheduling policy.\n");
> +		fprintf(stderr, "This likely means you lack real-time privileges.\n");
> +		fprintf(stderr, "It may be necessary to run as root or create/join a '=
realtime' group.\n");
> +		fprintf(stderr, "More details at the RTWiki:\n");
> +		fprintf(stderr, "https://rt.wiki.kernel.org/index.php/Frequently_Asked=
_Questions\n");
>  		return 1;
>  	}
> =20

I'm good with this.

Clark


--Sig_/vgGrMIrdWoy7C+513G8//0x
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlCAtvkACgkQHyuj/+TTEp0uoQCcCLYnAkVArUHnZbEkfsNjrlpX
O5AAn1aCG1AiwbjXjZAqVt25ynHGyfNv
=hp19
-----END PGP SIGNATURE-----

--Sig_/vgGrMIrdWoy7C+513G8//0x--
