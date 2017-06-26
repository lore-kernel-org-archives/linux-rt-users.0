From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 00/32]  tracing: Inter-event (e.g. latency) support
Date: Mon, 26 Jun 2017 17:49:00 -0500
Message-ID: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2297 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbdFZWti (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 18:49:38 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patchset adds support for 'inter-event' quantities to the trace
event subsystem.  The most important example of inter-event quantities
are latencies, or the time differences between two events.

This is a follow-up to the initial RFC patchset and subsequent
discussion at ELC.  I think I've covered all the basic suggestions
from both those sources - thanks to everyone who reviewed and
contributed suggestions.  Also, thanks to Vedang Patel for testing and
providing real-user input and scripts - a number of the new patches
such as extended error reporting, cpu fields, and aliases address his
input directly.

The current patchset has been fairly well tested and I'm not aware of
any major problems with it, but there is one problem/feature to be
aware of, which has to do with the fact that currently the tracing map
can naturally have duplicate entries.  Normally this is expected and
isn't a problem for histograms without variables attached, as
duplicates are merged on output.  If a histogram has variables though
and gets a duplicate entry, the variable associated with that record
can't be trusted, since it can't be retrieved again.  Luckily
duplicates are normally very rare occurrences - I've never personally
seen one in practice - but it does mean that you always need to check
that the 'Duplicates' value on the histogram summary is 0 if that
histogram has variables attached.  We're currently working on a 'fix'
for this that basically eliminates the possibility of duplicates, but
for now the 'Duplicates' total will alert users to that rare situation
should it occur.

One of the main motivations for adding this capability is to provide a
general-purpose base that existing existing tools such as the -RT
latency_hist patchset can be built upon, while at the same time
providing a simple way for users to track latencies (or any
inter-event quantity) generically between any two events.

Previous -RT latency_hist patchsets that take advantage of the trace
event subsystem have been submitted, but they essentially hard-code
special-case tracepoints and application logic in ways that can't be
reused.  It seemed to me that rather than providing a one-off patchset
devoted specifically to generating the specific histograms in the
latency_hist patchset, it should be possible to build the same
functionality on top of a generic layer allowing users to do similar
things for other non-latency_hist applications.

In addition to preliminary patches that add some basic missing
functionality such as a common ringbuffer-derived timestamp and
dynamically-creatable tracepoints, the overall patchset is divided up
into a few different areas that combine to produce the overall goal
(The Documentation patch explains all the details):

  - variables and simple expressions required to calculate a latency

    In order to calculate a latency or any inter-event value,
    something from one event needs to be saved and later retrieved,
    and some operation such as subtraction or addition is performed on
    it.  This means some minimal form of variables and expressions,
    which the first set of patches implements.  Saving and retrieving
    events to use in a latency calculation is normally done using a
    hash table, and that's exactly what we have with trace event hist
    triggers, so that's where variables are instantiated, set, and
    retrieved.  Basically, variables are set on one entry and
    retrieved and used by a 'matching' event.

  - 'synthetic' events, combining variables from other events

    The trace event interface is based on pseudo-files associated with
    individual events, so it wouldn't really make sense to have
    quantities derived from multiple events attached to any one of
    those events.  For that reason, the patchset implements a means of
    combining variables from other events into a separate 'synthetic'
    event, which can be treated as if it were just like any other
    trace event in the system.

  - 'actions' generating synthetic events, among other things

    Variables and synthetic events provide the data and data structure
    for new events, but something still needs to actually generate an
    event using that data.  'Actions' are expanded to provide that
    capability.  Though it hasn't been explicitly called as much
    before, the default 'action' currently for a hist trigger is to
    update the matching histogram entry's sum values.  This patchset
    essentially expands that to provide a new 'onmatch.event(params)'
    action that can be used to have one event generate another.  The
    mechanism is extensible to other actions, and in fact the patchset
    also includes another, 'onmax(var).save(field,...)' that can be
    used to save context whenever a value exceeds the previous maximum
    (something also needed by latency_hist).

Here are some examples that should make things less abstract.

  ====
  Example - wakeup latency
  ====

  This basically implements the -RT latency_hist 'wakeup_latency'
  histogram using the synthetic events, variables, and actions
  described.  The output below is from a run of cyclictest using the
  following command:

    # rt-tests/cyclictest -p 80 -n -s -t 2

  What we're measuring the latency of is the time between when a
  thread (of cyclictest) is awakened and when it's scheduled in.  To
  do that we add triggers to sched_wakeup and sched_switch with the
  appropriate variables, and on a matching sched_switch event,
  generate a synthetic 'wakeup_latency' event.  Since it's just
  another trace event like any other, we can also define a histogram
  on that event, the output of which is what we see displayed when
  reading the wakeup_latency 'hist' file.

  First, we create a synthetic event called wakeup_latency, that
  creates 3 fields which will reference variables from other events:

    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
        /sys/kernel/debug/tracing/synthetic_events

  Next we add a trigger to sched_wakeup, which saves the value of the
  '$common_timestamp' when that event is hit in a variable, ts0.  Note
  that this happens only when 'comm==cyclictest'.

  Also, '$common_timestamp' is a new field defined on every event (if
  needed - if there are no users of timestamps in a trace, timestamps
  won't be saved and there's no additional overhead from that).

    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

  Next, we add a trigger to sched_switch.  When the pid being switched
  to matches the pid woken up by a previous sched_wakeup event, this
  event grabs the ts0 variable saved on that event, takes the
  difference between it and the current sched_switch's
  $common_timestamp, and assigns it to a new 'wakeup_lat' variable.
  It then generates the wakeup_latency synthetic event defined earlier
  by 'invoking' it as a function using as parameters the wakeup_lat
  variable and two sched_switch event fields directly:

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0: \
        onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_prio) \
        if next_comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

  Finally, all we have left to do is create a standard histogram
  simply naming the fields of the wakeup_latency synthetic event:

    # echo 'hist:keys=pid,prio,lat:sort=pid,lat' >> \
        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger

  At any time, we can see the histogram output by simply reading the
  synthetic/wakeup_latency/hist file:

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,prio,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       2519, prio:        120, lat:          1 } hitcount:         12
    { pid:       2519, prio:        120, lat:          2 } hitcount:        671
    { pid:       2519, prio:        120, lat:          3 } hitcount:        588
    { pid:       2519, prio:        120, lat:          4 } hitcount:        202
    { pid:       2519, prio:        120, lat:          5 } hitcount:         28
    { pid:       2519, prio:        120, lat:          6 } hitcount:         13
    { pid:       2519, prio:        120, lat:          7 } hitcount:         12
    { pid:       2519, prio:        120, lat:          8 } hitcount:          7
    { pid:       2519, prio:        120, lat:          9 } hitcount:         12
    { pid:       2519, prio:        120, lat:         10 } hitcount:         11
    { pid:       2519, prio:        120, lat:         11 } hitcount:          7
    { pid:       2519, prio:        120, lat:         12 } hitcount:          6
    { pid:       2519, prio:        120, lat:         13 } hitcount:          1
    { pid:       2519, prio:        120, lat:         17 } hitcount:          1
    { pid:       2519, prio:        120, lat:         18 } hitcount:          3
    { pid:       2519, prio:        120, lat:         19 } hitcount:          2
    { pid:       2519, prio:        120, lat:         22 } hitcount:          2
    { pid:       2519, prio:        120, lat:         23 } hitcount:          1
    { pid:       2519, prio:        120, lat:         24 } hitcount:          1
    { pid:       2519, prio:        120, lat:         27 } hitcount:          1
    { pid:       2519, prio:        120, lat:         34 } hitcount:          1
    { pid:       2519, prio:        120, lat:         53 } hitcount:          1
    { pid:       2519, prio:        120, lat:         67 } hitcount:          1
    { pid:       2519, prio:        120, lat:         69 } hitcount:          1
    { pid:       2521, prio:         19, lat:          1 } hitcount:        735
    { pid:       2521, prio:         19, lat:          2 } hitcount:       8978
    { pid:       2521, prio:         19, lat:          3 } hitcount:       4798
    { pid:       2521, prio:         19, lat:          4 } hitcount:        716
    { pid:       2521, prio:         19, lat:          5 } hitcount:        298
    { pid:       2521, prio:         19, lat:          6 } hitcount:        136
    { pid:       2521, prio:         19, lat:          7 } hitcount:         93
    { pid:       2521, prio:         19, lat:          8 } hitcount:         51
    { pid:       2521, prio:         19, lat:          9 } hitcount:         20
    { pid:       2521, prio:         19, lat:         10 } hitcount:         18
    { pid:       2521, prio:         19, lat:         11 } hitcount:          3
    { pid:       2521, prio:         19, lat:         12 } hitcount:          1
    { pid:       2521, prio:         19, lat:         13 } hitcount:          3
    { pid:       2521, prio:         19, lat:         15 } hitcount:          1
    { pid:       2521, prio:         19, lat:         17 } hitcount:          1
    { pid:       2521, prio:         19, lat:         18 } hitcount:          1
    { pid:       2521, prio:         19, lat:         20 } hitcount:          2
    { pid:       2521, prio:         19, lat:         22 } hitcount:          1
    { pid:       2521, prio:         19, lat:         25 } hitcount:          1
    { pid:       2521, prio:         19, lat:         26 } hitcount:          1
    { pid:       2522, prio:         19, lat:          1 } hitcount:        392
    { pid:       2522, prio:         19, lat:          2 } hitcount:       5376
    { pid:       2522, prio:         19, lat:          3 } hitcount:       3982
    { pid:       2522, prio:         19, lat:          4 } hitcount:        500
    { pid:       2522, prio:         19, lat:          5 } hitcount:        202
    { pid:       2522, prio:         19, lat:          6 } hitcount:         67
    { pid:       2522, prio:         19, lat:          7 } hitcount:         35
    { pid:       2522, prio:         19, lat:          8 } hitcount:         12
    { pid:       2522, prio:         19, lat:          9 } hitcount:          9
    { pid:       2522, prio:         19, lat:         10 } hitcount:          4
    { pid:       2522, prio:         19, lat:         11 } hitcount:          3
    { pid:       2522, prio:         19, lat:         12 } hitcount:          1
    { pid:       2522, prio:         19, lat:         13 } hitcount:          1
    { pid:       2522, prio:         19, lat:         16 } hitcount:          1
    { pid:       2522, prio:         19, lat:         18 } hitcount:          2
    { pid:       2522, prio:         19, lat:         19 } hitcount:          1
    { pid:       2522, prio:         19, lat:         21 } hitcount:          2
    { pid:       2522, prio:         19, lat:         22 } hitcount:          1
    { pid:       2522, prio:         19, lat:         23 } hitcount:          1
    { pid:       2522, prio:         19, lat:         45 } hitcount:          1
    { pid:       2522, prio:         19, lat:         82 } hitcount:          1

    Totals:
        Hits: 28037
        Entries: 65
        Dropped: 0
        Duplicates: 0

  The above output uses the .usecs modifier to common_timestamp, so
  the latencies are reported in microseconds.  The default, without
  the modifier, is nanoseconds, but that's too fine-grained to put
  directly into a histogram - for that however we can use the .log2
  modifier on the 'lat' key.  Otherwise the rest is the same:

    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
        /sys/kernel/debug/tracing/synthetic_events

    # echo 'hist:keys=pid:ts0=$common_timestamp if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp-$ts0: \
        onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_prio) \
        if next_comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

    # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,prio,lat.log2:vals=hitcount:sort=pid,lat.log2:size=2048 [active]
    #

    { pid:       2585, prio:        120, lat: ~ 2^10 } hitcount:          1
    { pid:       2585, prio:        120, lat: ~ 2^11 } hitcount:        379
    { pid:       2585, prio:        120, lat: ~ 2^12 } hitcount:       1008
    { pid:       2585, prio:        120, lat: ~ 2^13 } hitcount:         42
    { pid:       2585, prio:        120, lat: ~ 2^14 } hitcount:         18
    { pid:       2585, prio:        120, lat: ~ 2^15 } hitcount:          3
    { pid:       2585, prio:        120, lat: ~ 2^16 } hitcount:          1
    { pid:       2586, prio:         19, lat: ~ 2^11 } hitcount:       4715
    { pid:       2586, prio:         19, lat: ~ 2^12 } hitcount:       9161
    { pid:       2586, prio:         19, lat: ~ 2^13 } hitcount:        632
    { pid:       2586, prio:         19, lat: ~ 2^14 } hitcount:         47
    { pid:       2586, prio:         19, lat: ~ 2^15 } hitcount:          3
    { pid:       2586, prio:         19, lat: ~ 2^17 } hitcount:          1
    { pid:       2587, prio:         19, lat: ~ 2^11 } hitcount:       3398
    { pid:       2587, prio:         19, lat: ~ 2^12 } hitcount:       5762
    { pid:       2587, prio:         19, lat: ~ 2^13 } hitcount:        505
    { pid:       2587, prio:         19, lat: ~ 2^14 } hitcount:         58
    { pid:       2587, prio:         19, lat: ~ 2^15 } hitcount:          3
    { pid:       2587, prio:         19, lat: ~ 2^17 } hitcount:          1

    Totals:
        Hits: 25738
        Entries: 19
        Dropped: 0
        Duplicates: 0

  ====
  Example - wakeup latency with onmax()
  ====

  This example is the same as the previous ones, but here we're
  additionally using the onmax() action to save some context (several
  fields of the sched_switch event) whenever the latency (wakeup_lat)
  exceeds the previous maximum.

  As with the similar functionality of the -RT latency_hist
  histograms, it's useful to be able to capture information about the
  previous process, which potentially could have contributed to the
  maximum latency that was saved.

    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
        /sys/kernel/debug/tracing/synthetic_events

    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

  Here we add an onmax() action that saves some important fields of
  the sched_switch event along with the maximum, in addition to
  sending some of the same data to the synthetic event:

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0: \
        onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm): \
	onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid,next_prio) \
	if next_comm=="cyclictest"' >> \
	/sys/kernel/debug/tracing/events/sched/sched_switch/trigger

    # echo 'hist:keys=pid,prio,lat:sort=pid,lat' >> \
        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger

  To see the maximums and associated data for each pid, cat the
  sched_switch event, as that's the event the onmax() action is
  associated with:

    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

    # event histogram
    #

    { next_pid:       6173 } hitcount:        199
      max:         14  next_comm: cyclictest  prev_pid:          0 \
      prev_prio:        120  prev_comm: swapper/2
    { next_pid:       6175 } hitcount:       1327
      max:         15  next_comm: cyclictest  prev_pid:          0 \
      prev_prio:        120  prev_comm: swapper/2
    { next_pid:       6174 } hitcount:       1985
      max:         30  next_comm: cyclictest  prev_pid:          0 \
      prev_prio:        120  prev_comm: swapper/3

    Totals:
        Hits: 17555
        Entries: 3
        Dropped: 0
        Duplicates: 0

  And, verifying, we can see that the max latencies captured above
  match the highest latencies for each thread in the wakeup_latency
  histogram:

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,prio,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       6173, prio:        120, lat:          1 } hitcount:          2
    { pid:       6173, prio:        120, lat:          2 } hitcount:         82
    { pid:       6173, prio:        120, lat:          3 } hitcount:         84
    ...
    { pid:       6173, prio:        120, lat:         14 } hitcount:          1
    { pid:       6174, prio:         19, lat:          1 } hitcount:         23
    { pid:       6174, prio:         19, lat:          2 } hitcount:        749
    ...
    { pid:       6174, prio:         19, lat:         30 } hitcount:          1
    { pid:       6175, prio:         19, lat:          1 } hitcount:         20
    { pid:       6175, prio:         19, lat:          2 } hitcount:        633
    ...
    { pid:       6175, prio:         19, lat:         15 } hitcount:          1

    Totals:
        Hits: 3511
        Entries: 38
        Dropped: 0
        Duplicates: 0

  ====
  Example - combined wakeup and switchtime (wakeupswitch) latency
  ====

  Finally, this example is quite a bit more involved, but that's
  because it implements 3 latencies, one which is a combination of the
  other two.  This also, is something that the -RT latency_hist
  patchset does and which this patchset adds generic support for.

  The latency_hist patchset creates a few individual latency
  histograms but also combines them into larger overall combined
  histograms.  For example, the time between when a thread is awakened
  and when it actually continues executing in userspace is something
  covered by a histogram, but it's also broken down into two
  sub-histograms, one covering the time between sched_wakeup and the
  time the thread is scheduled in (wakeup_latency as above), and the
  time between when the thread is scheduled in and the time it
  actually begins executing again (return from sys_nanosleep), covered
  by a separate switchtime_latency histogram.

  The below combines the wakeup_latency histogram from before, adds a
  new switchtime_latency histogram, and another, wakeupswitch_latency,
  that's a combination of the other two.

  There isn't anything really new here, other than that the use of the
  addition operator to add two latencies to produce the
  wakeupswitch_latency.

  First, we create the familiar wakeup_latency histogram:

    # echo 'wakeup_latency u64 lat; pid_t pid' >> \
        /sys/kernel/debug/tracing/synthetic_events

    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs \
        if comm=="cyclictest"' >> \
	/sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:\
        onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid) \
	if next_comm=="cyclictest"' >> \
	/sys/kernel/debug/tracing/events/sched/sched_switch/trigger

  Here we save the wakeup_latency lat value as wakeup_lat for use
  later in the combined latency:

    # echo 'hist:keys=pid,lat:wakeup_lat=lat:sort=pid,lat' \
        >> /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger

  Next, we create the switchtime_latency histogram:

    # echo 'switchtime_latency u64 lat; pid_t pid' >> \
        /sys/kernel/debug/tracing/synthetic_events

  Here we save the sched_switch next_pid field as 'pid'.  This is so
  we can access the next_pid in the matching sys_exit_nanosleep event.

    # echo 'hist:keys=next_pid:pid=next_pid:ts0=$common_timestamp.usecs \
        if next_comm=="cyclictest"' >> \
	/sys/kernel/debug/tracing/events/sched/sched_switch/trigger

    # echo 'hist:keys=common_pid:switchtime_lat=$common_timestamp.usecs-$ts0: \
        onmatch(sched.sched_switch).switchtime_latency($switchtime_lat,$pid)' \
	>> /sys/kernel/debug/tracing/events/syscalls/sys_exit_nanosleep/trigger

    # echo 'hist:keys=pid,lat:sort=pid,lat' \
        >> /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/trigger

  Finally, we create the combined wakeupswitch_latency:

    # echo 'wakeupswitch_latency u64 lat; pid_t pid' >> \
        /sys/kernel/debug/tracing/synthetic_events

  Here we calculate the combined latency using the saved $wakeup_lat
  variable from the wakeup_latency histogram and the lat value of the
  switchtime_latency, save it as ws_lat and then use it to generate
  the combined wakeupswitch latency:

    # echo 'hist:keys=pid,lat:sort=pid,lat:ws_lat=$wakeup_lat+lat: \
        onmatch(synthetic.wakeup_latency).wakeupswitch_latency($ws_lat,pid)' \
	>> /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/trigger

    # echo 'hist:keys=pid,lat:sort=pid,lat' >> \
    /sys/kernel/debug/tracing/events/synthetic/wakeupswitch_latency/trigger


  After running our cyclictest workload, we can now look at each
  histogram, starting with wakeup_latency:

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:wakeup_lat=lat:sort=pid,lat:size=2048 [active]
    #

    { pid:       6852, lat:          1 } hitcount:          2
    { pid:       6852, lat:          2 } hitcount:         88
    { pid:       6852, lat:          3 } hitcount:         72
    { pid:       6852, lat:          4 } hitcount:         19
    { pid:       6852, lat:          5 } hitcount:         10
    { pid:       6852, lat:          6 } hitcount:          1
    { pid:       6852, lat:          7 } hitcount:          4
    { pid:       6852, lat:          9 } hitcount:          2
    { pid:       6852, lat:         10 } hitcount:          1
    { pid:       6853, lat:          1 } hitcount:          1
    { pid:       6853, lat:          2 } hitcount:        535
    { pid:       6853, lat:          3 } hitcount:       1007
    ...
    { pid:       6853, lat:         19 } hitcount:          1
    { pid:       6853, lat:         20 } hitcount:          1
    { pid:       6853, lat:         29 } hitcount:          1
    { pid:       6854, lat:          1 } hitcount:          5
    { pid:       6854, lat:          2 } hitcount:        552
    { pid:       6854, lat:          3 } hitcount:        532
    { pid:       6854, lat:          4 } hitcount:        135
    { pid:       6854, lat:          5 } hitcount:         48
    { pid:       6854, lat:          6 } hitcount:         18
    { pid:       6854, lat:          7 } hitcount:         12
    { pid:       6854, lat:          8 } hitcount:          5
    ...
    { pid:       6854, lat:         29 } hitcount:          2
    { pid:       6854, lat:         48 } hitcount:          1

    Totals:
    Hits: 3501
    Entries: 46
    Dropped: 0
    Duplicates: 0

  Here's the switchtime histogram:

    # cat /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       6852, lat:          1 } hitcount:          1
    { pid:       6852, lat:          2 } hitcount:         33
    { pid:       6852, lat:          3 } hitcount:         73
    { pid:       6852, lat:          4 } hitcount:         49
    { pid:       6852, lat:          5 } hitcount:         28
    { pid:       6852, lat:          6 } hitcount:          4
    ...
    { pid:       6852, lat:         16 } hitcount:          1
    { pid:       6853, lat:          1 } hitcount:         76
    { pid:       6853, lat:          2 } hitcount:       1190
    { pid:       6853, lat:          3 } hitcount:        475
    { pid:       6853, lat:          4 } hitcount:        125
    { pid:       6853, lat:          5 } hitcount:         40
    { pid:       6853, lat:          6 } hitcount:         21
    { pid:       6853, lat:          7 } hitcount:         13
    { pid:       6853, lat:          8 } hitcount:          5
    { pid:       6853, lat:          9 } hitcount:         11
    ...
    { pid:       6853, lat:         20 } hitcount:          2
    { pid:       6854, lat:          1 } hitcount:         13
    { pid:       6854, lat:          2 } hitcount:        799
    { pid:       6854, lat:          3 } hitcount:        332
    { pid:       6854, lat:          4 } hitcount:         97
    { pid:       6854, lat:          5 } hitcount:         29
    { pid:       6854, lat:          6 } hitcount:         16
    ...
    { pid:       6854, lat:         22 } hitcount:          1
    { pid:       6854, lat:         26 } hitcount:          1

    Totals:
    Hits: 3501
    Entries: 48
    Dropped: 0
    Duplicates: 0

  And here's the combined wakeupswitch latency histogram:

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeupswitch_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       6852, lat:          4 } hitcount:         24
    { pid:       6852, lat:          5 } hitcount:         47
    { pid:       6852, lat:          6 } hitcount:         53
    { pid:       6852, lat:          7 } hitcount:         29
    ...
    { pid:       6852, lat:         25 } hitcount:          1
    { pid:       6853, lat:          3 } hitcount:          5
    { pid:       6853, lat:          4 } hitcount:        504
    { pid:       6853, lat:          5 } hitcount:        753
    { pid:       6853, lat:          6 } hitcount:        337
    { pid:       6853, lat:          7 } hitcount:        149
    { pid:       6853, lat:          8 } hitcount:         66
    { pid:       6853, lat:          9 } hitcount:         45
    { pid:       6853, lat:         10 } hitcount:         24
    { pid:       6853, lat:         11 } hitcount:         26
    { pid:       6853, lat:         12 } hitcount:          9
    { pid:       6853, lat:         13 } hitcount:         13
    { pid:       6853, lat:         14 } hitcount:          9
    { pid:       6853, lat:         15 } hitcount:          3
    { pid:       6853, lat:         17 } hitcount:          3
    { pid:       6853, lat:         18 } hitcount:          5
    { pid:       6853, lat:         19 } hitcount:          2
    ...
    { pid:       6853, lat:         37 } hitcount:          1
    { pid:       6853, lat:         38 } hitcount:          1
    { pid:       6854, lat:          3 } hitcount:          7
    { pid:       6854, lat:          4 } hitcount:        418
    { pid:       6854, lat:          5 } hitcount:        493
    { pid:       6854, lat:          6 } hitcount:        165
    { pid:       6854, lat:          7 } hitcount:         81
    { pid:       6854, lat:          8 } hitcount:         57
    { pid:       6854, lat:          9 } hitcount:         27
    { pid:       6854, lat:         10 } hitcount:         15
    { pid:       6854, lat:         11 } hitcount:         13
    { pid:       6854, lat:         12 } hitcount:          7
    { pid:       6854, lat:         13 } hitcount:         10
    { pid:       6854, lat:         14 } hitcount:          6
    { pid:       6854, lat:         15 } hitcount:          5
    { pid:       6854, lat:         16 } hitcount:          5
    { pid:       6854, lat:         17 } hitcount:          2
    { pid:       6854, lat:         18 } hitcount:          1
    ...
    { pid:       6854, lat:         55 } hitcount:          1

    Totals:
    Hits: 3501
    Entries: 70
    Dropped: 0
    Duplicates: 0

  Finally, just to show that synthetic events are indeed just like any
  other event as far as the event subsystem is concerned, we can
  enable the synthetic events and see the events appear in the trace
  buffer:

    # echo 1 > /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/enable
    # echo 1 > /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/enable
    # echo 1 > /sys/kernel/debug/tracing/events/synthetic/wakeupswitch_latency/enable

  Below is a snippet of the contents of the trace file produced when
  the above histograms were generated:

    # cat /sys/kernel/debug/tracing/trace

    # tracer: nop
    #
    # entries-in-buffer/entries-written: 10503/10503   #P:4
    #
    #                              _-----=> irqs-off
    #                             / _----=> need-resched
    #                            | / _---=> hardirq/softirq
    #                            || / _--=> preempt-depth
    #                            ||| /     delay
    #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
    #              | |       |   ||||       |         |
              <idle>-0     [001] d..2 23532.240146: wakeup_latency: lat=4, pid=6853
          cyclictest-6853  [001] .... 23532.240153: switchtime_latency: lat=7, pid=6853
          cyclictest-6853  [001] .... 23532.240157: wakeupswitch_latency: lat=11, pid=6853
     gnome-terminal--2500  [001] d..2 23532.240672: wakeup_latency: lat=5, pid=6854
          cyclictest-6854  [001] .... 23532.240676: switchtime_latency: lat=4, pid=6854
          cyclictest-6854  [001] .... 23532.240677: wakeupswitch_latency: lat=9, pid=6854
     gnome-terminal--2500  [001] d..2 23532.241169: wakeup_latency: lat=4, pid=6853
          cyclictest-6853  [001] .... 23532.241172: switchtime_latency: lat=3, pid=6853
          cyclictest-6853  [001] .... 23532.241174: wakeupswitch_latency: lat=7, pid=6853
              <idle>-0     [001] d..2 23532.242189: wakeup_latency: lat=6, pid=6853
          cyclictest-6853  [001] .... 23532.242195: switchtime_latency: lat=8, pid=6853
              <idle>-0     [000] d..2 23532.242196: wakeup_latency: lat=12, pid=6854
          cyclictest-6853  [001] .... 23532.240146: wakeupswitch_latency: lat=14, pid=6853
          cyclictest-6854  [000] .... 23532.242196: switchtime_latency: lat=4, pid=6854
              <idle>-0     [001] d..2 23532.240146: wakeup_latency: lat=2, pid=6853
          cyclictest-6854  [000] .... 23532.242196: wakeupswitch_latency: lat=16, pid=6854
          cyclictest-6853  [001] .... 23532.240146: switchtime_latency: lat=3, pid=6853
    ...

  One quick note about usage - the introduction of variables and
  actions obviously makes it harder to determine the cause of a hist
  trigger command failure - 'Invalid argument' is no longer sufficient
  in many cases.

  For that reason, a new 'extended error' mechanism has been added to
  hist triggers, initially focused on variable and action-related
  errors, but something that could possibly expanded to other error
  conditions later.

  To make use of it, simply read the 'hist' file of the event that was
  the target of the command.

  In this example, we've entered the same command twice, resulting in
  an attempt to define the same variable (ts0) twice.  After seeing
  the 'Invalid argument' error for the command, we read the same
  event's hist file and see a message to that effect at the bottom of
  the file:

    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

    -su: echo: write error: Invalid argument

    # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
    # event histogram
    #
    #

    Totals:
    Hits: 0
    Entries: 0
    Dropped: 0
    Duplicates: 0

    ERROR: Variable already defined: ts0
      Last command: keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"


The following changes since commit 681bec0367c2606b6154060310a2ffa543175980:

  tracing: Rename update the enum_map file (2017-06-13 17:13:06 -0400)

are available in the git repository at:

  https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/inter-event-v01
  https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-v01

Tom Zanussi (32):
  tracing: Add hist_field_name() accessor
  tracing: Reimplement log2
  ring-buffer: Add interface for setting absolute time stamps
  ring-buffer: Redefine the unimplemented RINGBUF_TIME_TIME_STAMP
  tracing: Give event triggers access to ring_buffer_event
  tracing: Add ring buffer event param to hist field functions
  tracing: Increase tracing map KEYS_MAX size
  tracing: Break out hist trigger assignment parsing
  tracing: Make traceprobe parsing code reusable
  tracing: Add NO_DISCARD event file flag
  tracing: Add post-trigger flag to hist trigger command
  tracing: Add hist trigger timestamp support
  tracing: Add per-element variable support to tracing_map
  tracing: Add hist_data member to hist_field
  tracing: Add usecs modifier for hist trigger timestamps
  tracing: Add variable support to hist triggers
  tracing: Account for variables in named trigger compatibility
  tracing: Add simple expression support to hist triggers
  tracing: Add variable reference handling to hist triggers
  tracing: Add support for dynamic tracepoints
  tracing: Add hist trigger action hook
  tracing: Add support for 'synthetic' events
  tracing: Add 'onmatch' hist trigger action support
  tracing: Add 'onmax' hist trigger action support
  tracing: Allow whitespace to surround hist trigger filter
  tracing: Make duplicate count from tracing_map available
  tracing: Add cpu field for hist triggers
  tracing: Add hist trigger support for variable reference aliases
  tracing: Add 'last error' error facility for hist triggers
  tracing: Add inter-event hist trigger Documentation
  tracing: Make tracing_set_clock() non-static
  tracing: Add a clock attribute for hist triggers

 Documentation/trace/events.txt      |  422 ++++
 include/linux/ring_buffer.h         |   14 +-
 include/linux/trace_events.h        |   17 +-
 include/linux/tracepoint.h          |   11 +-
 kernel/trace/ring_buffer.c          |  118 +-
 kernel/trace/trace.c                |  121 +-
 kernel/trace/trace.h                |   36 +-
 kernel/trace/trace_events.c         |    4 +-
 kernel/trace/trace_events_hist.c    | 4107 ++++++++++++++++++++++++++++++++---
 kernel/trace/trace_events_trigger.c |   69 +-
 kernel/trace/trace_kprobe.c         |   18 +-
 kernel/trace/trace_probe.c          |   86 -
 kernel/trace/trace_probe.h          |    7 -
 kernel/trace/trace_uprobe.c         |    2 +-
 kernel/trace/tracing_map.c          |  125 +-
 kernel/trace/tracing_map.h          |   16 +-
 kernel/tracepoint.c                 |   42 +-
 17 files changed, 4684 insertions(+), 531 deletions(-)

-- 
1.9.3

