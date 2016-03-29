From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 17:57:33 -0300
Message-ID: <56FAEC3D.1070300@redhat.com>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <20160329115700.40acb336@gandalf.local.home>
 <20160329160401.GB3430@twins.programming.kicks-ass.net>
 <20160329131056.5b01780b@gandalf.local.home>
 <20160329201145.GC3430@twins.programming.kicks-ass.net>
 <20160329162907.418cb972@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbcC2U5h (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 16:57:37 -0400
In-Reply-To: <20160329162907.418cb972@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/29/2016 05:29 PM, Steven Rostedt wrote:
>>> Yes, we don't want to get rid of the old one. But it shouldn't break
>>> > > anything if we extend it. I'm thinking of extending it with a dynamic
>>> > > array to store the deadline task values (runtime, period). And for non
>>> > > deadline tasks, the array would be empty (size zero). I think that
>>> > > could be doable and maintain backward compatibility.  
>> > 
>> > Why the complexity? Why not just tack those 32 bytes on and get on with
>> > life?
> 32 bytes that are zero and meaningless for 99.999% of scheduling?

I agree. Not only because of the extra bytes, but also because of extra
information that is not useful for 99.999% of non-deadline users.

> The scheduling tracepoint is probably the most common tracepoint used,
> and one of the frequent ones. 32bytes of wasted space per event can
> cause a lot of tracing to be missed.

And any change on it, now and in the future, will cause confusion for
99.999% of raw sched_switch users. Without considering those who wrote
bad applications that will break, and those who wrote nice applications
and probably will have to keep many versions of their handlers to keep
backward compatibility with old kernels.

If it needs to be generic, I vote for a dynamic set of data, handled
"per-scheduler", as Steven mentioned before... (even though it sounds
contradictory)

-- Daniel
