From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V5 0/5] Queue work on power efficient wq
Date: Mon, 8 Jul 2013 17:57:47 +0200
Message-ID: <20130708155747.GG29556@pengutronix.de>
References: <cover.1366803121.git.viresh.kumar@linaro.org>
 <20130708153716.GF29556@pengutronix.de>
 <CAKohpon+dFBDUhfbJcBBWyg4mAfQ1nU_wSd6OMvdTH6SzkUjNg@mail.gmail.com>
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
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42218 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab3GHP6F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jul 2013 11:58:05 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpon+dFBDUhfbJcBBWyg4mAfQ1nU_wSd6OMvdTH6SzkUjNg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 08, 2013 at 09:17:01PM +0530, Viresh Kumar wrote:
> On 8 July 2013 21:07, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix=
=2Ede> wrote:
> > This patch set hit my tree now. I wonder if it makes sense to make
> > WQ_POWER_EFFICIENT_DEFAULT depend on SMP. (Oh wait, big.LITTLE isn'=
t
> > SMP, so probably there is a better symbol to depend on?)
>=20
> Well, big LITTLE still runs an SMP kernel :) and so has this flag set=
=2E
The 'S' is justified because cpu0 and cpu1 are of the same type? Are
there b.L systems that have only one big and one LITTLE cpu? Do these
use SMP, too?

> You can make it dependent on that if required.
Well, it's not required. It's just that the corresponding question in
make oldconfig isn't really an enrichment for a kernel targeting an
Cortex M3 :-)

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
