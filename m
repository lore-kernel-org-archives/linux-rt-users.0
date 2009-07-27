From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: SCHED_RR preempted by SCHED_OTHER
Date: Mon, 27 Jul 2009 10:16:45 -0300
Message-ID: <20090727131645.GL23932@unix.sh>
References: <4A6D962B.20408@alcatel-lucent.fr> <20090727123609.GA26176@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Denis Richard <denis.richard@alcatel-lucent.fr>,
	linux-rt-users@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:21195 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbZG0NXH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Jul 2009 09:23:07 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1604954qwh.37
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2009 06:23:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090727123609.GA26176@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 27, 2009 at 02:36:09PM +0200, Uwe Kleine-K=F6nig wrote:
| On Mon, Jul 27, 2009 at 01:57:31PM +0200, Denis Richard wrote:
| > Hi all,
| > We work on powerpc board with kernel 2.6.29.6-rt23.
| > The kernel is configured with  "Complete Preemption (Real-Time)".
| > Working on our software, we have a strange behavior.
| > A real time thread (SCHED_RR) can be preempted by non real time one=
 =20
| > (SCHED_OTHER).
| >
| > We wrote a little test program (at the end of  this mail).
| > This program creates 2 threads, a SCHED_RR one which processes duri=
ng =20
| > about 12s
| > (long for a real time, but just for test), and a SCHED_OTHER one, =20
| > started after the first one,
| > which just modifies a global variable. The second one should not ru=
n =20
| > during the execution of
| > the first one. But it appends, the global variable is modified.
| >
| > > rr_other
| > Create thread
| > OTHER ran during RR
| > The end
| > >
| >
| > Is it normal, a non real time thread preempts a real time one ? (we=
 =20
| > think, it is not)
| > Or is there something wrong in the test program, the kernel =20
| > configuration, ... ?
| Does
|=20
| 	# echo -1 > /proc/sys/kernel/sched_rt_runtime_us
|=20
| help?

Also be prepared to find a WARNING on the kernel logs as the kernel get=
s
worried everytime a CPU runs the same process for more than 10s.

If Uwe's suggestion doesn't solve the issue, you may want to run the
sched_switch tracer from ftrace. Steven Rostedt recently posted a users=
pace
application to make this task easier.

Have fun,
Luis
--=20
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
