From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [SOLVED, RFC] Re: hrtimer problem on AT91RM9200
Date: Tue, 15 Sep 2009 20:40:03 +0200
Message-ID: <20090915184003.GA19766@pengutronix.de>
References: <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de> <20090911230735.GA23652@pengutronix.de> <4AAE1FF8.90007@newtec.dk> <20090914111020.GA2901@pengutronix.de> <20090915092934.GA2717@pengutronix.de> <alpine.LFD.2.00.0909151716450.8957@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bo Hansen <bh@newtec.dk>, john stultz <johnstul@us.ibm.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50799 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758243AbZIOSkM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2009 14:40:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0909151716450.8957@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Thomas,

On Tue, Sep 15, 2009 at 05:29:17PM +0200, Thomas Gleixner wrote:
> On Tue, 15 Sep 2009, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > I'm able to reproduce this now.  The problem is really that
> > hrtimer_interrupt() tries to program the next timer event which fai=
ls 4
> > times in a row, because the expiry time is already in the past when
> > tick_dev_program_event is called.  This happens because there are s=
o
> > much timers with small expiry times. (cyclictest -t40 on an UP mach=
ine)
>=20
> Pretty much the case which triggers the hang mechanism.
OK.

> > Addionally the fourth interation was short (probably because then t=
here
> > were no expired timers to check for) and so the try_time argument t=
o
> > hrtimer_interrupt_hanging was small and so min_delta_ns was decreas=
ed
> > instead of increased.
>=20
> He, what is decreasing min_delta_ns ? There is no such code.
hrtimer_interrupt_hanging() can decrease min_delta_ns.

Look at Bo's reports: min_delta_ns is initially 61036 and he gets

	hrtimer: interrupt too slow, forcing clock min delta to 52482 ns

If you want I can add a

	WARN_ON_ONCE((unsigned long)try_time.tv64 * 3 < dev->min_delta_ns)

and send you the output of dmesg.

> > I wonder why increasing min_delta_ns is supposed to fix something h=
ere.
> > Actually some pressure that results in hrtimer_interrupt_hanging be=
ing
> > called can always happen independently of min_delta_ns' value.
>=20
> It ensures that the timer interrupts are delayed sufficiently that
> something else than the timer interrupt has a chance to get on the
> CPU.
Hhhhm, doesn't destroy that any upper bound for latency.  If a process
succeeds to install many timers that expire one after another with a
short delta in between min_delta_ns goes up.  This in turn mean that
even high priority processes loose the ability to sleep a short period.
=20
> > And moreover, is it sensible to change the value of
> > force_clock_reprogram?  This makes the system harder to benchmark,
> > because to guarantee a certain latency now you have to check both
> > situations force_clock_reprogram=3D=3D1 and force_clock_reprogram=3D=
=3D0.
> >=20
> > My suggestion is to do the following:
> >   - fix hrtimer_interrupt_hanging not to decrease min_delta_ns
>=20
> It does not decrease anything, so what's to fix there ?
http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dcommitdiff;h=3Da1b=
46573904d822ac5c7495ea1dbc8ef38200bf7

> >   - in clockevents_program_event instead of
> > 	if (delta <=3D 0)
> > 		return -ETIME;
> >     do
> > 	if (delta <=3D -dev->min_delta_ns)
> > 		return -ETIME;
> >=20
> >     I'm not sure though if -dev->min_delta_ns is the right value or=
 if
> >     that is a good idea at all.
>=20
> You might expire timers early, which is wrong.
The critic be right, I haven't thought much about that, didn't even try
it.  My thought was only that in the original case (delta <=3D 0) the
event to program is in the past, so programming min_delta_ns for it
isn't too early at all.

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
