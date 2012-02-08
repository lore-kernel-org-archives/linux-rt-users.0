From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Wed, 8 Feb 2012 19:44:54 +0100
Message-ID: <20120208184454.GJ8621@pengutronix.de>
References: <4F143AB2.6070404@haw-aw.de>
 <CAOY97VZGuFz=txi1HnXjh_WqK+UVNiqRCifrnSxin7x2osbP5g@mail.gmail.com>
 <4F16D7E9.9070707@haw-aw.de>
 <20120118191955.GA4066@pengutronix.de>
 <4F3298E8.9090303@haw-aw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Austin Hendrix <ahendrix@willowgarage.com>,
	linux-rt-users@vger.kernel.org
To: Matthias =?iso-8859-1?Q?S=F6llner?= <m.soellner@haw-aw.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41883 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab2BHSpA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 13:45:00 -0500
Content-Disposition: inline
In-Reply-To: <4F3298E8.9090303@haw-aw.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Feb 08, 2012 at 04:46:48PM +0100, Matthias S=F6llner wrote:
> On 18.01.2012 20:19, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jan 18, 2012 at 03:32:09PM +0100, Matthias wrote:
> >> Ok.
> >> Where do I get a 3.0 Kernel with included preempt-Patch for instal=
ling
> >> in Debian 6.0?
> > if you're on amd64 install linux-image-3.0.0-2-rt-amd64 from
> > http://debian.pengutronix.de/debian sid main.=20
>=20
> I can't find the package in
> http://debian.pengutronix.de/debian sid main
>=20
> Added it to /etc/apt/sources.list, and made a sudo apt-get update.
> But the package is not there.
>=20
> What am I doing wrong?
What is the output of $(dpkg --print-architecture)?
debian.pengutronix.de only has the 3.x-rt kernels for amd64. The same i=
s
true for Debian itself BTW.

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
