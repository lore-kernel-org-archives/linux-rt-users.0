From: Bo Hansen <bh@newtec.dk>
Subject: Re: [SOLVED, RFC] Re: hrtimer problem on AT91RM9200
Date: Wed, 16 Sep 2009 08:26:47 +0200
Message-ID: <4AB08527.3030603@newtec.dk>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de> <20090911230735.GA23652@pengutronix.de> <4AAE1FF8.90007@newtec.dk> <20090914111020.GA2901@pengutronix.de> <20090915092934.GA2717@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:44704 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbZIPG0q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Sep 2009 02:26:46 -0400
In-Reply-To: <20090915092934.GA2717@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Uwe,

I'm happy to see you are able to reproduce the problem now.

This is a bit over my head as a newbie in the kernel, but I
will follow from the sideline ;-).

Thank you for taking care of the problem.

Best regards,
Bo



Uwe Kleine-K=F6nig wrote:
> Hello,
>
> I'm able to reproduce this now.  The problem is really that
> hrtimer_interrupt() tries to program the next timer event which fails=
 4
> times in a row, because the expiry time is already in the past when
> tick_dev_program_event is called.  This happens because there are so
> much timers with small expiry times. (cyclictest -t40 on an UP machin=
e)
>
> Addionally the fourth interation was short (probably because then the=
re
> were no expired timers to check for) and so the try_time argument to
> hrtimer_interrupt_hanging was small and so min_delta_ns was decreased
> instead of increased.
>
> I wonder why increasing min_delta_ns is supposed to fix something her=
e.
> Actually some pressure that results in hrtimer_interrupt_hanging bein=
g
> called can always happen independently of min_delta_ns' value.
> And moreover, is it sensible to change the value of
> force_clock_reprogram?  This makes the system harder to benchmark,
> because to guarantee a certain latency now you have to check both
> situations force_clock_reprogram=3D=3D1 and force_clock_reprogram=3D=3D=
0.
>
> My suggestion is to do the following:
>   - fix hrtimer_interrupt_hanging not to decrease min_delta_ns
>   - in clockevents_program_event instead of
> 	if (delta <=3D 0)
> 		return -ETIME;
>     do
> 	if (delta <=3D -dev->min_delta_ns)
> 		return -ETIME;
>
>     I'm not sure though if -dev->min_delta_ns is the right value or i=
f
>     that is a good idea at all.
>
> Best regards
> Uwe
>
>  =20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
