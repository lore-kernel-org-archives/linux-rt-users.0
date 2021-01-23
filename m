Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4128C433DB
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Jan 2021 12:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8535223B08
	for <linux-rt-users@archiver.kernel.org>; Sat, 23 Jan 2021 12:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbhAWMKN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Jan 2021 07:10:13 -0500
Received: from sleepmap.de ([85.10.206.218]:40030 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbhAWMKL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Jan 2021 07:10:11 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jan 2021 07:10:10 EST
Date:   Sat, 23 Jan 2021 12:59:29 +0100
From:   David Runge <dave@sleepmap.de>
To:     linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YAwPoaUZ1gTD5y+k@hmbx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vuJ1cb2128WBMNRd"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--vuJ1cb2128WBMNRd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 Jan 2021 12:59:29 +0100
From: David Runge <dave@sleepmap.de>
To: linux-rt-users@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

Hi!

I package linux-rt and linux-rt-lts for Arch Linux.
Due to time constraints over the past months I did not have the time to
test all of my own hardware setups with the recent realtime kernels.

Unfortunately firewire-ohci is unable to initialize my firewire
controller [1] (a PCIe card [2]) both on 5.4.91-rt50 and on 5.10.8-rt24: No
device nodes (i.e. /dev/fw0) are created and therefore no connected devices=
 can
be initialized either.

The controller is initialized properly on our other stock kernels on
Arch Linux though (e.g. linux/ linux-hardened/ linux-lts) and I usually keep
the config files for linux-rt[3] and linux-rt-lts[4] as close as possible to
that of our respective core linux packages linux[5] and linux-lts[6].

Looking at the kernel logs, this is what the initialization usually looks l=
ike
on our stock kernels (with `firewire_ohci debug=3D8` and duplicate lines
truncated for brevity):

```
firewire_ohci 0000:05:00.0: enabling device (0000 -> 0002)
firewire_ohci 0000:05:00.0: IRQ 00020010 AR_req busReset
firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT =
contexts, quirks 0x2
firewire_ohci 0000:05:00.0: IRQ 00030000 selfID busReset
firewire_ohci 0000:05:00.0: IRQ 00020000 busReset
[..]
firewire_ohci 0000:05:00.0: IRQ 00020000 busReset
firewire_core 0000:05:00.0: created device fw0: GUID 7856341278563412, S800
firewire_core 0000:05:00.0: phy config: new root=3Dffc1, gap_count=3D5
firewire_ohci 0000:05:00.0: IRQ 00020010 AR_req busReset
firewire_ohci 0000:05:00.0: IRQ 00030000 selfID busReset
firewire_ohci 0000:05:00.0: IRQ 00020000 busReset
[..]
firewire_ohci 0000:05:00.0: IRQ 00020000 busReset
firewire_core 0000:05:00.0: created device fw1: GUID 000a3500ada83262, S400
```

And this is how the initialization looks like on the realtime kernels (with
`firewire_ohci debug=3D-1`):

```
firewire_ohci 0000:05:00.0: enabling device (0000 -> 0002)
firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT =
contexts, quirks 0x2
firewire_ohci 0000:05:00.0: IRQ 00020010 AR_req busReset
firewire_ohci 0000:05:00.0: AR evt_bus_reset, generation 1
```

I have a laptop using an ExpressCard34 that provides Firewire800 [7], with =
the
same Texas Instruments chip which initializes properly (i.e. /dev/fw0 is
created, subsequently connected devices are initialized and are usable) on =
the
realtime kernels:

```
firewire_ohci 0000:06:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT =
contexts, quirks 0x2
firewire_ohci 0000:06:00.0: IRQ 00030010 selfID AR_req busReset
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
[..]
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
firewire_core 0000:06:00.0: created device fw0: GUID 000acd12007000ff, S800
firewire_ohci 0000:06:00.0: IRQ 00030010 selfID AR_req busReset
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
[..]
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
firewire_ohci 0000:06:00.0: IRQ 00020010 AR_req busReset
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
firewire_ohci 0000:06:00.0: IRQ 00830000 selfID cycleInconsistent busReset
firewire_ohci 0000:06:00.0: isochronous cycle inconsistent
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
[..]
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
firewire_core 0000:06:00.0: created device fw1: GUID 000a3500ada83262, S800
firewire_core 0000:06:00.0: phy config: new root=3Dffc0, gap_count=3D5
firewire_ohci 0000:06:00.0: IRQ 00030010 selfID AR_req busReset
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
[..]
firewire_ohci 0000:06:00.0: IRQ 00020000 busReset
```

At this point in time I'm uncertain whether this is a general problem
with the kernel module on the realtime kernels or a problem with the
kernel module on the realtime kernels with my PCIe controller specifically.
That it works using the ExpressCard34 based controller on my laptop makes it
extra odd (but I guess the underlying driver is handling this
differently due to the PCI bridge?).

Any pointers to solving this issue would be greatly appreciated, as not bei=
ng
able to use firewire audio interfaces on a realtime kernel in a workstation
context is bad for pro-audio people on Linux in general (and me in particul=
ar
;-) ).

Best,
David

[1]
```
$ lspci -kP -s 05:00.0
00:01.2/00.0/00.0/00.0/00.0 FireWire (IEEE 1394): Texas Instruments XIO2213=
A/B/XIO2221 IEEE-1394b OHCI Controller [Cheetah Express] (rev 01)
        Subsystem: Device 3412:7856
        Kernel driver in use: firewire_ohci
        Kernel modules: firewire_ohci
```
[2] https://www.delock.de/produkte/1114_FireWire/89153/merkmale.html
[3] https://aur.archlinux.org/cgit/aur.git/tree/config?h=3Dlinux-rt&id=3D3a=
ef702717033d63ddc7c078f6d1fc388ea0e420
[4] https://aur.archlinux.org/cgit/aur.git/tree/config?h=3Dlinux-rt-lts&id=
=3D6c529a838f028fd0c55b97b6f98a9d35108f6696
[5] https://github.com/archlinux/svntogit-packages/blob/a0a47291449ab346e0d=
d209a2f23c82264c60d79/trunk/config
[6] https://github.com/archlinux/svntogit-packages/blob/1a0e0ed59007a8c0ddd=
34f847a92174e2838244f/trunk/config
[7]
```
$ lspci -kP -s 05:00.0
00:1c.3/00.0 PCI bridge: Texas Instruments XIO2213A/B/XIO2221 PCI Express t=
o PCI Bridge [Cheetah Express] (rev 01)
$ lspci -kP -s 06:00.0
00:1c.3/00.0/00.0 FireWire (IEEE 1394): Texas Instruments XIO2213A/B/XIO222=
1 IEEE-1394b OHCI Controller [Cheetah Express] (rev 01)
        Subsystem: Device 3412:7856
        Kernel driver in use: firewire_ohci
        Kernel modules: firewire_ohci
```

--=20
https://sleepmap.de

--vuJ1cb2128WBMNRd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmAMD6EACgkQVMKPT/Wh
qUmSpw//SVmu4mKOLtGIxQWpkYQfXYU0WadBJ2uRjnt1WVl/j04iO6CHbOUm4NNj
ZXtabbRgWbJHS+7cLwUn6CM3aExRGatCO03uwBPF1s6F/Mhsy/gKP20///Xx3aAp
iW9eMC4oMwU3QsngdvmXC5FyxbSjjPYv5X9ymuFoUm0gxw+NY6gBxojqgwA+FDYD
m7BPN1z63DONemzr8y0AtK6uU3SSxSz3nlI+0nWg16hy5a61kNkytW/ZQmZ5xuev
7FjSmxovjPEP6fetUW8Pi94BeVNEW09Ha09/lKrVQuotDL0LBqHSfICSxYAQa6tD
QrSy/Dn1gpqpQdYeNWdunA7jAuMJ8IYqBe7T2jhihDajiKgQNRdLZMcrBHyDX64/
yJdQFB5c825b198AlqXP4mkiCU4abmD9z2eMHUDHkVnkP9wifoQmrg/BGSNFcER1
8qFZWPU68UEEDAZADNYLnWqWt8TqldPq7n5KzM0RlgyGcWuQQQy42wnjtZujdgs3
28hGbBZmpOcYbSMtcDGB3RnoLBu01EaLNTmwk9D7hVHV9Q9/tBF+D3OLRCo2z2Jx
QfIjDRehR3KnKPBszOQAh+ClyA033APlfkPLRi2vOvIwtifPtKy185W3rvk0ZzUa
vwzx/K51Yo6OoVTtBzwCVfNLuAFQQlLFpxC8MqLylbtElSzGhtk=
=d6kj
-----END PGP SIGNATURE-----

--vuJ1cb2128WBMNRd--
