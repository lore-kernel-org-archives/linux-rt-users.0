Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F65C433E0
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Feb 2021 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B0C64D79
	for <linux-rt-users@archiver.kernel.org>; Sun, 14 Feb 2021 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBNTQr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 14 Feb 2021 14:16:47 -0500
Received: from sleepmap.de ([85.10.206.218]:57382 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhBNTQp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 14 Feb 2021 14:16:45 -0500
Date:   Sun, 14 Feb 2021 20:16:02 +0100
From:   David Runge <dave@sleepmap.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YCl28sXo7LEyCK8y@hmbx>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
 <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Mqi9MYJz3uQEOHHo"
Content-Disposition: inline
In-Reply-To: <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--Mqi9MYJz3uQEOHHo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Feb 2021 20:16:02 +0100
From: David Runge <dave@sleepmap.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]

On 2021-02-08 10:19:40 (+0100), Sebastian Andrzej Siewior wrote:
> On 2021-02-07 10:58:13 [+0100], David Runge wrote:
> > With 5.10.12-rt26 the controller still does not initialize at all
> > though (/dev/fw0 does not appear):
> > https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.10.12-rt26-kernel.log
>=20
> So it is either config or chipset specific. Did you posted a link to
> your .config?

The current config can be found on the AUR [1].

The equivalent mainline kernel config (note, that it states it is for
5.10.13, but is actually used for 5.10.14 as well) where initialization
of the controller works (but the initialization of a connected device
does not, when using threadirqs) is here [2].

[1] https://aur.archlinux.org/cgit/aur.git/tree/config?h=3Dlinux-rt
[2] https://github.com/archlinux/svntogit-packages/blob/37abf96cac628b7f516=
c266a8c0288671ed96a2a/trunk/config

--=20
https://sleepmap.de

--Mqi9MYJz3uQEOHHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAmApdvIACgkQVMKPT/Wh
qUnwEQ//bOuHmMpCFozboLHry/nVr2hmB4jYIoY/mZCbLsb7GRo5I9yb3za8wpx5
LTElB5oBh0Lseb8PgIBxyertDAo0Axg2ZdMaURg08C4ZMTCtPe6gkh8EVzvoCBH4
0R0g0LRnAR8/D8khTANeZKA2BoSCIjMBuLZ1iGoX5aWn8hOqImvYk2CXIftVvtM6
rvtzxp9cKEahBsPNvJvGgKUpwEAzEj4eMvJb7GPnp95ZeDyyLfji61NXZpsVhB2x
9xO/3mAB0tXQbgszuXQB2F+rRReciVkVVvGm/D66CzMJlmNGqgsAuR8IjGblOtga
nBYP1SeDMrVU/tbXVb99whF+dGmD/8i208lLEJyl7QQy/xmDPEXzp+qfqBHbN4kZ
OA4A6P/RqTksYwPGEb+Eq9r5O6lo5a4ZAqn7xr9PaVhCWmmwvDnE9nTEX88P+/Xb
bKyVKHeX6271XX3xtt/N6rhQDKEAfQNKvM9KsdZYU55X/QwkecOsGqpbZvGXprlt
5idIbnwYaaYMzGlmRCNZvBb5gIn5ssjV2pAQIK0ZVd2FgswJirFD9tb3xKEY+iEc
scKJsytRUnT1WUDTqdBo2GwXnUIroYHXnIvJq7wWhC1yxv+PlebWU/zzDVeJkqZY
sz6uC2nY4CswTlU5x0t+IgeIijFTxk/stO6SierBZ/oIWFQRIwc=
=2WFy
-----END PGP SIGNATURE-----

--Mqi9MYJz3uQEOHHo--
