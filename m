From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Setting the priority of an IRQ thread
Date: Tue, 16 Jun 2009 20:27:34 +0200
Message-ID: <20090616182734.GD13048@pengutronix.de>
References: <loom.20090615T222836-377@post.gmane.org> <000001c9ee36$218cf3a0$a852c70a@dlh.st.com> <loom.20090616T074347-549@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Martin Shepherd <mcs@astro.caltech.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37841 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbZFPS1d (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2009 14:27:33 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090616T074347-549@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jun 16, 2009 at 07:59:28AM +0000, Martin Shepherd wrote:
> Suresh Kumar SHUKLA <suresh.shukla <at> st.com> writes:
> > 	// get IRQ descriptor from IRQ, it contains pid
> > 	desc =3D &irq_desc[IRQ_BASIC_TIMER_3_1];
>=20
> That's a very useful clue. I was thinking that I would have to walk t=
he process
> tree to find the thread by name. Following up on this clue, it appear=
s as though
> in kernel 2.6.29.4 I should be able to use desc=3Dirq_to_desc(irq) to=
 look up the
> IRQ descriptor, then use pid=3Dget_task_pid(desc->thread), to get the=
 PID of the
> IRQ thread, then use sys_sched_setscheduler(pid,...) to change its pr=
iority.
> I'll try that out in the morning.
I wouldn't recommend calling sys_sched_setscheduler from kernel space.
That's the userspace API and you need to pass a __user pointer as third
argument.

The right way is to do this change from userspace.

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
