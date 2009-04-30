From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: version 0.37 of rt-tests available
Date: Thu, 30 Apr 2009 08:52:59 +0200
Message-ID: <20090430065259.GA15709@pengutronix.de>
References: <20090429155011.09e2218f@torg> <49b7c2350904291830u79c827e6od323164fc19725e6@mail.gmail.com> <49b7c2350904292226r5c130b3ct1c520f2c25fb01cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40091 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZD3GxB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 02:53:01 -0400
Content-Disposition: inline
In-Reply-To: <49b7c2350904292226r5c130b3ct1c520f2c25fb01cc@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 30, 2009 at 02:26:52PM +0900, GeunSik Lim wrote:
> Dear Clark Willams.
>=20
> It's strange. It seems that you did't run "#> git commit -a" command.
>=20
> When I visited http://git.kernel.org/?p=3Dlinux/kernel/git/clrkwllms/=
rt-tests.git;a=3Dsummary
> webpage, I can't find v0.37 related "diff" contents in the shortlog
> table.
The problem is, that only the tag was pushed, not the master branch.
GeunSik Lim, what you can do is check out Clark's master branch (being
at 0.36) and simply pull in v0.37.

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
