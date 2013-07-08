From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 0/5] Queue work on power efficient wq
Date: Mon, 8 Jul 2013 22:18:08 +0530
Message-ID: <CAKohpokT3M5TNhzGxCwHZoFU69VkFutQ-KBCf5Xh5Vfwb+trzg@mail.gmail.com>
References: <cover.1366803121.git.viresh.kumar@linaro.org>
	<20130708153716.GF29556@pengutronix.de>
	<CAKohpon+dFBDUhfbJcBBWyg4mAfQ1nU_wSd6OMvdTH6SzkUjNg@mail.gmail.com>
	<20130708155747.GG29556@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tj@kernel.org, davem@davemloft.net, airlied@redhat.com,
	axboe@kernel.dk, tglx@linutronix.de, peterz@infradead.org,
	mingo@redhat.com, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	robin.randhawa@arm.com, Steve.Bannister@arm.com, Livi@jasper.es
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:45835 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab3GHQsJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jul 2013 12:48:09 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so5853246obc.27
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Jul 2013 09:48:08 -0700 (PDT)
In-Reply-To: <20130708155747.GG29556@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 8 July 2013 21:27, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.d=
e> wrote:
> On Mon, Jul 08, 2013 at 09:17:01PM +0530, Viresh Kumar wrote:

>> Well, big LITTLE still runs an SMP kernel :) and so has this flag se=
t.
> The 'S' is justified because cpu0 and cpu1 are of the same type? Are
> there b.L systems that have only one big and one LITTLE cpu? Do these
> use SMP, too?

=46ollowing definition of SMP says:
http://en.wikipedia.org/wiki/Symmetric_Multiprocessor

A system is SMP when:
- It has same type of cores
- controlled by a single instance of OS.

In big LITTLE first one is obviously not completely true as you pointed=
 out.
But second one is and so I would say its an SMP system :)

Don't know how it should be called though.

>> You can make it dependent on that if required.
> Well, it's not required. It's just that the corresponding question in
> make oldconfig isn't really an enrichment for a kernel targeting an
> Cortex M3 :-)

Just to make it clear enough, you are saying it doesn't make any
sense to enable it for M3? But because it is disabled by default,
the problem is not seen?

Why? Can't we have two M3's on a SoC and run an SMP kernel over
it?

--
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
