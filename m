From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Mon, 22 Feb 2016 12:48:54 -0500
Message-ID: <20160222124854.3816fec4@gandalf.local.home>
References: <cover.1456157869.git.bristot@redhat.com>
	<f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
	<20160222173259.GM6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160222173259.GM6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 22 Feb 2016 18:32:59 +0100
Peter Zijlstra <peterz@infradead.org> wrote:


> So I'm a bit allergic to tracepoints and this is very flimsy on reasons
> why I would want to do this.

Because there's no way to know if SCHED_DEADLINE tasks are doing what
they suppose to without hacking the kernel and adding your own
tracepoints.

> 
> As it stands, the existing tracepoint have already been an ABI
> trainwreck, why would I want to add more?

Yes, this may become a type of ABI, but even the sched switch
tracepoints haven't been that bad. Has it really prevented us from
changing anything?

"trainwreck" is a harsh word, and the information of scheduling
tracepoints have been crucial to finding bugs and such. And has been
tremendously useful in loads of cases.

But let me ask, what would you recommend to finding out if the kernel
has really given your tasks the recommended runtime within a given
period? We can't expect users of SCHED_DEADLINE to be modifying the
kernel themselves.

-- Steve
