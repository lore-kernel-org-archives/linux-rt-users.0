From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 00/21] tracing: Inter-event (e.g. latency) support
Date: Wed,  8 Feb 2017 11:24:56 -0600
Message-ID: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patchset adds support for 'inter-event' quantities to the trace
event subsystem.  The most important example of inter-event quantities
are latencies, or the time differences between two events.

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
    essentially expands that to provide a new 'onmatch.trace(event)'
    action that can be used to have one event generate another.  The
    mechanism is extensible to other actions, and in fact the patchset
    also includes another, 'onmax(var).save(field,...)' that can be
    used to save context whenever a value exceeds the previous maximum
    (something also needed by latency_hist).

I'm submitting the patchset (based on tracing/for-next) as an RFC not
only to get comments, but because there are still some problems I
haven't fixed yet...

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
  references 3 variables from other events:

    # echo 'wakeup_latency lat=sched_switch:wakeup_lat \
                           pid=sched_switch:woken_pid \
                           prio=sched_switch:woken_prio' >> \
            /sys/kernel/debug/tracing/synthetic_events

  Next we add a trigger to sched_wakeup, which saves the value of the
  'common_timestamp' when that event is hit in a variable, ts0.  Note
  that this happens only when 'comm==cyclictest'.

  Also, 'common_timestamp' is a new field defined on every event (if
  needed - if there are no users of timestamps in a trace, timestamps
  won't be saved and there's no additional overhead from that).

    #  echo 'hist:keys=pid:ts0=common_timestamp.usecs if \
             comm=="cyclictest"' >> \
             /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

  Next, we add a trigger to sched_switch.  When the pid being switched
  to matches the pid woken up by a previous sched_wakeup event, this
  event grabs the ts0 saved on that event, takes the difference
  between it and the current sched_switch's common_timestamp, and
  assigns it to a new 'wakeup_lat' variable.  It also saves a couple
  other variables and then invokes the onmatch().trace() action which
  generates a new wakeup_latency event using those variables.

    # echo 'hist:keys=woken_pid=next_pid:woken_prio=next_prio:\
       wakeup_lat=common_timestamp.usecs-ts0:onmatch().trace(wakeup_latency) \
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

  The above output uses the .usecs modifier to common_timestamp, so
  the latencies are reported in microseconds.  The default, without
  the modifier, is nanoseconds, but that's too fine-grained to put
  directly into a histogram - for that however we can use the .log2
  modifier on the 'lat' key.  Otherwise the rest is the same:

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


  ====
  Example - wakeup latency with onmax()
  ====

  This example is the same as the previous ones, but here we're using
  the onmax() action to save some context (several fields of the
  sched_switch event) whenever the latency (wakeup_lat) exceeds the
  previous maximum.

  As with the similar functionality of the -RT latency_hist
  histograms, it's useful to be able to capture information about the
  previous process, which potentially could have contributed to the
  maximum latency that was saved.

    # echo 'hist:keys=woken_pid=next_pid:woken_prio=next_prio: \
            wakeup_lat=common_timestamp.usecs-ts0:\
            onmax(wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
            if next_comm=="cyclictest"' >> \
            /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

    # event histogram
    #

    { next_pid:       3519 } hitcount:       2453  next_prio:          0 \
                             common_timestamp-ts0: 12785539665130611
	max:         79  next_comm: cyclictest \
        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1

    { next_pid:       3521 } hitcount:      16425  next_prio:          0  \
                             common_timestamp-ts0: 12785539665130611
	max:         84  next_comm: cyclictest \
        prev_pid:          0  prev_prio:        120  prev_comm: swapper/2

    { next_pid:       3520 } hitcount:      24593  next_prio:          0 \
                             common_timestamp-ts0: 12785539665130611
	max:         98  next_comm: cyclictest \
        prev_pid:          0  prev_prio:        120  prev_comm: swapper/0
                                    
    Totals:
        Hits: 217355
        Entries: 3
        Dropped: 0


  And, verifying, we can see that the max latencies captured above
  match the highest latencies for each thread in the wakeup_latency
  histogram:

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,prio,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       3519, prio:        120, lat:          0 } hitcount:          3
    { pid:       3519, prio:        120, lat:          1 } hitcount:        176
    { pid:       3519, prio:        120, lat:          2 } hitcount:       1284
    { pid:       3519, prio:        120, lat:          3 } hitcount:        709
    ...
    { pid:       3519, prio:        120, lat:         79 } hitcount:          1

    { pid:       3520, prio:         19, lat:          1 } hitcount:       3372
    { pid:       3520, prio:         19, lat:          2 } hitcount:      14777
    { pid:       3520, prio:         19, lat:          3 } hitcount:       4678
    { pid:       3520, prio:         19, lat:          4 } hitcount:        926
    ...
    { pid:       3520, prio:         19, lat:         98 } hitcount:          1

    { pid:       3521, prio:         19, lat:          1 } hitcount:       1551
    { pid:       3521, prio:         19, lat:          2 } hitcount:       8827
    { pid:       3521, prio:         19, lat:          3 } hitcount:       4620
    { pid:       3521, prio:         19, lat:          4 } hitcount:        876
    { pid:       3521, prio:         19, lat:         84 } hitcount:          1

    Totals:
        Hits: 43471
        Entries: 71
        Dropped: 0


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

    # wakeup latency

    # echo 'wakeup_latency lat=sched_switch:ss_lat pid=sched_switch:ss_pid' >> /sys/kernel/debug/tracing/synthetic_events

    # echo 'hist:keys=pid:wakeup_ts=common_timestamp.usecs if comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger

    # echo 'hist:keys=ss_pid=next_pid:ss_lat=common_timestamp.usecs-wakeup_ts:onmatch().trace(wakeup_latency) if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

    # echo 'hist:keys=pid:wakeup_latency=lat:sort=pid' >> /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
echo 'hist:keys=pid,lat:sort=pid,lat' >> /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger


    # switchtime latency

    # echo 'switchtime_latency lat=sys_exit_nanosleep:ns_lat pid=sys_exit_nanosleep:ns_pid' >> /sys/kernel/debug/tracing/synthetic_events

    # echo 'hist:keys=next_pid:ss_ts=common_timestamp.usecs if next_comm=="cyclictest"' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

    # echo 'hist:key=ns_pid=common_pid:ns_lat=common_timestamp.usecs-ss_ts:onmatch().trace(switchtime_latency)' >> /sys/kernel/debug/tracing/events/syscalls/sys_exit_nanosleep/trigger

    # echo 'hist:keys=pid:switchtime_latency=lat:sort=pid' >> /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/trigger

    # echo 'hist:keys=pid,lat:sort=pid,lat' >> /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/trigger

    # wakeupswitch latency

    # echo 'wakeupswitch_latency pid=sys_exit_nanosleep:ns_pid lat=sys_exit_nanosleep:wakeupswitch_lat' >> /sys/kernel/debug/tracing/synthetic_events

    # echo 'hist:key=common_pid:wakeupswitch_lat=wakeup_latency+switchtime_latency:onmatch().trace(wakeupswitch_latency)' >> /sys/kernel/debug/tracing/events/syscalls/sys_exit_nanosleep/trigger

    # echo 'hist:keys=pid,lat:sort=pid,lat' >> /sys/kernel/debug/tracing/events/synthetic/wakeupswitch_latency/trigger


    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       3015, lat:          1 } hitcount:          2
    { pid:       3015, lat:          2 } hitcount:        167
    { pid:       3015, lat:          3 } hitcount:        348
    { pid:       3015, lat:          4 } hitcount:        139
    { pid:       3015, lat:          5 } hitcount:         14
    { pid:       3015, lat:          6 } hitcount:          6
    { pid:       3015, lat:          7 } hitcount:          7
    { pid:       3015, lat:          8 } hitcount:          8
    { pid:       3015, lat:          9 } hitcount:          3
    { pid:       3015, lat:         10 } hitcount:          2
    { pid:       3015, lat:         11 } hitcount:          2
    { pid:       3015, lat:         12 } hitcount:          1
    { pid:       3015, lat:         13 } hitcount:          1
    { pid:       3015, lat:         21 } hitcount:          1
    { pid:       3016, lat:          1 } hitcount:        294
    { pid:       3016, lat:          2 } hitcount:       3641
    { pid:       3016, lat:          3 } hitcount:       2535
    { pid:       3016, lat:          4 } hitcount:        311
    { pid:       3016, lat:          5 } hitcount:        109
    { pid:       3016, lat:          6 } hitcount:         59
    { pid:       3016, lat:          7 } hitcount:         27
    { pid:       3016, lat:          8 } hitcount:         13
    { pid:       3016, lat:          9 } hitcount:          5
    { pid:       3016, lat:         10 } hitcount:          1
    { pid:       3016, lat:         11 } hitcount:          1
    { pid:       3016, lat:         12 } hitcount:          1
    { pid:       3016, lat:         13 } hitcount:          2
    { pid:       3016, lat:         15 } hitcount:          1
    { pid:       3016, lat:         17 } hitcount:          2
    { pid:       3016, lat:         21 } hitcount:          1
    { pid:       3017, lat:          1 } hitcount:         85
    { pid:       3017, lat:          2 } hitcount:       1752
    { pid:       3017, lat:          3 } hitcount:       2334
    { pid:       3017, lat:          4 } hitcount:        308
    { pid:       3017, lat:          5 } hitcount:         96
    { pid:       3017, lat:          6 } hitcount:         46
    { pid:       3017, lat:          7 } hitcount:         31
    { pid:       3017, lat:          8 } hitcount:         12
    { pid:       3017, lat:          9 } hitcount:         11
    { pid:       3017, lat:         10 } hitcount:          3
    { pid:       3017, lat:         12 } hitcount:          2
    { pid:       3017, lat:         16 } hitcount:          1
    { pid:       3017, lat:         21 } hitcount:          1

    Totals:
        Hits: 12386
        Entries: 43
        Dropped: 0


    # cat /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       3015, lat:          1 } hitcount:          2
    { pid:       3015, lat:          2 } hitcount:         46
    { pid:       3015, lat:          3 } hitcount:        284
    { pid:       3015, lat:          4 } hitcount:        164
    { pid:       3015, lat:          5 } hitcount:        116
    { pid:       3015, lat:          6 } hitcount:         61
    { pid:       3015, lat:          7 } hitcount:          3
    { pid:       3015, lat:          8 } hitcount:          2
    { pid:       3015, lat:          9 } hitcount:          2
    { pid:       3015, lat:         11 } hitcount:          3
    { pid:       3015, lat:         12 } hitcount:          4
    { pid:       3015, lat:         13 } hitcount:          5
    { pid:       3015, lat:         14 } hitcount:          3
    { pid:       3015, lat:         15 } hitcount:          5
    { pid:       3015, lat:         20 } hitcount:          1
    { pid:       3016, lat:          1 } hitcount:        469
    { pid:       3016, lat:          2 } hitcount:       5068
    { pid:       3016, lat:          3 } hitcount:        920
    { pid:       3016, lat:          4 } hitcount:        257
    { pid:       3016, lat:          5 } hitcount:         97
    { pid:       3016, lat:          6 } hitcount:         50
    { pid:       3016, lat:          7 } hitcount:         32
    { pid:       3016, lat:          8 } hitcount:         26
    { pid:       3016, lat:          9 } hitcount:         24
    { pid:       3016, lat:         10 } hitcount:         21
    { pid:       3016, lat:         11 } hitcount:         10
    { pid:       3016, lat:         12 } hitcount:         12
    { pid:       3016, lat:         13 } hitcount:          6
    { pid:       3016, lat:         14 } hitcount:          3
    { pid:       3016, lat:         15 } hitcount:          1
    { pid:       3016, lat:         17 } hitcount:          1
    { pid:       3016, lat:         19 } hitcount:          1
    { pid:       3016, lat:         21 } hitcount:          2
    { pid:       3016, lat:         25 } hitcount:          1
    { pid:       3016, lat:         29 } hitcount:          1
    { pid:       3016, lat:         61 } hitcount:          1
    { pid:       3017, lat:          1 } hitcount:        101
    { pid:       3017, lat:          2 } hitcount:       3278
    { pid:       3017, lat:          3 } hitcount:        877
    { pid:       3017, lat:          4 } hitcount:        207
    { pid:       3017, lat:          5 } hitcount:         66
    { pid:       3017, lat:          6 } hitcount:         52
    { pid:       3017, lat:          7 } hitcount:         27
    { pid:       3017, lat:          8 } hitcount:         19
    { pid:       3017, lat:          9 } hitcount:         20
    { pid:       3017, lat:         10 } hitcount:         16
    { pid:       3017, lat:         11 } hitcount:          8
    { pid:       3017, lat:         12 } hitcount:          4
    { pid:       3017, lat:         13 } hitcount:          2
    { pid:       3017, lat:         14 } hitcount:          2
    { pid:       3017, lat:         15 } hitcount:          1
    { pid:       3017, lat:         16 } hitcount:          1
    { pid:       3017, lat:         24 } hitcount:          1

    Totals:
        Hits: 12386
        Entries: 53
        Dropped: 0


    # cat /sys/kernel/debug/tracing/events/synthetic/wakeupswitch_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       3015, lat:          3 } hitcount:          2
    { pid:       3015, lat:          4 } hitcount:         21
    { pid:       3015, lat:          5 } hitcount:         77
    { pid:       3015, lat:          6 } hitcount:        174
    { pid:       3015, lat:          7 } hitcount:        180
    { pid:       3015, lat:          8 } hitcount:        123
    { pid:       3015, lat:          9 } hitcount:         65
    { pid:       3015, lat:         10 } hitcount:         13
    { pid:       3015, lat:         11 } hitcount:          9
    { pid:       3015, lat:         12 } hitcount:          5
    { pid:       3015, lat:         13 } hitcount:          5
    { pid:       3015, lat:         14 } hitcount:          5
    { pid:       3015, lat:         15 } hitcount:          3
    { pid:       3015, lat:         16 } hitcount:          4
    { pid:       3015, lat:         17 } hitcount:          3
    { pid:       3015, lat:         18 } hitcount:          7
    { pid:       3015, lat:         19 } hitcount:          2
    { pid:       3015, lat:         24 } hitcount:          1
    { pid:       3015, lat:         25 } hitcount:          1
    { pid:       3016, lat:          2 } hitcount:          3
    { pid:       3016, lat:          3 } hitcount:        472
    { pid:       3016, lat:          4 } hitcount:       3149
    { pid:       3016, lat:          5 } hitcount:       2148
    { pid:       3016, lat:          6 } hitcount:        516
    { pid:       3016, lat:          7 } hitcount:        250
    { pid:       3016, lat:          8 } hitcount:        174
    { pid:       3016, lat:          9 } hitcount:         90
    { pid:       3016, lat:         10 } hitcount:         58
    { pid:       3016, lat:         11 } hitcount:         40
    { pid:       3016, lat:         12 } hitcount:         31
    { pid:       3016, lat:         13 } hitcount:         16
    { pid:       3016, lat:         14 } hitcount:         12
    { pid:       3016, lat:         15 } hitcount:          9
    { pid:       3016, lat:         16 } hitcount:         10
    { pid:       3016, lat:         17 } hitcount:          6
    { pid:       3016, lat:         18 } hitcount:          7
    { pid:       3016, lat:         19 } hitcount:          2
    { pid:       3016, lat:         20 } hitcount:          2
    { pid:       3016, lat:         21 } hitcount:          1
    { pid:       3016, lat:         23 } hitcount:          2
    { pid:       3016, lat:         28 } hitcount:          2
    { pid:       3016, lat:         34 } hitcount:          1
    { pid:       3016, lat:         63 } hitcount:          1
    { pid:       3017, lat:          2 } hitcount:          2
    { pid:       3017, lat:          3 } hitcount:         89
    { pid:       3017, lat:          4 } hitcount:       1417
    { pid:       3017, lat:          5 } hitcount:       2026
    { pid:       3017, lat:          6 } hitcount:        549
    { pid:       3017, lat:          7 } hitcount:        169
    { pid:       3017, lat:          8 } hitcount:        148
    { pid:       3017, lat:          9 } hitcount:        104
    { pid:       3017, lat:         10 } hitcount:         63
    { pid:       3017, lat:         11 } hitcount:         36
    { pid:       3017, lat:         12 } hitcount:         34
    { pid:       3017, lat:         13 } hitcount:         19
    { pid:       3017, lat:         14 } hitcount:          9
    { pid:       3017, lat:         15 } hitcount:          6
    { pid:       3017, lat:         16 } hitcount:          3
    { pid:       3017, lat:         17 } hitcount:          3
    { pid:       3017, lat:         19 } hitcount:          1
    { pid:       3017, lat:         23 } hitcount:          1
    { pid:       3017, lat:         26 } hitcount:          2

    Totals:
        Hits: 12383
        Entries: 62
        Dropped: 0


The following changes since commit e704eff3ff5138a462443dcd64d071165df18782:

  ftrace: Have set_graph_function handle multiple functions in one write (2017-02-03 10:59:52 -0500)

are available in the git repository at:

  git://git.yoctoproject.org/linux-yocto-contrib.git tzanussi/inter-event-v0
  http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/log/?h=tzanussi/inter-event-v0

Tom Zanussi (21):
  tracing: Add hist_field_name() accessor
  tracing: Reimplement log2
  ring-buffer: Add TIME_EXTEND_ABS ring buffer type
  tracing: Give event triggers access to ring_buffer_event
  tracing: Add ring buffer event param to hist field functions
  tracing: Increase tracing map KEYS_MAX size
  tracing: Break out hist trigger assignment parsing
  tracing: Make traceprobe parsing code reusable
  tracing: Add hist trigger timestamp support
  tracing: Add per-element variable support to tracing_map
  tracing: Add variable support to hist triggers
  tracing: Account for variables in named trigger compatibility
  tracing: Add simple expression support to hist triggers
  tracing: Add variable reference handling to hist triggers
  tracing: Add usecs modifier for hist trigger timestamps
  tracing: Add support for dynamic tracepoints
  tracing: Add hist trigger action hook
  tracing: Add support for 'synthetic' events
  tracing: Add 'onmatch' hist trigger action support
  tracing: Add 'onmax' hist trigger action support
  tracing: Add inter-event hist trigger Documentation

 Documentation/trace/events.txt      |  330 +++++
 include/linux/ring_buffer.h         |   12 +-
 include/linux/trace_events.h        |   14 +-
 include/linux/tracepoint.h          |   11 +-
 kernel/trace/ring_buffer.c          |  109 +-
 kernel/trace/trace.c                |  108 +-
 kernel/trace/trace.h                |   20 +-
 kernel/trace/trace_events.c         |    4 +-
 kernel/trace/trace_events_hist.c    | 2687 ++++++++++++++++++++++++++++++++---
 kernel/trace/trace_events_trigger.c |   47 +-
 kernel/trace/trace_kprobe.c         |   18 +-
 kernel/trace/trace_probe.c          |   75 -
 kernel/trace/trace_probe.h          |    7 -
 kernel/trace/trace_uprobe.c         |    2 +-
 kernel/trace/tracing_map.c          |  113 ++
 kernel/trace/tracing_map.h          |   13 +-
 kernel/tracepoint.c                 |   42 +-
 17 files changed, 3244 insertions(+), 368 deletions(-)

-- 
1.9.3
