From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Mon, 01 Aug 2011 20:41:35 +0200
Message-ID: <1312224095.8151.78.camel@marge.simson.net>
References: <20110729151340.419467771@goodmis.org>
	 <1312017596.8752.78.camel@marge.simson.net>
	 <1312208313.18583.28.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54419 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab1HASlj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 14:41:39 -0400
In-Reply-To: <1312208313.18583.28.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2011-08-01 at 10:18 -0400, Steven Rostedt wrote:
> On Sat, 2011-07-30 at 11:19 +0200, Mike Galbraith wrote:
> > On Fri, 2011-07-29 at 11:13 -0400, Steven Rostedt wrote:
> > > Hi Mike,
> > > 
> > > Could you try this patch set out. Add the first patch and then
> > > run your tests. The first patch only adds benchmarking, and does not
> > > modify the scheduler algorithm.
> > > 
> > > Do this:
> > > 
> > > 1. apply first patch, build and boot
> > > 2. # mount -t debugfs nodev /sys/kernel/debug
> > > 3. # echo 0 > /sys/kernel/debug/cpupri; ./runtest; cat /sys/kernel/debug/cpupri > output
> > > 
> > > The output will give you the contention of the vector locks in the
> > > cpupri algorithm.
> > > 
> > > Then apply the second patch and do the same thing.
> > > 
> > > Then apply the third patch and do the same thing.
> > > 
> > > After that, could you send me the results of the output file for all
> > > three runs?  The final patch should probably be the best overall
> > > results.
> > 
> > These patches are RFC, so here's my Comment.  Steven rocks.
> 
> /me blushes!

Don't, they're excellent.  /me was having one _hell_ of a hard time
trying to convince box that somewhat tight constraint realtime really
really should be possible on isolated CPUs.

> Thanks for testing! I'll redo the patches to remove the logging, and
> send them to you again. Could you return back a 'Tested-by' tag
> afterward.

(I did the logging removal, the posted numbers were that, but..)

Sure.  I've been beating on them (heftily), there are there have been no
ill effects detected.  You can have my..
	Tested-by: Mike Galbraith <mgalbraith@suse.de> ||
	Tested-by: Mike Galbraith <efault@gmx.de> (the real /me)
..now fwiw, they were the deciding factor here.

> Could you also post the results without the two cpupri patches?

Sure, will do.  As noted, the cyclictest numbers were never as nasty as
the benchmark indicated they could (did) get.  With this particular test
app, there's there's a nasty feedback perturbation source, tty.  It can
feed on itself if several threads start griping.

While testing your patches, I just let it do it's thing with a ~full up
load it never could handle, and let the chips fall where they may.  The
cyclictest numbers I post will be 1:1 with the results posted, ie taking
tty out of the picture, so the difference won't be as huge as the lock
benchmark showed it can (did) get.

	-Mike

