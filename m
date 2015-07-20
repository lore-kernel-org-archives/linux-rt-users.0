From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: udelay and ndelay includes and linker
Date: Mon, 20 Jul 2015 08:49:08 +0200
Message-ID: <20150720064908.GO7013@pengutronix.de>
References: <CA+Owze6yjuSdWZO_awTKbmP4m-iXadkABUB-z2OdvqRT1fnCHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: jkraehemann-guest@users.alioth.debian.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55430 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbbGTGtK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2015 02:49:10 -0400
Content-Disposition: inline
In-Reply-To: <CA+Owze6yjuSdWZO_awTKbmP4m-iXadkABUB-z2OdvqRT1fnCHw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Jul 17, 2015 at 11:15:01PM +0200, Jo=EBl Kr=E4hemann wrote:
> Hi, since on my system /usr/include/linux/delay.h is missing I'm
> asking me how to include it and link against it.
>=20
> I'd like to use ndelay() instead of nanosleep().
ndelay isn't callable from userspace. That's also the reason for not
being defined in userspace includable header files.

Why do you think there is an advantage when using ndelay over nanosleep=
?

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
