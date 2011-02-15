From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Tue, 15 Feb 2011 09:23:27 +0100
Message-ID: <20110215082327.GK13279@pengutronix.de>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Peter LaDow <petela@gocougs.wsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48898 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1BOIX3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Feb 2011 03:23:29 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 14, 2011 at 02:31:43PM -0800, Peter LaDow wrote:
> How is the scheduling of the hrtimers softirq thread handled?
>=20
> When querying the RT priority of the hrtimer softirq, I get a priorit=
y
> of 50.  But when running a priority 99 thread, we still seem to be
> getting interrupted.  Shouldn't the hrtimer softirq be put off until
> the CPU is idle or a lower priority task is running?
The problem isn't just $(cat /proc/sys/kernel/sched_rt_runtime_us) bein=
g
smaller than $(/proc/sys/kernel/sched_rt_period_us)?

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
