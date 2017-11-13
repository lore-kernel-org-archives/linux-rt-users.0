From: Julia Cartwright <julia@ni.com>
Subject: Re: Security etc. status of -rt patches versus mainline
Date: Mon, 13 Nov 2017 10:55:46 -0600
Message-ID: <20171113165546.GA30279@jcartwri.amer.corp.natinst.com>
References: <2fa58167-d2cb-989e-ca0b-2e252d32cdc8@manjaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: <linux-rt-users@vger.kernel.org>
To: Jonathon Fernyhough <jonathon@manjaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:32902 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753640AbdKMQzu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Nov 2017 11:55:50 -0500
Content-Disposition: inline
In-Reply-To: <2fa58167-d2cb-989e-ca0b-2e252d32cdc8@manjaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 12, 2017 at 03:32:02PM +0000, Jonathon Fernyhough wrote:
> Hi!

Hello Jonathon-

> How do the -rt patches match up against mainline and any security
> fixes?  For example, mainline LTS 4.9 is version 4.9.61, but 4.9-rt is
> version 4.9.47.

Yes, as of right now, the current 4.9-rt stable release is out of date,
and is due for a refresh.

All of the maintained stable-rt releases effectively have two upstreams:
the upstream stable releases (4.9.61 as you've mentioned), which bring
in bug fixes from mainline, and secondly the latest rt-devel development
tree.  RT specific bug fixes from the rt-devel tree are cherry-picked
back to the relevant stable-rt releases.

We acknowledge we're a bit behind, and are currently in the process of
reshuffling around the stable-rt release work.

> Is mainline 4.9.47 with -rt37 secure (etc.), or should the 4.9.47-rt37
> patch-set be applied against the latest mainline point-release?

As Uwe mentioned, it's possible that you can just merge in the latest
upstream 4.9.y release for your usecase.  Otherwise, you can wait for us
to kick out an updated release (hopefully soon).

Thanks,
   Julia

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAloJzo8ACgkQjNrC4UVN
dG98bgf+OM03DYttGOwpYdKBVy4Obz7GjrFAzLA1s/kJSOSU6tqmPSGku44kX0ic
BaXPwwVBTg30JE7SojfeKDWp7oYeMdsuUYXcoOG/LU435GUzaSigKXYYKebqFM22
hbvvw1+UUhJ+wm2jxlW0crCRYcqz9tdvHvHoRnyLdTmoFLC/4fqBVy3s92nhm+OM
Bg+FJHBNOtvUf4E5Hbp7K4eQwZeEosbTs69GDOL5sRFkg9YU1AXXStAAWYGKArzL
Kdfso9j4ftysHEbdrZZ+wHQ4OoIikRWYjEdK3yco3bGQU3yg3x/G45NroUXQwe8+
BHDgDGxfvbFscajspaIfE84gLnTq8Q==
=btOK
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
