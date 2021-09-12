Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E22C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 18:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E32361051
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 18:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhILSzH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 14:55:07 -0400
Received: from sleepmap.de ([85.10.206.218]:42052 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234680AbhILSzH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 14:55:07 -0400
Date:   Sun, 12 Sep 2021 20:53:50 +0200
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YT5MvpE5yrqj/5WI@hmbx>
References: <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
 <YEkMvjJt/Vu9Jbgu@hmbx>
 <YTfy7pLhWkTOn+aI@hmbx>
 <YTgdLkTs7wEmj8fh@workstation>
 <20210910115541.jjf3fovv4v3etvde@linutronix.de>
 <YTx7EVV5vFuhKM5i@workstation>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5AP5xLDbQcoVBL2"
Content-Disposition: inline
In-Reply-To: <YTx7EVV5vFuhKM5i@workstation>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--Y5AP5xLDbQcoVBL2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Sep 2021 20:53:50 +0200
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux1394-devel@lists.sourceforge.net,
	linux-rt-users@vger.kernel.org,
	"Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-09-11 18:46:57 (+0900), Takashi Sakamoto wrote:
> Hi,
>=20
> On Fri, Sep 10, 2021 at 01:55:41PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-09-08 11:17:18 [+0900], Takashi Sakamoto wrote:
> > > Hi,
> > Hi,
> >=20
> > > According to the log, the task of 'pipewire-media-:2554' is blocked d=
uring
> > > 122 seconds by call of 'wait_for_completion()' in code of
> > > 'fw_run_transaction()'. This is odd in two points of transaction serv=
ice
> > > programmed in Linux FireWire subsystem:
> > >=20
> > > 1. The process context should be awakened by softIRQ context, which s=
hould
> > >    be scheduled by hwIRQ context for hardware interrupt of OHCI 1394
> > >    controller.
> > > 2. Even if the softIRQ context is not invoked, the process context
> > >    should be awakened by wheel timer context, which is scheduled to f=
inish
> > >    the transaction several jiffies later (originally prepared for the=
 case
> > >    of split-transaction). In the case, the result of transaction is
> > >    'RCODE_CANCELLED'.
> >=20
> >=20
> > Side note: David is using PREEMPT_RT and his problem can be reduced to
> > plain vanilla with `threadirqs' boot option. Back in February I sent him
> > a patch [0] which inlines the tasklet job as I assumed it is not good
> > reset the IRQ-event in the tasklet/workqueue. It seemed to improve the
> > situtation as it recognized the device attached to the bus but ended
> > then in the same timeout behaviour as now.
> >=20
> > [0] https://https://lkml.kernel.org/r/.kernel.org/all/20210218083849.ii=
tcrhdgv2oajfhv@linutronix.de/
>=20
> Thanks for the side note, and I apologize to follow the thread partially,
> not entire.
>=20
> Furthermore, I'd like to correct my misunderstanding about the 2nd point
> since the timer wheel context is scheduled only when the peer of
> transaction transfer ack_pending for the request subaction. Without the
> hwIRQ context, the task is blocked ever anyway.

Thanks at any rate to look into this! It is much appreciated!

Is there anything further I can try to debug this using threadirqs? It
would be really amazing to be able to use this device on PREEMPT_RT
again (especially given that now the ALSA driver has improved so
drastically). :)

Best,
David

--=20
https://sleepmap.de

--Y5AP5xLDbQcoVBL2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmE+TL4ACgkQVMKPT/Wh
qUnHZxAAhKANIdfxcbcADub6ZgZF2cp71omy2DXAQdNUCxO3iebpo6ijrSkXZkkQ
BX05eZAFBSVDVaXvP3Gf0078f8zT6sHlxTDipEA/KKxzrB3vBwiVWcddurTtVCHs
qrswqj+RfyjeqUHcc9S6Qs1c3YhlffbcwjYyR2/V9px5B5SUDRCKp4pKpDLcZEg1
CfdzTJJCbixir9sry6L26hx0XTl/5J9dFBUZiOCof2MMJ2QW6AIS+wAoPT6PWk4a
wXsITRZc5P8UhujVCxPLuxGJvL6T8I8feH8VrqbQNzSkNLXRI/8K7lAm/l+5dVHz
EPt6IpH1rsdLPm+OS64o/e0qKDgIdQQets71oLnT4/EF6gDliDxHUYDHRoJ92+nI
/oSmq1V8fiANtDXcxrXwzFQddAawco/lH76sFo1656EBRCQ94BnWaX2qlZ2XrVYB
VQrRpGcmkbeY50Z7IN1b5922B2hR5WRLh6xVjD9/JJEfX8D2m+3l8hRzoa5iERhv
a3nOqQi4Jn2E//MqcsJHVA0QX4Us402ekjcwxAOBtmF/aPaUIb1eICk3BlbdXV9z
Q4wtvmqQR+pWd62hiJCH8biGTomUaCcq9xLQwVfJacbZbTXMPlHxVPyoqymVA9Ob
40lRdMmH+WvhZLZ1Y3OhtaMFrZGpx/XgEg90n5aKZqzgUgiNht8=
=S4+S
-----END PGP SIGNATURE-----

--Y5AP5xLDbQcoVBL2--
