From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Ooops 805 2.6.31.12-rt20
Date: Thu, 28 Jan 2010 20:54:57 +0100
Message-ID: <20100128195457.GA5541@pengutronix.de>
References: <20100127140902.8EDEBE967@iss1.vlsi.informatik.tu-darmstadt.de> <20100128080125.GC13756@pengutronix.de> <201001282041.30610.tstone@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Tim Sander <tstone@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44965 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab0A1Ty6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 14:54:58 -0500
Content-Disposition: inline
In-Reply-To: <201001282041.30610.tstone@vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Tim,

On Thu, Jan 28, 2010 at 08:41:30PM +0100, Tim Sander wrote:
> Hi=20
> > This is already fixed in mainline.  (And you were Cc:d for the two
> > most relevant patches!)
> Oh, then sorry for the noise. I really forgot it seems as if last yea=
r is like long ago...
>=20
> > 84177a2 and 81538e7 are the important ones for you, I didn't check =
the
> Ok thanks.
>=20
> Btw. is there a up to date preempt rt git tree. I looked on git.kerne=
l.org but i didn't=20
> find any recent preemt-rt linux tree? I mean one where the mainline=20
> fixes and the -rt patches are in one tree?
It's not trivial to merge Linus' tree and the rt tree.  In the mail
announcing 2.6.31.12-rt20 Thomas says to start working at 33-rcX-rt.  I
assume you have to wait for that.

> Btw heres a little typo fix (colon missing). Probably the wrong
> mailing list, but the right people 8-)
The right people are reading linux-arm-kernel ML, not this one.  I sent
a patch including a commit log to that list.

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
