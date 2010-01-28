From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Ooops 805 2.6.31.12-rt20
Date: Thu, 28 Jan 2010 09:01:25 +0100
Message-ID: <20100128080125.GC13756@pengutronix.de>
References: <20100127140902.8EDEBE967@iss1.vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Tim Sander <tstone@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51459 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab0A1IB1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 03:01:27 -0500
Content-Disposition: inline
In-Reply-To: <20100127140902.8EDEBE967@iss1.vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> it seems as if the FEC ethernet driver of the phycore pcm043 freescal=
e imx35 is unhappy.
> If there is an easy way to test this i would give it a try.
This is already fixed in mainline.  (And you were Cc:d for the two
most relevant patches!)

	$ git lg v2.6.31.12-rt20..linus/master -- drivers/net/fec.c
	78abcb1 net: fix section mismatch in fec.c
	66bc4a6 Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gerg/m68knommu
	4980296 m68knommu: remove ColdFire direct interrupt register access
	81538e7 fec: don't enable irqs in hard irq context
	84177a2 fec: fix recursive locking of mii_lock
	aa11d95 Merge branch 'master' of master.kernel.org:/pub/scm/linux/kern=
el/git/davem/net-2.6
	da81203 Merge branch 'master' of master.kernel.org:/pub/scm/linux/kern=
el/git/davem/net-2.6
	6ed1065 net: use NETDEV_TX_OK instead of 0 in ndo_start_xmit() functio=
ns

84177a2 and 81538e7 are the important ones for you, I didn't check the
others.

Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
