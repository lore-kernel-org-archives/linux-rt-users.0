From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 0/5] Queue work on power efficient wq
Date: Mon, 8 Jul 2013 21:17:01 +0530
Message-ID: <CAKohpon+dFBDUhfbJcBBWyg4mAfQ1nU_wSd6OMvdTH6SzkUjNg@mail.gmail.com>
References: <cover.1366803121.git.viresh.kumar@linaro.org>
	<20130708153716.GF29556@pengutronix.de>
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
Received: from mail-ob0-f173.google.com ([209.85.214.173]:52347 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3GHPrC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jul 2013 11:47:02 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so5607361obb.4
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Jul 2013 08:47:01 -0700 (PDT)
In-Reply-To: <20130708153716.GF29556@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 8 July 2013 21:07, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.d=
e> wrote:
> This patch set hit my tree now. I wonder if it makes sense to make
> WQ_POWER_EFFICIENT_DEFAULT depend on SMP. (Oh wait, big.LITTLE isn't
> SMP, so probably there is a better symbol to depend on?)

Well, big LITTLE still runs an SMP kernel :) and so has this flag set.
You can make it dependent on that if required.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
