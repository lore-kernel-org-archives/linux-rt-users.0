From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: realtime kernel for Debian
Date: Sun, 29 Mar 2009 21:56:38 +0200
Message-ID: <20090329195638.GA25453@pengutronix.de>
References: <alpine.DEB.2.00.0903250812230.17709@wr-linux02> <49CA1781.3050603@gmail.com> <20090325131713.GH15865@ltw.loris.tv> <49CDFB4D.7070908@gmail.com> <f1357b430903280615u215182fan2e62581394174603@mail.gmail.com> <alpine.DEB.2.00.0903282331360.22173@wr-linux02> <49CF50D3.1080000@gmail.com> <49CFBDBE.5020408@gmail.com> <20090329185525.GB25154@pengutronix.de> <49CFC58D.4010803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Debian Developers <debian-devel@lists.debian.org>,
	pkg-multimedia-maintainers@lists.alioth.debian.org,
	rt-users <linux-rt-users@vger.kernel.org>
To: Grammostola Rosea <rosea.grammostola@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54042 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbZC2T4n (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Mar 2009 15:56:43 -0400
Content-Disposition: inline
In-Reply-To: <49CFC58D.4010803@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

[your To: header was strange, maybe my mail reaches less recipents than
your's]

>>> To get some progress here, I'm searching for a person who wants and=
=20
>>> is  capable in filing a wishlist bug (with a patch vs. the package=20
>>> linux-2.6
>>>    =20
>> Maybe providing a patch package is a better first step?
>>  =20
> thanks for thinking. Who could provide such a patch package?
I can.  I'd need a sponsor, though.  I know two Debian developers, I
will ask them.

The patch on top of Debian's 2.6.29 is already made[1]---I just merged
v2.6.29-rt1 and Debian's tree.

Best regards
Uwe

[1] Available in my git repo at

	git://git.pengutronix.de/git/ukl/linux-2.6.git debian-rt

or browsable at:

	http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3Ddebi=
an-rt

The actual diff is at:

	http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dcommitdiff;h=3Dde=
bian-rt;hp=3Ddebian/v2.6.29

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
