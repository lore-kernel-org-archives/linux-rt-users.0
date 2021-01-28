Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871D9C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 21:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B264DEB
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Jan 2021 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA1Vma (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:42:30 -0500
Received: from sleepmap.de ([85.10.206.218]:43880 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhA1Vm2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Jan 2021 16:42:28 -0500
Date:   Thu, 28 Jan 2021 22:41:45 +0100
From:   David Runge <dave@sleepmap.de>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YBMvmU+kp11f7+wF@hmbx>
References: <YAwPoaUZ1gTD5y+k@hmbx>
 <YBJZk9/77+E0TRk4@lx-t490>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xQ9xaHb/SmmtzFh5"
Content-Disposition: inline
In-Reply-To: <YBJZk9/77+E0TRk4@lx-t490>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--xQ9xaHb/SmmtzFh5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Jan 2021 22:41:45 +0100
From: David Runge <dave@sleepmap.de>
To: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-01-28 07:28:35 (+0100), Ahmed S. Darwish wrote:
> On Sat, Jan 23, 2021 at 12:59:29PM +0100, David Runge wrote:
> ...
> Can you please send the full kernel log, with boot parameter
> "firewire_ohci.debug=3D-1", for mainline v5.4.91 vs. v5.4.91-rt50?

kernel log for mainline:
https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-kernel.log

kernel log for rt (no dice :-/):
https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91.50.arch1-kernel.log

> Please also make sure to use the exact same defconfig for both, except
> with CONFIG_PREEMPT_RT=3Dy for the -rt kenrel of course.

config diff:
https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-lts_changed_vs_rt-lts=
=2Epatch

> This will help in comparing apples to apples, as you were posting the
> results of different base kernels (vs. the -rt versions), and different
> defconfigs (vs. -rt) within such kernels.

The configuration for the 5.4.91 stock kernel has not been updated since
the 5.4.83, which is maybe a bit misleading.
Generally I enable anything that I can in the config for the realtime
kernel. However, some settings of course get switched off, as they are
not compatible.
The diff above is for a custom version I just made, just to make sure
and clear things out.

> Good luck,

Thanks, seems it's needed!

> P.S. Since this maybe is a timing issue, and ohci bus reset handling
> occurs at SCHED_OTHER workqueu context, were you by any chance running
> unreasonably-intensive realtime workloads by the time the driver was
> loaded?

Not that I am aware of. The driver neither initializes the device during
boot nor when later reloading.
There are no intense services running. The system is fairly
multi-purpose, so most things are started on demand.

Thanks!

David

--=20
https://sleepmap.de

--xQ9xaHb/SmmtzFh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmATL5kACgkQVMKPT/Wh
qUkPdBAAgK7/YwFvPgqG7uJ2jOMC49R1nPfs5VdJwgZ8Ue+ltq5ihY85F5GHHmub
rCbtSGTHSANjpYk8ZfniQcehzemHB9KMKroSSnst5einTQC7jIZ8DDHytRPyoDPZ
a7USfJ3cs4H6JryopqTY5q3hzapwMLX4b2H9WFIUe/KoNYvY9oEXZDY4y8wapnlv
JW7nSviV1guat1FNhf7PwpgCD4y2zCAEVHlV2jED0PqG7YlsMJVcxI8e9CZBvExQ
vFMbhhlpdcM0JUissUcKyqk1Jo4PK347ZBROOT12LcdcS5BCkyT/HzMOZaBNb0J/
KbKsoUMVdGPa9gmWyHv5a8CYhVA8WECwGBat7fn9k/nkNA2qUcTe/zlZBG0jljqT
UwNvKjWjTWS6pFqSt0C6AqzPvh3rN1PKwnFUjqGvUFcuykL+ULpCbW6u7uR4cPNW
PWsBP7Qw3zhum9dwCg6d4P6//55cAZ0oK9xrdlfnoiHYsJhQ8CAvdcOy8CUkHSDj
tRdQs5kfnsiYxDlmLAvSGgE08n2n372qOjsD4Uy2ohKN/jMp9G9VSDRAnnEPMXAm
I3AI8vS5cu07EwuPmab9HQ/Wbmi2WyWk3pFCciGKBQQIFDcfcb0HqhRZfmJV8Ecb
9KrqAWRo3+wVeYvlfHMTXeyJarOQWINFeK9yFTlygRNG+28gP48=
=qjyt
-----END PGP SIGNATURE-----

--xQ9xaHb/SmmtzFh5--
