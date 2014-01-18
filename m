From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.12.6-rt9
Date: Sat, 18 Jan 2014 04:15:29 +0100
Message-ID: <1390014929.5444.38.camel@marge.simpson.net>
References: <20131223225017.GA8623@linutronix.de>
	 <1387900067.5490.33.camel@marge.simpson.net>
	 <20140117170052.GF5785@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140117170052.GF5785@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2014-01-17 at 18:00 +0100, Sebastian Andrzej Siewior wrote:=20
> * Mike Galbraith | 2013-12-24 16:47:47 [+0100]:
>=20
> >I built this kernel with Paul's patch and NO_HZ_FULL enabled again o=
n 64
> >core box.  I haven't seen RCU grip yet, but I just checked on it aft=
er
> >3.5 hours into this boot/beat (after fixing crash+kdump setup), and
> >found it in the process of dumping.=20
>=20
> So you also have the timers-do-not-raise-softirq-unconditionally.patc=
h?

Oh dear, there's holidays, vacation, and massive turkey overdose betwee=
n
then and now, but I'm almost positive that the tree was virgin $subject=
,
with only Paul's patch enabled, that being what I wanted to beat on.

> I have a small problem with understanding this=E2=80=A6
>=20
> |#24 [ffff880273a03cd0] run_timer_softirq at ffffffff81069002
>=20
> Here we obtain wait_lock from tvec_base of _this_ CPU. And we get to
> init_lists() before the apic timer kicks in. So we have the wait_lock=
=2E

gdb fibs a little, we're acquiring.

>--- <IRQ stack> ---
> >#21 [ffff880273a03b28] apic_timer_interrupt at ffffffff815cbf9d
> >    [exception RIP: _raw_spin_lock+50]

> In the hard interrupt triggered by the apic timer we get to
> get_next_timer_interrupt() and go again for same the wait_lock. Here =
we
> have the try_lock so we avoid this deadlock.
> The odd part: we get the lock. It should be the same lock because bot=
h use
> | struct tvec_base *base =3D __this_cpu_read(tvec_bases);
> to ge it. And we shouldn't get it because the lock is already hold.
> We get into trouble in the unlock path where we spin forever:
>=20
> |#14 [ffff880276803e50] rt_spin_unlock_after_trylock_in_irq at ffffff=
ff815c3425
> |#12 [ffff880276803e28] _raw_spin_trylock at ffffffff815c3790
>=20
> which releases the lock with a trylock in order to keep lockdep happy=
=2E
> My understanding was that we should be able to obtain the wait_lock h=
ere
> since we were able to obtain it in the lock path and in irq off conte=
xt
> there is nothing that could take the lock in the meantime.

IIRC, we were endlessly trying, but with an un-punched ticket under us,
and no Xen like evilness to save the day.

I've since cleaned out my crashdump directory and moved on to frolickin=
g
with hotplug gremlins, so don't have that one to revisit, but the don't
unconditionally raise timer softirq patch is the bad guy.

-Mike
