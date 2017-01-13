From: Alexander Dahl <post@lespocky.de>
Subject: Re: debian 8 rt kernel
Date: Fri, 13 Jan 2017 08:52:15 +0100
Message-ID: <20170113075215.GF2532@falbala.home.lespocky.de>
References: <CADzbtTJ8BAX+HaBQkxe8_YOjX7RKyghNz5jS8UToEoSbMXXo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Cc: linux-rt-users@vger.kernel.org, info@pengutronix.de
To: luca paganotti <luca.paganotti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62954 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdAMHwf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Jan 2017 02:52:35 -0500
Content-Disposition: inline
In-Reply-To: <CADzbtTJ8BAX+HaBQkxe8_YOjX7RKyghNz5jS8UToEoSbMXXo3w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hei hei,

On Tue, Dec 20, 2016 at 10:01:26AM +0100, luca paganotti wrote:
> Hi all, I'm new to debian and I would like to install an rt kernel on
> my debian 8 jessie machine, I've configured the pengutronix repository
> in my /etc/apt/sources.list.d as:
> deb http://debian.pengutronix.de/debian jessie main contrib non-free
> in pengutronix.list file, but I don't know which packages I need to
> install. I would like to use the rt kernel for my musical work with
> jack, ardour, etc ...

I had a look at this package repository and it contains only very old
kernels, 2.6.29, 2.6.31 and 2.6.33. If you are on jessie, you may want
to try linux-image-rt-686-pae or linux-image-rt-amd64 from backports
which depends on a more recent 4.8 rt kernel. I'm not sure why
pengutronix still allows access to those outdated kernels.

Besides: I used jack some time ago on Debian and some packages for
music, which were available in previous Debian releases are not
available anymore. Also the default sound setup is not optimized for
audio production, as far as I could tell and what I heard and saw, I
would have a look for a specialised Linux distribution like Ubuntu
Studio, AVLinux, or KXStudio (there are more, use a search engine).

Greets
Alex

--=20
=BBWith the first link, the chain is forged. The first speech censured,=20
the first thought forbidden, the first freedom denied, chains us all=20
irrevocably.=AB (Jean-Luc Picard, quoting Judge Aaron Satie)
*** GnuPG-FP: C28E E6B9 0263 95CF 8FAF  08FA 34AD CD00 7221 5CC6 ***

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJYeIcuAAoJEDStzQByIVzG1FsQAK1YgBIX9IXUCP6mw+4GoM7A
tQCx77Z+xZl1+BMcYx672s5MfuWXvAhZif9b5+heESS52qWpby/QKZUd1cI7v7Jm
a+twCC6kB/KX5xr0kvQQJrzqWlNlM+P/MfY1fLxA71ybLX/kGi5jB0SgejBoCApK
1CBQ8DilXSncb1AdQC15Cn2GT/tFkIDgGLKnpp2QW9vwpfaBNuM/NooY/GjhQhU/
FUEOplzq+aHxHCE1qN39AwHalcEPma+TOpWzY3ms7i2bK2Ij/gkjR9ZwlWnEyeB6
DnAtJ8GG25M1qlSJ5lxh18WXGTN9wGODxFm+KEngH2IP1XwsruEKcOrZwNuv3Iah
GssyhbXbSnC1LyqmgColisUXgONrCcbBUoNqiEhlroX/t/pU45dcgtgTOG16DdSw
oQc7Tzxwp09d0rmcMo45kOT+ztNGe+kIrzn59DDeNs7+Fds3XzODorCfECINuxLf
lM2nCbHM+WaYI2mqO23Km89RQ+m6z+XyxlDPot9Px2OnzP8wpxvDer0kDFXDSx8q
uGzMPgVCQ3FqtXNcgFkiAoLsOc5SzTItNy+1xTdE1KDK0UoGJUCE1hhcLh2Yb1aa
uqOGTckDGU9xfDAMbVQ+hMlasE5WtWyIM3khDQct74BZGKgoBuBK7CEumEcUlfpX
400PPNyJ2FbGApTYop1E
=wPyb
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
