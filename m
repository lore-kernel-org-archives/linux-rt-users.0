From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Wed, 15 Jul 2009 15:53:33 -0600
Message-ID: <4A5E4FDD.7090307@nortel.com>
References: <1247336891.9978.32.camel@laptop> <4A594D2D.3080101@ittc.ku.edu> <1247412708.6704.105.camel@laptop> <1247499843.8107.548.camel@Palantir> <4A5B61DF.8090101@nortel.com> <1247568455.9086.115.camel@Palantir> <4A5C9ABA.9070909@nortel.com> <alpine.LRH.2.00.0907141109190.16818@anderson.cs.unc.edu> <1247589099.7500.191.camel@twins> <alpine.LRH.2.00.0907141234280.16818@anderson.cs.unc.edu> <20090715205503.GA14993@cs.fsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "James H. Anderson" <anderson@cs.unc.edu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Raistlin <raistlin@linux.it>,
	Douglas Niehaus <niehaus@ittc.ku.edu>,
	Henrik Austad <henrik@austad.us>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Linux RT <linux-rt-users@vger.kernel.org>,
	Fabio Checconi <fabio@gandalf.sssup.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dhaval Giani <dhaval.giani@gmail.com>,
	Noah Watkins <jayhawk@soe.ucsc.edu>,
	KUSP Google Group <kusp@googlegroups.com>,
	Tommaso Cucinotta <cucinotta@sssup.it>,
	Giuseppe Lipari <lipari@retis.sssup.it>,
	Bjoern Brandenburg <bbb@cs.unc.edu>
To: Ted Baker <baker@cs.fsu.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zcars04e.nortel.com ([47.129.242.56]:51598 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbZGOVxq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Jul 2009 17:53:46 -0400
In-Reply-To: <20090715205503.GA14993@cs.fsu.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ted Baker wrote:

> The present Linux "RT throttling" mechanism seems to be an attempt
> to achieve something similar (preventing RT tasks from shutting
> out other work, by reserving some bandwidth for non-RT tasks).
> However, it is done so grossly as to be unsatisfactory for
> real-time applications.  The better way to do this would be to
> enforce a bandwidth limit on each task with real-time priority --
> using the budget amount and replenishment interval required by
> that task -- and enforce by admission control that the real-time
> tasks do not exceed some configurable percent of the total system
> utilization.

>From an API standpoint, the "group scheduling" functionality in linux
allows for the creation of an arbitrary hierarchy of groups, each of
which may contain zero or more tasks.  (Each task is associated with
exactly one group.)

There is a distinction between groups containing realtime tasks, and
groups containing non-realtime tasks.  For realtime groups, each group
is allocated a specific amount of cpu time.  For non-realtime groups,
each group is allocated a specific weight.

A realtime group may use up to its specified amount of cpu time.  Any
cpu time not used by a realtime group is distributed to the non-realtime
groups according to their relative weights.

This does add a whole different API to the mix, but allows for controls
to be set by the administrator on existing POSIX apps without needing to
recompile them.

Chris
