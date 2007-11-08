From: =?iso-8859-1?q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>
Subject: Re: Priority Ceiling for SMP?
Date: Thu, 8 Nov 2007 23:29:17 +0000
Message-ID: <200711082329.17959.lhenriques@netvisao.pt>
References: <473346DF.3080108@l1nuxh4ck3r.de> <200711081800.35937.lhenriques@netvisao.pt> <47335D45.7040507@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from front1.netvisao.pt ([213.228.128.56]:36686 "HELO
	front1.netvisao.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761400AbXKHXpz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2007 18:45:55 -0500
In-Reply-To: <47335D45.7040507@l1nuxh4ck3r.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 08 November 2007, you wrote:
> Lu=EDs Henriques wrote:
> > Maybe I didn't completely understood your question, but... if there=
 is a
> > problem with SMP efficiency (I do not really know, but believe you =
:) )
> > with priority ceiling (PC) implementation, this problem should have=
 been
> > already identified (and possibly solved) in the current PI
> > implementation, right?
>
> To make it clear: I'm not aware of any efficiency issues with
> the current PI implementation :-)
>
>
> The (potential) efficiency issue with PC on SMP derives from the
> dead-lock avoidance mechanism that you mentioned: If a task
> locks a resource, then it's priority is raised to the ceiling
> (which is typically the highest priority of all task sharing
> that resource). Once that happens, no other task (sharing the
> same resource) could then lock another resource that potentially
> leads to a dead-lock situation.
>
> Example:
>
> * A low priority Task A shall share resources X and Y
>    with a high priority Task B.
>
> * Task A shall execute the following fraction of code:
>
>      1. lock(X)
>      2. lock(Y)
>
> * Task B shall execute the following fraction of code:
>
>      1. lock(Y)
>      2. lock(X)
>
> With PI, this could easily lead to a race condition resulting
> in a dead-lock. But with PC, no dead-lock is possible: the very
> moment Task A locks X, Task B won't be scheduled any more
> (assuming a FIFO scheduling policy), because A would now run
> at the same priority as B. If B takes Y, then lower priority A
> wouldn't be scheduled anyway, because in a single CPU system,
> only the highest priority task will actually run!

=46ully agree!  Single CPU systems are great :)

> On SMP systems, the situation is completely different, because
> you can have two CPUs to run the tasks on: even if Task A running
> on CPU 1 is boosted to the ceiling when it takes X, then Task B
> on CPU 2 is not affected and could easily lock Y -> deadlock!

Now I see what you mean.  However, I guess the problem here is that, in=
 the=20
example you provide you are using nested locks and this is _always_ an =
issue. =20
It is a known problem with the PI protocol.  Good practices in RT=20
applications development say you should never do this.  Anyway, the mai=
n goal=20
of PI and PC protocols is to avoid priority inversion, not dead-locks.

> The only solution (i'm aware of) would be that when Task A locks
> Y, then CPU 1 needs to inform CPU 2 to un-schedule Task B (if it's
> currently running) or to mark Task-B as un-schedulable (if it's
> not currently running), respectively. This way, Task B can't take
> any shared resources (X or Y) while Task A holds X or Y. When
> Task A frees the lock, CPU 1 has to tell CPU 2 to kick Task B again
> (if it was put asleep) or to mark it as schedulable, respectivly.

I believe this could actually be implemented _but_ it might not be desi=
rable=20
to do it.  An in-deep analysis would be required to check this, but I b=
elieve=20
the determinism of the system would suffer with this.

> Effectivly, all Tasks using PC and sharing the same resources do
> not perform any better than on a single CPU system because they
> can't run in parallel on different CPUs. Even worse the notable
> notification overhead could reduce performance dramatically for
> heavyly contended locks!
>
> Now my actual question was if there is any other resource
> locking mechanism that inherently (by design) avoids dead-locks
> and is proven to work on SMP?

Well... apart for good RT applications design and some schedulabity ana=
lysis,=20
no, I don't know anything else.  I know there are several academic rese=
arch=20
(probably some implementations too, of course) on distributed systems l=
ocking=20
mechanisms that deal with this issues but I am not familiar with those.

Note once again that the main goal of PI and PC protocols is not dead-l=
ocks=20
avoidance but to prevent priority inversion.

> > (BTW, what do you think that should be the kernel behaviour when th=
e
> > ceiling value is violated?  Typical solution in RTOS is to have a f=
atal
> > error)
>
> Here's where i'm not exactly sure what you mean:

When you have a some kind of locking mechanism (a mutex, for example) t=
hat=20
implements the PC protocol, you need to define a ceiling value for it. =
 This=20
ceiling value is defined according to an analysis of your system and=20
correspond to the highest priority task that can access this locking=20
mechanism.  My question was: sometimes it may not be easy to define thi=
s=20
value and, in runtime, the ceiling may be violated by a task that acces=
ses=20
this mutex.

> You mean, if in the example above, a new yet higher priority Task C
> would come in (sharing X or Y) and thus the ceiling value would
> need to be (dynamically) changed? I don't think that would have
> any implications for the case, above.

Well, but if you dynamically change the ceiling value, then we are talk=
ing=20
about PI, right? :)

Best regards
--=20
Lu=EDs Henriques
