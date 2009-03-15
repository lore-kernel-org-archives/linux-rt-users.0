From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: some ARM fixes for 2.6.29-rc7-rt1
Date: Sun, 15 Mar 2009 07:48:03 +0100
Message-ID: <20090315064803.GB6982@pengutronix.de>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain> <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain> <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain> <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain> <20090313010458.GB1192@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>, Clark Williams <williams@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45253 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZCOGsK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Mar 2009 02:48:10 -0400
Content-Disposition: inline
In-Reply-To: <20090313010458.GB1192@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Fri, Mar 13, 2009 at 02:04:58AM +0100, Uwe Kleine-K=F6nig wrote:
> on top of 2.6.29-rc7-rc1 I did some ARM related fixes that you can fi=
nd
> at
>=20
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git v2.6.29-rc7-rt1-pu
>=20
> The top commit currently isn't pretty as it contains several independ=
ant
> fixes.  Some of them are netX specific so you probably don't need the=
m,
> but they shouldn't hurt you either.
>=20
> I will update this branch as I continue working in a non-fast-forward
> manner.  I use TopGit to manage this branch, you might want to use it=
,
> too, if you intend to follow my work.
>=20
> My status quo is:
>=20
> 	Testing tracer sched_switch: PASSED
> 	Testing tracer function: PASSED
> 	Testing tracer irqsoff: .. no entries found ..FAILED!
> 	Testing tracer preemptoff: .. no entries found ..FAILED!
> 	Testing tracer preemptirqsoff: .. no entries found ..
[removed stack dump]
> 	FAILED!
I still have this problem.  I digged into irqsoff without finding the r=
eason.

Looking at trace_selftest_startup_irqsoff I saw that
trace_buffer_lock_reserve is called thrice successfully.

Steven (or someone else of course), do you can give me a hint?

> Other than that my machine boots and reports from time to time
>=20
> 	scheduling while atomic
>=20
> and
>=20
> 	sleeping function called from invalid context at kernel/rtmutex.c:68=
3
>=20
> Both errors probably happen because some spin_locks need to be conver=
ted
> to raw_spin_locks.  Will look later.
Up to now I didn't try to do much with my system, but just booting
doesn't yield such BUGs or Warnings anymore.
=20
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
