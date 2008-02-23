From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH [RT] 08/14] add a loop counter based timeout mechanism
Date: Sat, 23 Feb 2008 13:31:00 +0100
Message-ID: <20080223123100.GB9021@bingen.suse.de>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net> <20080221152707.4804.59177.stgit@novell1.haskins.net> <200802211741.10299.ak@suse.de> <20080222190814.GD11213@linux.vnet.ibm.com> <9810cff90802221119j23818e74g2721512a693a0a01@mail.gmail.com> <9810cff90802221121s216f69f4k4a5f39eaaf11dd7f@mail.gmail.com> <20080222194341.GE11213@linux.vnet.ibm.com> <1203710145.4772.107.camel@sven.thebigcorporation.com> <20080222202316.GF11213@linux.vnet.ibm.com> <47BF46AF.7010200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulmck@linux.vnet.ibm.com,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	"Bill Huey (hui)" <bill.huey@gmail.com>, Andi Kleen <ak@suse.de>,
	Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	gregkh@suse.de, pmorreale@novell.com, mkohari@novell.com
To: gregory.haskins@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40992 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbYBWMbH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Feb 2008 07:31:07 -0500
Content-Disposition: inline
In-Reply-To: <47BF46AF.7010200@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> *) compute the context-switch pair time average for the system.  This is 
> your time threshold (CSt).

This is not a uniform time. Consider the difference between
context switch on the same hyperthread, context switch between cores
on a die, context switch between sockets, context switch between
distant numa nodes. You could have several orders of magnitude
between all those.

>
> *) For each lock, maintain an average hold-time (AHt) statistic (I am 
> assuming this can be done cheaply...perhaps not).

That would assume that the hold times are very uniform. But what happens
when you e.g. have a workload where 50% of the lock aquisitions are short 
and 30% are long? 

I'm a little sceptical of such "too clever" algorithms.

-Andi
