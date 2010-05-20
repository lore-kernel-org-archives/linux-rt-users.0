From: Clark Williams <williams@redhat.com>
Subject: Re: [RT] RCU splat on 2.6.33.4-rt20
Date: Thu, 20 May 2010 08:59:27 -0500
Message-ID: <20100520085927.480047d4@torg>
References: <20100519211911.5450c1dd@torg>
	<20100520032246.GB2708@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/xDQV/D.S7bLxt2/RhB8/gcO"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54376 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199Ab0ETN7l (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 May 2010 09:59:41 -0400
In-Reply-To: <20100520032246.GB2708@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/xDQV/D.S7bLxt2/RhB8/gcO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 May 2010 20:22:46 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, May 19, 2010 at 09:19:11PM -0500, Clark Williams wrote:
> > Thomas/Paul,
> >=20
> > Resumed my laptop (T60, 64-bit kernel) and after about five
> > minutes of doing nothing but surfing with firefox, got the following
> > RCU stall notification from a 2.6.33.4-rt20 kernel:
> >=20
> > INFO: RCU detected CPU 1 stall (t=3D0 jiffies)
>=20
> Hmmm...  "t=3D0 jiffies".  I wonder if the hibernation/resumption confused
> the stall-warning code.  My first thought was that an RCU grace period
> had spanned the hibernation, but that would not be consistent with it
> waiting five minutes after resumption to splat.
>=20
> I will look into this.
>=20

Don't take that "five minutes" as anything approaching some degree of
accuracy. It could have been quicker; I was distracted and not even
touching the keyboard when a loud beep sounded and I had to poke around
a bit to realize that an NMI backtrace had triggered.

Depending on your timeout values, I think that it's quite reasonable to
suspect that an RCU spanned the suspend/resume.

Clark

--Sig_/xDQV/D.S7bLxt2/RhB8/gcO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkv1QEMACgkQHyuj/+TTEp1AegCglbEOLVUggBdlCZsGqJDGzqAq
2kEAn2IG/LXaxiKImNkb6ivkXR42kbyf
=AoC0
-----END PGP SIGNATURE-----

--Sig_/xDQV/D.S7bLxt2/RhB8/gcO--
