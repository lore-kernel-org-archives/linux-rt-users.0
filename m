From: Mark Brown <broonie@kernel.org>
Subject: Re: v4.1.38-rt46 build: 1 failures 46 warnings (v4.1.38-rt46)
Date: Fri, 24 Mar 2017 18:56:55 +0000
Message-ID: <20170324185655.knt6vdmohkamzs4n@sirena.org.uk>
References: <E1cmQcG-0002cE-Cd@optimist>
 <CAK8P3a37VfnxHPxNs7A=3s-cOzZsZSK93f_wk-WaJpnCqk-6Bw@mail.gmail.com>
 <20170321201000.GE10423@jcartwri.amer.corp.natinst.com>
 <CAK8P3a066bfxM+B0DYyvKzMRfzTgFpS-WihH4YSYwODTLrz5SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hrvcwzapuv6a25kf"
Cc: Julia Cartwright <julia@ni.com>,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49756 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965753AbdCXS5G (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Mar 2017 14:57:06 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a066bfxM+B0DYyvKzMRfzTgFpS-WihH4YSYwODTLrz5SA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--hrvcwzapuv6a25kf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 21, 2017 at 09:40:29PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 21, 2017 at 9:10 PM, Julia Cartwright <julia@ni.com> wrote:

> >         drivers/tty/serial/amba-pl011.c: In function 'pl011_console_write':
> >         include/linux/spinlock.h:256:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]

> > Which looks like perhaps gcc is confused about the conditional
> > locking/unlocking in this function.

> Mark might have a way of providing more verbose build logs, I don't
> think he has a web interface though. kernelci.org and
> http://arm-soc.lixom.net/buildlogs/ have some more logs, but don't
> build this tree.

I do have https://builds.sirena.org.uk/ but it's just a dump of files.

--hrvcwzapuv6a25kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljVa/YACgkQJNaLcl1U
h9BZewf+O5oRtpPCQH7uuR0WHfcXSyVWtURWBqoJtwQ8pykE+/Wr0jHjcCt/DMf/
zoCwIZIm4Y0DX0dKWzxg67DdHtmpNtNrwgc83kwtRIcLiWJ8ToaJtd5CKs/J4Ivz
RA0Gzc1keP4+rwYzpXON8V41RDOjXrgOA6qCH/HlFIXtgdUE3vfCWeyuwqw47EFn
9XGh0mbXpT50dOh/dRvtA4CnH+2hr6+mvOj05IkbKFsON2v7BpOYQjUxlTTeOEbC
jMF7U68kiOiIIZj8MSG6MBLe45uPCEWSagb8FjziLW6eMrzFnLVse8DloYq+MbtL
zA9wtyMYI7nhEB0podHg6T0Y8QEGPw==
=ZPLP
-----END PGP SIGNATURE-----

--hrvcwzapuv6a25kf--
