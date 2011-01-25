From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Kernel module crashed in 2.6.33.7-rt30
Date: Tue, 25 Jan 2011 17:21:36 +0100
Message-ID: <20110125162136.GD22005@pengutronix.de>
References: <1295941160.4853.0.camel@vikram-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Vikram <vikram186@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59502 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1AYQVh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Jan 2011 11:21:37 -0500
Content-Disposition: inline
In-Reply-To: <1295941160.4853.0.camel@vikram-pc>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jan 25, 2011 at 01:09:20PM +0530, Vikram wrote:
> Hi all,
> I am using linux 2.6.33.7.2-rt30 for running my kernel module.
> The kernel module is an Ethernet based protocol stack.=20
> I am setting the following priorities before loading the module
>=20
> 81 for sirq-hrtimer/1
> 81 for sirq-hrtimer/1
> 80 for the Ethernet Interrupt
> using the command 'chrt -f -p 81'
>=20
> The module runs fine for some time, but stops after an hour or so.
> This is what I got from the dmesg
>=20
> START TRACE=20
>=20
> [ 3353.564157] BUG: unable to handle kernel NULL pointer dereference =
at
> (null)
Don't know if this is available on X86, but setting DEBUG_BUGVERBOSE
might help here.

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
