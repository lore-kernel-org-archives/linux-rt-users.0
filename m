Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F09AC433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E8D2088E
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 20:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbgEZUQg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 16:16:36 -0400
Received: from sleepmap.de ([85.10.206.218]:54290 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389885AbgEZUQg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 16:16:36 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2020 16:16:35 EDT
Date:   Tue, 26 May 2020 22:10:00 +0200
From:   David Runge <dave@sleepmap.de>
To:     Reiner =?utf-8?B?UHLDtmxz?= <reiner.proels@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: RT Patch and EFI
Message-ID: <20200526201000.GB5157@dvzrv.localdomain>
References: <0e6032b1-9cca-fbcb-5ea1-77575a69afa3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <0e6032b1-9cca-fbcb-5ea1-77575a69afa3@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RT Patch and EFI

Hi Reiner,

On 2020-05-26 21:54:39 (+0200), Reiner Pr=C3=B6ls wrote:
> I tried the last RT patch against a 5.6.10 kernel.
>=20
> After enabeling the FULL preemption model I'am no longer possible to
> use efibootmgr.
>=20
> The kernel module efivarfs refuses to load - no device ...

IIRC, efivarfs functionality is disabled by default due to the patchset.
Add the `efi=3Druntime` kernel parameter and reboot.

Best,
David

--=20
https://sleepmap.de

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAl7Nd5gACgkQVMKPT/Wh
qUlHUQ/+OMKGQSaajuxEiyBOgmgm+Iv/S5B/cmVD15QqqxBzs7nw5alvHiP45Da5
vHHBXelxHBYDNgdDg+T5fyfUcaRNGyrLk45aga99RPn8IMQvqEG3dhIXSWQfA5dR
h4VMKalGPGKYxIN4k/TDR0Keamh5Dqesd4YfTHDKR2V52RjWboElIvf714iXnECq
mfovIld5oWP0N/aJwIMHQJP/SkYq0BcahzcWnp/6WX+Lk/TrgIiXgYurXkEduZXC
G2GGylHBnGQJQrhAtcV3A2vknPpMCeiKqx/s4QibFbfuuzRnApE2XQdJobOlTKbO
Evv1+I+yHU+2h/P4ztfjn8qTiD7hfYIyaqc5pWUx6J8qxikL2w7apYng6K/kiqBh
HTVEZSuCZRgSLfxejoD4d5QCQRyAqqqy6r4IqNjy91k5YdAq/ucyNhRwb0tDD76B
tqW1zcDCEEbV3QV1/PLCPfO5BZEiH2v3fd6K1r1ovz4n9PRlV627xZ67o5zvZhtr
W5i7YWhvn9VbfEMCagiAOVGueIiZAcKNfUfBTGvZpQtIZa9HiW7VWlnlJq8U4BqX
WhTLzNI6zWEH6QZt4Wv1DQn5YQFcIs2YSjOJRc2cNqvwOIGTnFkzSgXN+kSBybc6
p09bmCi/6xtjp4g2WeaRZoIe9psx2Lm6Fa8tnH6Xpa2fx5bvIuI=
=atrf
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
