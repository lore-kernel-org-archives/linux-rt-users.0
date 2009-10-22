From: Clark Williams <williams@redhat.com>
Subject: proposed FAQ entry for rt.wiki.kernel.org (v2)
Date: Thu, 22 Oct 2009 15:25:39 -0500
Message-ID: <20091022152539.04e2787a@torg>
References: <20091022120832.4bfd29e2@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/t3HcbmNjUEaXvsbOb2F.xyb"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	Sven-Thorsten Dietrich <sven@thebigcorporation.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37474 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586AbZJVU0G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 16:26:06 -0400
In-Reply-To: <20091022120832.4bfd29e2@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/t3HcbmNjUEaXvsbOb2F.xyb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Got some good feedback on the first round, but missed CC'ing rostedt,
since he isn't on linux-rt-users, so here's the revised text with
the edits from dvhart and sven applied:

---------------------8< snip 8<----------------------------------

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
inheritance", which is a mechanism for avoiding a deadlock situation
known as "priority inversion"
(http://en.wikipedia.org/wiki/Priority_inversion). In order to prevent
a low priority thread that is holding a lock from preventing a higher
priority thread from running, the low priority thread temporarily
inherits the priority of the highest priority thread that is requesting
the lock, which allows the low-priority thread to run until it
completes its critical section and releases the lock.=20

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

---------------------8< snip 8<----------------------------------

Kinda big for an elevator pitch, but hey, I'm sure the marketing and
sales guys will paraphrase it into "It makes things go Real Fast!" :)

Clark




=09

--Sig_/t3HcbmNjUEaXvsbOb2F.xyb
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrgv8cACgkQHyuj/+TTEp3L+wCg5V3iiXMK5F9QM1dnht8wO6YB
V7cAnjQn75BNB6WrkYeO45SkkYsHHoYs
=Vwlg
-----END PGP SIGNATURE-----

--Sig_/t3HcbmNjUEaXvsbOb2F.xyb--
