From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V5 0/5] Queue work on power efficient wq
Date: Mon, 8 Jul 2013 17:37:16 +0200
Message-ID: <20130708153716.GF29556@pengutronix.de>
References: <cover.1366803121.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tj@kernel.org, davem@davemloft.net, airlied@redhat.com,
	axboe@kernel.dk, tglx@linutronix.de, peterz@infradead.org,
	mingo@redhat.com, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	robin.randhawa@arm.com, Steve.Bannister@arm.com, Livi@jasper.es
To: Viresh Kumar <viresh.kumar@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57303 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3GHPhl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jul 2013 11:37:41 -0400
Content-Disposition: inline
In-Reply-To: <cover.1366803121.git.viresh.kumar@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Wed, Apr 24, 2013 at 05:12:52PM +0530, Viresh Kumar wrote:
> This patchset was called: "Create sched_select_cpu() and use it for w=
orkqueues"
> for the first three versions.
>=20
> Earlier discussions over v3, v2 and v1 can be found here:
> https://lkml.org/lkml/2013/3/18/364
> http://lists.linaro.org/pipermail/linaro-dev/2012-November/014344.htm=
l
> http://www.mail-archive.com/linaro-dev@lists.linaro.org/msg13342.html
>=20
> V4 is here:
> https://lkml.org/lkml/2013/3/31/55
>=20
> Workqueues can be performance or power oriented. For performance we m=
ay want to
> keep them running on a single cpu, so that it remains cache hot. For =
power we
> can give scheduler the liberty to choose target cpu for running work =
handler.
>=20
> Later one (Power oriented WQ) can be achieved if the workqueue is all=
ocated with
> WQ_UNBOUND flag. Enabling CONFIG_WQ_POWER_EFFICIENT will set
> 'wq_power_efficient' to 'true'. Setting 'power_efficient' boot param =
will
> override value of 'wq_power_efficient' variable. When 'wq_power_effic=
ient' is
> set to 'true', we will convert WQ_POWER_EFFICIENT flag to WQ_UNBOUND =
on wq
> allocation. And so scheduler will have the liberty to choose where to=
 run this
> work.
>=20
> Here we are migrating few users of workqueues to WQ_POWER_EFFICIENT. =
These
> drivers are found to be very much active on idle or lightly busy syst=
em and
> using WQ_POWER_EFFICIENT for these gave impressive results.
>=20
> These would be used in power saving mode only if relevant configs are=
 enabled
> at compile time or in bootargs. Otherwise behavior is unchanged.
>=20
> Setup:
> -----
> - ARM Vexpress TC2 - big.LITTLE CPU
> - Core 0-1: A15, 2-4: A7
> - rootfs: linaro-ubuntu-devel
This patch set hit my tree now. I wonder if it makes sense to make
WQ_POWER_EFFICIENT_DEFAULT depend on SMP. (Oh wait, big.LITTLE isn't
SMP, so probably there is a better symbol to depend on?)

Just my 2 cent
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
