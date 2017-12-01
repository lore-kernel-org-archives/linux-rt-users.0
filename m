From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] crypto: limit more FPU-enabled sections
Date: Fri, 1 Dec 2017 14:50:00 +0100
Message-ID: <20171201134959.GG1612@linutronix.de>
References: <20171130142216.GB12606@linutronix.de>
 <20171130101943.15f7ade4@gandalf.local.home>
 <20171130152236.GA11362@linutronix.de>
 <20171201104422.GC1612@linutronix.de>
 <20171201113235.6tmkwtov5cg2locv@hirez.programming.kicks-ass.net>
 <20171201133256.GE1612@linutronix.de>
 <20171201134454.rgiy5cfh72imqqcl@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50307 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbdLANuE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Dec 2017 08:50:04 -0500
Content-Disposition: inline
In-Reply-To: <20171201134454.rgiy5cfh72imqqcl@hirez.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-01 14:44:54 [+0100], Peter Zijlstra wrote:
> !PREEMPT kernels. The above should work for everyone and would allow
> using 'long' kernel_fpu loops:
> 
> 	kernel_fpu_begin();
> 	while (work) {
> 		do_work();
> 		kernel_fpu_resched();
> 	}
> 	kernel_fpu_end();
> 
> regardless of preempt setting.

Ach, wasn't aware that you wanted that explicit for !PREEMPT kernels,
too. Okay, so let me pick this hunk up as-is for RT and before I throw
it mainline I will add some numbers.

Sebastian
