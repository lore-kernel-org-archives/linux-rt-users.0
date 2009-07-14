From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Tue, 14 Jul 2009 12:24:26 -0600
Message-ID: <4A5CCD5A.80108@nortel.com>
References: <200907102350.47124.henrik@austad.us>	 <1247336891.9978.32.camel@laptop>  <4A594D2D.3080101@ittc.ku.edu>	 <1247412708.6704.105.camel@laptop> <1247499843.8107.548.camel@Palantir>	 <4A5B61DF.8090101@nortel.com> <1247568455.9086.115.camel@Palantir>	 <4A5C9ABA.9070909@nortel.com> <1247590112.9086.936.camel@Palantir>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Douglas Niehaus <niehaus@ittc.ku.edu>,
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
Received: from zcars04e.nortel.com ([47.129.242.56]:59136 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbZGNSYh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2009 14:24:37 -0400
In-Reply-To: <1247590112.9086.936.camel@Palantir>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Raistlin wrote:

> Remember that all my points are concerned with budgets, i.e., a scenario
> where you have some mean to limit the capability of a task to ask for
> CPU time over some kind of period.
> And here it is where the problem comes since running C instead of having
> A busy waiting means:
> - that A is actually blocked, as said before;

Why does it make any difference that A is blocked rather than busy
waiting?  In either case A cannot make forward progress.

> - that A's budget is not diminished.

If we're running B with A's priority, presumably it will get some amount
of cpu time above and beyond what it would normally have gotten during a
particular scheduling interval.  Perhaps it would make sense to charge B
what it would normally have gotten, and charge the excess amount to A?

Chris
