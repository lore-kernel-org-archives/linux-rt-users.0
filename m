From: Julia Cartwright <julia@ni.com>
Subject: Re: v4.1.38-rt46 build: 1 failures 46 warnings (v4.1.38-rt46)
Date: Tue, 21 Mar 2017 15:10:00 -0500
Message-ID: <20170321201000.GE10423@jcartwri.amer.corp.natinst.com>
References: <E1cmQcG-0002cE-Cd@optimist>
 <CAK8P3a37VfnxHPxNs7A=3s-cOzZsZSK93f_wk-WaJpnCqk-6Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: Build bot for Mark Brown <broonie@kernel.org>,
        <kernel-build-reports@lists.linaro.org>,
        <linaro-kernel@lists.linaro.org>, <linux-rt-users@vger.kernel.org>,
        <stable@vger.kernel.org>, Sasha Levin <alexander.levin@verizon.com>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a37VfnxHPxNs7A=3s-cOzZsZSK93f_wk-WaJpnCqk-6Bw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Arnd-

On Fri, Mar 17, 2017 at 09:21:35PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 10, 2017 at 8:54 PM, Build bot for Mark Brown
> <broonie@kernel.org> wrote:
>=20
> > -----------------------------------------------------------------------=
--------
> > defconfigs with issues (other than build errors):
> >      36 warnings    3 mismatches  : arm64-allmodconfig
> >       4 warnings    0 mismatches  : arm-multi_v5_defconfig
> >       5 warnings    0 mismatches  : arm-multi_v7_defconfig
> >       3 warnings    0 mismatches  : x86_64-defconfig
> >      31 warnings    0 mismatches  : arm-allmodconfig
> >       2 warnings    0 mismatches  : arm64-defconfig
>=20
> For some reason, neither kernelci.org nor broonie's built bot include
> the stable/v4.1.y
> tree, but we do get reports for v4.1-rt, which unlike v4.4-rt show a numb=
er of
> warnings. Sasha, are you interested in backporting the fixes for these so=
 we can
> eventually get a clean build and spot regressions more easily? A lot of t=
hese
> are just patches to shut up harmless warnings, but some also address real=
 bugs.

I can't speak for Sasha, but I'd certainly like to see the RT-specific
build warnings fixed, and have already began the process of doing so.

The 4.1.y powerpc build is actually broken for newer gccs.  The fix is
upstream as 1e407ee3b21f9 ("powerpc/ptrace: Fix out of bounds array
access warning").  There are other build warnings on other architectures
as well.  I've resent the patch last week to stable folks, but was
having mailer problems, so perhaps need to resend.

I'm also happy to hear that the 4.1-rt is getting build testing by the
build bot.  Is there any way I can be CC'd on build reports on this
branch?  Or, is the best way for me just to subscribe to the list?

[..]
> >         ../net/ipv6/ip6_offload.c:261:25: warning: 'sit_gro_receive' de=
fined but not used [-Wunused-function]
>=20
> Here, upstream commit fac8e0f57969 ("tunnels: Don't apply GRO to multiple
>  layers of encapsulation.") seems to have been incorrectly backported into
> v4.1.y commit 066b300e5be4.
>
> I have not analyzed why the function is now unused, but in the original p=
atch
> it is used, unlike in the backport.

It looks like this patch fixes a bug in commit feec0cb3f20b8 ("ipv6:
gro: support sit protocol"), which didn't land until v4.4, so perhaps
this patch can just be dropped from 4.1.y.

[..]
> >         ../include/linux/spinlock.h:256:3: warning: 'flags' may be used=
 uninitialized in this function [-Wmaybe-uninitialized]
>=20
> I could not immediately find this one.

I'm not sure if full logs are available somewhere, but the line above
this is probably of more interest.  For example:

	drivers/tty/serial/amba-pl011.c: In function 'pl011_console_write':
	include/linux/spinlock.h:256:3: warning: 'flags' may be used uninitialized=
 in this function [-Wmaybe-uninitialized]

Which looks like perhaps gcc is confused about the conditional
locking/unlocking in this function.

   Julia

PS. Apologies if I've mangled my reply, I've been having mail issues w/
    vger recently, had to reconstruct Arnd's original email from an archive.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAljRiJQACgkQjNrC4UVN
dG9Tnwf/RU9ew2u2k9JCWP1RouLMmxYLQCmY0L1ss4OBbj+Zh3SGN07qM08MakBH
XnUZaWYLlhveZkibZ9ywesBsIKso936zkP/27d4U1wjcC38ATGVBm9qpOJteYekP
1/96YxTVwUGceY9VWR+dWls1q5KlUKRHEh3WfFPekz4MndJwFZvN24ELwgODcE9V
UJ12idVV9ccRdouAv9dNe5l/ew2R/NgmCSIMaPJa86+gOC0GS5Jz73JeVC825zAq
9gQYngdqX+/EjGq+vMLxDY0zkzzrjwL/Zd7lCmhmd3JIjDyXQI0mRjtLL28INZ54
jCfrfnOXWdDkPrMBUgsa+E3YouRQaA==
=P/se
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
