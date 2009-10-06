From: Jose Angel Martinez Conde <joseangel@taller-id.com>
Subject: Re: Problem with network on kernel 2.6.29.6-rt23 (Debian)
Date: Tue, 6 Oct 2009 11:22:35 +0200 (CEST)
Message-ID: <242065626.331254820955036.JavaMail.root@groupware>
References: <20091006091509.GA11134@pengutronix.de>
Reply-To: Jose Angel Martinez Conde <joseangel@taller-id.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 43.pool85-52-160.static.orange.es ([85.52.160.43]:61579 "EHLO
	groupware.taller-id.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755857AbZJFJVx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2009 05:21:53 -0400
In-Reply-To: <20091006091509.GA11134@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


In my case, only with rt kernel.

Regards,

--
jose angel

----- "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de> wrote:

> On Tue, Oct 06, 2009 at 08:47:40AM +0200, Hans-Peter Bock wrote:
> > hmm, i have a similar issue with my network interfaces on one
> special
> > computer. At first I thought it is a bug in some pci card driver.
> But
> > since the same setup works on a mainboard with different chipset
> and
> > CPU, I do not assume that any longer.
> >=20
> > My computer with the similar issue has an nVidia chipset, see lspci
> > beneath. Does your computer have the same chipset?
> If so, do you have problems with a non-rt kernel, too?
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                              | Uwe Kleine-K=C3=B6nig=
     =20
>      |
> Industrial Linux Solutions                    |
> http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
