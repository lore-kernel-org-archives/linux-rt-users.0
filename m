Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282C8C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA2361A23
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 09:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYJIe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 05:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCYJIE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 05:08:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC49C06174A
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 02:08:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPLxz-0005zr-FG; Thu, 25 Mar 2021 10:07:47 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPLxz-0001ki-59; Thu, 25 Mar 2021 10:07:47 +0100
Date:   Thu, 25 Mar 2021 10:07:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, kernel@pengutronix.de
Subject: "printk: move console printing to kthreads" breaks NFS boot on i.MX8
Message-ID: <20210325090746.ukwwhslcruo77sqq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7dowt2ce7mkl3u2"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rt-users@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--l7dowt2ce7mkl3u2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have an i.MX8 board here (NXP's EVK) and booting it with the rootfs on
NFS fails like below on v5.11.4-rt11:

	...
	[    0.531118] mmc2: new HS400 MMC card at address 0001
	[    0.531658] mmcblk2: mmc2:0001 DG4032 29.1 GiB
	[    0.531820] mmcblk2boot0: mmc2:0001 DG4032 partition 1 4.00 MiB
	[    0.531988] mmcblk2boot1: mmc2:0001 DG4032 partition 2 4.00 MiB
	[    0.532116] mmcblk2rpmb: mmc2:0001 DG4032 partition 3 4.00 MiB, chardev=
 (240:0)
	[    0.551648]  mmcblk2: p1 p2
	[    0.571698] mmc1: host does not support reading read-only switch, assum=
ing write-enable
	[    0.582270] mmc1: new SDHC card at address b368
	[    0.582731] mmcblk1: mmc1:b368 SDC   3.84 GiB
	[    0.599759]  mmcblk1: p1
	[    4.351592] fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full - flow =
control rx/tx
	[    4.374722] Sending DHCP requests .
	[    6.942718] .
	[   11.438718] .
	[   19.302718] .
	[   33.054718] .
	[   57.118718] .
	[   87.118717]  timed out!
	[   87.125308] IP-Config: Retrying forever (NFS root)...
	[   87.129137] RTL8211F Gigabit Ethernet 30be0000.ethernet-1:01: attached =
PHY driver (mii_bus:phy_addr=3D30be0000.ethernet-1:01, irq=3DPOLL)
	[   91.231580] fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full - flow =
control rx/tx
	[   91.262719] Sending DHCP requests .
	[   93.766718] .
	[   98.142718] .
	[  105.790718] .
	[  119.174718] .
	[  142.598718] .
	[  172.598718]  timed out!
	[  172.605397] IP-Config: Retrying forever (NFS root)...
	[  172.609252] RTL8211F Gigabit Ethernet 30be0000.ethernet-1:01: attached =
PHY driver (mii_bus:phy_addr=3D30be0000.ethernet-1:01, irq=3DPOLL)
	[  176.703574] fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full - flow =
control rx/tx
	[  176.730720] Sending DHCP requests .
	[  179.178718] .
	[  183.458718] .
	[  190.938718] .
	...

(with DEBUG defined in net/ipv4/ipconfig.c).

I bisected and identified

	42afcbce7b62 (printk: move console printing to kthreads)

as the problematic commit. I just double checked that 42afcbce7b62 is
indeed bad and it's parent boots just fine.

I didn't start to look into what is the actual problem yet. Does this
ring a bell? Do you have a hint how to debug this?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l7dowt2ce7mkl3u2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBcUt8ACgkQwfwUeK3K
7Al7IAf+OpTG3sD0HY94enGMJsJsf8az8Zp8etDHFt8TbNCh6whQYLXCYfKoVacz
VYuXcY7WoTJ1xF+9JVBhVQkieZ2I50uKHRrukWLtXeDselLODNeEf1Xv2MAzNRjB
WA+Kjm9Ui+dbnDHUbrY5MC45v6BTEk5fR8bDe6ffIDrXS9+WKJjfwG9DFuYY1iTZ
/0OAsZaiRlSf0O5QO0P/Rj7FBp2JMmlwtLvRZkFUoT7q9tjDezRIvCpEWASrRedI
yuI7Rqzt3OK9HUvfbyeyKb/LIjvBEa3c/duxNGwwyyItXi/6vZx7J9RAjMLZw8oH
NDEQONZdfsX5hMp4ya/RmJncP8XYdg==
=TIsM
-----END PGP SIGNATURE-----

--l7dowt2ce7mkl3u2--
