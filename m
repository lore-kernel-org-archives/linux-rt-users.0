From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: SCHED_RR preempted by SCHED_OTHER
Date: Mon, 27 Jul 2009 14:36:09 +0200
Message-ID: <20090727123609.GA26176@pengutronix.de>
References: <4A6D962B.20408@alcatel-lucent.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Denis Richard <denis.richard@alcatel-lucent.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39464 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZG0MgK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jul 2009 08:36:10 -0400
Content-Disposition: inline
In-Reply-To: <4A6D962B.20408@alcatel-lucent.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 27, 2009 at 01:57:31PM +0200, Denis Richard wrote:
> Hi all,
> We work on powerpc board with kernel 2.6.29.6-rt23.
> The kernel is configured with  "Complete Preemption (Real-Time)".
> Working on our software, we have a strange behavior.
> A real time thread (SCHED_RR) can be preempted by non real time one =20
> (SCHED_OTHER).
>
> We wrote a little test program (at the end of  this mail).
> This program creates 2 threads, a SCHED_RR one which processes during=
 =20
> about 12s
> (long for a real time, but just for test), and a SCHED_OTHER one, =20
> started after the first one,
> which just modifies a global variable. The second one should not run =
=20
> during the execution of
> the first one. But it appends, the global variable is modified.
>
> > rr_other
> Create thread
> OTHER ran during RR
> The end
> >
>
> Is it normal, a non real time thread preempts a real time one ? (we =20
> think, it is not)
> Or is there something wrong in the test program, the kernel =20
> configuration, ... ?
Does

	# echo -1 > /proc/sys/kernel/sched_rt_runtime_us

help?

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
