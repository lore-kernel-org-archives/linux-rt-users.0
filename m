From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: RT Patch to use for Kernel 3.2.0
Date: Sat, 17 Jan 2015 20:30:58 +0100
Message-ID: <20150117193058.GB22880@pengutronix.de>
References: <2181AC96E5EC8347999039A22D7597B7C6D8AA@MAL901.liteon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Jing Shao <Jing.Shao@liteon.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35874 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbbAQTbC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Jan 2015 14:31:02 -0500
Content-Disposition: inline
In-Reply-To: <2181AC96E5EC8347999039A22D7597B7C6D8AA@MAL901.liteon.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Jan 16, 2015 at 10:14:10PM +0000, Jing Shao wrote:
> I am trying to patch a Linux 3.2.0 kernel with PREEMPT_RT patch, I
> tried the patch-3.2.64-rt94.patch.gz, but the Linux kernel fails to
> compile afterwards, is this the right patch to use?
>=20
> For your info, the ouput of "uname -r" is 3.2.0. The kernel comes in
> as part of the SDK for a TI Sitara processor.
You don't want to use 3.2.0. There is a pile of fixes available. So
switch to 3.2.66 and try to apply the patch from 3.2.64-rt94 on top of
that.

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
