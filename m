From: Julia Cartwright <julia@ni.com>
Subject: Re: Radeon driver hang with 4.9.0-rt
Date: Thu, 2 Mar 2017 15:10:14 -0600
Message-ID: <20170302211013.GC2723@jcartwri.amer.corp.natinst.com>
References: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
 <1389032467.26259129.1487907530442.JavaMail.zimbra@redhat.com>
 <48ef9ca7-0c7e-730f-e8c2-6b07e75018b6@lebib.org>
 <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Cc: Wargreen <wargreen@lebib.org>, Pankaj Gupta <pagupta@redhat.com>,
        <linux-rt-users@vger.kernel.org>
To: Daniel Vidal <danielvidalchornet@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:50967 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750959AbdCBVKr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Mar 2017 16:10:47 -0500
Content-Disposition: inline
In-Reply-To: <CAObZbXS1AsJ7MPfNacZLnCvzCzmFcpyHDNge9sOd-AhyB1CbvQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 12:55:01PM +0100, Daniel Vidal wrote:
> Hi
>=20
> The radeon driver hangs from 3.16 kernel.
>=20
> RT patch for radeon driver only disable ( preempt_disable_rt() ) and
> reenable ( preempt_enable_rt() ) the whole RT in file radeon_display.c
>=20
> Obviously this is not enough.
>=20
> I think the radeon developers should make some modification in the
> driver but I do not know which is the right place to indicate it
>=20
> Here my backtrace.

Two more debugging ideas:

  1. Boot with lockdep enabled, see if that gives you a meaningful
     splat.

  2. Use sysrq-trigger 'd' to dump held locks to console when stuck in
     this state, in order to track down the codepath causing problems.

   Julia

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAli4ijIACgkQjNrC4UVN
dG95AQgAqz+gLnx4WrFI5/VxtHiuni+teqM7FLPcgE/RZ7On1c+lUqDqxOFP/oDB
bt/seuYED2hBTvlmx0Jn1OL1tcQESDEE1n2y3GkUEQ39ZYhsOLLb43oD6u8XmEIQ
h2h9jBWJb2pWuw7bUMqMdJfhpupVZEoO127uu32wUrwhqMTaA2WP1PmqvWl/PbHB
qNN375HwHZS2aAG8o4kcSUOyJZI1243ZxGavQgshF+B5bRZgszUdIXSY3GG3lcgT
wdkvA81xz1ofc/cDp8Yy0HW57GBrHn6QdbOnl6T6wRMCDpbww56HC10/zSDBJ9L4
Lqog5bgZ25QBPDdWvkS2OJ8TNqJyyA==
=h4LK
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
