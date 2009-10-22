From: Clark Williams <williams@redhat.com>
Subject: proposed FAQ entry for rt.wiki.kernel.org (v3)
Date: Thu, 22 Oct 2009 16:39:59 -0500
Message-ID: <20091022163959.322ae5ad@torg>
References: <20091022120832.4bfd29e2@torg>
	<20091022152539.04e2787a@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Ldu8t3so4TyjFwPEaW9wGqm"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbZJVVk0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 17:40:26 -0400
In-Reply-To: <20091022152539.04e2787a@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/Ldu8t3so4TyjFwPEaW9wGqm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Due to the hue and cry over my inexcusable abuse of OS terminology,
here is a rework with the priority inversion section.  :)

----------------------8< snip 8<------------------------------

Q. How does Real-Time Linux (aka the PREEMPT_RT patch) improve
"latency"?

A. The Linux RT patch modifies the behavior of the most common
kernel-level locking primitive (the spinlock) and kernel interrupt
handling logic, to increase the number of points where a preemption or
reschedule may occur. This reduces the amount of time a high priority
task must wait to be scheduled when it becomes ready to run, reducing
event service time (or "latency").=20

Most spinlocks in the kernel are converted to a construct called an
rtmutex, which has the property of *not* disabling interrupts or
preventing task switching while the lock is held. It also has the
property of sleeping on contention rather than spinning (hence the
sometimes heard term "sleeping spinlocks"). These two properties mean
that interrupts may occur while rtmutexes are held and interrupt
handling is a potential preemption point; on return from handling an
interrupt, a scheduler check is made as to whether a higher priority
thread needs to run.

The rtmutex locking construct also has a property known as "priority
inheritance", which is a mechanism for avoiding a condition known as
"priority inversion", where a high-priority thread is blocked from
executing by lower priority threads holding a shared lock.  In order
to prevent this condition, the low priority thread holding the lock
temporarily inherits the priority of the highest priority thread that
is requesting the lock, which allows the low-priority thread to run
until it completes its critical section and releases the lock. For
more information on priority inversion see: =20

     http://en.wikipedia.org/wiki/Priority_inversion

In addition to changing kernel locking, interrupts have been threaded,
meaning that instead of handling interrupts in a special "interrupt
context", each interrupt number has a dedicated thread for running its
service routines. Interrupts go to a common handler and that handler
schedules the appropriate thread to service the interrupt. This means
that interrupt service order may be prioritized by assigning appropriate
realtime priorities to the interrupt threads.  Further, using realtime
priorities, user-level threads may be prioritized *above* certain
device level activity, allowing critical application tasks to take
precedence over device activity deemed less important.

----------------------8< snip 8<------------------------------



--Sig_/Ldu8t3so4TyjFwPEaW9wGqm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrg0TMACgkQHyuj/+TTEp1VewCgkSdRB/+gJgD0JVioy54uTHtT
raMAn2RCNWWKPUN/YwHYTCrj6W8ggPnh
=ZnZl
-----END PGP SIGNATURE-----

--Sig_/Ldu8t3so4TyjFwPEaW9wGqm--
