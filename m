From: Henrik Austad <henrik@austad.us>
Subject: Re: replacement of tasklet_hrtimer_init in RT
Date: Wed, 25 Oct 2017 22:48:05 +0200
Message-ID: <20171025204805.GA5381@sisyphus.home.austad.us>
References: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
 <20171025053441.GA2280@sisyphus.home.austad.us>
 <6a64e3bcea28466d2be864ee2ec69f1e.squirrel@email.powweb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Cc: linux-rt-users@vger.kernel.org
To: Chris Caudle <chris@chriscaudle.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44223 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdJYUrx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Oct 2017 16:47:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id 75so1425607lfx.1
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Oct 2017 13:47:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6a64e3bcea28466d2be864ee2ec69f1e.squirrel@email.powweb.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2017 at 11:50:01AM -0500, Chris Caudle wrote:
> On Wed, October 25, 2017 12:34 am, Henrik Austad wrote:
> > /me eyes include/linux/interupt.h and kernel/softirq.c and finds
> > tasklet_hrtimer_init().
>=20
> Are you sure?  I previously sent a copy of my interrupt.h to the list, may
> have been rejected because I attached the file rather than copied inline.

do'h! you're right, I was looking in the wrong version (for some reason I=
=20
was looking at v4.9.33-rt23) - it has since been removed.

> I downloaded the patches file for 4.11.12-rt14 and searching for
> tasklet_hrtimer_init() I find this reference:
>=20
> 0022-softirq-Remove-tasklet_hrtimer.patch:-tasklet_hrtimer_init(struct
> tasklet_hrtimer *ttimer,
>=20
> The very top lines of that 0022 patch file are these:

yeah, I see it, my bad, sorry

-Henrik

> ---------
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Thu, 31 Aug 2017 11:03:11 +0000
> Subject: [PATCH 22/25] softirq: Remove tasklet_hrtimer
>=20
> There are no more tasklet_hrtimer users of this interface.
> Remove it.
> ---------
>=20
> It looks to me like the tasklet_hrtimer interface is being intentionally
> removed.
>=20
> --=20
> Chris Caudle
>=20
>=20

--=20
Henrik Austad

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnw+IUACgkQ6k5VT6v45lnTWgCgphfueAY/bQe2uSL2e7s6xPjK
UqkAn3Q0q6ZjQNJ3mtbVz8qzL2mzVjJf
=AI5Q
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
