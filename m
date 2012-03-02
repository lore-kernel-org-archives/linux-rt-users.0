From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 7/9][RFC] [PATCH 7/9] cpu/rt: Rework cpu down for
 PREEMPT_RT
Date: Fri, 2 Mar 2012 16:51:05 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203021649580.2742@ionos>
References: <20120301185527.064629423@goodmis.org>   <20120301190346.172835662@goodmis.org>   <alpine.LFD.2.02.1203021518501.2742@ionos>  <1330701323.25686.260.camel@gandalf.stny.rr.com>  <alpine.LFD.2.02.1203021618330.2742@ionos>
 <1330702617.25686.265.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43623 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab2CBPvH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Mar 2012 10:51:07 -0500
In-Reply-To: <1330702617.25686.265.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2 Mar 2012, Steven Rostedt wrote:

> On Fri, 2012-03-02 at 16:20 +0100, Thomas Gleixner wrote:
> 
> > Already queued. I'd say #4 is a bug fix as well, though I
> > fundamentally hate the ass backwards semantics of that new function.
> 
> It is a bug fix, but I don't like it either. Note, that the patch didn't
> update the pin_current_cpu() code, which would have to be done too (to
> be a full fix).

I know.
 
> But I was also thinking that as a work around, as we plan on changing
> this code anyway. Instead of adding a new API which is ass backwards,
> just encompass the cpu_hotplug.lock instead. Something like this:

Thought about that already. It's way less fugly.
 
Thanks,

	tglx
