From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] lockdep: Add nr_save_trace_invocations counter
Date: Fri, 23 Apr 2010 10:05:15 +0200
Message-ID: <1272009915.1646.25.camel@laptop>
References: <alpine.LFD.2.00.1004222208310.3155@localhost>
	 <20100423025850.GA21328@windriver.com>
	 <alpine.LFD.2.00.1004230907050.4151@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Yong Zhang <yong.zhang@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:57087 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478Ab0DWIFY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Apr 2010 04:05:24 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O5Dt5-00052A-30
	for linux-rt-users@vger.kernel.org; Fri, 23 Apr 2010 08:05:23 +0000
In-Reply-To: <alpine.LFD.2.00.1004230907050.4151@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-04-23 at 09:24 +0200, John Kacur wrote:
> direct dependencies:                  8752 [max: 16384]
> I have
> stack-trace invocations: 10888
> from the same run.
> 
> Still trying to figure out what the meaning is of that though to be 
> honest.
> 
> Here is a portion of the lockdep_stats, with all of the new fields and the 
> redundant ones.
> 
> stack-trace invocations: 10888
>         LOCK_USED_IN_HARDIRQ: 15
>         LOCK_USED_IN_HARDIRQ_READ: 0
>         LOCK_ENABLED_HARDIRQ: 543
>         LOCK_ENABLED_HARDIRQ_READ: 28
>         LOCK_USED_IN_SOFTIRQ: 0
>         LOCK_USED_IN_SOFTIRQ_READ: 0
>         LOCK_ENABLED_SOFTIRQ: 543
>         LOCK_ENABLED_SOFTIRQ_READ: 28
>         LOCK_USED_IN_RECLAIM_FS: 5
>         LOCK_USED_IN_RECLAIM_FS_READ: 0
>         LOCK_ENABLED_RECLAIM_FS: 95
>         LOCK_ENABLED_RECLAIM_FS_READ: 8
>         LOCK_USED: 871 

8752+871+8+95+5+28+543+28+543+15=10888

So you get a stack-trace for each direct-dependency, and you get a
stack-trace for each LOCK_state, the sum seems to match the total
invocations.

Non of these numbers look strange.. 

