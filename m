From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: Don't reference non-standard realtime group
Date: Thu, 18 Oct 2012 11:13:21 -0500
Message-ID: <20121018161321.GE11335@beefymiracle.amer.corp.natinst.com>
References: <1310590111-11484-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120902194911.GT28643@pengutronix.de>
 <alpine.LFD.2.02.1210160107520.6335@tycho>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:45882 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab2JRQN0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2012 12:13:26 -0400
In-Reply-To: <alpine.LFD.2.02.1210160107520.6335@tycho>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2012 at 01:13:35AM +0200, John Kacur wrote:
>=20
>=20
> On Sun, 2 Sep 2012, Uwe Kleine-K=F6nig wrote:
>=20
> > On Wed, Jul 13, 2011 at 10:48:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > > There is no dedicated realtime group in most distributions. So make t=
he
> > > error message a bit more understandable for people not running Redhat
> > > MRG.
>=20
> I thought we rejected this (via irc) the first time you sent it. The idea=
=20
> of a realtime group is pretty generic, but sure, it isn't there by defaul=
t=20
> if you don't create it. However, the worse thing about this patch is that=
=20
> your message is in no way clearer than the original. It's longer though.

How do you feel about this wording?

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index f4da4b3..e799c15 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -264,8 +264,11 @@ int check_privs(void)
 	/* try to change to SCHED_FIFO */
 	param.sched_priority =3D 1;
 	if (sched_setscheduler(0, SCHED_FIFO, &param)) {
-		fprintf(stderr, "Unable to change scheduling policy!\n");
-		fprintf(stderr, "either run as root or join realtime group\n");
+		fprintf(stderr, "Unable to change scheduling policy.\n");
+		fprintf(stderr, "This likely means you lack real-time privileges.\n");
+		fprintf(stderr, "It may be necessary to run as root or create/join a 're=
altime' group.\n");
+		fprintf(stderr, "More details at the RTWiki:\n");
+		fprintf(stderr, "https://rt.wiki.kernel.org/index.php/Frequently_Asked_Q=
uestions\n");
 		return 1;
 	}
=20

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQgCqhAAoJEEef0niEbw+lXXwP/3NX9qkm1nStIZYUQE4wK9AK
UhPIHAdc7Eq6RYKayukhQglPE5DTeFnmlI6JFhMw6kfuYpMpZ4trwpB5FBY33nwb
LXu5HyStpehULA0AlwGqDBabapWWlAmDqFE0gcMYqpc5+Mjx8eql3lXE7D8p7/pn
9+nJuz6zsJnxclOT5IjR7ve9gPnxudUHuPKB2yvFm2fMTuoidnLQJyBXEXWOAXi2
LUugsm1/z1tFYqXGZlR4EI8mVGSoxKJQ5sad2N105VUrwOfR8G0mKwIhCM3wqh8J
UaOMWggl1eOCyvM2cokXmGHqFq+q6ePJR9PN0cifO7fxRYmxhms+OzMCGv8R31Kc
Ar1MIZznFi3dtmdeUo3lozGu85WlfrHFSYxj2m8nsUpFqszb0OnjEBMt2n8X7fAn
bW+x82/FoDGLZ3N5nEYOSz5vDq3mJ810gUqbc/B+SgwlOfZY+tuBSWo8aD9i3hUW
mcrO0cS5clcWAppMhaziXyUZo4awuEF00AY6Th50RdVZToDmOMM+gAM2Zu+EDu5C
RiSXI5J9WrF+R7ZLdNmOAaaYjbPqX2A0BWW+tL/3h40afC/d7c7BfCRdvlsMjQxr
RV19BCh+UrP+hdYdjpRICNYlMHrMC5oVt0p0JboWScmSHPRt6G/7iC1giRyWT1v8
1JGZJeIJKjPZgv2WOs77
=KmUq
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
