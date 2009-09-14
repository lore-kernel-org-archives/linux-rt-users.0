From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: hrtimer problem on AT91RM9200
Date: Mon, 14 Sep 2009 13:10:20 +0200
Message-ID: <20090914111020.GA2901@pengutronix.de>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de> <20090911230735.GA23652@pengutronix.de> <4AAE1FF8.90007@newtec.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37767 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284AbZINLK3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 07:10:29 -0400
Content-Disposition: inline
In-Reply-To: <4AAE1FF8.90007@newtec.dk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Bo,

On Mon, Sep 14, 2009 at 12:50:32PM +0200, Bo Hansen wrote:
> I tried to apply your patch and enabled ftrace but have not been able=
 to =20
> reproduce
> the panic.
> It should also be noted that the panic is much more rare if I apply t=
he =20
> first patch you
> sent.
Revert this patch, only use the second.  And optimally add a BUG() in
hrtimer_interrupt_hanging (in kernel/hrtimer.c) after the printk.

> The only panic I got was using your first patch and enabling ftrace. =
I =20
> have not yet had
> the time to try changing pr_info/pr_emerg.
In the meantime I understood why the 2nd printk doesn't appear on the
serial console.  That's because "non-atomic" consoles don't print
anything in atomic context (with PREEMPT_RT=3Dy)

> It seems to run stable when something like: "hrtimer: interrupt too =20
> slow, forcing clock
> min delta to 480771 ns" is found in the dmesg output, but I cannot be=
 =20
> sure as I don't
> know if this is also written to the log just before the panic.
Actually this is a bug because then min_delta_ns is decreased.  With th=
e
BUG as suggested above this message would be enough to debug this
further.

> Unfortunately I don't have much time for testing this at the moment b=
ut =20
> I'll get back
> as soon as possible.
:-|

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
