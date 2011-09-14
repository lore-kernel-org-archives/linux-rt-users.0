From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: ARM pad issue with 3.0.[0-4]
Date: Wed, 14 Sep 2011 09:21:07 +0200
Message-ID: <20110914072107.GS28624@pengutronix.de>
References: <87fwk0tu7o.fsf@vostro.fn.ogness.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Ogness <john.ogness@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38187 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab1INHVI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Sep 2011 03:21:08 -0400
Content-Disposition: inline
In-Reply-To: <87fwk0tu7o.fsf@vostro.fn.ogness.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
On Tue, Sep 13, 2011 at 04:03:55PM +0200, John Ogness wrote:
> There is currently a bug in Linux 3.0 where the ARM pad control value=
s
> will be set to 0 instead of being left as they were when NO_PAD_CTRL =
is
> used. This bug was fixed with commit:
>=20
> 425933b30b0ccfac58065bca6c853ea627443cdf
Just a small addition: This doesn't affect ARM in general, only
the following Freescale SoCs: i.MX25, i.MX35, i.MX50, i.MX51 and i.MX53=
=2E

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
