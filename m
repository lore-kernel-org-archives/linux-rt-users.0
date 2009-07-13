From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Mon, 13 Jul 2009 19:25:41 +0200
Message-ID: <1247505941.7500.39.camel@twins>
References: <200907102350.47124.henrik@austad.us>
	 <1247336891.9978.32.camel@laptop>  <4A594D2D.3080101@ittc.ku.edu>
	 <1247412708.6704.105.camel@laptop>  <1247499843.8107.548.camel@Palantir>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Douglas Niehaus <niehaus@ittc.ku.edu>,
	Henrik Austad <henrik@austad.us>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Linux RT <linux-rt-users@vger.kernel.org>,
	Fabio Checconi <fabio@gandalf.sssup.it>,
	"James H. Anderson" <anderson@cs.unc.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ted Baker <baker@cs.fsu.edu>,
	Dhaval Giani <dhaval.giani@gmail.com>,
	Noah Watkins <jayhawk@soe.ucsc.edu>,
	KUSP Google Group <kusp@googlegroups.com>,
	Tommaso Cucinotta <cucinotta@sssup.it>,
	Giuseppe Lipari <lipari@retis.sssup.it>
To: Raistlin <raistlin@linux.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from viefep20-int.chello.at ([62.179.121.40]:42247 "EHLO
	viefep20-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389AbZGMRZu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 13:25:50 -0400
In-Reply-To: <1247499843.8107.548.camel@Palantir>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2009-07-13 at 17:44 +0200, Raistlin wrote:
> > PIP doesn't suffer this, but does suffer the pain from having to
> > reimplement the full schedule function on the waitqueues, which when you
> > have hierarchical scheduling means you have to replicate the full
> > hierarchy per waitqueue.
> > 
> And, further than this, at least from my point of view, if you have
> server/group based scheduling, and in general some kind of budgeting or
> bandwidth enforcing mechanism in place, PIP is far from being a
> solution...

I think you can extend PIP to include things like bandwidth inheritance
too. Instead of simply propagating the priority through the waitqueue
hierarchy, you can pass the actual task around, and having this task you
can indeed consume its bandwidth etc..

But sure, hierarchical scheduling and things really complicate the
waitqueue implementation.

