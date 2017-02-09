From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Thu, 09 Feb 2017 11:18:32 -0600
Message-ID: <1486660712.2871.107.camel@tzanussi-mobl.amr.corp.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
         <20170209081327.0f0f4db4e5cb8f1b9be25338@kernel.org>
         <1486602862.2871.62.camel@tzanussi-mobl.amr.corp.intel.com>
         <20170209231837.c29ad7da3f1e73a1f8a245f4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:55053 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932358AbdBIRSw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Feb 2017 12:18:52 -0500
In-Reply-To: <20170209231837.c29ad7da3f1e73a1f8a245f4@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2017-02-09 at 23:18 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed, 08 Feb 2017 19:14:22 -0600
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > > > I'm submitting the patchset (based on tracing/for-next) as an RFC not
> > > > only to get comments, but because there are still some problems I
> > > > haven't fixed yet...
> > > > 
> > > > Here are some examples that should make things less abstract.
> > > > 
> > > >   ====
> > > >   Example - wakeup latency
> > > >   ====
> > > > 
> > > >   This basically implements the -RT latency_hist 'wakeup_latency'
> > > >   histogram using the synthetic events, variables, and actions
> > > >   described.  The output below is from a run of cyclictest using the
> > > >   following command:
> > > > 
> > > >     # rt-tests/cyclictest -p 80 -n -s -t 2
> > > > 
> > > >   What we're measuring the latency of is the time between when a
> > > >   thread (of cyclictest) is awakened and when it's scheduled in.  To
> > > >   do that we add triggers to sched_wakeup and sched_switch with the
> > > >   appropriate variables, and on a matching sched_switch event,
> > > >   generate a synthetic 'wakeup_latency' event.  Since it's just
> > > >   another trace event like any other, we can also define a histogram
> > > >   on that event, the output of which is what we see displayed when
> > > >   reading the wakeup_latency 'hist' file.
> > > > 
> > > >   First, we create a synthetic event called wakeup_latency, that
> > > >   references 3 variables from other events:
> > > > 
> > > >     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
> > > >                            pid=sched_switch:woken_pid \
> > > >                            prio=sched_switch:woken_prio' >> \
> > > >             /sys/kernel/debug/tracing/synthetic_events
> > > > 
> > > >   Next we add a trigger to sched_wakeup, which saves the value of the
> > > >   'common_timestamp' when that event is hit in a variable, ts0.  Note
> > > >   that this happens only when 'comm==cyclictest'.
> > > > 
> > > >   Also, 'common_timestamp' is a new field defined on every event (if
> > > >   needed - if there are no users of timestamps in a trace, timestamps
> > > >   won't be saved and there's no additional overhead from that).
> > > > 
> > > >     #  echo 'hist:keys=pid:ts0=common_timestamp.usecs if \
> > > >              comm=="cyclictest"' >> \
> > > >              /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> > > > 
> > > >   Next, we add a trigger to sched_switch.  When the pid being switched
> > > >   to matches the pid woken up by a previous sched_wakeup event, this
> > > >   event grabs the ts0 saved on that event, takes the difference
> > > >   between it and the current sched_switch's common_timestamp, and
> > > >   assigns it to a new 'wakeup_lat' variable.  It also saves a couple
> > > >   other variables and then invokes the onmatch().trace() action which
> > > >   generates a new wakeup_latency event using those variables.
> > > > 
> > > >     # echo 'hist:keys=woken_pid=next_pid:woken_prio=next_prio:\
> > > >        wakeup_lat=common_timestamp.usecs-ts0:onmatch().trace(wakeup_latency) \
> > > >             if next_comm=="cyclictest"' >> \
> > > >             /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> > > 
> > > Hmm, this looks a bit hard to understand, I guess that onmatch() means
> > > "if there is an event which has ts0 variable and the event's key matches
> > > this key, take some action".
> > 
> > Yes, that's pretty much it. It's essentially shorthand for this kind of
> > common idiom, where timestamp[] is an associative array, which in our
> > case is the tracing_map of the histogram: 
> > 
> > event sched_wakeup()
> > {
> > 	ts0[wakeup_pid] = now()
> > }
> > 
> > event sched_switch()
> > {
> > 	if (ts0[next_pid])
> > 		latency = now() - ts0[next_pid] /* next_pid == wakeup_pid */
> > }
> > 
> > Only if ts0 has already been set does the onmatch() get invoked - if ts0
> > hasn't been set, there's no match and the trace(wakeup_latency) doesn't
> > happen.
> 
> OK, it reminds me other questions.
> 
> - Even if there is no matched ts0, sched_switch's hist will store
>   woken_pid etc on its histogram map?

Yes, the match is just to invoke the onmatch() action, but the variables
are set regardless.

> - If there is matched ts0 and wakeup_latency event has been kicked,
>   the matched entry on ts0 is removed? and also in that case what
>   happens on sched_switch's hist?
> 

The entry isn't actually removed, but as far as ts0 goes, the result is
the same as if it had been - ts0 is a read-once variable, so once it's
used by the latency calculation, it's reset to an 'unset' after reading.
This essentially is how the 'if ts0[next_pid]' gets implemented -
actually, I should have added the implied removal to the pseudocode
above:

 	if (ts0[next_pid])
 		latency = now() - ts0[next_pid]
                ts0[next_pid] = null

The variables on sched_switch, since they aren't referenced by any
expression, aren't read-once, and just remain as they are.

I wanted to avoid making the user explicitly specify somehow whether a
variable was 'normal' or read-once, so I figured a simplifying
assumption could be that if the variable was referenced in an
expression, that means it should be read-once, while otherwise there's
no reason it should be read-once.

> > > I think there are 2 indefinate point that
> > > - Where the 'ts0' came from? what the variable will have 'global' scope?
> > 
> > ts0 is basically a per-table-entry variable - there's one for each entry
> > in the table, and it can only be accessed by events with matching keys.
> > The table owns the variable name, so you can't have two different tables
> > with the ts0 variable.
> 
> Would you mean 'ts0' is a special name?
> 

Not sure what you mean by a special name here...

> > So if we create a histogram on event1 and associate a variable ts0 with
> > it, any event hit on that histogram assigns to the corresponding entry's
> > ts0 instance. 
> > 
> > If we create a histogram on event2 which references ts0, it knows that
> > ts0 belongs to event1's histogram, and when there's a hit on event2, the
> > same key is used to look up the entry corresponding to that key on
> > event1, and if there's a matching entry, it grabs the value of ts0 from
> > that and subtracts it from the current event's value to produce the
> > latency or whatever it is.
> > 
> > So, that's a long-winded way of saying that the name ts0 is global
> > across all tables (histograms) but an instance of ts0 is local to each
> > entry in the table that owns the name.
> 
> Ah, what I concerned was the scope of name... not instance.
> 
> Hmm, in that case, what about other variables in sched_switch?
> it seems to have woken_pid,woken_prio and wakeup_lat. Are those also
> becomes global instance?

> Since I saw below definition, I expected those were not global.

Actually, internally, every variable is fully scoped as
system/event/var_name, and that's what those refer to.

To simplify things for the user, I didn't want to require the user to
have to fully qualify variable names in the triggers where there most
commonly used e.g. common_timestamp.usecs-sched_wakeup.ts0, so just made
the simplification that a variable should be globally unique, and
therefore didn't implement any scope parsing in the trigger, assuming
unique names.

But I agree, there is some inconsistency with that and the below -
variables probably shouldn't be global, and if there are two variabls
with the same name we should allow the user to resolve the ambiguity by
explicitly specifying the full system/event/var_name or event/var_name
which usually suffices.

> > > >     # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
> > > >                            pid=sched_switch:woken_pid \
> > > >                            prio=sched_switch:woken_prio' >> \
> > > >             /sys/kernel/debug/tracing/synthetic_events
> 
> And if so, it is very unsure for users to check what variables are
> already defined. I think we'd better to have a 'global'tag for ts0.
> 
> > > - What matches to what? onmatch() doesn't tell it.
> > > 
> > 
> > It's implied by the references to other events - in order for ts0 to be
> > resolved, it needs to find the match on event1.  Also, the synthetic
> > event has references to variables on other events - in order to generate
> > the synthetic event, those variables also need to be resolved to
> > matching events - note that variables can also come from the current
> > event as well.
> 
> I don't like such implications, which can make users lost in events easily,
> especially for triggers since we don't have the system-wide list of triggers.
> IMHO, since this interface is for a kind of programming, it should provide
> the abstract but consistent system model too. Implication will mislead
> users.

I think it might make a lot of sense at this point to actually create a
system-wide list of active triggers e.g. tracing/events/triggers or
something like that.  It's something I've kind of wanted anyway, and
would be really useful if not indispensable for this.  Actually, I
thought it might even be nice to have some kind of mini-fs or something
making it easy to group sets of related triggers and enable and
disable/remove them as a group, but a simple list would suffice too...

Tom   

> 
> > Hope that clears things up a bit (although the details under the covers
> > might seem confusing).
> 
> Thank you,
> 


