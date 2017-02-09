From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Thu, 09 Feb 2017 12:43:37 -0600
Message-ID: <1486665817.2871.150.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <20170209081327.0f0f4db4e5cb8f1b9be25338@kernel.org>
         <1486602862.2871.62.camel@tzanussi-mobl.amr.corp.intel.com>
         <y0mtw83v2uq.fsf@fche.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <y0mtw83v2uq.fsf@fche.csb>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Frank,

On Thu, 2017-02-09 at 09:46 -0500, Frank Ch. Eigler wrote:
> Hi, Tom -
> 
> 
> tom.zanussi wrote:
> 
> > [...]
> >> Hmm, this looks a bit hard to understand, I guess that onmatch() means
> >> "if there is an event which has ts0 variable and the event's key matches
> >> this key, take some action".
> >
> > Yes, that's pretty much it. It's essentially shorthand for this kind of
> > common idiom, where timestamp[] is an associative array, which in our
> > case is the tracing_map of the histogram: 
> >
> > event sched_wakeup()
> > {
> > 	ts0[wakeup_pid] = now()
> > }
> > event sched_switch()
> > {
> > 	if (ts0[next_pid])
> > 		latency = now() - ts0[next_pid] /* next_pid == wakeup_pid */
> > }
> 
> By the way, here is a working systemtap version of this demo:
> 
> # cat foo.stp
> global ts0%, latency%
> function now() { return gettimeofday_us() }
> 
> probe kernel.trace("sched_wakeup") { ts0[$p->pid] = now() }
> 
> probe kernel.trace("sched_switch") {
>    if (ts0[$next->pid])
>       latency[$next->pid,$next->prio] <<< now() - ts0[$next->pid];
> }
> 
> probe timer.s(5) {
>    foreach ([pid+,x] in latency) {
>       println("pid:", pid, " prio:", x)
>       print(@hist_log(latency[pid,x]))
>    }
>    delete latency
> }
> 
> 
> # stap foo.stp
> [...]
> pid:20183 prio:109
> value |-------------------------------------------------- count
>     2 |                                                   0
>     4 |                                                   0
>     8 |@                                                  1
>    16 |                                                   0
>    32 |                                                   0
> 
> pid:29095 prio:120
> value |-------------------------------------------------- count
>     0 |                                                    1
>     1 |@@@@                                                8
>     2 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             76
>     4 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     60
>     8 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                 68
>    16 |@@@@@@@@                                           16
>    32 |                                                    0
>    64 |                                                    0
> [...]
> 
> 

Nice!

> 
> 
> > ts0 is basically a per-table-entry variable - there's one for each
> > entry in the table, and it can only be accessed by events with
> > matching keys.  [...]  So, that's a long-winded way of saying that the
> > name ts0 is global across all tables (histograms) but an instance of
> > ts0 is local to each entry in the table that owns the name.
> 
> In systemtap, one of the things we take care of is automatic concurrency
> control over such shared variables.  Even if many CPUs run these same
> functions and try to access the same ts0/latency hash tables at the same
> time, things will work correctly.  I'm curious how your code deals with
> this.
> 

The hash tables used by the hist triggers this is based on are
themselves based on tracing_maps, which are lock-free hash tables, and
the variables themselves are atomic, so there shouldn't be any problems
with concurrent access, unless I'm missing something...

Tom 

> 
> - FChE
