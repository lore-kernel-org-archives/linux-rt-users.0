From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Linux RT and Jffs2
Date: Mon, 28 Nov 2011 08:13:24 +0100
Message-ID: <20111128071324.GF17668@pengutronix.de>
References: <CAAVaN8wdd3HjfwzqBeBm0LiMsz93FfJ=ubp6iz2p4gui7sw=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Andreas O <andreas2025@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33593 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab1K1HN3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Nov 2011 02:13:29 -0500
Content-Disposition: inline
In-Reply-To: <CAAVaN8wdd3HjfwzqBeBm0LiMsz93FfJ=ubp6iz2p4gui7sw=EA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Andreas,

On Mon, Nov 28, 2011 at 02:45:26AM +0000, Andreas O wrote:
> I am using a real-time 2.6.33.7 version on ARM and I have noticed som=
e
> problems with the NAND. After a power cycle I see messages like
> "mtd->read( ) returned ECC Error." It is quite strange.
> Example:
>=20
> mtd->read(0x1fba0 bytes from 0x4e0460) returned ECC error
> mtd->read(0x1d520 bytes from 0x4e2ae0) returned ECC error
>=20
> Initially, I make write to the NAND the jff2 filesystem and when I
> boot for first time
> there are no ECC errors at all. After the first power cycler, some EC=
C
> errors will appear.
> If I do a second power cycle, more may be would appear.
> If I repeat again the same procedure, writing again the rootfile
> system to the NAND, after a power cycle the ECC errors will come from
> the same region (0x4exxxx). I have used different types of NAND, and
> the problem is the same.
>=20
> I think it might have to do with a combination of the RT and jffs2,
> Jffs2 garbage collector thread. The GC thread might need priority
> change as it takes the lock for performing the scan and may sleep for
> longer within the RT world. Therefore writes do not happen that often=
,
> therefore those ECC errors from un-flushed wbuf buffers.
>=20
> Have you seen similar behaviour before with RT and Jffs2?
How do you restart. Just pressing reset or unplugging is expected to
yield warnings by jffs2. See

http://www.linux-mtd.infradead.org/faq/jffs2.html#L_messages.

Maybe rt makes it more likely for these to appear, but the problem is
not specific to rt.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
