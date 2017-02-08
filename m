From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Thu, 9 Feb 2017 08:13:27 +0900
Message-ID: <20170209081327.0f0f4db4e5cb8f1b9be25338@kernel.org>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On Wed,  8 Feb 2017 11:24:56 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> This patchset adds support for 'inter-event' quantities to the trace
> event subsystem.  The most important example of inter-event quantities
> are latencies, or the time differences between two events.

Great! This is what I dream! :)
I'd like to use it. 

>   - 'actions' generating synthetic events, among other things
> 
>     Variables and synthetic events provide the data and data structure
>     for new events, but something still needs to actually generate an
>     event using that data.  'Actions' are expanded to provide that
>     capability.  Though it hasn't been explicitly called as much
>     before, the default 'action' currently for a hist trigger is to
>     update the matching histogram entry's sum values.  This patchset
>     essentially expands that to provide a new 'onmatch.trace(event)'
>     action that can be used to have one event generate another.  The
>     mechanism is extensible to other actions, and in fact the patchset
>     also includes another, 'onmax(var).save(field,...)' that can be
>     used to save context whenever a value exceeds the previous maximum
>     (something also needed by latency_hist).

BTW, I would like to comment on this grammer.

> 
> I'm submitting the patchset (based on tracing/for-next) as an RFC not
> only to get comments, but because there are still some problems I
> haven't fixed yet...
> 
> Here are some examples that should make things less abstract.
> 
>   ====
>   Example - wakeup latency
>   ====
> 
>   This basically implements the -RT latency_hist 'wakeup_latency'
>   histogram using the synthetic events, variables, and actions
>   described.  The output below is from a run of cyclictest using the
>   following command:
> 
>     # rt-tests/cyclictest -p 80 -n -s -t 2
> 
>   What we're measuring the latency of is the time between when a
>   thread (of cyclictest) is awakened and when it's scheduled in.  To
>   do that we add triggers to sched_wakeup and sched_switch with the
>   appropriate variables, and on a matching sched_switch event,
>   generate a synthetic 'wakeup_latency' event.  Since it's just
>   another trace event like any other, we can also define a histogram
>   on that event, the output of which is what we see displayed when
>   reading the wakeup_latency 'hist' file.
> 
>   First, we create a synthetic event called wakeup_latency, that
>   references 3 variables from other events:
> 
>     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
>                            pid=sched_switch:woken_pid \
>                            prio=sched_switch:woken_prio' >> \
>             /sys/kernel/debug/tracing/synthetic_events
> 
>   Next we add a trigger to sched_wakeup, which saves the value of the
>   'common_timestamp' when that event is hit in a variable, ts0.  Note
>   that this happens only when 'comm==cyclictest'.
> 
>   Also, 'common_timestamp' is a new field defined on every event (if
>   needed - if there are no users of timestamps in a trace, timestamps
>   won't be saved and there's no additional overhead from that).
> 
>     #  echo 'hist:keys=pid:ts0=common_timestamp.usecs if \
>              comm=="cyclictest"' >> \
>              /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> 
>   Next, we add a trigger to sched_switch.  When the pid being switched
>   to matches the pid woken up by a previous sched_wakeup event, this
>   event grabs the ts0 saved on that event, takes the difference
>   between it and the current sched_switch's common_timestamp, and
>   assigns it to a new 'wakeup_lat' variable.  It also saves a couple
>   other variables and then invokes the onmatch().trace() action which
>   generates a new wakeup_latency event using those variables.
> 
>     # echo 'hist:keys=woken_pid=next_pid:woken_prio=next_prio:\
>        wakeup_lat=common_timestamp.usecs-ts0:onmatch().trace(wakeup_latency) \
>             if next_comm=="cyclictest"' >> \
>             /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

Hmm, this looks a bit hard to understand, I guess that onmatch() means
"if there is an event which has ts0 variable and the event's key matches
this key, take some action".
I think there are 2 indefinate point that
- Where the 'ts0' came from? what the variable will have 'global' scope?
- What matches to what? onmatch() doesn't tell it.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
