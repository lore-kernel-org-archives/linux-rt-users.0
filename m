From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: preempt_disable and sleep()
Date: Thu, 13 May 2010 20:37:32 -0700
Message-ID: <20100514033732.GA2418@linux.vnet.ibm.com>
References: <AANLkTinbwZK5Tp6aI4ja38XaiiB5aIyECzHPdMpvkaIy@mail.gmail.com>
 <1273776201.11899.23.camel@sven.thebigcorporation.com>
 <AANLkTilMrwdaLrTAUVETYZLYSpoqVFVXfKZ2lZit6uG3@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: ratheesh k <ratheesh.ksz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37909 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab0ENDhe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 23:37:34 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilMrwdaLrTAUVETYZLYSpoqVFVXfKZ2lZit6uG3@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 14, 2010 at 08:16:07AM +0530, ratheesh k wrote:
> On Fri, May 14, 2010 at 12:13 AM, Sven-Thorsten Dietrich
> <thebigcorporation@gmail.com> wrote:
>=20
> > Why would you do this?
> I was reading some linux kernel journel about preempt_disable() . Thi=
s
> a doubt came to me .
>=20
>=20
> > If you had tried this code, you would have seen the corresponding s=
tack
> > dump on the console.
>=20
>=20
> Why it so .? could you explain a little more ? .sleep() will schedule
> () , which inturn give back control to kernel .

Sleeping in the kernel with preemption disabled is considered to be a
bug.  So the scheduler will print an error and a stack dump when this
happens.

In contrast, it is OK to do the following:

	preempt_disable();
	do_something();
	preempt_enable();
	schedule();
	preempt_disable();
	do_something_else();
	preempt_enable();

							Thanx, Paul

> Thank,
> Ratheesh
>=20
> On Fri, May 14, 2010 at 12:13 AM, Sven-Thorsten Dietrich
> <thebigcorporation@gmail.com> wrote:
> > On Fri, 2010-05-14 at 00:02 +0530, ratheesh k wrote:
> >> I am running RT linux .
> >>
> >> /* code snippet */
> >>
> >> preempt_disable()
> >> ...........
> >> sleep(10);
> >> '............
> >> preempt_enable()
> >>
> >>
> >> will this sleep() will cause reschedule ?.
> >>
> >
> > Why would you do this?
> >
> > If you had tried this code, you would have seen the corresponding s=
tack
> > dump on the console.
> >
> >> if an interrupt comes =A0while premption is disabled , how it is h=
andled ?.
> >>
> >
> > Depends on the number of (idle) cores, the setting of CONFIG_PREEMP=
T_[]
> > and the type of interrupt.
> >
> > RT threaded IRQs would not run until preemption is enabled on a sin=
gle
> > core system.
> >
> >
> >
> >> Thanks,
> >> Ratheesh
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-rt=
-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
