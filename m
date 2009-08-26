From: Ingo Molnar <mingo@elte.hu>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Wed, 26 Aug 2009 23:34:00 +0200
Message-ID: <20090826213400.GA25536@elte.hu>
References: <1251298443.4791.7.camel@raz> <1251300625.18584.18.camel@twins> <alpine.DEB.1.10.0908261136590.9933@gentwo.org> <1251302598.18584.31.camel@twins> <alpine.DEB.1.10.0908261211340.9933@gentwo.org> <20090826180407.GA13632@elte.hu> <alpine.DEB.1.10.0908261509580.9933@gentwo.org> <20090826193252.GA14721@elte.hu> <alpine.DEB.1.10.0908261627110.5554@gentwo.org> <20090826135041.e6169d18.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Lameter <cl@linux-foundation.org>, peterz@infradead.org,
	raziebe@gmail.com, maximlevitsky@gmail.com, cfriesen@nortel.com,
	efault@gmx.de, riel@redhat.com, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753935AbZHZVeb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090826135041.e6169d18.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 26 Aug 2009 16:40:09 -0400 (EDT)
> Christoph Lameter <cl@linux-foundation.org> wrote:
> 
> > Peter has not given a solution to the problem. Nor have you.
> 
> What problem?
> 
> All I've seen is "I want 100% access to a CPU".  That's not a problem
> statement - it's an implementation.
> 
> What is the problem statement?
> 
> My take on these patches: the kernel gives userspace unmediated 
> access to memory resources if it wants that. The kernel gives 
> userspace unmediated access to IO devices if it wants that. But 
> for some reason people freak out at the thought of providing 
> unmediated access to CPU resources.

Claiming all user-available CPU time from user-space is already 
possible: use SCHED_FIFO - the only question are remaining latencies 
in the final 0.01% of CPU time you cannot claim via SCHED_FIFO.

( Btw., this scheduling feature was implemented in Linux well before
  raw IO block devices were implemented, so i'm not sure what you
  mean by 'freaking out'. )

What we are objecting to are these easy isolation side-hacks for the 
remaining 0.01% that fail to address the real problem: the 
latencies. Those latencies can hurt not just isolated apps but _non 
isolated_ (and latency critical) apps too, and what we insist on is 
getting the proper fixes, not just ugly workarounds that side-step 
the problem.

( a secondary objection is the extension and extra layering
  of something that could be done within existing APIs/ABIs too. We
  want to minimize the configuration space. )

> Don't get all religious about this.  If the change is clean, 
> maintainable and useful then there's no reason to not merge it.

Precisely. This feature as proposed here hinders the correct 
solution being implemented - and hence hurts long term 
maintainability and hence is a no-merge right now. [It also weakens 
the pressure to fix latencies for a much wider set of applications, 
hence hurts the quality of Linux in the long run. (i.e. is a net 
step backwards)]

	Ingo
