From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 15:12:18 +0200
Message-ID: <1366895538.6139.19.camel@marge.simpson.net>
References: <1366760662.9609.176.camel@gandalf.local.home>
	 <2156546.QlsX0XyPQz@dabox> <51792277.8000205@linutronix.de>
	 <1366893374.6139.5.camel@marge.simpson.net> <517927C2.40402@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Sander <tim.sander@hbm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <517927C2.40402@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2013-04-25 at 14:55 +0200, Sebastian Andrzej Siewior wrote:=20
> On 04/25/2013 02:36 PM, Mike Galbraith wrote:
> > hrtimer: fix hrtimer free zone build bug
> >=20
> > Signed-off-by: Mike Galbraith <bitbucket@online.de>
> >=20
> > diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
> > index 2328c04..31d57a2 100644
> > --- a/kernel/hrtimer.c
> > +++ b/kernel/hrtimer.c
> > @@ -1036,7 +1036,7 @@ int __hrtimer_start_range_ns(struct hrtimer *=
timer, ktime_t tim,
> >  		&& hrtimer_enqueue_reprogram(timer, new_base)) {
> > =20
> >  		if (wakeup
> > -#ifdef CONFIG_PREEMPT_RT_BASE
> > +#if defined(CONFIG_PREEMPT_RT_BASE) && defined(CONFIG_HIGH_RES_TIM=
ERS)
> >  		    /*
> >  		     * Move softirq based timers away from the rbtree in
> >  		     * case it expired already. Otherwise we would have a
> >=20
> >=20
>=20
> hrtimer_enqueue_reprogram() returns 0 in non-high res case so
> everything down there is never reached. The compiler should see this =
:)

-Werror=3D

  CC      kernel/hrtimer.o
kernel/hrtimer.c: In function =E2=80=98__hrtimer_start_range_ns=E2=80=99=
:
kernel/hrtimer.c:1045:7: error: implicit declaration of function =E2=80=
=98hrtimer_rt_defer=E2=80=99 [-Werror=3Dimplicit-function-declaration]
kernel/hrtimer.c: At top level:
kernel/hrtimer.c:1416:12: error: static declaration of =E2=80=98hrtimer=
_rt_defer=E2=80=99 follows non-static declaration
kernel/hrtimer.c:1045:10: note: previous implicit declaration of =E2=80=
=98hrtimer_rt_defer=E2=80=99 was here
cc1: some warnings being treated as errors

make[1]: *** [kernel/hrtimer.o] Error 1
make: *** [kernel/hrtimer.o] Error 2
git@marge:~/linux-2.6>
