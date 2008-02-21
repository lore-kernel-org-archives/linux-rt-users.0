From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: [PATCH [RT] 10/14] adjust pi_lock usage in wakeup
Date: Thu, 21 Feb 2008 10:09:04 -0700
Message-ID: <1203613744.4232.32.camel@hermosa.morrealenet>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
	 <20080221152717.4804.56212.stgit@novell1.haskins.net>
	 <Pine.LNX.4.58.0802211147270.11610@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bill.huey@gmail.com, kevin@hilman.org, cminyard@mvista.com,
	dsingleton@mvista.com, dwalker@mvista.com, npiggin@suse.de,
	dsaxena@plexity.net, ak@suse.de, gregkh@suse.de,
	sdietrich@novell.com, mkohari@novell.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:37761 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932392AbYBURJS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 12:09:18 -0500
In-Reply-To: <Pine.LNX.4.58.0802211147270.11610@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2008-02-21 at 11:48 -0500, Steven Rostedt wrote:
> On Thu, 21 Feb 2008, Gregory Haskins wrote:
> 
> > From: Peter W.Morreale <pmorreale@novell.com>
> >
> > In wakeup_next_waiter(), we take the pi_lock, and then find out whether
> > we have another waiter to add to the pending owner.  We can reduce
> > contention on the pi_lock for the pending owner if we first obtain the
> > pointer to the next waiter outside of the pi_lock.
> >
> > This patch adds a measureable increase in throughput.
> 
> I see how this may decrease contention (slightly less time in holding the
> pi_lock). But, please, when stating something like: "adds a measurable
> increase in throughput", show the benchmark numbers.
> 
> -- Steve
> 

Approximately 3% to the dbench benchmark we used.

My "standard" sanity check was to mount a ramfs filesystem and execute:

dbench -t 10 30

five times and generate an average from the reported "Throughput"
numbers displayed by the runs. 

dbench was chosen merely because of the contention on dcache_lock.

Best,
-PWM
