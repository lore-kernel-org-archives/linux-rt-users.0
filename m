Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011ADC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D976E61157
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 17:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbhIHRb2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:31:28 -0400
Received: from sleepmap.de ([85.10.206.218]:41310 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhIHRb1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 13:31:27 -0400
Date:   Wed, 8 Sep 2021 19:30:14 +0200
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kristian Hoegsberg <krh@bitplanet.net>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YTjzKftQmFtPLYUR@hmbx>
References: <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
 <YEkMvjJt/Vu9Jbgu@hmbx>
 <YTfy7pLhWkTOn+aI@hmbx>
 <YTgdLkTs7wEmj8fh@workstation>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7whbo5xfvtqAAJgT"
Content-Disposition: inline
In-Reply-To: <YTgdLkTs7wEmj8fh@workstation>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--7whbo5xfvtqAAJgT
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 8 Sep 2021 19:30:14 +0200
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kristian Hoegsberg <krh@bitplanet.net>,
	linux1394-devel@lists.sourceforge.net,
	linux-rt-users@vger.kernel.org,
	"Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

Hi Takashi,

thanks for the prompt and detailed response!

Unfortunately I lack the knowledge about the driver and its inner
workings to be able to provide a patch for this issue myself.
If anyone reading this who is able to suggest a fix, I'd be happy to
test it!

On 2021-09-08 11:17:18 (+0900), Takashi Sakamoto wrote:
> I guess we have issue in the softIRQ context or timer wheel context
> instead of hwIRQ context, if the OHCI 1394 controller you use has
> no quirk (I suggest you to give information about the controller).
>=20
> I'd like you to check it. The firewire-ohci module has 'debug' parameter.
>=20
> ``
> $ modinfo firewire-ohci
> ...
> parm:           debug:Verbose logging (default =3D 0, AT/AR events =3D 1,=
 self-IDs =3D 2, IRQs =3D 4, busReset events =3D 8, or a combination, or al=
l =3D -1) (int)
> ``

I am using '-1' (all) in the 2nd link in my previous mail. It appears to
not show a different output in the kernel logs from when I set it to '5'
though. There seems to be something wrong...
I'm adding the options in a .conf file below /etc/modprobe.d/, e.g.:

```
options firewire-ohci debug=3D5
```

The only output I get from that is:

```
firewire_ohci 0000:05:00.0: enabling device (0000 -> 0002)
firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT =
contexts, quirks 0x2
firewire_core 0000:05:00.0: created device fw0: GUID 7856341278563412, S800
firewire_ohci 0000:05:00.0: isochronous cycle inconsistent
firewire_core 0000:05:00.0: created device fw1: GUID 000a3500ada83262, S400
firewire_core 0000:05:00.0: phy config: new root=3Dffc0, gap_count=3D5
```

This is with starting with the audio interface connected and on. I have
to switch it off and on again to get recognized, but then the driver
crashes (full kernel log [1])

[1] https://pkgbuild.com/~dvzrv/bugs/2021/09/linux-5.14.1.19.realtime1-fire=
wire-ohci-debug-kernel.log

Best,
David

--=20
https://sleepmap.de

--7whbo5xfvtqAAJgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmE48yYACgkQVMKPT/Wh
qUmGNBAAkoh52BI9hO/mESSlPDS7lEiTzI/UWZruXfRft/f5odfm59EqwVWdQr79
tshPKsvdBYKeavsvQoGVG8SUmqqxKuyBFEB8a6/qF2K4lspUGSRDJVhYGE3HwFCC
o2OVE0RtObn3CT7ps38l9Zwk7oDKTxxG+8O03mfDMpS2OlwhkBMt/QpKd20G6HEg
N8QeEYFjnGoUJfahEST8Ew4lFkWJbxQKXM/DnqtW+V/DkVrhzZHyGA4UKLWO0tu3
+fmskzxYx3O8Cm3s7ONi/FaNJorSC8wd9aHq1O9qId29DeaxY3F8ZtOlmQgoUhCm
cOffP3rOJk2ZNKRR7Ev7tL7VNtkzZYyKipKhlPurAUwY7DnwnPGgUYcZiObGGeT4
ZqbLLR0omLvRJDFAKq+5+a70611QEHJ5FJhppnUMJotduWSZJAzbO7uTwuFBijLu
RW2mQsFugoYONEyOpkrml4HKQCiOvh5rviFBsS109W44BYItkOekoMdM1jSmijK/
NxeqbdadgluUbnTHHVQW6wvxdyVEzvP2ll5eYm4YqEqINEkR79lmg73TkK63V9oz
n1wQrXFOeylEmd6Y0M2xdX9EgbwulZWmGQkCbBVd+yihl/PfRzXZfRzt44WTJu8y
5/zALb61bngeV3g/jYMcm64zGjeGuIqBdbnew9OVALYGTNGkHNw=
=PJBS
-----END PGP SIGNATURE-----

--7whbo5xfvtqAAJgT--
