Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4997C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7617E61051
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 18:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhILSqO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 14:46:14 -0400
Received: from sleepmap.de ([85.10.206.218]:42050 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234680AbhILSqN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 14:46:13 -0400
Date:   Sun, 12 Sep 2021 20:44:56 +0200
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kristian Hoegsberg <krh@bitplanet.net>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YT5KqKpm1QvyFHAb@hmbx>
References: <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
 <YEkMvjJt/Vu9Jbgu@hmbx>
 <YTfy7pLhWkTOn+aI@hmbx>
 <YTgdLkTs7wEmj8fh@workstation>
 <YTjzKftQmFtPLYUR@hmbx>
 <YTlZTvb6B3O2as+q@workstation>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZXnbIQ7ayhysz0I"
Content-Disposition: inline
In-Reply-To: <YTlZTvb6B3O2as+q@workstation>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--7ZXnbIQ7ayhysz0I
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Sep 2021 20:44:56 +0200
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kristian Hoegsberg <krh@bitplanet.net>,
	linux1394-devel@lists.sourceforge.net,
	linux-rt-users@vger.kernel.org,
	"Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-09-09 09:46:06 (+0900), Takashi Sakamoto wrote:
> On Wed, Sep 08, 2021 at 07:30:14PM +0200, David Runge wrote:
> > I am using '-1' (all) in the 2nd link in my previous mail. It appears to
> > not show a different output in the kernel logs from when I set it to '5'
> > though. There seems to be something wrong...
> > I'm adding the options in a .conf file below /etc/modprobe.d/, e.g.:
> >=20
> > ```
> > options firewire-ohci debug=3D5
> > ```
> >=20
> > The only output I get from that is:
> >=20
> > ```
> > firewire_ohci 0000:05:00.0: enabling device (0000 -> 0002)
> > firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 8 IR + 8=
 IT contexts, quirks 0x2
> > firewire_core 0000:05:00.0: created device fw0: GUID 7856341278563412, =
S800
> > firewire_ohci 0000:05:00.0: isochronous cycle inconsistent
> > firewire_core 0000:05:00.0: created device fw1: GUID 000a3500ada83262, =
S400
> > firewire_core 0000:05:00.0: phy config: new root=3Dffc0, gap_count=3D5
> > ```
>=20
> Before printing 'created device fw1', Linux FireWire subsystem already
> initiates asynchronous transactions to retrieve content of configuration
> ROM located in 0x'ffff'f000'0400 of node address space. If you can see
> no transaction record but see the print, it means to fail configuration
> of the parameter of firewire-ohci module.
>=20
> I think your system uses initramfs. Any node for storage function in
> IEEE 1394 bus is available as initial boot disk, thus it's reasonable
> that the designer of your initramfs puts firewire-ohci/firewire-core
> modules into it. In the case, we can not configure module by
> '/etc/modprobe.d/*' since the modules are already loaded before mounting
> root file system.
>=20
> I think the design of initramfs differs depending on distribution, thus
> you need to find instruction for the way to configure module parameter
> by yourself.
>=20
> Instead, I suggest you to configure the module via sysfs after booting,
> like:
>=20
> ```
> # echo 5 > /sys/module/firewire_ohci/parameters/debug
> ```

I have played around with adding the configuration and the module
explicitly to the initramfs (we're using mkinitcpio on Arch Linux).
However, this did not change anything in the output provided by
journalctl [1].

A boot with the vanilla 5.14.2 (no threadirqs) and debug=3D-1 set for
firewire-ohci logs everything successfully [2].

My assumption is that the debug parameter is either not considered or
the module hangs far before there's any further output when on linux-rt.


Unrelated sidenote: I am currently booted into vanilla 5.14.2 (no
threadirqs) and the device works well using pipewire and the ALSA driver
snd-fireface.
Good job to everyone involved! I'm very happy about the results! \o/

Best,
David

[1] https://pkgbuild.com/~dvzrv/bugs/2021/09/linux-5.14.1.19.realtime1-fire=
wire-ohci-debug--1-initramfs-kernel.log
[2] https://pkgbuild.com/~dvzrv/bugs/2021/09/linux-5.14.2.arch1-firewire-oh=
ci-debug--1-initramfs-kernel.log

--=20
https://sleepmap.de

--7ZXnbIQ7ayhysz0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmE+SqgACgkQVMKPT/Wh
qUm4NQ/9FTLRychics9FSUnMxf/6ZHHj6Ko7wm8TnLA+KQGi/u0diPVx+Te7fCR1
x2kACGZJXBmVuIwchWvseVcaX2nvhkHRc1DcY2DwTLbMkkvSI1ngULH3UTSUwgVX
NSamkSSff+mdVK/aWowURtBJiNthlzk3IiODGKRAixWAG7OEBj8Qu6VJ916oIk0q
MigX3/tdqglPNu0uAtsrylSpcpdJ4EFgCxnEFCgNxBUHSqXQjaxPsOY6GrK9tU4Y
rCz91+WjpaCKqXFknpzHtPRFhYDuprNXWlMICMhSWrf2gLCIaLyo9DGFQiN1pkz4
SL11AHB22WgthDRmCBzKCpfCRMMPLcUC2ayX8cMh+FGkCjWskYBG+KVr61NEyIEe
cZoBQ5i97iNWOB7vIbfbMfRjsw/FyiTI6bOSxmBl0NqU3Aa+fjZgPIIepM7G/jdt
L4SbsvSjWwydy90Bz9YTIur+hSN7k/2Aub0gI1D4UHF2KqBRREfd4iqVUldPBOg+
TTrLPmvlNi2ELFVDVz+rjljddLpprar8QRsOJMxTreAi2YCSZCMH6CN34VdJ2dbO
jQy8LSBUhR61BiNttJd9iTKEAh1ILOb7xxIkzh06kTgKM8HcLRo2aHqyRWvTelMh
551jctAgffRrSjWovwG1sqLS7oaD52owPVkjgrxLqFYPCmCezss=
=PdJv
-----END PGP SIGNATURE-----

--7ZXnbIQ7ayhysz0I--
