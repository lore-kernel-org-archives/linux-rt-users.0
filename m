From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Problem with Realtime Kernel and Ethernet Card
Date: Wed, 18 Jan 2012 20:19:55 +0100
Message-ID: <20120118191955.GA4066@pengutronix.de>
References: <4F143AB2.6070404@haw-aw.de>
 <CAOY97VZGuFz=txi1HnXjh_WqK+UVNiqRCifrnSxin7x2osbP5g@mail.gmail.com>
 <4F16D7E9.9070707@haw-aw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Austin Hendrix <ahendrix@willowgarage.com>,
	linux-rt-users@vger.kernel.org
To: Matthias =?iso-8859-1?Q?S=F6llner?= <m.soellner@haw-aw.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56605 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2ARTUD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jan 2012 14:20:03 -0500
Content-Disposition: inline
In-Reply-To: <4F16D7E9.9070707@haw-aw.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 18, 2012 at 03:32:09PM +0100, Matthias S=F6llner wrote:
> Ok.
> Where do I get a 3.0 Kernel with included preempt-Patch for installin=
g
> in Debian 6.0?
if you're on amd64 install linux-image-3.0.0-2-rt-amd64 from
http://debian.pengutronix.de/debian sid main. That is what was in Debia=
n
while it had 3.0 and updated to 3.0.12-rt30 and 3.0.14 which IIRC
matches 3.0.14-rt31.
=20
> By the way, is there any package which includes a Kernel with include=
d
> Preempt-Patch for use in Ubuntu 11.10 as it was available for ubuntu
> 8.04 (linux-rt)?
Nothing I'm aware of. Maybe the debian kernels just work?!

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
