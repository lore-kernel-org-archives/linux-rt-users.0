From: =?iso-8859-1?q?Lu=EDs_Henriques?= <lhenriques@netvisao.pt>
Subject: Re: rt mutex priority boost
Date: Wed, 28 Nov 2007 14:13:30 +0000
Message-ID: <200711281413.31140.lhenriques@netvisao.pt>
References: <1196257876.4078.195.camel@hermosa.morrealenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Peter W. Morreale" <pmorreale@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from front1.netvisao.pt ([213.228.128.56]:52907 "HELO
	front1.netvisao.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752930AbXK1ONg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 09:13:36 -0500
In-Reply-To: <1196257876.4078.195.camel@hermosa.morrealenet>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi!  Just my 5 cents (or even less!)...

On Wednesday 28 November 2007, Peter W. Morreale wrote:
> Steve,
>
> I'm directing this question to you, however it may be of interest to =
the
> community as well...
>
> I've been looking closely at the rtmutex code, spin locks in particul=
ar,
> and noticed something that has me confused.  I instrumented the code =
to
> add some simple counters and have found that for non-rt loads, we see=
m
> to perform priority boosts more frequently than expected.  Here are s=
ome
> numbers...
>
> rs_pi_boost            =3D 2060
> rs_pi_unboost          =3D 1451
> rs_rt_contention       =3D 708
>
> 'rs_pi_boost' and 'rs_pi_unboost' are are counts of the number of tim=
es
> a task priority is about to be changed in __rt_mutext_adjust_prio().
> 'rs_rt_contention' is a count of the number of times an RT-priority t=
ask
> entered task_blocks_on_rt_mutex() (which means the lock was outstandi=
ng
> at that time the counter was incremented)
>
> I'm confused on two counts, 1) the disparity between the boost and
> unboost, and 2) the factor of 2x difference between the (potentially)
> about to block RT task and the boost counts.

I am not very familiar with PI-related code but I believe that at least=
 your=20
1st assumption is not correct, i.e., the number of boost and unboost is=
 not=20
necessarily equal.  If you have, for example, a task which priority is =
boost=20
several times in a row (without releasing the resource), it will only u=
nboost=20
once -- when the resource is released.  Thus, the boost/unboost relatio=
n is=20
not one-to-one but many-to-one ;)

Note again that I am not very familiar with this code but I believe thi=
s is=20
the default behaviour of the kernel.

Hope this helps you understand the problem...
--=20
Lu=EDs Henriques

> My expectation would be that all three counters would be more or less
> the same.  Further, that we would only boost non-RT tasks in contenti=
on
> with an RT task.  Is that a wrong assumption?  The code seems to impl=
y
> that we boost anyone.
>
> The samples were taken after a reboot followed by a 'make' in an alre=
ady
> built kernel tree.  The counts (gradually) grow in this proportion as
> time/load passes.  They are currently low due to the reboot.
>
> What got me started on this path was noticing the context switch coun=
ts
> go extremely high with the addition of a single process.  Here is the
> output of a silly little program I wrote that reads /proc/stat and ca=
lcs
> context-switches/second:
>
> prev:    1990167, current:    1992750, diff:        516/s
> prev:    1992755, current:    1994567, diff:        362/s
> prev:    1994569, current:    1997847, diff:        655/s
> prev:    1997849, current:    2011904, diff:       2811/s # make star=
t
> prev:    2011913, current:    2041192, diff:       5855/s
> prev:    2041194, current:    2074749, diff:       6711/s
> prev:    2074752, current:    2107060, diff:       6461/s
> prev:    2107065, current:    2139376, diff:       6462/s
> prev:    2139378, current:    2164268, diff:       4978/s # make kill=
ed
> prev:    2164274, current:    2166674, diff:        480/s
> prev:    2166676, current:    2168187, diff:        302/s
> prev:    2168189, current:    2169576, diff:        277/s
>
> Factor of 10x for a single make (no -j) on an otherwise idle system.
> Again, this was on an already built kernel tree and taken shortly aft=
er
> the a previous make invocation (implying the caches should be warm).
> Since I'm hitting on the dcache and inode spin locks (that are now
> rt_spin_locks) and only contending with other system processes (syslo=
g,
> etc) I'm at a loss attempting to understand why the dramatic increase=
 in
> the context switch rate.
>
> Any insights appreciated....
>
> Thx,
> -PWM
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
