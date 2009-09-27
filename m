From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: R:[ANNOUNCE] Linux-RT for Debian
Date: Sun, 27 Sep 2009 12:12:59 +0200
Message-ID: <20090927101258.GA16580@pengutronix.de>
References: <20090926171218.GD13150@pengutronix.de> <002215b019b2335a6504747f2d2d@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
To: neuromancer85@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57758 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbZI0KM5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Sep 2009 06:12:57 -0400
Content-Disposition: inline
In-Reply-To: <002215b019b2335a6504747f2d2d@google.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Antonio,

On Sat, Sep 26, 2009 at 06:24:34PM +0000, neuromancer85@gmail.com wrote=
:
> this is a GREAT news! I'm using linux-rt on debian testing as audio =20
> workstation, and before those
> packages I used to recompile the new rt kernel every time... So thank=
s=20
> for let me save some time ;)
>
> However I have a little problem: I need to install the package =20
> linux-headers-2.6.31-rt11-1-amd64 but it seems
> to depend on linux-kbuild-2.6.31-rt11, but it is not installable... A=
nd I=20
> need it to build the nvidia closed drivers :(
> Are you going to add it in the repo, or it is there and I'm just doin=
g =20
> something wrong somewhere? :D
I thought having added them to the archive, but it seems all have
vanished.  I will investigate and in the meantime added the kbuild
packages for .31-rt11.  The other will follow when I resolved the issue=
=2E

Thanks
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
