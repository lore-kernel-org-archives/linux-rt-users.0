From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/18] tracing/ring-buffer: fixes for latency tracer
 [2.6.32]
Date: Tue, 08 Sep 2009 11:39:10 -0400
Message-ID: <1252424350.15626.9.camel@gandalf.stny.rr.com>
References: <20090904235527.520961911@goodmis.org>
	 <20090905150658.GA13387@ghostprotocols.net>
	 <4de7f8a60909070320j692d746drb06bd635ca7f7c55@mail.gmail.com>
	 <4de7f8a60909080742m3497f6cfo6cce42b1dcee09ab@mail.gmail.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: Jan Blunck <jblunck@suse.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751362AbZIHPjN@vger.kernel.org>
In-Reply-To: <4de7f8a60909080742m3497f6cfo6cce42b1dcee09ab@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2009-09-08 at 16:42 +0200, Jan Blunck wrote:
> On Mon, Sep 7, 2009 at 12:20 PM, Jan Blunck<jblunck@suse.de> wrote:
> > On Sat, Sep 5, 2009 at 5:06 PM, Arnaldo Carvalho de Melo<acme@redhat.com> wrote:
> >>
> >> I did a quick port to tip/rt/head and couldn't reproduce the problems I
> >> was experiencing, thanks!
> >>
> >> I've put the ported patch series at:
> >>
> >> http://userweb.kernel.org/~acme/rostedt-rb-rt
> >>
> 
> Besides the problem with the wakeup tracer I see traces with
> preemptirqsoff that I think are invalid:
> 
> # tracer: preemptirqsoff
> #
> # preemptirqsoff latency trace v1.1.5 on 2.6.31-rc8-rt9-rt_trace
> # --------------------------------------------------------------------
> # latency: 332 us, #4/4, CPU#24 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:32)
> #    -----------------
> #    | task: -0 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: start_secondary
> #  => ended at:   start_secondary
> #
> #
> #                  _------=> CPU#
> #                 / _-----=> irqs-off
> #                | / _----=> need-resched
> #                || / _---=> hardirq/softirq
> #                ||| / _--=> preempt-depth
> #                |||| /
> #                |||||     delay
> #  cmd     pid   ||||| time  |   caller
> #     \   /      |||||   \   |   /
>   <idle>-0      24.N.1    0us : cpu_idle <-start_secondary
>   <idle>-0      24dN.1    1us!: tick_nohz_stop_idle <-tick_nohz_restart_sched_ti
> ck
>   <idle>-0      24dN.1  332us+: cpu_idle <-start_secondary
>   <idle>-0      24dN.1  336us : trace_preempt_on <-start_secondary
> 
> I have set kernel.ftrace_enabled = 1 but still not a single function
> is recorded in tick_nohz_stop_idle().
> 
> Any ideas?

Which arch is this for? When the system goes into idle, it usually
disables preemption and maybe interrupts. But the idle call in assembly
will enable interrupts. And when an interrupt happens it comes out.

There should be callbacks in cpu_idle to disable latency tracing. These
functions are called stop_critical_timings and start_critical_timings.
You'll see these calls in both process_64.c and process_32.c in the x86
arch.

Is you set up not calling cpu_idle?

-- Steve
