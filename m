From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Mon, 13 Jul 2009 19:28:22 +0200
Message-ID: <1247506102.7500.41.camel@twins>
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
Received: from viefep14-int.chello.at ([62.179.121.34]:16460 "EHLO
	viefep14-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438AbZGMR2a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 13:28:30 -0400
In-Reply-To: <1247499843.8107.548.camel@Palantir>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2009-07-13 at 17:44 +0200, Raistlin wrote:
> What we would like to achieve is some set of rules that, extending the
> UP ones, yield a situation which is both:
> - analyzable from the real-time theorist's point of view... Which is
>   (un?)fortunately what we are :-)
> - possible to implement... Which is not always (un!)fortunately obvious 
>   here :-)

I would very much like a proper theoretical foundation for whatever we
end up with ;-)

> Very basically: from the analysis point of view one easy and effective
> solution would be to have the blocked-running tasks --i.e., the tasks
> blocked on some lock that have been left on the rq to proxy-execute the
> lock owner-- busy waiting while the lock owner is running. This allows
> for retaining a lot of nice properties BWI already has, as far as
> analyzability is concerned.

Right, practically we cannot do this, since we expose the block graph to
userspace and you could in userspace construct a program that would
exploit this spinning to DoS the system.

