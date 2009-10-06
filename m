From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Problem with network on kernel 2.6.29.6-rt23 (Debian)
Date: Tue, 6 Oct 2009 11:15:09 +0200
Message-ID: <20091006091509.GA11134@pengutronix.de>
References: <1804966706.191254768514851.JavaMail.root@groupware> <369171892.211254768721569.JavaMail.root@groupware> <20091006064740.GB14219@isw.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jose Angel Martinez Conde <joseangel@taller-id.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Hans-Peter Bock <Hans-Peter.Bock@isw.uni-stuttgart.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51977 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbZJFJPu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2009 05:15:50 -0400
Content-Disposition: inline
In-Reply-To: <20091006064740.GB14219@isw.uni-stuttgart.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Oct 06, 2009 at 08:47:40AM +0200, Hans-Peter Bock wrote:
> hmm, i have a similar issue with my network interfaces on one special
> computer. At first I thought it is a bug in some pci card driver. But
> since the same setup works on a mainboard with different chipset and
> CPU, I do not assume that any longer.
>=20
> My computer with the similar issue has an nVidia chipset, see lspci
> beneath. Does your computer have the same chipset?
If so, do you have problems with a non-rt kernel, too?

Best regards
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
