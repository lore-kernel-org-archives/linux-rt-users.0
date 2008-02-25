From: Gregory Haskins <ghaskins@novell.com>
Subject: [(RT RFC) PATCH v2 0/9] adaptive real-time locks
Date: Mon, 25 Feb 2008 11:00:38 -0500
Message-ID: <20080225155959.11268.35541.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, pavel@ucw.cz, acme@redhat.com, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com,
	ghaskins@novell.com
To: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53862
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753365AbYBYQ3J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2008 11:29:09 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

You can download this series here:

ftp://ftp.novell.com/dev/ghaskins/adaptive-locks-v2.tar.bz2

Changes since v1:

*) Rebased from 24-rt1 to 24.2-rt2
*) Dropped controversial (and likely unecessary) printk patch
*) Dropped (internally) controversial PREEMPT_SPINLOCK_WAITERS config o=
ptions
*) Incorporated review feedback for comment/config cleanup from Pavel/P=
eterZ
*) Moved lateral-steal to front of queue
*) Fixed compilation issue with !defined(LATERAL_STEAL)
*) Moved spinlock rework into a separate series:
           ftp://ftp.novell.com/dev/ghaskins/ticket-locks.tar.bz2

Todo:
*) Convert loop based timeouts to use nanoseconds
*) Tie into lockstat infrastructure.
*) Long-term: research adaptive-timeout algorithms so a fixed/one-size-
   -fits-all value is not necessary.

------------------------

Adaptive real-time locks
=EF=BB=BF
The Real Time patches to the Linux kernel converts the architecture
specific SMP-synchronization primitives commonly referred to as
"spinlocks" to an "RT mutex" implementation that support a priority
inheritance protocol, and priority-ordered wait queues.  The RT mutex
implementation allows tasks that would otherwise busy-wait for a
contended lock to be preempted by higher priority tasks without
compromising the integrity of critical sections protected by the lock.
The unintended side-effect is that the -rt kernel suffers from
significant degradation of IO throughput (disk and net) due to the
extra overhead associated with managing pi-lists and context switching.
This has been generally accepted as a price to pay for low-latency
preemption.

Our research indicates that it doesn't necessarily have to be this
way.  This patch set introduces an adaptive technology that retains bot=
h
the priority inheritance protocol as well as the preemptive nature of
spinlocks and mutexes and adds a 300+% throughput increase to the Linux
Real time kernel.  It applies to 2.6.24-rt1. =20

These performance increases apply to disk IO as well as netperf UDP
benchmarks, without compromising RT preemption latency.  For more
complex applications, overall the I/O throughput seems to approach the
throughput on a PREEMPT_VOLUNTARY or PREEMPT_DESKTOP Kernel, as is
shipped by most distros.

Essentially, the RT Mutex has been modified to busy-wait under
contention for a limited (and configurable) time.  This works because
most locks are typically held for very short time spans.  Too often,
by the time a task goes to sleep on a mutex, the mutex is already being
released on another CPU.

The effect (on SMP) is that by polling a mutex for a limited time we
reduce context switch overhead by up to 90%, and therefore eliminate CP=
U
cycles as well as massive hot-spots in the scheduler / other bottleneck=
s
in the Kernel - even though we busy-wait (using CPU cycles) to poll the
lock.

We have put together some data from different types of benchmarks for
this patch series, which you can find here:

ftp://ftp.novell.com/dev/ghaskins/adaptive-locks.pdf

It compares a stock kernel.org 2.6.24 (PREEMPT_DESKTOP), a stock
2.6.24-rt1 (PREEMPT_RT), and a 2.6.24-rt1 + adaptive-lock
(2.6.24-rt1-al) (PREEMPT_RT) kernel.  The machine is a 4-way (dual-core=
,
dual-socket) 2Ghz 5130 Xeon (core2duo-woodcrest) Dell Precision 490.=20

Some tests show a marked improvement (for instance, ~450% more throughp=
ut
for dbench, and ~500% faster for hackbench), whereas some others
(make -j 128) the results were not as profound but they were still
net-positive. In all cases we have also verified that deterministic
latency is not impacted by using cyclic-test.=20

This patch series depends on some re-work on the raw_spinlock
infrastructure, including Nick Piggin's x86-ticket-locks.  We found tha=
t
the increased pressure on the lock->wait_locks could cause rare but
serious latency spikes that are fixed by a fifo raw_spinlock_t
implementation.  Nick was gracious enough to allow us to re-use his
work (which is already accepted in 2.6.25).  Note that we also have a
C version of his protocol available if other architectures need
fifo-lock support as well, which we will gladly post upon request.

You can find this re-work as a separate series here:

ftp://ftp.novell.com/dev/ghaskins/ticket-locks.tar.bz2

Special thanks go to many people who were instrumental to this project,
including:
  *) the -rt team here at Novell for research, development, and testing=
=2E
  *) Nick Piggin for his invaluable consultation/feedback and use of hi=
s
     x86-ticket-locks.
  *) The reviewers/testers at Suse, Montavista, and Bill Huey for their
     time and feedback on the early versions of these patches.

As always, comments/feedback/bug-fixes are welcome.

Regards,
-Greg
