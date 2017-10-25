From: Henrik Austad <henrik@austad.us>
Subject: Re: replacement of tasklet_hrtimer_init in RT
Date: Wed, 25 Oct 2017 07:34:41 +0200
Message-ID: <20171025053441.GA2280@sisyphus.home.austad.us>
References: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Cc: linux-rt-users@vger.kernel.org
To: Chris Caudle <chris@chriscaudle.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:52101 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdJYFea (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Oct 2017 01:34:30 -0400
Received: by mail-lf0-f67.google.com with SMTP id r129so26443695lff.8
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Oct 2017 22:34:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Oct 24, 2017 at 11:33:46AM -0500, Chris Caudle wrote:
> I recently began helping someone test a new multimedia driver (network
> audio) and found that the driver would not compile on my machine running
> an RT kernel because the driver used tasklet_hrtimer_init(), but that
> function is not defined in interrupt.h in the RT  patched kernel.

/me eyes include/linux/interupt.h and kernel/softirq.c and finds=20
tasklet_hrtimer_init().

It is marked EXPORT_SYMBOL_GPL() though, so if you do not export the=20
modules as GPL, it won't resolve that symbol.

If this is not the case, please provide which kernel-version and PREEMPT-RT=
=20
patch version you are using. A .config would probably also be helpful.

> What should be used in place of that, and where should be look for
> documentation describing any differences that need to be accomodated?

Using tasklets is somewhat frowned upon -have you tried using a=20
kernelthread instead? (You can adjust priority and set affinity for=20
threads)

-Henrik

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnwInEACgkQ6k5VT6v45lnGcwCfRPwiDUt6DeU1gU2iIEZWm2z2
yvQAoNLGJ7acWbTsYxrAbR9ur2vK1Y9X
=mETA
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
