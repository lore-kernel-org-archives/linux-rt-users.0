From: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [Patch RT] Fix CFS load balancing for RT tasks
Date: Fri, 13 Jul 2007 09:01:51 +0200
Message-ID: <20070713090151.13554f72@frecb000686.frec.bull.fr>
References: <20070711164708.48907792@frecb000686.frec.bull.fr>
	<1184258515.3000.11.camel@josh-work.beaverton.ibm.com>
	<1184260438.3000.16.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	john stultz <johnstul@us.ibm.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Josh Triplett <josht@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:37493 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbXGMHEC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 03:04:02 -0400
In-Reply-To: <1184260438.3000.16.camel@josh-work.beaverton.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


 Hi Josh,

On Thu, 12 Jul 2007 10:13:57 -0700 Josh Triplett <josht@linux.vnet.ibm.=
com> wrote:

> On Thu, 2007-07-12 at 09:41 -0700, Josh Triplett wrote:
> > On Wed, 2007-07-11 at 16:47 +0200, S=C3=A9bastien Dugu=C3=A9 wrote:
> > >   there seems to be something wrong with the way the CFS balances=
 (or does not
> > > balance) RT tasks. This was evidenced using the sched_football te=
stcase
> > > available from the RT wiki (http://rt.wiki.kernel.org/index.php/I=
BM_Test_Cases)
> > > which I modified and attached to this mail.
> > >=20
> > >   The testcase starts a number of threads which fall into 3 categ=
ories:
> > >=20
> > > 	1 referee thread: SCHED_FIFO, RT prio 5
> > > 	ncpus defensive threads: SCHED_FIFO, RT prio 4
> > > 	ncpus offensive threads: SCHED_FIFO, RT prio 3
> > >=20
> > > 	(ncpus being the number of CPUs)
> > >=20
> > >   To make a long story short, the defensive threads should end up=
 distributed
> > > among all CPUs, but that's not the case. For example, on a dual H=
T Xeon box,
> > > after task migration stabilizes we have the following running on =
the different
> > > CPUs:
> > >=20
> > >   CPU 0: defense2
> > >   CPU 1: referee offense2 offense3 offense4 defense3
> > >   CPU 2: offense1
> > >   CPU 3: defense1 defense4
> > >=20
> > > which clearly show the imbalance between CPU 2 and CPU 3 where of=
fense1
> > > should not be allowed to run while the higher prio defense1 and d=
efense4
> > > are sharing the same CPU.
> > >=20
> > >   The following patch fixes this by re-enabling the RT overload d=
etection
> > > for the CFS. It may not be the right solution, maybe it should be=
 incorporated
> > > into the other load balancing mechanisms. I did not digg deep eno=
ugh yet
> > > to make that call ;-)
> >=20
> > 2.6.21.5-rt20 plus this patch passed 1000 runs of the standard
> > sched_football on an 8 processor (quad dual-core) x86-64 box.  Nice
> > work.
>=20
> Hmmm, seems I spoke a bit too soon; due to a bug in the test log
> checker, the test failed but the log checker said PASS.  Actual resul=
ts:
> $ grep 'Final ball position' rt-tests.log | sort | uniq -c
>     960 Final ball position: 0
>      39 Final ball position: 1
>       1 Final ball position: 2
>=20
> So it failed 4% of the runs.  However, it failed much less
> spectacularly; rather than overrunning the integer maximum, it only
> reached 1-2.  Still a huge improvement despite not solving the proble=
m
> completely.


  Yeah, I had a 5000 iterations test run last night which failed with
one of the runs having a final ball position of 1. So it's not yet
perfect. I think we're hitting the same bug as with the O(1) scheduler
in 2.6.21-rt8.

  It seems that the more CPUs there are, the easier it is to reproduce.
Hopefully I should have access to a quad dual core box soon now to
verify this.

  One more thing, the bug seems even harder to reproduce if I have
a logdev LD_MARK (direct marker, no kprobe) in context_switch().

  Ingo, Thomas, any ideas, opinions? It looks like there might be a rac=
e in
the RT balancing code that prevents pulling the highest prio task and
instead selects a lower one to run.

  In the mean time I'll continue poring over the 2.6.21-rt8 scheduler
to try to find something.


  S=C3=A9bastien.
