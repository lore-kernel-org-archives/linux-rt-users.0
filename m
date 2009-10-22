From: Clark Williams <williams@redhat.com>
Subject: proposed FAQ entry for rt.wiki.kernel.org
Date: Thu, 22 Oct 2009 12:08:32 -0500
Message-ID: <20091022120832.4bfd29e2@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/43THr3nbJmHhp9VuU9.tPNJ"; protocol="application/pgp-signature"
To: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11190 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbZJVRIs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 13:08:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/43THr3nbJmHhp9VuU9.tPNJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Today, for the Nth time, I was asked by a potential customer "How does
the RT patch improve latency?". I looked at rt.wiki.kernel.org,
hoping (vainly) that someone had written up an elevator-pitch for the
RT patch, but it was not to be. So I wrote up something that I hope
made sense and sent it off.=20

Since then I did a little bit of tweaking and expansion and thought I'd
send it to the RT users list to see if we can agree on an answer, then
put that in the RT FAQ.=20

So, please read and critique the following:

Q. How does the Linux RT kernel improve "latency"?

A. The Linux RT patch modifies the behavior of spinlocks and
interrupt handling, to increase the number of points where a
preemption or reschedule may occur. This reduces the amount of time a
high priority task must wait to be scheduled when it becomes ready to
run, reducing event service time (or "latency").=20

Most spinlocks in the kernel are converted to a construct called an
rtmutex, which has the property of *not* disabling interrupts while
the lock is held and will sleep rather than spin. This means that
interrupts will occur while rtmutexes are held and interrupt handling
is a potential preemption point; on return from handling an interrupt,
a scheduler check is made as to whether a higher priority thread needs
to run.

The rtmutex locking construct also has a property known as "priority
inheritance", which is a mechanism for avoiding a deadlock situation
known as "priority inversion". In order to prevent a low priority
thread that is holding a lock from preventing a higher priority thread
from running, the low priority thread temporarily inherits the
priority of the highest priority thread that is requesting the lock,
which allows the low-priority thread to run until it completes its
critical section and releases the lock.=20

In addition to changing spinlocks, interrupts have been threaded,
meaning that instead of handling interrupts in a special "interrupt
context", each IRQ has a dedicated thread for running its
ISRs. Interrupts go to a common handler and the handler schedules the
appropriate thread to handle the interrupt. This means that sleeping
spinlocks (rtmutexes) have a context to return to and that interrupt
handling can be prioritized by assigning appropriate realtime
priorities to the interrupt threads.=20

--Sig_/43THr3nbJmHhp9VuU9.tPNJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkrgkZQACgkQHyuj/+TTEp0WDACfUFmroffmLeX7B1geW9twXwaw
m/UAoIEf9ZWMNHRWj8iZqd8dXr7qR9Fx
=iLzN
-----END PGP SIGNATURE-----

--Sig_/43THr3nbJmHhp9VuU9.tPNJ--
