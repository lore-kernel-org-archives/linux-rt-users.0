Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0C0C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Mar 2021 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A5364FB3
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Mar 2021 18:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhCJSP4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:15:56 -0500
Received: from sleepmap.de ([85.10.206.218]:42070 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233622AbhCJSP2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Mar 2021 13:15:28 -0500
Date:   Wed, 10 Mar 2021 19:15:20 +0100
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YEkMvjJt/Vu9Jbgu@hmbx>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6msKiO1TDZjGbyAt"
Content-Disposition: inline
In-Reply-To: <20210308141210.yoa37dsc26p4jsim@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--6msKiO1TDZjGbyAt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Mar 2021 19:15:20 +0100
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-03-08 15:12:10 (+0100), Sebastian Andrzej Siewior wrote:
> On 2021-02-18 10:27:51 [+0100], To David Runge wrote:
> > On 2021-02-18 09:38:49 [+0100], To David Runge wrote:
> > > On 2021-02-14 20:16:02 [+0100], David Runge wrote:
> > > > The current config can be found on the AUR [1].
> > >=20
> > > So this did make a difference.=20
> >=20
> > made _no_ difference. Sorry for the confusion.
>=20
> David, did you had a chance to test the patch?

Hey Sebastian,

sorry for the long delay! I got busy with other packaging/
infrastructure things and nearly forgot about this one.

I have now tested with 5.11.2-rt9 with and without your proposed patch.

Without the patch [1], the behavior is as before, only the parent device
node of the controller (/dev/fw0) is created, but the attached audio
interface is not recognized.

With the patch applied [2], things get a little more exciting, as now
both the parent and the child node are created (so both /dev/fw0 and
/dev/fw1 show up).

However, starting jackd on the interface leads to a zombification of the
jackd process and the process never exits:

```
Starting JACK server using fw-fireface800-48000.conf profile...
no message buffer overruns
no message buffer overruns
no message buffer overruns
jackdmp 1.9.17
Copyright 2001-2005 Paul Davis and others.
Copyright 2004-2016 Grame.
Copyright 2016-2021 Filipe Coelho.
jackdmp comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK server starting in realtime mode with priority 80
self-connect-mode is "Don't restrict self connect requests"
1615399142007837:  (ffado.cpp)[  92] ffado_streaming_init: libffado
2.4.4 built Nov 12 2020 17:24:24
jack@fw-fireface800-48000.service: start operation timed out.
Terminating.
jack@fw-fireface800-48000.service: State 'stop-sigterm' timed out.
Killing.
jack@fw-fireface800-48000.service: Killing process 1813 (jackd) with
signal SIGKILL.
jack@fw-fireface800-48000.service: Killing process 2021 (FW_ARMSTD) with
signal SIGKILL.
jack@fw-fireface800-48000.service: Processes still around after SIGKILL.
Ignoring.
jack@fw-fireface800-48000.service: State 'final-sigterm' timed out.
Killing.
jack@fw-fireface800-48000.service: Killing process 1813 (jackd) with
signal SIGKILL.
jack@fw-fireface800-48000.service: Processes still around after final
SIGKILL. Entering failed mode.
jack@fw-fireface800-48000.service: Failed with result 'timeout'.
jack@fw-fireface800-48000.service: Unit process 1813 (jackd) remains
running after unit stopped.
Failed to start JACK server using fw-fireface800-48000.conf profile.
```

If I can provide more info, please let me know!

Best,
David

[1] https://pkgbuild.com/~dvzrv/bugs/2021/03/linux-5.11.2-rt9-kernel.log
[2] https://pkgbuild.com/~dvzrv/bugs/2021/03/linux-5.11.2-rt9-kernel_firewi=
re_ohci_patch.log

--=20
https://sleepmap.de

--6msKiO1TDZjGbyAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmBJDLkACgkQVMKPT/Wh
qUkwOQ//Uklo50mVmPxwAoqKv4lb47p5V8M74mGO8SmaH519nGWoeep43rL8V8sO
dvcRHTzTHHgCivdrgsxrDzKbrMy5FuQvJgMlypx0LQi6gjboyXYiVvcOCVXn+Q3U
hAnnt8g1AgR7UG9qcY0ehjsWu/hKlztQbZwR9by+WLOKhkFb2UGOHK2Ksbydhu6/
rOcenjb1X2r4+lB0IpBtyf270IlbCHD1WYG2RJR57MPcTRB/9aL+MdfGeCtucuZa
gsblnu1O2m71MlNjbF86D5Yt3gHX+GLxQl+d+cT61YncVqWUG9ikSkkDARL+Pwbn
TulhADSiZy8ddcQhS6hRm0uQSF/7RY05WSiSKn7EUY1nl8ig8+6KMUMqCmr1la/t
mdgcUx2pnM25VsbLHm+8Pt8nyJziU75ozlbgMEIn5tJpTO14ZEJej27KYVvHENsM
fQcpoiwYp61aFZvPlGUI4aLgCxbLarVGHfA8ZohthgpcjgY1X/4AhSFGFOxx6BG0
4YqO+cFzF1Q/AKfTtJ+IfMNBNcXoRjOYodTgZjrK49mdFE57765nBWS0CB0dUsNw
GjGqhk34BXOtEGNW+5eOL9RaSutohFjpZA+FwJgSkBDmweN0SIOBW6aoHjo+DcCL
/h4iCUdv2jQmqRGWcRn2zgHmTGrBCTR6HtGs5AFABfEfNRrgsEw=
=mDUN
-----END PGP SIGNATURE-----

--6msKiO1TDZjGbyAt--
