From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Re: Priority Ceiling for SMP?
Date: Thu, 08 Nov 2007 20:02:29 +0100
Message-ID: <47335D45.7040507@l1nuxh4ck3r.de>
References: <473346DF.3080108@l1nuxh4ck3r.de> <200711081800.35937.lhenriques@netvisao.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:20880 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762432AbXKHTBg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2007 14:01:36 -0500
In-Reply-To: <200711081800.35937.lhenriques@netvisao.pt>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Lu=EDs Henriques wrote:

> Maybe I didn't completely understood your question, but... if there i=
s a=20
> problem with SMP efficiency (I do not really know, but believe you :)=
 ) with=20
> priority ceiling (PC) implementation, this problem should have been a=
lready=20
> identified (and possibly solved) in the current PI implementation, ri=
ght?

To make it clear: I'm not aware of any efficiency issues with
the current PI implementation :-)


The (potential) efficiency issue with PC on SMP derives from the
dead-lock avoidance mechanism that you mentioned: If a task
locks a resource, then it's priority is raised to the ceiling
(which is typically the highest priority of all task sharing
that resource). Once that happens, no other task (sharing the
same resource) could then lock another resource that potentially
leads to a dead-lock situation.

Example:

* A low priority Task A shall share resources X and Y
   with a high priority Task B.

* Task A shall execute the following fraction of code:

     1. lock(X)
     2. lock(Y)

* Task B shall execute the following fraction of code:

     1. lock(Y)
     2. lock(X)

With PI, this could easily lead to a race condition resulting
in a dead-lock. But with PC, no dead-lock is possible: the very
moment Task A locks X, Task B won't be scheduled any more
(assuming a FIFO scheduling policy), because A would now run
at the same priority as B. If B takes Y, then lower priority A
wouldn't be scheduled anyway, because in a single CPU system,
only the highest priority task will actually run!

On SMP systems, the situation is completely different, because
you can have two CPUs to run the tasks on: even if Task A running
on CPU 1 is boosted to the ceiling when it takes X, then Task B
on CPU 2 is not affected and could easily lock Y -> deadlock!

The only solution (i'm aware of) would be that when Task A locks
Y, then CPU 1 needs to inform CPU 2 to un-schedule Task B (if it's
currently running) or to mark Task-B as un-schedulable (if it's
not currently running), respectively. This way, Task B can't take
any shared resources (X or Y) while Task A holds X or Y. When
Task A frees the lock, CPU 1 has to tell CPU 2 to kick Task B again
(if it was put asleep) or to mark it as schedulable, respectivly.

Effectivly, all Tasks using PC and sharing the same resources do
not perform any better than on a single CPU system because they
can't run in parallel on different CPUs. Even worse the notable=20
notification overhead could reduce performance dramatically for
heavyly contended locks!

Now my actual question was if there is any other resource
locking mechanism that inherently (by design) avoids dead-locks
and is proven to work on SMP?


> (BTW, what do you think that should be the kernel behaviour when the =
ceiling=20
> value is violated?  Typical solution in RTOS is to have a fatal error=
)

Here's where i'm not exactly sure what you mean:

You mean, if in the example above, a new yet higher priority Task C
would come in (sharing X or Y) and thus the ceiling value would
need to be (dynamically) changed? I don't think that would have
any implications for the case, above.


regards

Bernhard
