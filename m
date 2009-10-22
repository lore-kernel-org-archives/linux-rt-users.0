From: Clark Williams <williams@redhat.com>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org
Date: Thu, 22 Oct 2009 13:41:39 -0500
Message-ID: <20091022134139.0c8a4cc2@torg>
References: <20091022120832.4bfd29e2@torg>
	<1256235503.10735.32.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/8Do+txM0BVPPeR9Jecuzb5f"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33088 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756208AbZJVSlx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 14:41:53 -0400
In-Reply-To: <1256235503.10735.32.camel@quadrophenia.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/8Do+txM0BVPPeR9Jecuzb5f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2009 11:18:23 -0700
Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:

> On Thu, 2009-10-22 at 12:08 -0500, Clark Williams wrote:
> > So, please read and critique the following:
> >=20
> > Q. How does the Linux RT kernel improve "latency"?
> >=20
> > A. The Linux RT patch modifies the behavior of=20
>=20
> > spinlocks and
>=20
> simpler: "Kernel-level locking". Avoids "whats a spinlock?"

Yeah, I can go with that. Although, we might do it this way:

The Linux RT patch modifies the behavior of the most common
kernel-level locking primitive (the spinlock) and interrupt handling,
to increase the number of points where a preemption or reschedule may
occur.

>=20
> > interrupt handling, to increase the number of points where a
> > preemption or reschedule may occur. This reduces the amount of time a
> > high priority task must wait to be scheduled when it becomes ready to
> > run, reducing event service time (or "latency").=20
> >=20
> > Most spinlocks in the kernel are converted to a construct called an
> > rtmutex, which has the property of *not* disabling interrupts while
> > the lock is held and will sleep rather than spin.
>=20
> Technically, not all spinlocks disable irqs.
>=20
> maybe "property of *not* preventing task switching or suppressing
> interrupt services on a particular CPU while..."
>=20

Agreed, but the rtmutex *does* have the property of not disabling
interrupts, so it's a nop when replacing spinlocks that don't as well.
I do like calling out that the conversion explicitly enable task
switching though. How about this:

Most spinlocks in the kernel are converted to a construct called an
rtmutex, which has the property of *not* disabling interrupts or
preventing task switching while the lock is held. It also has the
property of sleeping on contention rather than spinning (hence the
sometimes heard term "sleeping spinlocks").=20


> >  This means that
> > interrupts will occur while rtmutexes are held and interrupt handling
> > is a potential preemption point; on return from handling an interrupt,
> > a scheduler check is made as to whether a higher priority thread needs
> > to run.
> >=20
> > The rtmutex locking construct also has a property known as "priority
> > inheritance", which is a mechanism for avoiding a deadlock situation
> > known as "priority inversion". In order to prevent a low priority
> > thread that is holding a lock from preventing a higher priority thread
> > from running, the low priority thread temporarily inherits the
> > priority of the highest priority thread that is requesting the lock,
> > which allows the low-priority thread to run until it completes its
> > critical section and releases the lock.=20
> >=20
> > In addition to changing spinlocks, interrupts have been threaded,
> > meaning that instead of handling interrupts in a special "interrupt
> > context", each IRQ has a dedicated thread for running its
> > ISRs. Interrupts go to a common handler and the handler schedules the
> > appropriate thread to handle the interrupt. This means that sleeping
> > spinlocks (rtmutexes) have a context to return to and that interrupt
> > handling can be prioritized by assigning appropriate realtime
> > priorities to the interrupt threads.=20
>=20
> Further, user-level processes may be prioritized above device-level
> services, allowing computational load and I/O load to be dynamically
> expedited, partitioned, or decoupled.

You used to work in marketing, didn't you :)

How about:

Further, using realtime priorities, user-level threads may be
prioritized *above* certain device level activity, allowing critical
application tasks to take precedence over device activity deemed less
important.

Clark
=20

--Sig_/8Do+txM0BVPPeR9Jecuzb5f
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrgp2YACgkQHyuj/+TTEp3QQgCg57wetshvb+crqgkeCJwOVBaT
yfgAn2GS7aspFWVLCFdwbuK649P2nDMe
=8wEU
-----END PGP SIGNATURE-----

--Sig_/8Do+txM0BVPPeR9Jecuzb5f--
