From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Re: Priority Ceiling for SMP?
Date: Fri, 09 Nov 2007 14:22:23 +0100
Message-ID: <47345F0F.3000709@l1nuxh4ck3r.de>
References: <473346DF.3080108@l1nuxh4ck3r.de> <200711081800.35937.lhenriques@netvisao.pt> <47335D45.7040507@l1nuxh4ck3r.de> <200711082329.17959.lhenriques@netvisao.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:14047 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbXKINV2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Nov 2007 08:21:28 -0500
In-Reply-To: <200711082329.17959.lhenriques@netvisao.pt>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Lu=EDs Henriques wrote:

>> [...] because in a single CPU system,
>> only the highest priority task will actually run!
>=20
> Fully agree!  Single CPU systems are great :)

Basically agreed, but the situation is that the industry is going
multi-core because you get more bang for the buck - so it is
necessary to somehow scope with it ...


>> The only solution (i'm aware of) would be [...]
>=20
> I believe this could actually be implemented _but_ it might not be de=
sirable=20
> to do it.  An in-deep analysis would be required to check this, but I=
 believe=20
> the determinism of the system would suffer with this.

I came to the same conclusion - hence the question if there is a
better way to do it :-)


> I know there are several academic research (probably some implementat=
ions
 > too, of course) on distributed systems locking mechanisms that deal =
with
 > this issues

Can you please give me hint where to find papers on that topic?
A Google research didn't helped very much - i guess i didn't used
the right keywords ...


> the main goal of PI and PC protocols is not dead-locks=20
> avoidance but to prevent priority inversion.

In respect to prevent priority inversion, i think PI is
superior to PC, but i have recently learned that a dead-lock
avoidance mechanism can be very helpful if it comes to SIL
certification: stating "we follow good programming practices"
is certainly a weaker justification for a high safety integrity
level rather then telling "our OS avoids dead-locks by design".


> When you have a some kind of locking mechanism (a mutex, for example)=
 that=20
> implements the PC protocol, you need to define a ceiling value for it=
=2E  This=20
> ceiling value is defined according to an analysis of your system and=20
> correspond to the highest priority task that can access this locking=20
> mechanism.  My question was: sometimes it may not be easy to define t=
his=20
> value and, in runtime, the ceiling may be violated by a task that acc=
esses=20
> this mutex.

Now i see the problem: i.e.. if the *topmost* priority task *rarely*
accesses a *highly* contended lock, you may decide to lower the
ceiling because otherwise the lock pretty much acts like a giant lock.
(causing in-determinism). However, when lowering the ceiling, then
dead-locks may happen, again, and the only potential advantage of PC
over PI is gone ...


> Well, but if you dynamically change the ceiling value, then we are ta=
lking=20
> about PI, right? :)

Not necessarily: lets assume that we stick to the rule that the ceiling
value for a lock should always be equal to the highest priority amongst
all tasks using the lock. Now the situation is that the ceiling value
may change when new high priority tasks are created or old high priorit=
y
tasks get killed. If each task provides a list of locks it uses to the
OS, then the OS could easily decide the new ceiling value for each lock
when a tasks is created or killed (from what i understand, this might
be tricky to implement for -rt). Change the ceiling value during runtim=
e
is IMHO no problem: either no task is currently accessing a lock, so th=
e
new task can simple run at it's priority, or the the lock is in use by
another task so it's priority will be temporarily raised to the new
ceiling value. Did i missed anything?

regards

Bernhard
