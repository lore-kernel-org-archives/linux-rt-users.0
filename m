From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.35 RT support roadmap
Date: Fri, 13 Aug 2010 08:14:47 +0200
Message-ID: <1281680087.8870.82.camel@marge.simson.net>
References: <CD8FEF6F82F55744AA1ED2BE5E7D8FD2015184EE0B@dnce01.ent.ti.com>
	 <AANLkTimmCqNz+ZhSCqMGhaiCmW38hnjfkLV0ZU+e2gkX@mail.gmail.com>
	 <1281638311.7093.4.camel@marge.simson.net> <4C645567.2080308@gmail.com>
	 <AANLkTikoUbL4Q8PNia38AByEfTY56Bqr5uVnyyNxvS1W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	Xianghua Xiao <xiaoxianghua@gmail.com>,
	"Walzer, Frank" <f-walzer@ti.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: jordan johnston <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:54671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752538Ab0HMGOc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Aug 2010 02:14:32 -0400
In-Reply-To: <AANLkTikoUbL4Q8PNia38AByEfTY56Bqr5uVnyyNxvS1W@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-08-12 at 23:17 -0400, jordan johnston wrote:
> > Google did Android and even Palm woke up (just long enough to watch its own
> > demise).
> >
> > The rest is history.
> >
> > Except of course putting the RT Kernel in Android.
> 
> As i understand it, many Android users are using the BFS patchset, and
> have been for a while. BFS pretty much does what "the end result of
> using the rt-patches" accomplish, minus rtirq, spin-locks, etc. You
> will get the desired
> responsiveness that using RT would give you.

Heh, RT kernel patch and BFS _scheduler_ patch are not even on the same
planet.  BFS is probably not a bad choice for a single cache machine
doing soft RT.  I tested it pretty heavily a while back, and it was
generally pretty good.

> Im pretty sure that is why Zen-kernel has a git repository "very
> specifically" for android (BFS is the default kernel setting). I'm
> sure there are other goodies for android in there too.
> 
> www.zen-kernel.org
> 
> I don't know much about the Android repo's state (as it's fairly new).
> but worth a
> look for your "rt-usage" (ie. performance/responsiveness) for android.
>  As i do not own an Android, i have not tested it, but i have talked
> with people who do..
> 
> I'm waiting to see what 2.6.35 holds for RT.... but personally i am
> using BFS and 2.6.34 with a lot of performance tuning (a good deal of
> time spent analyzing/tuning) and i am yielding better results not
> using the upstream rt-patches.
> we will see what happens in 2.6.35/36....

It depends on what you're calling performance.  A non-rt kernel
absolutely will outperform the rt kernel in many respects.  For
instance, if your measure of performance is the time it takes to play
one byte ping-pong over localhost (eg netperf TCP_RR), the rt kernel
will (does) lose badly due to context switch cost between various rt
middle-man threads.  If your performance criteria is things like
priority inversion tests, suddenly the comparison does a flipflop.

	-Mike

