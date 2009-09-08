From: Jan Blunck <jblunck@suse.de>
Subject: Re: [PATCH 00/18] tracing/ring-buffer: fixes for latency tracer
	[2.6.32]
Date: Tue, 8 Sep 2009 16:42:50 +0200
Message-ID: <4de7f8a60909080742m3497f6cfo6cce42b1dcee09ab@mail.gmail.com>
References: <20090904235527.520961911@goodmis.org>
	 <20090905150658.GA13387@ghostprotocols.net>
	 <4de7f8a60909070320j692d746drb06bd635ca7f7c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:44681 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZIHOqd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Sep 2009 10:46:33 -0400
In-Reply-To: <4de7f8a60909070320j692d746drb06bd635ca7f7c55@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 7, 2009 at 12:20 PM, Jan Blunck<jblunck@suse.de> wrote:
> On Sat, Sep 5, 2009 at 5:06 PM, Arnaldo Carvalho de Melo<acme@redhat.com> wrote:
>>
>> I did a quick port to tip/rt/head and couldn't reproduce the problems I
>> was experiencing, thanks!
>>
>> I've put the ported patch series at:
>>
>> http://userweb.kernel.org/~acme/rostedt-rb-rt
>>

Besides the problem with the wakeup tracer I see traces with
preemptirqsoff that I think are invalid:

# tracer: preemptirqsoff
#
# preemptirqsoff latency trace v1.1.5 on 2.6.31-rc8-rt9-rt_trace
# --------------------------------------------------------------------
# latency: 332 us, #4/4, CPU#24 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:32)
#    -----------------
#    | task: -0 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#  => started at: start_secondary
#  => ended at:   start_secondary
#
#
#                  _------=> CPU#
#                 / _-----=> irqs-off
#                | / _----=> need-resched
#                || / _---=> hardirq/softirq
#                ||| / _--=> preempt-depth
#                |||| /
#                |||||     delay
#  cmd     pid   ||||| time  |   caller
#     \   /      |||||   \   |   /
  <idle>-0      24.N.1    0us : cpu_idle <-start_secondary
  <idle>-0      24dN.1    1us!: tick_nohz_stop_idle <-tick_nohz_restart_sched_ti
ck
  <idle>-0      24dN.1  332us+: cpu_idle <-start_secondary
  <idle>-0      24dN.1  336us : trace_preempt_on <-start_secondary

I have set kernel.ftrace_enabled = 1 but still not a single function
is recorded in tick_nohz_stop_idle().

Any ideas?
