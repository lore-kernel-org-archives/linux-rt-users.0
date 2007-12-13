From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 0/6] RCU: Preemptible-RCU
Date: Thu, 13 Dec 2007 21:38:04 +0100
Message-ID: <20071213203804.GE25130@elte.hu>
References: <20071213170348.GA25981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul E McKenney <paulmck@us.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Gautham R Shenoy <ego@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:39353 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762380AbXLMUjE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 15:39:04 -0500
Content-Disposition: inline
In-Reply-To: <20071213170348.GA25981@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> Hello everyone,
> 
> This patchset is an updated version of the preemptible RCU patchset 
> that Paul McKenney had posted it in September earlier this year that 
> can be found here --> http://lkml.org/lkml/2007/9/10/213
> 
> This patchset incorporates the review comments from Oleg Nesterov and 
> Steven Rostedt.
> 
> The testing report of the patchset is as follows:
> ====================================================================
> Patch-stack:  	2.6.23-rc3 + cpu-hotplug patches from 
> 		http://lkml.org/lkml/2007/11/15/239 + Preempt-RCU
> 		patches.
> Test:		RCU-Torture running parallelly with CPU-Hotplug
> 		operations.
> Duration:	24 hours.
> Architectures:	x86,x86_64, ppc64.
> ====================================================================
> 
> 
> Currently it is based against the latest linux-2.6-sched-devel.git
> 
> Awaiting your feedback!

thanks Gautham, the patchset from you and Paul looks good to me and i've 
applied it to sched-devel.git to get it tested and reviewed some more.

from the Nitpicking Police, there are a couple of minor style 
problems/warnings with the code, you can see it via:

  scripts/checkpatch.pl --file kernel/rcu*.c

nothing serious - RCU is still one of the cleanest subsystems in the 
kernel:

                                      errors   lines of code   errors/KLOC
kernel/rcuclassic.c                        0             575             0
kernel/rcupdate.c                          1             138           7.2
kernel/rcupreempt.c                        0             953             0
kernel/rcupreempt_trace.c                  0             330             0
kernel/rcutorture.c                        8             995           8.0

the eventual goal would be to match:

   scripts/checkpatch.pl --file kernel/sched*.[ch]

output ;-)

	Ingo
