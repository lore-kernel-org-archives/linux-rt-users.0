Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CFC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 23:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A16610C8
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 23:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbhIGX0L (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 19:26:11 -0400
Received: from sleepmap.de ([85.10.206.218]:41166 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347096AbhIGX0K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Sep 2021 19:26:10 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2021 19:26:10 EDT
Date:   Wed, 8 Sep 2021 01:17:02 +0200
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Kristian Hoegsberg <krh@bitplanet.net>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YTfy7pLhWkTOn+aI@hmbx>
References: <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
 <YEkMvjJt/Vu9Jbgu@hmbx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szSozMvqi6i2vSzl"
Content-Disposition: inline
In-Reply-To: <YEkMvjJt/Vu9Jbgu@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--szSozMvqi6i2vSzl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 8 Sep 2021 01:17:02 +0200
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Kristian Hoegsberg <krh@bitplanet.net>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

Hi all,

As a follow-up to the previous conversation, I have now also tried
5.14.1-rt19 (packaged as 5.14.1.19.realtime1) in the hopes that ALSA
driver improvements for my Fireface800 will allow me to use pipewire
going forward.

Unfortunately, firewire-ohci and/or firewire-core are still freezing
upon trying to make use of the connected device which is connected with
the card using the chip in question (see title).

Upon first boot the /dev/fw0 and /dev/fw1 nodes did not show up
initially [1] (log without using -1 debug parameter), which is why I
switched the device off and on again.
Afterwards the device nodes were created, so I attempted to use aplay -l
to check whether the device was detected. The command hung forever (also
starting jackd) and I had to reboot eventually. Using alsamixer I was
able to select the Fireface800 device from the list of devices though.

Upon 2nd boot I used the -1 debug parameter for firewire-ohci [2].
The device nodes were created automatically, but neither aplay -l nor
alsamixer showed the audio interface. The attempt to switch the device
off and on again and afterwards to remove the firewire-ohci module lead
to another freeze and a successive reboot.

If I can provide further information, please let me know!

I hope I can try the vanilla 5.14.1 kernel tomorrow to see how it
behaves in regards to firewire-ohci (judging from the past it will
probably work though).

Best,
David

P.S.: I have added Kristian Hoegsberg in CC, who is mentioned as the
author of firewire-ohci and firewire-core.

[1] https://pkgbuild.com/~dvzrv/bugs/2021/09/linux-5.14.1.19.realtime1-kern=
el.log
[2] https://pkgbuild.com/~dvzrv/bugs/2021/09/linux-5.14.1.19.realtime1-rest=
art_device_kernel.log

--=20
https://sleepmap.de

--szSozMvqi6i2vSzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmE38u4ACgkQVMKPT/Wh
qUl12g//W7rwFM2sqRnj6SHYKlLQ2tWJn/vAOhB1LsbGRBglN5a2BamkX7fl8QL9
F6YMWgAII6i3tLnaqhjn5viEQgi7ITD2uT9yos9YvCYWpfxN12x/ocPFvIjKQbvA
qFST54+ZstgT/+IZWMAI0fC1+j/pC8RQqPWt/5/TLoY+YRgvWPMXSwad8x5LAIwT
OOi8fVfdqu1LiDItxvGn27/U7rELpwUm2LyzlZrUnVpiphme4UEjbjfYHdsd5XyJ
C+KcbZqZ0yCfz+8xeYGfFYUUgU2dgwjltrT7O4mf03LSXjHvMXbOxRSabj5H9DP7
2TmGPLkfzfCKvdaxkm98uJBCHEFs549qneorSexFHqDg5VacRXITvLOvNdaEHzP5
eS98pcCxMmfteQJuC9sLcJlowT0NdrCeGMhmCviZpkNhWk2EN48tefZ0nu7dOx/w
/ASUWvxpwPnB9v+2bsNKcrVUNSIlqPcKTgbi9p4OFmuKdy8X07qOWtisPSdKKFPd
r7UKPW6IEMMS2IyNNNcr+Dm7IlJDhiAFzErtvqN0720XmlicavVPXV/CHym9aBVg
+qdYMwpeXByK5lEJ6Wu7o9oZ4kwSR2MbElvuGvW9Ml+o9P3br/dV4M64T0t83EKK
se/S37NWD7AowDAzDNNsb808FjJz2ha2jK+u2fH5hCYrY0rWHF0=
=ibYX
-----END PGP SIGNATURE-----

--szSozMvqi6i2vSzl--
