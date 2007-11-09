From: =?iso-8859-1?q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>
Subject: Re: Priority Ceiling for SMP?
Date: Fri, 9 Nov 2007 14:32:21 +0000
Message-ID: <200711091432.21649.lhenriques@netvisao.pt>
References: <473346DF.3080108@l1nuxh4ck3r.de> <200711082329.17959.lhenriques@netvisao.pt> <47345F0F.3000709@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from front2.netvisao.pt ([213.228.128.57]:54520 "HELO
	front2.netvisao.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759912AbXKIOce convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Nov 2007 09:32:34 -0500
In-Reply-To: <47345F0F.3000709@l1nuxh4ck3r.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday 09 November 2007, Bernhard Kuhn wrote:
[...]
> Can you please give me hint where to find papers on that topic?
> A Google research didn't helped very much - i guess i didn't used
> the right keywords ...

Actually, I do not have any links on my bookmarks on this topic, but, a=
fter a=20
very quick search, I guess I found something that you might take a look=
 at:

http://www-md.e-technik.uni-rostock.de/ma/gol/rtsys/articulos/YCS159.pd=
f

And talking about articles, there is one on this topic that you probabl=
y=20
already know: "Against priority inheritance".  It is a very light artic=
le...=20
well... against priority inheritance :)

> > the main goal of PI and PC protocols is not dead-locks
> > avoidance but to prevent priority inversion.
>
> In respect to prevent priority inversion, i think PI is
> superior to PC, but i have recently learned that a dead-lock
> avoidance mechanism can be very helpful if it comes to SIL
> certification: stating "we follow good programming practices"
> is certainly a weaker justification for a high safety integrity
> level rather then telling "our OS avoids dead-locks by design".

Yes, fully agree with you this.

I would like, however, to add that telling "our OS avoids dead-locks by=
=20
design" is also not enough for SIL certification -- you need to prove t=
his,=20
which might be as difficult as implementing your system without these=20
mechanisms (they tend to add high complexity to the kernel).

BTW and just for curiosity: anyone's aware of any application running o=
n top=20
of a Linux kernel that has been SIL (or similar) certified?  I guess th=
at you=20
need a fully qualified kernel for SIL, right?

> > When you have a some kind of locking mechanism (a mutex, for exampl=
e)
> > that implements the PC protocol, you need to define a ceiling value=
 for
> > it.  This ceiling value is defined according to an analysis of your
> > system and correspond to the highest priority task that can access =
this
> > locking mechanism.  My question was: sometimes it may not be easy t=
o
> > define this value and, in runtime, the ceiling may be violated by a=
 task
> > that accesses this mutex.
>
> Now i see the problem: i.e.. if the *topmost* priority task *rarely*
> accesses a *highly* contended lock, you may decide to lower the
> ceiling because otherwise the lock pretty much acts like a giant lock=
=2E
> (causing in-determinism). However, when lowering the ceiling, then
> dead-locks may happen, again, and the only potential advantage of PC
> over PI is gone ...
>
> > Well, but if you dynamically change the ceiling value, then we are
> > talking about PI, right? :)
>
> Not necessarily: lets assume that we stick to the rule that the ceili=
ng
> value for a lock should always be equal to the highest priority among=
st
> all tasks using the lock. Now the situation is that the ceiling value
> may change when new high priority tasks are created or old high prior=
ity
> tasks get killed. If each task provides a list of locks it uses to th=
e
> OS, then the OS could easily decide the new ceiling value for each lo=
ck
> when a tasks is created or killed (from what i understand, this might
> be tricky to implement for -rt). Change the ceiling value during runt=
ime
> is IMHO no problem: either no task is currently accessing a lock, so =
the
> new task can simple run at it's priority, or the the lock is in use b=
y
> another task so it's priority will be temporarily raised to the new
> ceiling value. Did i missed anything?

You're right, I heard about this variation on the PC protocol.  If I re=
member=20
correctly, it is called "dynamic priority ceiling protocol".

To sum up: most of the priority-inversion/dead-lock avoidance mechanism=
s=20
(we've been discussing PI and PC but probably there are much more...) h=
ave=20
advantages and disadventages which are widely known and documented.  Th=
e=20
conclusion, I guess, is that no "magic" solution exists and the applica=
tions=20
system architects will need to choose one or more (or none!) of the ava=
ilable=20
mechanisms.

My personal opinion is that, no matter what mechanism you select, if yo=
ur=20
developing critical software you will _always_ need to perform static=20
schedulability analysis of your system and never rely on PI or PC.  Bee=
n=20
there... ;)

--=20
Lu=EDs Henriques
