From: Clark Williams <williams@redhat.com>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org
Date: Thu, 22 Oct 2009 13:29:48 -0500
Message-ID: <20091022132948.480d3d03@torg>
References: <20091022120832.4bfd29e2@torg>
	<4AE0A17B.9020201@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/EMcGMytPDSPxct6J.v3hn10"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756102AbZJVSaN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 14:30:13 -0400
In-Reply-To: <4AE0A17B.9020201@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/EMcGMytPDSPxct6J.v3hn10
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2009 11:16:27 -0700
Darren Hart <dvhltc@us.ibm.com> wrote:

> Clark Williams wrote:
> > Today, for the Nth time, I was asked by a potential customer "How does
> > the RT patch improve latency?". I looked at rt.wiki.kernel.org,
> > hoping (vainly) that someone had written up an elevator-pitch for the
> > RT patch, but it was not to be. So I wrote up something that I hope
> > made sense and sent it off.=20
>=20
> I have "elevator pitch" on my todo list as well.  Good timing.
>=20
> >=20
> > Since then I did a little bit of tweaking and expansion and thought I'd
> > send it to the RT users list to see if we can agree on an answer, then
> > put that in the RT FAQ.=20
> >=20
> > So, please read and critique the following:
> >=20
> > Q. How does the Linux RT kernel improve "latency"?
>=20
> "Linux RT" ... pretty close to RTLinux, which of course we can't use, so=
=20
> maybe use "Real-Time Linux" or "The PREEMPT_RT patch".

How's this:

Q. How does Real-Time Linux (aka the PREEMPT_RT patch) improve
"latency"?
>=20
> >=20
> > A. The Linux RT patch modifies the behavior of spinlocks and
> > interrupt handling, to increase the number of points where a
> > preemption or reschedule may occur. This reduces the amount of time a
> > high priority task must wait to be scheduled when it becomes ready to
> > run, reducing event service time (or "latency").=20
> >=20
> > Most spinlocks in the kernel are converted to a construct called an
> > rtmutex, which has the property of *not* disabling interrupts while
> > the lock is held and will sleep rather than spin. This means that
> > interrupts will occur while rtmutexes are held and interrupt handling
> > is a potential preemption point; on return from handling an interrupt,
> > a scheduler check is made as to whether a higher priority thread needs
> > to run.
> >=20
> > The rtmutex locking construct also has a property known as "priority
> > inheritance", which is a mechanism for avoiding a deadlock situation
> > known as "priority inversion".=20
>=20
> A reference might be a good idea. The medium priority tasks not=20
> interested in the contended resource is a key aspect of priority inversio=
n.
>=20
> http://en.wikipedia.org/wiki/Priority_inversion

Yeah, I didn't want to get into a full-on discussion of priority
inversion, so a reference is a good idea.

>=20
> > In order to prevent a low priority
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
> I think I'd focus a bit more on interrupt threads having configurable=20
> priorities.
>=20
> I'm not sure the bit about "spinlocks have a context to return to" makes=
=20
> sense in an elevator-type pitch, might be too low level, and detract=20
> from the high-level message?
>=20

Well, some of the people that have asked were actually looking for a
more technical description than was available in, ahem, Marketing
Literature. So I guess I was attempting to straddle that fence. I will
re-arrange that last sentence to put prioritization first or may be
split it into two sections. How about this:

This means that interrupt service order may be prioritized by
assigning appropriate realtime priorities to the interrupt threads.=20

Yeah, I see what you mean about "context to return to". A bit too deep
for the 30-second description.=20

Clark

--Sig_/EMcGMytPDSPxct6J.v3hn10
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrgpKAACgkQHyuj/+TTEp1eAACeM9Y6IDBNE12S3wzQ7VHatoMH
fvEAn0Bv8buJC10LzCwn9au/oNBvCPn4
=p4Ds
-----END PGP SIGNATURE-----

--Sig_/EMcGMytPDSPxct6J.v3hn10--
