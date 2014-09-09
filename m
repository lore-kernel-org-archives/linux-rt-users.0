From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC 0/4] Improving SPI driver latency (vs v3.8.13.14-rt31)
Date: Tue, 9 Sep 2014 22:01:17 +0200
Message-ID: <20140909200117.GU23009@pengutronix.de>
References: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57170 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaIIUBT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Sep 2014 16:01:19 -0400
Content-Disposition: inline
In-Reply-To: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Jeff,

On Mon, Sep 01, 2014 at 09:30:31AM -0500, Jeff Epler wrote:
> Unfortunately, I found that there were frequent large latencies, some
> over 10ms, when using /dev/spidev.  This seems to be typical of other=
s'
> experience using it (for instance, one can find threads discussing
> disappointing RT performance of SPI on the beaglebone and pandaboard;=
 at
> least one raspberry pi project chose to implement a pure userspace SP=
I
> driver instead of using spidev)
>=20
> At all levels of the SPI stack, I found things that could be improved=
 if
> lowest delays are the goal.  I doubt that in their current form these
> changes are suitable to be incorporated in preempt-rt, but I hope tha=
t=20
> this might spur some discussion that would ultimately lead to better
> realtime performance of SPI in the preempt-rt kernel.
I wonder why you didn't consider mainline as target for your patches
instead of preempt-rt. Also you might want to cc the spi maintainer on
this topic. I didn't check in detail what you did, but if it's useful
for others it would be a pity if it were not picked up because the
responsible people were not aware of your effort.

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
