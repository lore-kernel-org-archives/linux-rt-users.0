From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Thu, 26 Feb 2015 07:46:09 -0500
Message-ID: <20150226074609.27ccd39d@grimm.local.home>
References: <20150224133946.3948c4b7@gandalf.local.home>
	<20150225103535.GJ5029@twins.programming.kicks-ass.net>
	<20150225105116.7fa03cc9@gandalf.local.home>
	<20150225171110.GO21418@twins.programming.kicks-ass.net>
	<20150225125015.6c5110ca@gandalf.local.home>
	<20150226074907.GQ21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	=?UTF-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:8943 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932272AbbBZMpR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 07:45:17 -0500
In-Reply-To: <20150226074907.GQ21418@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 26 Feb 2015 08:49:07 +0100
Peter Zijlstra <peterz@infradead.org> wrote:
 
> Yes, notice that we don't start iterating at the beginning; this in on
> purpose. If we start iterating at the beginning, _every_ cpu will again
> pile up on the first one.
> 
> By starting at the current cpu, each cpu will start iteration some place
> else and hopefully, with a big enough system, different CPUs end up on a
> different rto cpu.

Note, v3 doesn't start at the current CPU, it starts at the original
CPU again. As the start of every IPI comes from a different CPU, this
still keeps a restart from clobbering the same CPU.

-- Steve
