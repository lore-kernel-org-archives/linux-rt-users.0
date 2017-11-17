From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v6 00/37] tracing: Inter-event (e.g. latency) support
Date: Fri, 17 Nov 2017 14:32:39 -0600
Message-ID: <cover.1510948725.git.tom.zanussi@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

This is V6 of the inter-event tracing patchset, addressing input from
V5.

There were only a couple comments on the last version, which are
addressed here, in addition to a problems noted while testing, and a
fix for a problem found by the 0day bot:

  - fixed parse_var_defs() again, moving the VARS_MAX check up to the
    proper place.  Also added a hist_err message to parse_assignment()
    and removed the hist_err message from create_var_field(), since
    it's no longer necessary given the above.
  - fixed a bogus format string check in synth_field_fmt()
  - merged in a fix from Fengguang Wu for a 0day bot-flagged sizeof
    pointer problem (to 24/37, Add support for synthetic events)
  - noticed that duplicate variables on the same trigger weren't being
    detected and added a fix for that

Changes from V4:

  - fixed struct noinline typo
  - for the selftests, the following changes were made [from Rajvi Jingar]
    - In extended error support test, changed last "&&" to redirect
      error/output to /dev/null instead.
    - In synthetic event create remove test, changed to same event
      style in creating and removing and added a case to check adding
      an event with wrong format
    - Added -q option in grep since don’t need to show grep results.
    - Changes to use newly added exit_pass()/exit_fail().
  - in the variable reference handling patch, changed list_add_rcu to
    list_add_tail_rcu when adding hist triggers.  Using list_add_rcu
    causes the triggers to be executed in reverse order to how they
    were added, which in the case of multiple triggers with variables
    on the same event can lead to variables being accessed before they
    were set. [thanks to Rajvi for the bug report]
  - noticed and fixed a couple problems with synthetic event refcounting

Changes from V3:

These mainly directly address the input from V3, but there are a
couple new things too - a new set of selftests (thanks to Rajvi Jingar
for those), and a new 'timestamp_mode' ftrace file making it easy to
see exactly what mode the ring buffer timestamping is in at any given
time (delta or absolute).  The detailed list:

  - fixed up 'if' parsing to also handle variables starting with 'if'
  - added lots of comments to the field variable code
  - added code to check and not fail if a field variable was already created
  - fixed various typos,etc in commit messages
  - moved target_hist_data fix from onmatch patch to field var patch
  - fixed var_name leak in parse_var_defs()
  - changed common_timestamp -> $common_timestamp in commit messages
  - discovered and fixed a bug where variable references were not guaranteed unique
  - added missing destroy_hist_field() in expression code
  - separated synth event list management from synth event de/registration
  - added missing 2nd-level variable reference checking in expressions
  - added self-reference check to find_any_var_ref()
  - removed HIST_FIELD_FL_VAR_ONLY and related code
  - added WARN_ON_ONCE to hist_trigger_entry_print()
  - changed absolute timestamps to allow coexistence with normal (delta) timestamps
  - added a new read-only 'timestamp_mode' file to show current timestamp mode
  - moved hist trigger Documentation into standalone histogram.txt file
  - added new inter-event Documentation to histogram.txt
  - removed redundant description of $common_timestamp usage from Documentation
  - added missing .log2 line to Documentation
  - added missing .usecs line to README pseudo-file
  - added new set of selftests for various inter-event features [Rajvi Jingar]

Changes from V2:

  - split out standalone bugfixes and cleanups to a separate patchset
  - moved hunks around and merged patches as suggested
  - added inter-event note in config option
  - updates to duplicates patch [Vedang Patel]
  - various memory allocation checks and use-after-free bugfix [Rajvi Jingar]
  - various code improvements as suggested by Steve
  - switched hist_field_flags over to using shifts
  - added comments about synth_event mutex usage
  - added example and explanation of field variables
  - fixed field variable synth_event_mutex bug
  - commented the whitespace handling in hist_trigger_func()
    (the extra complexity is needed to allow spaces in actions)
  - use smp_processor_id() instead of raw_ for cpu field
  - added better description of aliases
  - use static arrays instead of kmalloc for hist_err code, along with
    various other cleanups
  - removed 'tracing: Add support for dynamic tracepoints' since I was
    mistaken about the need for this

Changes from V1:

There are too many changes to list in detail, most of them directly
addressing input from V1, but here are the major changes from V1
(thanks to everyone who reviewed V1 and thanks to both Vedang Patel
and Baohong Liu for their contributions and included patches):

  - cleaned up the event format
  - add types to synthetic event fields
  - change to mutex ordering to avoid splat
  - suppress output of the contributing trace events into the trace
    buffer, unless explicitly enabled
  - changed from sched_wakeup to sched_waking in the examples
  - extended timestamp updates
  - use a flag to signify dynamic tracepoints, rather than via api changes
  - recursion level fixes
  - removal of the possibility of tracing_map duplicates (Vedang)
  - removal of duplicate-merging code (Vedang)
  - max buffer absolute timestamp fix (Baohong)
  - separate variable definition and assignment (Baohong) 
  - make variables instance-safe
  - split a couple larger patches into smaller, various refactoring
  - string handling fixes
  - use function pointer for synthetic tracepoint func
  - use union for actions
  - various clean-ups as mentioned in review
  - Documentation updates
  - special-case recursion allowance for synthetic event generation

NOTE: The first patch in the series, 'tracing: Exclude 'generic
fields' from histograms' should go in regardless of the rest, since it
fixes a bug in existing code.

Thanks,

Tom


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
  do that we add triggers to sched_waking and sched_switch with the
  appropriate variables, and on a matching sched_switch event,
  generate a synthetic 'wakeup_latency' event.  Since it's just
  another trace event like any other, we can also define a histogram
  on that event, the output of which is what we see displayed when
  reading the wakeup_latency 'hist' file.

  First, we create a synthetic event called wakeup_latency, that
  creates 3 fields which will reference variables from other events:

    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
        /sys/kernel/debug/tracing/synthetic_events

  Next we add a trigger to sched_waking, which saves the value of the
  '$common_timestamp' when that event is hit in a variable, ts0.  Note
  that this happens only when 'comm==cyclictest'.

  Also, '$common_timestamp' is a new field defined on every event (if
  needed - if there are no users of timestamps in a trace, timestamps
  won't be saved and there's no additional overhead from that).

    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

  Next, we add a trigger to sched_switch.  When the pid being switched
  to matches the pid woken up by a previous sched_waking event, this
  event grabs the ts0 variable saved on that event, takes the
  difference between it and the current sched_switch's
  $common_timestamp, and assigns it to a new 'wakeup_lat' variable.
  It then generates the wakeup_latency synthetic event defined earlier
  by 'invoking' it as a function using as parameters the wakeup_lat
  variable and two sched_switch event fields directly:

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0: \
        onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_prio) \
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

    { pid:       2418, prio:        120, lat:          6 } hitcount:         21
    { pid:       2418, prio:        120, lat:          7 } hitcount:         62
    { pid:       2418, prio:        120, lat:          8 } hitcount:         44
    { pid:       2418, prio:        120, lat:          9 } hitcount:         34
    { pid:       2418, prio:        120, lat:         10 } hitcount:         16
    { pid:       2418, prio:        120, lat:         11 } hitcount:          5
    { pid:       2418, prio:        120, lat:         12 } hitcount:          2
    { pid:       2418, prio:        120, lat:         13 } hitcount:          2
    { pid:       2418, prio:        120, lat:         14 } hitcount:          1
    { pid:       2418, prio:        120, lat:         15 } hitcount:          1
    { pid:       2418, prio:        120, lat:         16 } hitcount:          1
    { pid:       2418, prio:        120, lat:         18 } hitcount:          2
    { pid:       2418, prio:        120, lat:         19 } hitcount:          1
    { pid:       2418, prio:        120, lat:         20 } hitcount:          1
    { pid:       2418, prio:        120, lat:         21 } hitcount:          1
    { pid:       2418, prio:        120, lat:         22 } hitcount:          1
    { pid:       2418, prio:        120, lat:         23 } hitcount:          1
    { pid:       2418, prio:        120, lat:         56 } hitcount:          1
    { pid:       2418, prio:        120, lat:         60 } hitcount:          1
    { pid:       2418, prio:        120, lat:        123 } hitcount:          1
    { pid:       2419, prio:         19, lat:          4 } hitcount:         12
    { pid:       2419, prio:         19, lat:          5 } hitcount:        230
    { pid:       2419, prio:         19, lat:          6 } hitcount:        343
    { pid:       2419, prio:         19, lat:          7 } hitcount:        485
    { pid:       2419, prio:         19, lat:          8 } hitcount:        574
    { pid:       2419, prio:         19, lat:          9 } hitcount:        164
    { pid:       2419, prio:         19, lat:         10 } hitcount:         51
    { pid:       2419, prio:         19, lat:         11 } hitcount:         36
    { pid:       2419, prio:         19, lat:         12 } hitcount:         23
    { pid:       2419, prio:         19, lat:         13 } hitcount:         16
    { pid:       2419, prio:         19, lat:         14 } hitcount:         13
    { pid:       2419, prio:         19, lat:         15 } hitcount:          5
    { pid:       2419, prio:         19, lat:         16 } hitcount:          6
    { pid:       2419, prio:         19, lat:         17 } hitcount:          5
    { pid:       2419, prio:         19, lat:         18 } hitcount:          1
    { pid:       2419, prio:         19, lat:         19 } hitcount:          2
    { pid:       2419, prio:         19, lat:         26 } hitcount:          1
    { pid:       2419, prio:         19, lat:         29 } hitcount:          1
    { pid:       2419, prio:         19, lat:         37 } hitcount:          1
    { pid:       2419, prio:         19, lat:         38 } hitcount:          1
    { pid:       2420, prio:         19, lat:          4 } hitcount:          1
    { pid:       2420, prio:         19, lat:          5 } hitcount:         45
    { pid:       2420, prio:         19, lat:          6 } hitcount:         96
    { pid:       2420, prio:         19, lat:          7 } hitcount:        227
    { pid:       2420, prio:         19, lat:          8 } hitcount:        558
    { pid:       2420, prio:         19, lat:          9 } hitcount:        236
    { pid:       2420, prio:         19, lat:         10 } hitcount:         67
    { pid:       2420, prio:         19, lat:         11 } hitcount:         27
    { pid:       2420, prio:         19, lat:         12 } hitcount:         17
    { pid:       2420, prio:         19, lat:         13 } hitcount:         12
    { pid:       2420, prio:         19, lat:         14 } hitcount:         11
    { pid:       2420, prio:         19, lat:         15 } hitcount:          8
    { pid:       2420, prio:         19, lat:         16 } hitcount:          6
    { pid:       2420, prio:         19, lat:         17 } hitcount:          3
    { pid:       2420, prio:         19, lat:         18 } hitcount:          1
    { pid:       2420, prio:         19, lat:         23 } hitcount:          1
    { pid:       2420, prio:         19, lat:         25 } hitcount:          1
    { pid:       2420, prio:         19, lat:         26 } hitcount:          1
    { pid:       2420, prio:         19, lat:        434 } hitcount:          1

    Totals:
        Hits: 3488
        Entries: 59
        Dropped: 0

  The above output uses the .usecs modifier to common_timestamp, so
  the latencies are reported in microseconds.  The default, without
  the modifier, is nanoseconds, but that's too fine-grained to put
  directly into a histogram - for that however we can use the .log2
  modifier on the 'lat' key.  Otherwise the rest is the same:

    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
        /sys/kernel/debug/tracing/synthetic_events

    # echo 'hist:keys=pid:ts0=$common_timestamp if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp-$ts0: \
        onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_prio) \
        if next_comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_switch/trigger

    # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,prio,lat.log2:vals=hitcount:sort=pid,lat.log2:size=2048 [active]
    #

    { pid:       2457, prio:        120, lat: ~ 2^13 } hitcount:         99
    { pid:       2457, prio:        120, lat: ~ 2^14 } hitcount:         91
    { pid:       2457, prio:        120, lat: ~ 2^15 } hitcount:          8
    { pid:       2458, prio:         19, lat: ~ 2^13 } hitcount:       1437
    { pid:       2458, prio:         19, lat: ~ 2^14 } hitcount:        519
    { pid:       2458, prio:         19, lat: ~ 2^15 } hitcount:         11
    { pid:       2458, prio:         19, lat: ~ 2^16 } hitcount:          2
    { pid:       2458, prio:         19, lat: ~ 2^18 } hitcount:          1
    { pid:       2459, prio:         19, lat: ~ 2^13 } hitcount:        874
    { pid:       2459, prio:         19, lat: ~ 2^14 } hitcount:        442
    { pid:       2459, prio:         19, lat: ~ 2^15 } hitcount:          4

    Totals:
        Hits: 3488
        Entries: 11
        Dropped: 0

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
        /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

  Here we add an onmax() action that saves some important fields of
  the sched_switch event along with the maximum, in addition to
  sending some of the same data to the synthetic event:

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0: \
        onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm): \
	onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_prio) \
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
    # trigger info: hist:keys=next_pid:vals=hitcount:wakeup_lat=$common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global:onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm):onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,next_prio) if next_comm=="cyclictest" [active]
    #

    { next_pid:       2803 } hitcount:        198
      max:         55  next_comm: cyclictest           prev_pid:          0
      prev_prio:        120  prev_comm: swapper/2

    { next_pid:       2805 } hitcount:       1319
      max:         53  next_comm: cyclictest           prev_pid:          0
      prev_prio:        120  prev_comm: swapper/1

    { next_pid:       2804 } hitcount:       1970
      max:         79  next_comm: cyclictest           prev_pid:          0
      prev_prio:        120  prev_comm: swapper/0

    Totals:
        Hits: 3487
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

    { pid:       2803, prio:        120, lat:          6 } hitcount:         12
    { pid:       2803, prio:        120, lat:          7 } hitcount:         42
    ...
    { pid:       2803, prio:        120, lat:         22 } hitcount:          2
    { pid:       2803, prio:        120, lat:         55 } hitcount:          1
    { pid:       2804, prio:         19, lat:          4 } hitcount:          5
    { pid:       2804, prio:         19, lat:          5 } hitcount:        188
    ...
    { pid:       2804, prio:         19, lat:         30 } hitcount:          1
    { pid:       2804, prio:         19, lat:         79 } hitcount:          1
    { pid:       2805, prio:         19, lat:          5 } hitcount:         19
    { pid:       2805, prio:         19, lat:          6 } hitcount:         73
    ...
    { pid:       2805, prio:         19, lat:         44 } hitcount:          1
    { pid:       2805, prio:         19, lat:         53 } hitcount:          1

    Totals:
        Hits: 3487
        Entries: 57
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
  sub-histograms, one covering the time between sched_waking and the
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
	/sys/kernel/debug/tracing/events/sched/sched_waking/trigger

    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:\
        onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid) \
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

    { pid:       4146, lat:          6 } hitcount:          8
    { pid:       4146, lat:          7 } hitcount:         50
    { pid:       4146, lat:          8 } hitcount:         53
    { pid:       4146, lat:          9 } hitcount:         34
    { pid:       4146, lat:         10 } hitcount:         22
    { pid:       4146, lat:         11 } hitcount:          6
    { pid:       4146, lat:         12 } hitcount:          4
    { pid:       4146, lat:         13 } hitcount:          1
    { pid:       4146, lat:         14 } hitcount:          4
    { pid:       4146, lat:         15 } hitcount:          2
    { pid:       4146, lat:         16 } hitcount:          2
    { pid:       4146, lat:         17 } hitcount:          3
    { pid:       4146, lat:         19 } hitcount:          1
    { pid:       4146, lat:         20 } hitcount:          2
    { pid:       4146, lat:         21 } hitcount:          4
    { pid:       4146, lat:         24 } hitcount:          1
    { pid:       4146, lat:         53 } hitcount:          1
    { pid:       4147, lat:          4 } hitcount:          1
    { pid:       4147, lat:          5 } hitcount:        156
    { pid:       4147, lat:          6 } hitcount:        344
    { pid:       4147, lat:          7 } hitcount:        560
    { pid:       4147, lat:          8 } hitcount:        540
    { pid:       4147, lat:          9 } hitcount:        195
    { pid:       4147, lat:         10 } hitcount:         50
    { pid:       4147, lat:         11 } hitcount:         38
    { pid:       4147, lat:         12 } hitcount:         26
    { pid:       4147, lat:         13 } hitcount:         13
    { pid:       4147, lat:         14 } hitcount:         12
    { pid:       4147, lat:         15 } hitcount:         10
    { pid:       4147, lat:         16 } hitcount:          3
    { pid:       4147, lat:         17 } hitcount:          2
    { pid:       4147, lat:         18 } hitcount:          4
    { pid:       4147, lat:         19 } hitcount:          2
    { pid:       4147, lat:         20 } hitcount:          1
    { pid:       4147, lat:         21 } hitcount:          1
    { pid:       4147, lat:         26 } hitcount:          1
    { pid:       4147, lat:         35 } hitcount:          1
    { pid:       4147, lat:         59 } hitcount:          1
    { pid:       4148, lat:          5 } hitcount:         38
    { pid:       4148, lat:          6 } hitcount:        229
    { pid:       4148, lat:          7 } hitcount:        219
    { pid:       4148, lat:          8 } hitcount:        486
    { pid:       4148, lat:          9 } hitcount:        181
    { pid:       4148, lat:         10 } hitcount:         59
    { pid:       4148, lat:         11 } hitcount:         27
    { pid:       4148, lat:         12 } hitcount:         23
    { pid:       4148, lat:         13 } hitcount:         16
    { pid:       4148, lat:         14 } hitcount:          7
    { pid:       4148, lat:         15 } hitcount:          7
    { pid:       4148, lat:         16 } hitcount:          6
    { pid:       4148, lat:         17 } hitcount:          2
    { pid:       4148, lat:         18 } hitcount:          2
    { pid:       4148, lat:         19 } hitcount:          4
    { pid:       4148, lat:         20 } hitcount:          3
    { pid:       4148, lat:         25 } hitcount:          1
    { pid:       4148, lat:         26 } hitcount:          1
    { pid:       4148, lat:         27 } hitcount:          1
    { pid:       4148, lat:         29 } hitcount:          2
    { pid:       4148, lat:         47 } hitcount:          1

    Totals:
        Hits: 3474
        Entries: 59
        Dropped: 0

  Here's the switchtime histogram:

    # cat /sys/kernel/debug/tracing/events/synthetic/switchtime_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       4146, lat:          3 } hitcount:         11
    { pid:       4146, lat:          4 } hitcount:         32
    { pid:       4146, lat:          5 } hitcount:         65
    { pid:       4146, lat:          6 } hitcount:         37
    { pid:       4146, lat:          7 } hitcount:         35
    { pid:       4146, lat:          8 } hitcount:          5
    { pid:       4146, lat:         10 } hitcount:          1
    { pid:       4146, lat:         11 } hitcount:          1
    { pid:       4146, lat:         12 } hitcount:          1
    { pid:       4146, lat:         13 } hitcount:          1
    { pid:       4146, lat:         14 } hitcount:          1
    { pid:       4146, lat:         15 } hitcount:          1
    { pid:       4146, lat:         16 } hitcount:          2
    { pid:       4146, lat:         17 } hitcount:          1
    { pid:       4146, lat:         18 } hitcount:          1
    { pid:       4146, lat:         20 } hitcount:          1
    { pid:       4146, lat:         22 } hitcount:          1
    { pid:       4146, lat:         55 } hitcount:          1
    { pid:       4147, lat:          3 } hitcount:        554
    { pid:       4147, lat:          4 } hitcount:        999
    { pid:       4147, lat:          5 } hitcount:        193
    { pid:       4147, lat:          6 } hitcount:        102
    { pid:       4147, lat:          7 } hitcount:         38
    { pid:       4147, lat:          8 } hitcount:         21
    { pid:       4147, lat:          9 } hitcount:          8
    { pid:       4147, lat:         10 } hitcount:         10
    { pid:       4147, lat:         11 } hitcount:         11
    { pid:       4147, lat:         12 } hitcount:          7
    { pid:       4147, lat:         13 } hitcount:          2
    { pid:       4147, lat:         14 } hitcount:          2
    { pid:       4147, lat:         15 } hitcount:          5
    { pid:       4147, lat:         16 } hitcount:          2
    { pid:       4147, lat:         17 } hitcount:          3
    { pid:       4147, lat:         18 } hitcount:          2
    { pid:       4147, lat:         23 } hitcount:          2
    { pid:       4148, lat:          3 } hitcount:        245
    { pid:       4148, lat:          4 } hitcount:        761
    { pid:       4148, lat:          5 } hitcount:        152
    { pid:       4148, lat:          6 } hitcount:         64
    { pid:       4148, lat:          7 } hitcount:         25
    { pid:       4148, lat:          8 } hitcount:          7
    { pid:       4148, lat:          9 } hitcount:         14
    { pid:       4148, lat:         10 } hitcount:         11
    { pid:       4148, lat:         11 } hitcount:         12
    { pid:       4148, lat:         12 } hitcount:          6
    { pid:       4148, lat:         13 } hitcount:          2
    { pid:       4148, lat:         14 } hitcount:          7
    { pid:       4148, lat:         15 } hitcount:          2
    { pid:       4148, lat:         17 } hitcount:          2
    { pid:       4148, lat:         18 } hitcount:          1
    { pid:       4148, lat:         19 } hitcount:          1
    { pid:       4148, lat:         24 } hitcount:          1
    { pid:       4148, lat:         25 } hitcount:          1
    { pid:       4148, lat:         42 } hitcount:          1

    Totals:
        Hits: 3474
        Entries: 54
        Dropped: 0

  And here's the combined wakeupswitch latency histogram:

    # cat /sys/kernel/debug/tracing/events/synthetic/wakeupswitch_latency/hist

    # event histogram
    #
    # trigger info: hist:keys=pid,lat:vals=hitcount:sort=pid,lat:size=2048 [active]
    #

    { pid:       4146, lat:         10 } hitcount:         16
    { pid:       4146, lat:         11 } hitcount:         18
    { pid:       4146, lat:         12 } hitcount:         25
    { pid:       4146, lat:         13 } hitcount:         38
    { pid:       4146, lat:         14 } hitcount:         25
    { pid:       4146, lat:         15 } hitcount:         14
    { pid:       4146, lat:         16 } hitcount:         17
    { pid:       4146, lat:         17 } hitcount:         14
    { pid:       4146, lat:         18 } hitcount:          7
    { pid:       4146, lat:         19 } hitcount:          1
    { pid:       4146, lat:         20 } hitcount:          3
    { pid:       4146, lat:         21 } hitcount:          2
    { pid:       4146, lat:         22 } hitcount:          1
    { pid:       4146, lat:         23 } hitcount:          1
    { pid:       4146, lat:         24 } hitcount:          1
    { pid:       4146, lat:         25 } hitcount:          2
    { pid:       4146, lat:         26 } hitcount:          2
    { pid:       4146, lat:         29 } hitcount:          1
    { pid:       4146, lat:         30 } hitcount:          1
    { pid:       4146, lat:         32 } hitcount:          1
    { pid:       4146, lat:         33 } hitcount:          2
    { pid:       4146, lat:         36 } hitcount:          1
    { pid:       4146, lat:         37 } hitcount:          1
    { pid:       4146, lat:         38 } hitcount:          1
    { pid:       4146, lat:         39 } hitcount:          1
    { pid:       4146, lat:         73 } hitcount:          1
    { pid:       4146, lat:         76 } hitcount:          1
    { pid:       4147, lat:          8 } hitcount:         54
    { pid:       4147, lat:          9 } hitcount:        205
    { pid:       4147, lat:         10 } hitcount:        391
    { pid:       4147, lat:         11 } hitcount:        544
    { pid:       4147, lat:         12 } hitcount:        342
    { pid:       4147, lat:         13 } hitcount:        141
    { pid:       4147, lat:         14 } hitcount:         68
    { pid:       4147, lat:         15 } hitcount:         46
    { pid:       4147, lat:         16 } hitcount:         42
    { pid:       4147, lat:         17 } hitcount:         23
    { pid:       4147, lat:         18 } hitcount:         23
    { pid:       4147, lat:         19 } hitcount:         17
    { pid:       4147, lat:         20 } hitcount:          8
    { pid:       4147, lat:         21 } hitcount:          7
    { pid:       4147, lat:         22 } hitcount:          7
    { pid:       4147, lat:         23 } hitcount:          8
    { pid:       4147, lat:         24 } hitcount:          4
    { pid:       4147, lat:         25 } hitcount:          6
    { pid:       4147, lat:         26 } hitcount:          4
    { pid:       4147, lat:         27 } hitcount:          1
    { pid:       4147, lat:         28 } hitcount:          4
    { pid:       4147, lat:         29 } hitcount:          2
    { pid:       4147, lat:         30 } hitcount:          3
    { pid:       4147, lat:         31 } hitcount:          3
    { pid:       4147, lat:         32 } hitcount:          1
    { pid:       4147, lat:         34 } hitcount:          1
    { pid:       4147, lat:         35 } hitcount:          3
    { pid:       4147, lat:         36 } hitcount:          1
    { pid:       4147, lat:         50 } hitcount:          1
    { pid:       4147, lat:         71 } hitcount:          1
    { pid:       4148, lat:          8 } hitcount:          2
    { pid:       4148, lat:          9 } hitcount:        100
    { pid:       4148, lat:         10 } hitcount:        156
    { pid:       4148, lat:         11 } hitcount:        340
    { pid:       4148, lat:         12 } hitcount:        341
    { pid:       4148, lat:         13 } hitcount:        139
    { pid:       4148, lat:         14 } hitcount:         55
    { pid:       4148, lat:         15 } hitcount:         42
    { pid:       4148, lat:         16 } hitcount:         24
    { pid:       4148, lat:         17 } hitcount:         17
    { pid:       4148, lat:         18 } hitcount:         18
    { pid:       4148, lat:         19 } hitcount:         17
    { pid:       4148, lat:         20 } hitcount:          7
    { pid:       4148, lat:         21 } hitcount:          4
    { pid:       4148, lat:         22 } hitcount:          7
    { pid:       4148, lat:         23 } hitcount:          6
    { pid:       4148, lat:         24 } hitcount:          3
    { pid:       4148, lat:         25 } hitcount:          7
    { pid:       4148, lat:         26 } hitcount:          5
    { pid:       4148, lat:         27 } hitcount:          3
    { pid:       4148, lat:         28 } hitcount:          3
    { pid:       4148, lat:         29 } hitcount:          1
    { pid:       4148, lat:         30 } hitcount:          4
    { pid:       4148, lat:         31 } hitcount:          1
    { pid:       4148, lat:         32 } hitcount:          2
    { pid:       4148, lat:         33 } hitcount:          3
    { pid:       4148, lat:         34 } hitcount:          1
    { pid:       4148, lat:         36 } hitcount:          1
    { pid:       4148, lat:         37 } hitcount:          2
    { pid:       4148, lat:         38 } hitcount:          1
    { pid:       4148, lat:         41 } hitcount:          1
    { pid:       4148, lat:         53 } hitcount:          1
    { pid:       4148, lat:         71 } hitcount:          1

    Totals:
        Hits: 3474
        Entries: 90
        Dropped: 0

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
        /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"' >> \
        /sys/kernel/debug/tracing/events/sched/sched_waking/trigger

    -su: echo: write error: Invalid argument

    # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist
    # event histogram
    #
    #

    Totals:
    Hits: 0
    Entries: 0
    Dropped: 0

    ERROR: Variable already defined: ts0
      Last command: keys=pid:ts0=$common_timestamp.usecs if comm=="cyclictest"


The following changes since commit a96a5037ed0f52e2d86739f4a1ef985bd036e575:

  tracing, thermal: Hide cpu cooling trace events when not in use (2017-10-17 19:03:09 -0400)

are available in the git repository at:

  https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/inter-event-v6
  https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/inter-event-v6

Rajvi Jingar (1):
  selftests: ftrace: Add inter-event hist triggers testcases

Tom Zanussi (34):
  tracing: Move hist trigger Documentation to histogram.txt
  tracing: Add Documentation for log2 modifier
  ring-buffer: Add interface for setting absolute time stamps
  ring-buffer: Redefine the unimplemented RINGBUF_TYPE_TIME_STAMP
  tracing: Add timestamp_mode trace file
  tracing: Give event triggers access to ring_buffer_event
  tracing: Add ring buffer event param to hist field functions
  tracing: Break out hist trigger assignment parsing
  tracing: Add hist trigger timestamp support
  tracing: Add per-element variable support to tracing_map
  tracing: Add hist_data member to hist_field
  tracing: Add usecs modifier for hist trigger timestamps
  tracing: Add variable support to hist triggers
  tracing: Account for variables in named trigger compatibility
  tracing: Move get_hist_field_flags()
  tracing: Add simple expression support to hist triggers
  tracing: Generalize per-element hist trigger data
  tracing: Pass tracing_map_elt to hist_field accessor functions
  tracing: Add hist_field 'type' field
  tracing: Add variable reference handling to hist triggers
  tracing: Add hist trigger action hook
  tracing: Add support for 'synthetic' events
  tracing: Add support for 'field variables'
  tracing: Add 'onmatch' hist trigger action support
  tracing: Add 'onmax' hist trigger action support
  tracing: Allow whitespace to surround hist trigger filter
  tracing: Add cpu field for hist triggers
  tracing: Add hist trigger support for variable reference aliases
  tracing: Add 'last error' error facility for hist triggers
  tracing: Add inter-event hist trigger Documentation
  tracing: Make tracing_set_clock() non-static
  tracing: Add a clock attribute for hist triggers
  tracing: Increase trace_recursive_lock() limit for synthetic events
  tracing: Add inter-event blurb to HIST_TRIGGERS config option

Vedang Patel (2):
  tracing: Add support to detect and avoid duplicates
  tracing: Remove code which merges duplicates

 Documentation/trace/events.txt                     | 1548 +------
 Documentation/trace/ftrace.txt                     |   24 +
 Documentation/trace/histogram.txt                  | 1998 ++++++++
 include/linux/ring_buffer.h                        |   14 +-
 include/linux/trace_events.h                       |   14 +-
 kernel/trace/Kconfig                               |    3 +
 kernel/trace/ring_buffer.c                         |  125 +-
 kernel/trace/trace.c                               |   97 +-
 kernel/trace/trace.h                               |   18 +-
 kernel/trace/trace_events_hist.c                   | 4748 ++++++++++++++++++--
 kernel/trace/trace_events_trigger.c                |   53 +-
 kernel/trace/tracing_map.c                         |  232 +-
 kernel/trace/tracing_map.h                         |   18 +-
 tools/testing/selftests/ftrace/test.d/functions    |    7 +
 .../inter-event/trigger-extended-error-support.tc  |   39 +
 .../inter-event/trigger-field-variable-support.tc  |   54 +
 .../trigger-inter-event-combined-hist.tc           |   58 +
 .../inter-event/trigger-onmatch-action-hist.tc     |   50 +
 .../trigger-onmatch-onmax-action-hist.tc           |   50 +
 .../inter-event/trigger-onmax-action-hist.tc       |   48 +
 .../trigger-synthetic-event-createremove.tc        |   54 +
 21 files changed, 7146 insertions(+), 2106 deletions(-)
 create mode 100644 Documentation/trace/histogram.txt
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-extended-error-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-createremove.tc

-- 
1.9.3
