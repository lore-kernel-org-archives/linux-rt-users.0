From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 15:19:21 -0400
Message-ID: <1363634361.28194.9.camel@gandalf.local.home>
References: <1363617383.25967.152.camel@gandalf.local.home>
	 <20130318160652.GA20133@mtj.dyndns.org>
	 <1363623799.25967.172.camel@gandalf.local.home>
	 <1363624020.25967.175.camel@gandalf.local.home>
	 <1363624243.25967.178.camel@gandalf.local.home>
	 <20130318164351.GA21516@mtj.dyndns.org>
	 <1363626487.25967.186.camel@gandalf.local.home>
	 <20130318182130.GA3042@htj.dyndns.org>
	 <1363633050.25967.210.camel@gandalf.local.home>
	 <20130318190616.GC3042@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14876 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab3CRTTX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Mar 2013 15:19:23 -0400
In-Reply-To: <20130318190616.GC3042@htj.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-03-18 at 12:06 -0700, Tejun Heo wrote:

> Me neither.  Unfortunately, I'm out of ideas at the moment.
> Hmm... last year, there was a similar issue, I think it was in AMD
> cpufreq, which was caused by work function doing
> set_cpus_allowed_ptr(), so the idle worker was on the correct CPU but
> the one issuing local wake up was on the wrong one. 

I should also tell you that -rt is currently based on 3.6.11. Did that
bug get passed on to stable? If not, we could be hitting that same bug
too. Except this is running on Intel. :-/


>  It could be that
> there's another such usage in kernle which doesn't trigger easily w/o
> RT.  As preemption doesn't trigger concurrency management wakeup, as
> long as such user doesn't do something explicitly blocking, upstream
> would be fine as long as it restores affinity before finishing but in
> RT spinlocks become mutexes and can trigger local wakeups, so...

And these wakeups can be triggered by blocking on the gcwq->lock as
well, where it probably happens more often on -rt than mainline.

> 
> Anyways, having a crashdump would go a long way towards identifying
> what's going on.  All we need to know are the work function which was
> being executed, whether the worker was on the right CPU and which
> worker it was trying to wake up.
> 

OK, I'll have my box set up. But I doubt this bug will even trigger
again before I have to return it :-(

-- Steve


