From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] v4.11.8-rt5
Date: Wed, 5 Jul 2017 12:29:09 +0200
Message-ID: <20170705102907.7bm4ov6gqowsysxd@linutronix.de>
References: <20170705102757.t65qoxirvhiv7fht@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170705102757.t65qoxirvhiv7fht@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-07-05 12:27:58 [+0200], To Thomas Gleixner wrote:
> The delta patch against v4.11.8-rt4 will be sent as a reply to this mail
> and can be found here:

diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.txt
@@ -571,6 +571,7 @@ triggers (you have to use '!' for each one added.)
 	.sym-offset display an address as a symbol and offset
 	.syscall    display a syscall id as a system call name
 	.execname   display a common_pid as a program name
+	.usecs      display a $common_timestamp in microseconds
 
   Note that in general the semantics of a given field aren't
   interpreted when applying a modifier to it, but there are some
@@ -668,6 +669,43 @@ triggers (you have to use '!' for each one added.)
   The examples below provide a more concrete illustration of the
   concepts and typical usage patterns discussed above.
 
+  'synthetic' event fields
+  ------------------------
+
+  There are a number of 'synthetic fields' available for use as keys
+  or values in a hist trigger.  These look like and behave as if they
+  were event fields, but aren't actually part of the event's field
+  definition or format file.  They are however available for any
+  event, and can be used anywhere an actual event field could be.
+  'Synthetic' field names are always prefixed with a '$' character to
+  indicate that they're not normal fields (with the exception of
+  'cpu', for compatibility with existing filter usage):
+
+    $common_timestamp      u64 - timestamp (from ring buffer) associated
+                                 with the event, in nanoseconds.  May be
+				 modified by .usecs to have timestamps
+				 interpreted as microseconds.
+    cpu                    int - the cpu on which the event occurred.
+
+  Extended error information
+  --------------------------
+
+  For some error conditions encountered when invoking a hist trigger
+  command, extended error information is available via the
+  corresponding event's 'hist' file.  Reading the hist file after an
+  error will display more detailed information about what went wrong,
+  if information is available.  This extended error information will
+  be available until the next hist trigger command for that event.
+
+  If available for a given error condition, the extended error
+  information and usage takes the following form:
+
+    # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+    echo: write error: Invalid argument
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
+    ERROR: Couldn't yyy: zzz
+      Last command: xxx
 
 6.2 'hist' trigger examples
 ---------------------------
@@ -2064,3 +2102,387 @@ triggers (you have to use '!' for each one added.)
         Hits: 489
         Entries: 7
         Dropped: 0
+
+6.3 Inter-event hist triggers
+-----------------------------
+
+Inter-event hist triggers are hist triggers that combine values from
+one or more other events and create a histogram using that data.  Data
+from an inter-event histogram can in turn become the source for
+further combined histograms, thus providing a chain of related
+histograms, which is important for some applications.
+
+The most important example of an inter-event quantity that can be used
+in this manner is latency, which is simply a difference in timestamps
+between two events (although trace events don't have an externally
+visible timestamp field, the inter-event hist trigger support adds a
+pseudo-field to all events named '$common_timestamp' which can be used
+as if it were an actual event field).  Although latency is the most
+important inter-event quantity, note that because the support is
+completely general across the trace event subsystem, any event field
+can be used in an inter-event quantity.
+
+An example of a histogram that combines data from other histograms
+into a useful chain would be a 'wakeupswitch latency' histogram that
+combines a 'wakeup latency' histogram and a 'switch latency'
+histogram.
+
+Normally, a hist trigger specification consists of a (possibly
+compound) key along with one or more numeric values, which are
+continually updated sums associated with that key.  A histogram
+specification in this case consists of individual key and value
+specifications that refer to trace event fields associated with a
+single event type.
+
+The inter-event hist trigger extension allows fields from multiple
+events to be referenced and combined into a multi-event histogram
+specification.  In support of this overall goal, a few enabling
+features have been added to the hist trigger support:
+
+  - In order to compute an inter-event quantity, a value from one
+    event needs to saved and then referenced from another event.  This
+    requires the introduction of support for histogram 'variables'.
+
+  - The computation of inter-event quantities and their combination
+    require some minimal amount of support for applying simple
+    expressions to variables (+ and -).
+
+  - A histogram consisting of inter-event quantities isn't logically a
+    histogram on either event (so having the 'hist' file for either
+    event host the histogram output doesn't really make sense).  To
+    address the idea that the histogram is associated with a
+    combination of events, support is added allowing the creation of
+    'synthetic' events that are events derived from other events.
+    These synthetic events are full-fledged events just like any other
+    and can be used as such, as for instance to create the
+    'combination' histograms mentioned previously.
+
+  - A set of 'actions' can be associated with histogram entries -
+    these can be used to generate the previously mentioned synthetic
+    events, but can also be used for other purposes, such as for
+    example saving context when a 'max' latency has been hit.
+
+  - Trace events don't have a 'timestamp' associated with them, but
+    there is an implicit timestamp saved along with an event in the
+    underlying ftrace ring buffer.  This timestamp is now exposed as a
+    a synthetic field named '$common_timestamp' which can be used in
+    histograms as if it were any other event field.  Note that it has
+    a '$' prefixed to it - this is meant to indicate that it isn't an
+    actual field in the trace format but rather is a synthesized value
+    that nonetheless can be used as if it were an actual field.  By
+    default it is in units of nanoseconds; appending '.usecs' to a
+    common_timestamp field changes the units to microseconds.
+
+A note on inter-event timestamps: If $common_timestamp is used in a
+histogram, the trace buffer is automatically switched over to using
+absolute timestamps and the "global" trace clock, in order to avoid
+bogus timestamp differences with other clocks that aren't coherent
+across CPUs.  This can be overriden by specifying one of the other
+trace clocks instead, using the "clock=XXX" hist trigger attribute,
+where XXX is any of the clocks listed in the tracing/trace_clock
+pseudo-file.
+
+These features are decribed in more detail in the following sections.
+
+6.3.1 Histogram Variables
+-------------------------
+
+Variables are simply named locations used for saving and retrieving
+values between matching events.  A 'matching' event is defined as an
+event that has a matching key - if a variable is saved for a histogram
+entry corresponding to that key, any subsequent event with a matching
+key can access that variable.
+
+A variable's value is normally available to any subsequent event until
+it is set to something else by a subsequent event.  The one exception
+to that rule is that any variable used in an expression is essentially
+'read-once' - once it's used by an expression in a subsequent event,
+it's reset to its 'unset' state, which means it can't be used again
+unless it's set again.  This ensures not only that an event doesn't
+use an uninitialized variable in a calculation, but that that variable
+is used only once and not for any unrelated subsequent match.
+
+The basic syntax for saving a variable is to simply prefix a unique
+variable name not corresponding to any keyword along with an '=' sign
+to any event field.
+
+Either keys or values can be saved and retrieved in this way.  This
+creates a variable named 'ts0' for a histogram entry with the key
+'next_pid':
+
+  # echo 'hist:keys=next_pid:vals=ts0=$common_timestamp ... >> event/trigger
+
+The ts0 variable can be accessed by any subsequent event having the
+same pid as 'next_pid'.
+
+Variable references are formed by prepending the variable name with
+the '$' sign.  Thus for example, the ts0 variable above would be
+referenced as '$ts0' in subsequent expressions.
+
+Because 'vals=' is used, the $common_timestamp variable value above
+will also be summed as a normal histogram value would (though for a
+timestamp it makes little sense).
+
+The below shows that a key value can also be saved in the same way:
+
+  # echo 'hist:key=timer_pid=common_pid ...' >> event/trigger
+
+If a variable isn't a key variable or prefixed with 'vals=', the
+associated event field will be saved in a variable but won't be summed
+as a value:
+
+  # echo 'hist:keys=next_pid:ts1=$common_timestamp ... >> event/trigger
+
+Multiple variables can be assigned at the same time.  The below would
+result in both ts0 and b being created as variables, with both
+common_timestamp and field1 additionally being summed as values:
+
+  # echo 'hist:keys=pid:vals=ts0=$common_timestamp,b=field1 ... >> event/trigger
+
+Any number of variables not bound to a 'vals=' prefix can also be
+assigned by simply separating them with colons.  Below is the same
+thing but without the values being summed in the histogram:
+
+  # echo 'hist:keys=pid:ts0=$common_timestamp:b=field1 ... >> event/trigger
+
+Variables set as above can be referenced and used in expressions on
+another event.
+
+For example, here's how a latency can be calculated:
+
+  # echo 'hist:keys=pid,prio:ts0=$common_timestamp ... >> event1/trigger
+  # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp-$ts0 ... >> event2/trigger
+
+In the first line above, the event's timetamp is saved into the
+variable ts0.  In the next line, ts0 is subtracted from the second
+event's timestamp to produce the latency, which is then assigned into
+yet another variable, 'wakeup_lat'.  The hist trigger below in turn
+makes use of the wakeup_lat variable to compute a combined latency
+using the same key and variable from yet another event:
+
+  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ... >> event3/trigger
+
+6.3.2 Synthetic Events
+----------------------
+
+Synthetic events are user-defined events generated from hist trigger
+variables or fields associated with one or more other events.  Their
+purpose is to provide a mechanism for displaying data spanning
+multiple events consistent with the existing and already familiar
+usage for normal events.
+
+To define a synthetic event, the user writes a simple specification
+consisting of the name of the new event along with one or more
+variables and their types, which can be any valid field type,
+separated by semicolons, to the tracing/synthetic_events file.
+
+For instance, the following creates a new event named 'wakeup_latency'
+with 3 fields: lat, pid, and prio.  Each of those fields is simply a
+variable reference to a variable on another event:
+
+  # echo 'wakeup_latency \
+          u64 lat; \
+          pid_t pid; \
+	  int prio' >> \
+	  /sys/kernel/debug/tracing/synthetic_events
+
+Reading the tracing/synthetic_events file lists all the currently
+defined synthetic events, in this case the event defined above:
+
+  # cat /sys/kernel/debug/tracing/synthetic_events
+    wakeup_latency u64 lat; pid_t pid; int prio
+
+An existing synthetic event definition can be removed by prepending
+the command that defined it with a '!':
+
+  # echo '!wakeup_latency u64 lat pid_t pid int prio' >> \
+    /sys/kernel/debug/tracing/synthetic_events
+
+At this point, there isn't yet an actual 'wakeup_latency' event
+instantiated in the event subsytem - for this to happen, a 'hist
+trigger action' needs to be instantiated and bound to actual fields
+and variables defined on other events (see Section 6.3.3 below).
+
+Once that is done, an event instance is created, and a histogram can
+be defined using it:
+
+  # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
+        /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+
+The new event is created under the tracing/events/synthetic/ directory
+and looks and behaves just like any other event:
+
+  # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
+        enable  filter  format  hist  id  trigger
+
+Like any other event, once a histogram is enabled for the event, the
+output can be displayed by reading the event's 'hist' file.
+
+6.3.3 Hist trigger 'actions'
+----------------------------
+
+A hist trigger 'action' is a function that's executed whenever a
+histogram entry is added or updated.
+
+The default 'action' if no special function is explicity specified is
+as it always has been, to simply update the set of values associated
+with an entry.  Some applications, however, may want to perform
+additional actions at that point, such as generate another event, or
+compare and save a maximum.
+
+The following additional actions are available.  To specify an action
+for a given event, simply specify the action between colons in the
+hist trigger specification.
+
+  - onmatch(matching.event).<synthetic_event_name>(param list)
+
+    The 'onmatch(matching.event).<synthetic_event_name>(params)' hist
+    trigger action is invoked whenever an event matches and the
+    histogram entry would be added or updated.  It causes the named
+    synthetic event to be generated with the values given in the
+    'param list'.  The result is the generation of a synthetic event
+    that consists of the values contained in those variables at the
+    time the invoking event was hit.
+
+    The 'param list' consists of one or more parameters which may be
+    either variables or fields defined on either the 'matching.event'
+    or the target event.  The variables or fields specified in the
+    param list may be either fully-qualified or unqualified.  If a
+    variable is specified as unqualified, it must be unique between
+    the two events.  A field name used as a param can be unqualified
+    if it refers to the target event, but must be fully qualified if
+    it refers to the matching event.  A fully-qualified name is of the
+    form 'system.event_name.$var_name' or 'system.event_name.field'.
+
+    The 'matching.event' specification is simply the fully qualified
+    event name of the event that matches the target event for the
+    onmatch() functionality, in the form 'system.event_name'.
+
+    Finally, the number and type of variables/fields in the 'param
+    list' must match the number and types of the fields in the
+    synthetic event being generated.
+
+    As an example the below defines a simple synthetic event and uses
+    a variable defined on the sched_wakeup_new event as a parameter
+    when invoking the synthetic event.  Here we define the synthetic
+    event:
+
+    # echo 'wakeup_new_test pid_t pid' >> \
+           /sys/kernel/debug/tracing/synthetic_events
+
+    # cat /sys/kernel/debug/tracing/synthetic_events
+          wakeup_new_test pid_t pid
+
+    The following hist trigger both defines the missing testpid
+    variable and specifies an onmatch() action that generates a
+    wakeup_new_test synthetic event whenever a sched_wakeup_new event
+    occurs, which because of the 'if comm == "cyclictest"' filter only
+    happens when the executable is cyclictest:
+
+    # echo 'hist:keys=testpid=pid:onmatch(sched.sched_wakeup_new).\
+            wakeup_new_test($testpid) if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+
+    Creating and displaying a histogram based on those events is now
+    just a matter of using the fields and new synthetic event in the
+    tracing/events/synthetic directory, as usual:
+
+    # echo 'hist:keys=pid:sort=pid' >> \
+           /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
+
+    Running 'cyclictest' should cause wakeup_new events to generate
+    wakeup_new_test synthetic events which should result in histogram
+    output in the wakeup_new_test event's hist file:
+
+    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/hist
+
+    A more typical usage would be to use two events to calculate a
+    latency.  The following example uses a set of hist triggers to
+    produce a 'wakeup_latency' histogram:
+
+    First, we define a 'wakeup_latency' synthetic event:
+
+    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
+            /sys/kernel/debug/tracing/synthetic_events
+
+    Next, we specify that whenever we see a sched_wakeup event for a
+    cyclictest thread, save the timestamp in a 'ts0' variable:
+
+    # echo 'hist:keys=saved_pid=pid:ts0=$common_timestamp.usecs \
+            if comm=="cyclictest"' >> \
+	    /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+
+    Then, when the corresponding thread is actually scheduled onto the
+    CPU by a sched_switch event, calculate the latency and use that
+    along with another variable and an event field to generate a
+    wakeup_latency synthetic event:
+
+    # echo 'hist:keys=next_pid:wakeup_lat=$common_timestamp.usecs-$ts0:\
+            onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,\
+	            $saved_pid,next_prio) if next_comm=="cyclictest"' >> \
+	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+
+    We also need to create a histogram on the wakeup_latency synthetic
+    event in order to aggregate the generated synthetic event data:
+
+    # echo 'hist:keys=pid,prio,lat:sort=pid,lat' >> \
+            /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+
+    Finally, once we've run cyclictest to actually generate some
+    events, we can see the output by looking at the wakeup_latency
+    synthetic event's hist file:
+
+    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
+
+  - onmax(var).save(field,...)
+
+    The 'onmax(var).save(field,...)' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    exceeds the current maximum contained in that variable.
+
+    The end result is that the trace event fields specified as the
+    onmax.save() params will be saved if 'var' exceeds the current
+    maximum for that hist trigger entry.  This allows context from the
+    event that exhibited the new maximum to be saved for later
+    reference.  When the histogram is displayed, additional fields
+    displaying the saved values will be printed.
+
+    As an example the below defines a couple of hist triggers, one for
+    sched_wakeup and another for sched_switch, keyed on pid.  Whenever
+    a sched_wakeup occurs, the timestamp is saved in the entry
+    corresponding to the current pid, and when the scheduler switches
+    back to that pid, the timestamp difference is calculated.  If the
+    resulting latency, stored in wakeup_lat, exceeds the current
+    maximum latency, the values specified in the save() fields are
+    recoreded:
+
+    # echo 'hist:keys=pid:ts0=$common_timestamp.usecs \
+            if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+
+    # echo 'hist:keys=next_pid:\
+            wakeup_lat=$common_timestamp.usecs-$ts0:\
+            onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
+            if next_comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+
+    When the histogram is displayed, the max value and the saved
+    values corresponding to the max are displayed following the rest
+    of the fields:
+
+    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+      { next_pid:       2255 } hitcount:        239
+        common_timestamp-ts0:          0
+        max:         27
+	next_comm: cyclictest
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+
+      { next_pid:       2256 } hitcount:       2355
+        common_timestamp-ts0: 0
+        max:         49  next_comm: cyclictest
+        prev_pid:          0  prev_prio:        120  prev_comm: swapper/0
+
+      Totals:
+          Hits: 12970
+          Entries: 2
+          Dropped: 0
diff --git a/Documentation/trace/histograms.txt b/Documentation/trace/histograms.txt
deleted file mode 100644
--- a/Documentation/trace/histograms.txt
+++ /dev/null
@@ -1,186 +0,0 @@
-		Using the Linux Kernel Latency Histograms
-
-
-This document gives a short explanation how to enable, configure and use
-latency histograms. Latency histograms are primarily relevant in the
-context of real-time enabled kernels (CONFIG_PREEMPT/CONFIG_PREEMPT_RT)
-and are used in the quality management of the Linux real-time
-capabilities.
-
-
-* Purpose of latency histograms
-
-A latency histogram continuously accumulates the frequencies of latency
-data. There are two types of histograms
-- potential sources of latencies
-- effective latencies
-
-
-* Potential sources of latencies
-
-Potential sources of latencies are code segments where interrupts,
-preemption or both are disabled (aka critical sections). To create
-histograms of potential sources of latency, the kernel stores the time
-stamp at the start of a critical section, determines the time elapsed
-when the end of the section is reached, and increments the frequency
-counter of that latency value - irrespective of whether any concurrently
-running process is affected by latency or not.
-- Configuration items (in the Kernel hacking/Tracers submenu)
-  CONFIG_INTERRUPT_OFF_LATENCY
-  CONFIG_PREEMPT_OFF_LATENCY
-
-
-* Effective latencies
-
-Effective latencies are actually occuring during wakeup of a process. To
-determine effective latencies, the kernel stores the time stamp when a
-process is scheduled to be woken up, and determines the duration of the
-wakeup time shortly before control is passed over to this process. Note
-that the apparent latency in user space may be somewhat longer, since the
-process may be interrupted after control is passed over to it but before
-the execution in user space takes place. Simply measuring the interval
-between enqueuing and wakeup may also not appropriate in cases when a
-process is scheduled as a result of a timer expiration. The timer may have
-missed its deadline, e.g. due to disabled interrupts, but this latency
-would not be registered. Therefore, the offsets of missed timers are
-recorded in a separate histogram. If both wakeup latency and missed timer
-offsets are configured and enabled, a third histogram may be enabled that
-records the overall latency as a sum of the timer latency, if any, and the
-wakeup latency. This histogram is called "timerandwakeup".
-- Configuration items (in the Kernel hacking/Tracers submenu)
-  CONFIG_WAKEUP_LATENCY
-  CONFIG_MISSED_TIMER_OFSETS
-
-
-* Usage
-
-The interface to the administration of the latency histograms is located
-in the debugfs file system. To mount it, either enter
-
-mount -t sysfs nodev /sys
-mount -t debugfs nodev /sys/kernel/debug
-
-from shell command line level, or add
-
-nodev	/sys			sysfs	defaults	0 0
-nodev	/sys/kernel/debug	debugfs	defaults	0 0
-
-to the file /etc/fstab. All latency histogram related files are then
-available in the directory /sys/kernel/debug/tracing/latency_hist. A
-particular histogram type is enabled by writing non-zero to the related
-variable in the /sys/kernel/debug/tracing/latency_hist/enable directory.
-Select "preemptirqsoff" for the histograms of potential sources of
-latencies and "wakeup" for histograms of effective latencies etc. The
-histogram data - one per CPU - are available in the files
-
-/sys/kernel/debug/tracing/latency_hist/preemptoff/CPUx
-/sys/kernel/debug/tracing/latency_hist/irqsoff/CPUx
-/sys/kernel/debug/tracing/latency_hist/preemptirqsoff/CPUx
-/sys/kernel/debug/tracing/latency_hist/wakeup/CPUx
-/sys/kernel/debug/tracing/latency_hist/wakeup/sharedprio/CPUx
-/sys/kernel/debug/tracing/latency_hist/missed_timer_offsets/CPUx
-/sys/kernel/debug/tracing/latency_hist/timerandwakeup/CPUx
-
-The histograms are reset by writing non-zero to the file "reset" in a
-particular latency directory. To reset all latency data, use
-
-#!/bin/sh
-
-TRACINGDIR=/sys/kernel/debug/tracing
-HISTDIR=$TRACINGDIR/latency_hist
-
-if test -d $HISTDIR
-then
-  cd $HISTDIR
-  for i in `find . | grep /reset$`
-  do
-    echo 1 >$i
-  done
-fi
-
-
-* Data format
-
-Latency data are stored with a resolution of one microsecond. The
-maximum latency is 10,240 microseconds. The data are only valid, if the
-overflow register is empty. Every output line contains the latency in
-microseconds in the first row and the number of samples in the second
-row. To display only lines with a positive latency count, use, for
-example,
-
-grep -v " 0$" /sys/kernel/debug/tracing/latency_hist/preemptoff/CPU0
-
-#Minimum latency: 0 microseconds.
-#Average latency: 0 microseconds.
-#Maximum latency: 25 microseconds.
-#Total samples: 3104770694
-#There are 0 samples greater or equal than 10240 microseconds
-#usecs	         samples
-    0	      2984486876
-    1	        49843506
-    2	        58219047
-    3	         5348126
-    4	         2187960
-    5	         3388262
-    6	          959289
-    7	          208294
-    8	           40420
-    9	            4485
-   10	           14918
-   11	           18340
-   12	           25052
-   13	           19455
-   14	            5602
-   15	             969
-   16	              47
-   17	              18
-   18	              14
-   19	               1
-   20	               3
-   21	               2
-   22	               5
-   23	               2
-   25	               1
-
-
-* Wakeup latency of a selected process
-
-To only collect wakeup latency data of a particular process, write the
-PID of the requested process to
-
-/sys/kernel/debug/tracing/latency_hist/wakeup/pid
-
-PIDs are not considered, if this variable is set to 0.
-
-
-* Details of the process with the highest wakeup latency so far
-
-Selected data of the process that suffered from the highest wakeup
-latency that occurred in a particular CPU are available in the file
-
-/sys/kernel/debug/tracing/latency_hist/wakeup/max_latency-CPUx.
-
-In addition, other relevant system data at the time when the
-latency occurred are given.
-
-The format of the data is (all in one line):
-<PID> <Priority> <Latency> (<Timeroffset>) <Command> \
-<- <PID> <Priority> <Command> <Timestamp>
-
-The value of <Timeroffset> is only relevant in the combined timer
-and wakeup latency recording. In the wakeup recording, it is
-always 0, in the missed_timer_offsets recording, it is the same
-as <Latency>.
-
-When retrospectively searching for the origin of a latency and
-tracing was not enabled, it may be helpful to know the name and
-some basic data of the task that (finally) was switching to the
-late real-tlme task. In addition to the victim's data, also the
-data of the possible culprit are therefore displayed after the
-"<-" symbol.
-
-Finally, the timestamp of the time when the latency occurred
-in <seconds>.<microseconds> after the most recent system boot
-is provided.
-
-These data are also reset when the wakeup histogram is reset.
diff --git a/arch/Kconfig b/arch/Kconfig
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -56,7 +56,6 @@ config KPROBES
 config JUMP_LABEL
        bool "Optimize very unlikely/likely branches"
        depends on HAVE_ARCH_JUMP_LABEL
-       depends on (!INTERRUPT_OFF_HIST && !PREEMPT_OFF_HIST && !WAKEUP_LATENCY_HIST && !MISSED_TIMER_OFFSETS_HIST)
        help
          This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -86,10 +86,9 @@ enum hrtimer_restart {
  *		was armed.
  * @function:	timer expiry callback function
  * @base:	pointer to the timer base (per cpu and per clock)
- * @state:	state information (See bit values above)
  * @cb_entry:	list entry to defer timers from hardirq context
  * @irqsafe:	timer can run in hardirq context
- * @praecox:	timer expiry time if expired at the time of programming
+ * @state:	state information (See bit values above)
  * @is_rel:	Set if the timer was armed relative
  *
  * The hrtimer structure must be initialized by hrtimer_init()
@@ -99,12 +98,9 @@ struct hrtimer {
 	ktime_t				_softexpires;
 	enum hrtimer_restart		(*function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
-	u8				state;
 	struct list_head		cb_entry;
 	int				irqsafe;
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-	ktime_t				praecox;
-#endif
+	u8				state;
 	u8				is_rel;
 };
 
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -36,10 +36,12 @@ struct ring_buffer_event {
  *				 array[0] = time delta (28 .. 59)
  *				 size = 8 bytes
  *
- * @RINGBUF_TYPE_TIME_STAMP:	Sync time stamp with external clock
- *				 array[0]    = tv_nsec
- *				 array[1..2] = tv_sec
- *				 size = 16 bytes
+ * @RINGBUF_TYPE_TIME_STAMP:	Absolute timestamp
+ *				 Same format as TIME_EXTEND except that the
+ *				 value is an absolute timestamp, not a delta
+ *				 event.time_delta contains bottom 27 bits
+ *				 array[0] = top (28 .. 59) bits
+ *				 size = 8 bytes
  *
  * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
  *				Data record
@@ -56,12 +58,12 @@ enum ring_buffer_type {
 	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
 	RINGBUF_TYPE_PADDING,
 	RINGBUF_TYPE_TIME_EXTEND,
-	/* FIXME: RINGBUF_TYPE_TIME_STAMP not implemented */
 	RINGBUF_TYPE_TIME_STAMP,
 };
 
 unsigned ring_buffer_event_length(struct ring_buffer_event *event);
 void *ring_buffer_event_data(struct ring_buffer_event *event);
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event);
 
 /*
  * ring_buffer_discard_commit will remove an event that has not
@@ -180,6 +182,8 @@ void ring_buffer_normalize_time_stamp(struct ring_buffer *buffer,
 				      int cpu, u64 *ts);
 void ring_buffer_set_clock(struct ring_buffer *buffer,
 			   u64 (*clock)(void));
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs);
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
 size_t ring_buffer_page_len(void *page);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1023,12 +1023,7 @@ struct task_struct {
 	/* Bitmask and counter of trace recursion: */
 	unsigned long			trace_recursion;
 #endif /* CONFIG_TRACING */
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-	u64 preempt_timestamp_hist;
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-	long timer_offset;
-#endif
-#endif
+
 #ifdef CONFIG_KCOV
 	/* Coverage collection mode enabled for this task (0 if disabled): */
 	enum kcov_mode			kcov_mode;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -309,6 +309,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_MODE_BIT,
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
 	EVENT_FILE_FL_PID_FILTER_BIT,
+	EVENT_FILE_FL_NO_DISCARD_BIT,
 };
 
 /*
@@ -323,6 +324,7 @@ enum {
  *  TRIGGER_MODE  - When set, invoke the triggers associated with the event
  *  TRIGGER_COND  - When set, one or more triggers has an associated filter
  *  PID_FILTER    - When set, the event is filtered based on pid
+ *  NO_DISCARD    - When set, do not discard events, something needs them later
  */
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
@@ -334,6 +336,7 @@ enum {
 	EVENT_FILE_FL_TRIGGER_MODE	= (1 << EVENT_FILE_FL_TRIGGER_MODE_BIT),
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
 	EVENT_FILE_FL_PID_FILTER	= (1 << EVENT_FILE_FL_PID_FILTER_BIT),
+	EVENT_FILE_FL_NO_DISCARD	= (1 << EVENT_FILE_FL_NO_DISCARD_BIT),
 };
 
 struct trace_event_file {
@@ -403,11 +406,13 @@ enum event_trigger_type {
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
 
-extern enum event_trigger_type event_triggers_call(struct trace_event_file *file,
-						   void *rec);
-extern void event_triggers_post_call(struct trace_event_file *file,
-				     enum event_trigger_type tt,
-				     void *rec);
+extern enum event_trigger_type
+event_triggers_call(struct trace_event_file *file, void *rec,
+		    struct ring_buffer_event *event);
+extern void
+event_triggers_post_call(struct trace_event_file *file,
+			 enum event_trigger_type tt,
+			 void *rec, struct ring_buffer_event *event);
 
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
 
@@ -427,7 +432,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
 
 	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
 		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
-			event_triggers_call(file, NULL);
+			event_triggers_call(file, NULL, NULL);
 		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
 			return true;
 		if (eflags & EVENT_FILE_FL_PID_FILTER)
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -37,9 +37,12 @@ extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
 tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void *data,
-			       int prio);
+			       int prio, bool dynamic);
+extern int dynamic_tracepoint_probe_register(struct tracepoint *tp,
+					     void *probe, void *data);
 extern int
-tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
+tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data,
+			    bool dynamic);
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv);
@@ -206,13 +209,13 @@ extern void syscall_unregfunc(void);
 				   int prio)				\
 	{								\
 		return tracepoint_probe_register_prio(&__tracepoint_##name, \
-					      (void *)probe, data, prio); \
+				      (void *)probe, data, prio, false); \
 	}								\
 	static inline int						\
 	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
 	{								\
 		return tracepoint_probe_unregister(&__tracepoint_##name,\
-						(void *)probe, data);	\
+					   (void *)probe, data, false); \
 	}								\
 	static inline void						\
 	check_trace_callback_type_##name(void (*cb)(data_proto))	\
diff --git a/include/trace/events/hist.h b/include/trace/events/hist.h
deleted file mode 100644
--- a/include/trace/events/hist.h
+++ /dev/null
@@ -1,73 +0,0 @@
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM hist
-
-#if !defined(_TRACE_HIST_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_HIST_H
-
-#include "latency_hist.h"
-#include <linux/tracepoint.h>
-
-#if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
-#define trace_preemptirqsoff_hist(a, b)
-#define trace_preemptirqsoff_hist_rcuidle(a, b)
-#else
-TRACE_EVENT(preemptirqsoff_hist,
-
-	TP_PROTO(int reason, int starthist),
-
-	TP_ARGS(reason, starthist),
-
-	TP_STRUCT__entry(
-		__field(int,	reason)
-		__field(int,	starthist)
-	),
-
-	TP_fast_assign(
-		__entry->reason		= reason;
-		__entry->starthist	= starthist;
-	),
-
-	TP_printk("reason=%s starthist=%s", getaction(__entry->reason),
-		  __entry->starthist ? "start" : "stop")
-);
-#endif
-
-#ifndef CONFIG_MISSED_TIMER_OFFSETS_HIST
-#define trace_hrtimer_interrupt(a, b, c, d)
-#else
-TRACE_EVENT(hrtimer_interrupt,
-
-	TP_PROTO(int cpu, long long offset, struct task_struct *curr,
-		struct task_struct *task),
-
-	TP_ARGS(cpu, offset, curr, task),
-
-	TP_STRUCT__entry(
-		__field(int,		cpu)
-		__field(long long,	offset)
-		__array(char,		ccomm,	TASK_COMM_LEN)
-		__field(int,		cprio)
-		__array(char,		tcomm,	TASK_COMM_LEN)
-		__field(int,		tprio)
-	),
-
-	TP_fast_assign(
-		__entry->cpu	= cpu;
-		__entry->offset	= offset;
-		memcpy(__entry->ccomm, curr->comm, TASK_COMM_LEN);
-		__entry->cprio  = curr->prio;
-		memcpy(__entry->tcomm, task != NULL ? task->comm : "<none>",
-			task != NULL ? TASK_COMM_LEN : 7);
-		__entry->tprio  = task != NULL ? task->prio : -1;
-	),
-
-	TP_printk("cpu=%d offset=%lld curr=%s[%d] thread=%s[%d]",
-		__entry->cpu, __entry->offset, __entry->ccomm,
-		__entry->cprio, __entry->tcomm, __entry->tprio)
-);
-#endif
-
-#endif /* _TRACE_HIST_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff --git a/include/trace/events/latency_hist.h b/include/trace/events/latency_hist.h
deleted file mode 100644
--- a/include/trace/events/latency_hist.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef _LATENCY_HIST_H
-#define _LATENCY_HIST_H
-
-enum hist_action {
-	IRQS_ON,
-	PREEMPT_ON,
-	TRACE_STOP,
-	IRQS_OFF,
-	PREEMPT_OFF,
-	TRACE_START,
-};
-
-static char *actions[] = {
-	"IRQS_ON",
-	"PREEMPT_ON",
-	"TRACE_STOP",
-	"IRQS_OFF",
-	"PREEMPT_OFF",
-	"TRACE_START",
-};
-
-static inline char *getaction(int action)
-{
-	if (action >= 0 && action <= sizeof(actions)/sizeof(actions[0]))
-		return actions[action];
-	return "unknown";
-}
-
-#endif /* _LATENCY_HIST_H */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -50,7 +50,6 @@
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
 #include <linux/timer.h>
-#include <trace/events/hist.h>
 #include <linux/freezer.h>
 
 #include <linux/uaccess.h>
@@ -1013,16 +1012,7 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 
 	/* Switch the timer base, if necessary: */
 	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-	{
-		ktime_t now = new_base->get_time();
 
-		if (ktime_to_ns(tim) < ktime_to_ns(now))
-			timer->praecox = now;
-		else
-			timer->praecox = ktime_set(0, 0);
-	}
-#endif
 	leftmost = enqueue_hrtimer(timer, new_base);
 	if (!leftmost)
 		goto unlock;
@@ -1401,8 +1391,6 @@ static inline int hrtimer_rt_defer(struct hrtimer *timer) { return 0; }
 
 #endif
 
-static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);
-
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 {
 	struct hrtimer_clock_base *base = cpu_base->clock_base;
@@ -1423,15 +1411,6 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
 
 			timer = container_of(node, struct hrtimer, node);
 
-			trace_hrtimer_interrupt(raw_smp_processor_id(),
-			    ktime_to_ns(ktime_sub(ktime_to_ns(timer->praecox) ?
-				timer->praecox : hrtimer_get_expires(timer),
-				basenow)),
-			    current,
-			    timer->function == hrtimer_wakeup ?
-			    container_of(timer, struct hrtimer_sleeper,
-				timer)->task : NULL);
-
 			/*
 			 * The immediate goal for using the softexpires is
 			 * minimizing wakeups, not running timers at the
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -184,24 +184,6 @@ config IRQSOFF_TRACER
 	  enabled. This option and the preempt-off timing option can be
 	  used together or separately.)
 
-config INTERRUPT_OFF_HIST
-	bool "Interrupts-off Latency Histogram"
-	depends on IRQSOFF_TRACER
-	help
-	  This option generates continuously updated histograms (one per cpu)
-	  of the duration of time periods with interrupts disabled. The
-	  histograms are disabled by default. To enable them, write a non-zero
-	  number to
-
-	      /sys/kernel/debug/tracing/latency_hist/enable/preemptirqsoff
-
-	  If PREEMPT_OFF_HIST is also selected, additional histograms (one
-	  per cpu) are generated that accumulate the duration of time periods
-	  when both interrupts and preemption are disabled. The histogram data
-	  will be located in the debug file system at
-
-	      /sys/kernel/debug/tracing/latency_hist/irqsoff
-
 config PREEMPT_TRACER
 	bool "Preemption-off Latency Tracer"
 	default n
@@ -226,24 +208,6 @@ config PREEMPT_TRACER
 	  enabled. This option and the irqs-off timing option can be
 	  used together or separately.)
 
-config PREEMPT_OFF_HIST
-	bool "Preemption-off Latency Histogram"
-	depends on PREEMPT_TRACER
-	help
-	  This option generates continuously updated histograms (one per cpu)
-	  of the duration of time periods with preemption disabled. The
-	  histograms are disabled by default. To enable them, write a non-zero
-	  number to
-
-	      /sys/kernel/debug/tracing/latency_hist/enable/preemptirqsoff
-
-	  If INTERRUPT_OFF_HIST is also selected, additional histograms (one
-	  per cpu) are generated that accumulate the duration of time periods
-	  when both interrupts and preemption are disabled. The histogram data
-	  will be located in the debug file system at
-
-	      /sys/kernel/debug/tracing/latency_hist/preemptoff
-
 config SCHED_TRACER
 	bool "Scheduling Latency Tracer"
 	select GENERIC_TRACER
@@ -289,74 +253,6 @@ config HWLAT_TRACER
 	 file. Every time a latency is greater than tracing_thresh, it will
 	 be recorded into the ring buffer.
 
-config WAKEUP_LATENCY_HIST
-	bool "Scheduling Latency Histogram"
-	depends on SCHED_TRACER
-	help
-	  This option generates continuously updated histograms (one per cpu)
-	  of the scheduling latency of the highest priority task.
-	  The histograms are disabled by default. To enable them, write a
-	  non-zero number to
-
-	      /sys/kernel/debug/tracing/latency_hist/enable/wakeup
-
-	  Two different algorithms are used, one to determine the latency of
-	  processes that exclusively use the highest priority of the system and
-	  another one to determine the latency of processes that share the
-	  highest system priority with other processes. The former is used to
-	  improve hardware and system software, the latter to optimize the
-	  priority design of a given system. The histogram data will be
-	  located in the debug file system at
-
-	      /sys/kernel/debug/tracing/latency_hist/wakeup
-
-	  and
-
-	      /sys/kernel/debug/tracing/latency_hist/wakeup/sharedprio
-
-	  If both Scheduling Latency Histogram and Missed Timer Offsets
-	  Histogram are selected, additional histogram data will be collected
-	  that contain, in addition to the wakeup latency, the timer latency, in
-	  case the wakeup was triggered by an expired timer. These histograms
-	  are available in the
-
-	      /sys/kernel/debug/tracing/latency_hist/timerandwakeup
-
-	  directory. They reflect the apparent interrupt and scheduling latency
-	  and are best suitable to determine the worst-case latency of a given
-	  system. To enable these histograms, write a non-zero number to
-
-	      /sys/kernel/debug/tracing/latency_hist/enable/timerandwakeup
-
-config MISSED_TIMER_OFFSETS_HIST
-	depends on HIGH_RES_TIMERS
-	select GENERIC_TRACER
-	bool "Missed Timer Offsets Histogram"
-	help
-	  Generate a histogram of missed timer offsets in microseconds. The
-	  histograms are disabled by default. To enable them, write a non-zero
-	  number to
-
-	      /sys/kernel/debug/tracing/latency_hist/enable/missed_timer_offsets
-
-	  The histogram data will be located in the debug file system at
-
-	      /sys/kernel/debug/tracing/latency_hist/missed_timer_offsets
-
-	  If both Scheduling Latency Histogram and Missed Timer Offsets
-	  Histogram are selected, additional histogram data will be collected
-	  that contain, in addition to the wakeup latency, the timer latency, in
-	  case the wakeup was triggered by an expired timer. These histograms
-	  are available in the
-
-	      /sys/kernel/debug/tracing/latency_hist/timerandwakeup
-
-	  directory. They reflect the apparent interrupt and scheduling latency
-	  and are best suitable to determine the worst-case latency of a given
-	  system. To enable these histograms, write a non-zero number to
-
-	      /sys/kernel/debug/tracing/latency_hist/enable/timerandwakeup
-
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
 	depends on !GENERIC_TRACER
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -38,10 +38,6 @@ obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
 obj-$(CONFIG_HWLAT_TRACER) += trace_hwlat.o
-obj-$(CONFIG_INTERRUPT_OFF_HIST) += latency_hist.o
-obj-$(CONFIG_PREEMPT_OFF_HIST) += latency_hist.o
-obj-$(CONFIG_WAKEUP_LATENCY_HIST) += latency_hist.o
-obj-$(CONFIG_MISSED_TIMER_OFFSETS_HIST) += latency_hist.o
 obj-$(CONFIG_NOP_TRACER) += trace_nop.o
 obj-$(CONFIG_STACK_TRACER) += trace_stack.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
diff --git a/kernel/trace/latency_hist.c b/kernel/trace/latency_hist.c
deleted file mode 100644
--- a/kernel/trace/latency_hist.c
+++ /dev/null
@@ -1,1178 +0,0 @@
-/*
- * kernel/trace/latency_hist.c
- *
- * Add support for histograms of preemption-off latency and
- * interrupt-off latency and wakeup latency, it depends on
- * Real-Time Preemption Support.
- *
- *  Copyright (C) 2005 MontaVista Software, Inc.
- *  Yi Yang <yyang@ch.mvista.com>
- *
- *  Converted to work with the new latency tracer.
- *  Copyright (C) 2008 Red Hat, Inc.
- *    Steven Rostedt <srostedt@redhat.com>
- *
- */
-#include <linux/module.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/percpu.h>
-#include <linux/kallsyms.h>
-#include <linux/uaccess.h>
-#include <linux/sched.h>
-#include <linux/sched/rt.h>
-#include <linux/slab.h>
-#include <linux/atomic.h>
-#include <asm/div64.h>
-
-#include "trace.h"
-#include <trace/events/sched.h>
-
-#define NSECS_PER_USECS 1000L
-
-#define CREATE_TRACE_POINTS
-#include <trace/events/hist.h>
-
-enum {
-	IRQSOFF_LATENCY = 0,
-	PREEMPTOFF_LATENCY,
-	PREEMPTIRQSOFF_LATENCY,
-	WAKEUP_LATENCY,
-	WAKEUP_LATENCY_SHAREDPRIO,
-	MISSED_TIMER_OFFSETS,
-	TIMERANDWAKEUP_LATENCY,
-	MAX_LATENCY_TYPE,
-};
-
-#define MAX_ENTRY_NUM 10240
-
-struct hist_data {
-	atomic_t hist_mode; /* 0 log, 1 don't log */
-	long offset; /* set it to MAX_ENTRY_NUM/2 for a bipolar scale */
-	long min_lat;
-	long max_lat;
-	unsigned long long below_hist_bound_samples;
-	unsigned long long above_hist_bound_samples;
-	long long accumulate_lat;
-	unsigned long long total_samples;
-	unsigned long long hist_array[MAX_ENTRY_NUM];
-};
-
-struct enable_data {
-	int latency_type;
-	int enabled;
-};
-
-static char *latency_hist_dir_root = "latency_hist";
-
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-static DEFINE_PER_CPU(struct hist_data, irqsoff_hist);
-static char *irqsoff_hist_dir = "irqsoff";
-static DEFINE_PER_CPU(cycles_t, hist_irqsoff_start);
-static DEFINE_PER_CPU(int, hist_irqsoff_counting);
-#endif
-
-#ifdef CONFIG_PREEMPT_OFF_HIST
-static DEFINE_PER_CPU(struct hist_data, preemptoff_hist);
-static char *preemptoff_hist_dir = "preemptoff";
-static DEFINE_PER_CPU(cycles_t, hist_preemptoff_start);
-static DEFINE_PER_CPU(int, hist_preemptoff_counting);
-#endif
-
-#if defined(CONFIG_PREEMPT_OFF_HIST) && defined(CONFIG_INTERRUPT_OFF_HIST)
-static DEFINE_PER_CPU(struct hist_data, preemptirqsoff_hist);
-static char *preemptirqsoff_hist_dir = "preemptirqsoff";
-static DEFINE_PER_CPU(cycles_t, hist_preemptirqsoff_start);
-static DEFINE_PER_CPU(int, hist_preemptirqsoff_counting);
-#endif
-
-#if defined(CONFIG_PREEMPT_OFF_HIST) || defined(CONFIG_INTERRUPT_OFF_HIST)
-static notrace void probe_preemptirqsoff_hist(void *v, int reason, int start);
-static struct enable_data preemptirqsoff_enabled_data = {
-	.latency_type = PREEMPTIRQSOFF_LATENCY,
-	.enabled = 0,
-};
-#endif
-
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-struct maxlatproc_data {
-	char comm[FIELD_SIZEOF(struct task_struct, comm)];
-	char current_comm[FIELD_SIZEOF(struct task_struct, comm)];
-	int pid;
-	int current_pid;
-	int prio;
-	int current_prio;
-	long latency;
-	long timeroffset;
-	u64 timestamp;
-};
-#endif
-
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-static DEFINE_PER_CPU(struct hist_data, wakeup_latency_hist);
-static DEFINE_PER_CPU(struct hist_data, wakeup_latency_hist_sharedprio);
-static char *wakeup_latency_hist_dir = "wakeup";
-static char *wakeup_latency_hist_dir_sharedprio = "sharedprio";
-static notrace void probe_wakeup_latency_hist_start(void *v,
-	struct task_struct *p);
-static notrace void probe_wakeup_latency_hist_stop(void *v,
-	bool preempt, struct task_struct *prev, struct task_struct *next);
-static notrace void probe_sched_migrate_task(void *,
-	struct task_struct *task, int cpu);
-static struct enable_data wakeup_latency_enabled_data = {
-	.latency_type = WAKEUP_LATENCY,
-	.enabled = 0,
-};
-static DEFINE_PER_CPU(struct maxlatproc_data, wakeup_maxlatproc);
-static DEFINE_PER_CPU(struct maxlatproc_data, wakeup_maxlatproc_sharedprio);
-static DEFINE_PER_CPU(struct task_struct *, wakeup_task);
-static DEFINE_PER_CPU(int, wakeup_sharedprio);
-static unsigned long wakeup_pid;
-#endif
-
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-static DEFINE_PER_CPU(struct hist_data, missed_timer_offsets);
-static char *missed_timer_offsets_dir = "missed_timer_offsets";
-static notrace void probe_hrtimer_interrupt(void *v, int cpu,
-	long long offset, struct task_struct *curr, struct task_struct *task);
-static struct enable_data missed_timer_offsets_enabled_data = {
-	.latency_type = MISSED_TIMER_OFFSETS,
-	.enabled = 0,
-};
-static DEFINE_PER_CPU(struct maxlatproc_data, missed_timer_offsets_maxlatproc);
-static unsigned long missed_timer_offsets_pid;
-#endif
-
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-static DEFINE_PER_CPU(struct hist_data, timerandwakeup_latency_hist);
-static char *timerandwakeup_latency_hist_dir = "timerandwakeup";
-static struct enable_data timerandwakeup_enabled_data = {
-	.latency_type = TIMERANDWAKEUP_LATENCY,
-	.enabled = 0,
-};
-static DEFINE_PER_CPU(struct maxlatproc_data, timerandwakeup_maxlatproc);
-#endif
-
-void notrace latency_hist(int latency_type, int cpu, long latency,
-			  long timeroffset, u64 stop,
-			  struct task_struct *p)
-{
-	struct hist_data *my_hist;
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-	struct maxlatproc_data *mp = NULL;
-#endif
-
-	if (!cpu_possible(cpu) || latency_type < 0 ||
-	    latency_type >= MAX_LATENCY_TYPE)
-		return;
-
-	switch (latency_type) {
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-	case IRQSOFF_LATENCY:
-		my_hist = &per_cpu(irqsoff_hist, cpu);
-		break;
-#endif
-#ifdef CONFIG_PREEMPT_OFF_HIST
-	case PREEMPTOFF_LATENCY:
-		my_hist = &per_cpu(preemptoff_hist, cpu);
-		break;
-#endif
-#if defined(CONFIG_PREEMPT_OFF_HIST) && defined(CONFIG_INTERRUPT_OFF_HIST)
-	case PREEMPTIRQSOFF_LATENCY:
-		my_hist = &per_cpu(preemptirqsoff_hist, cpu);
-		break;
-#endif
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-	case WAKEUP_LATENCY:
-		my_hist = &per_cpu(wakeup_latency_hist, cpu);
-		mp = &per_cpu(wakeup_maxlatproc, cpu);
-		break;
-	case WAKEUP_LATENCY_SHAREDPRIO:
-		my_hist = &per_cpu(wakeup_latency_hist_sharedprio, cpu);
-		mp = &per_cpu(wakeup_maxlatproc_sharedprio, cpu);
-		break;
-#endif
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-	case MISSED_TIMER_OFFSETS:
-		my_hist = &per_cpu(missed_timer_offsets, cpu);
-		mp = &per_cpu(missed_timer_offsets_maxlatproc, cpu);
-		break;
-#endif
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-	case TIMERANDWAKEUP_LATENCY:
-		my_hist = &per_cpu(timerandwakeup_latency_hist, cpu);
-		mp = &per_cpu(timerandwakeup_maxlatproc, cpu);
-		break;
-#endif
-
-	default:
-		return;
-	}
-
-	latency += my_hist->offset;
-
-	if (atomic_read(&my_hist->hist_mode) == 0)
-		return;
-
-	if (latency < 0 || latency >= MAX_ENTRY_NUM) {
-		if (latency < 0)
-			my_hist->below_hist_bound_samples++;
-		else
-			my_hist->above_hist_bound_samples++;
-	} else
-		my_hist->hist_array[latency]++;
-
-	if (unlikely(latency > my_hist->max_lat ||
-	    my_hist->min_lat == LONG_MAX)) {
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-		if (latency_type == WAKEUP_LATENCY ||
-		    latency_type == WAKEUP_LATENCY_SHAREDPRIO ||
-		    latency_type == MISSED_TIMER_OFFSETS ||
-		    latency_type == TIMERANDWAKEUP_LATENCY) {
-			strncpy(mp->comm, p->comm, sizeof(mp->comm));
-			strncpy(mp->current_comm, current->comm,
-			    sizeof(mp->current_comm));
-			mp->pid = task_pid_nr(p);
-			mp->current_pid = task_pid_nr(current);
-			mp->prio = p->prio;
-			mp->current_prio = current->prio;
-			mp->latency = latency;
-			mp->timeroffset = timeroffset;
-			mp->timestamp = stop;
-		}
-#endif
-		my_hist->max_lat = latency;
-	}
-	if (unlikely(latency < my_hist->min_lat))
-		my_hist->min_lat = latency;
-	my_hist->total_samples++;
-	my_hist->accumulate_lat += latency;
-}
-
-static void *l_start(struct seq_file *m, loff_t *pos)
-{
-	loff_t *index_ptr = NULL;
-	loff_t index = *pos;
-	struct hist_data *my_hist = m->private;
-
-	if (index == 0) {
-		char minstr[32], avgstr[32], maxstr[32];
-
-		atomic_dec(&my_hist->hist_mode);
-
-		if (likely(my_hist->total_samples)) {
-			long avg = (long) div64_s64(my_hist->accumulate_lat,
-			    my_hist->total_samples);
-			snprintf(minstr, sizeof(minstr), "%ld",
-			    my_hist->min_lat - my_hist->offset);
-			snprintf(avgstr, sizeof(avgstr), "%ld",
-			    avg - my_hist->offset);
-			snprintf(maxstr, sizeof(maxstr), "%ld",
-			    my_hist->max_lat - my_hist->offset);
-		} else {
-			strcpy(minstr, "<undef>");
-			strcpy(avgstr, minstr);
-			strcpy(maxstr, minstr);
-		}
-
-		seq_printf(m, "#Minimum latency: %s microseconds\n"
-			   "#Average latency: %s microseconds\n"
-			   "#Maximum latency: %s microseconds\n"
-			   "#Total samples: %llu\n"
-			   "#There are %llu samples lower than %ld"
-			   " microseconds.\n"
-			   "#There are %llu samples greater or equal"
-			   " than %ld microseconds.\n"
-			   "#usecs\t%16s\n",
-			   minstr, avgstr, maxstr,
-			   my_hist->total_samples,
-			   my_hist->below_hist_bound_samples,
-			   -my_hist->offset,
-			   my_hist->above_hist_bound_samples,
-			   MAX_ENTRY_NUM - my_hist->offset,
-			   "samples");
-	}
-	if (index < MAX_ENTRY_NUM) {
-		index_ptr = kmalloc(sizeof(loff_t), GFP_KERNEL);
-		if (index_ptr)
-			*index_ptr = index;
-	}
-
-	return index_ptr;
-}
-
-static void *l_next(struct seq_file *m, void *p, loff_t *pos)
-{
-	loff_t *index_ptr = p;
-	struct hist_data *my_hist = m->private;
-
-	if (++*pos >= MAX_ENTRY_NUM) {
-		atomic_inc(&my_hist->hist_mode);
-		return NULL;
-	}
-	*index_ptr = *pos;
-	return index_ptr;
-}
-
-static void l_stop(struct seq_file *m, void *p)
-{
-	kfree(p);
-}
-
-static int l_show(struct seq_file *m, void *p)
-{
-	int index = *(loff_t *) p;
-	struct hist_data *my_hist = m->private;
-
-	seq_printf(m, "%6ld\t%16llu\n", index - my_hist->offset,
-	    my_hist->hist_array[index]);
-	return 0;
-}
-
-static const struct seq_operations latency_hist_seq_op = {
-	.start = l_start,
-	.next  = l_next,
-	.stop  = l_stop,
-	.show  = l_show
-};
-
-static int latency_hist_open(struct inode *inode, struct file *file)
-{
-	int ret;
-
-	ret = seq_open(file, &latency_hist_seq_op);
-	if (!ret) {
-		struct seq_file *seq = file->private_data;
-		seq->private = inode->i_private;
-	}
-	return ret;
-}
-
-static const struct file_operations latency_hist_fops = {
-	.open = latency_hist_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
-
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-static void clear_maxlatprocdata(struct maxlatproc_data *mp)
-{
-	mp->comm[0] = mp->current_comm[0] = '\0';
-	mp->prio = mp->current_prio = mp->pid = mp->current_pid =
-	    mp->latency = mp->timeroffset = -1;
-	mp->timestamp = 0;
-}
-#endif
-
-static void hist_reset(struct hist_data *hist)
-{
-	atomic_dec(&hist->hist_mode);
-
-	memset(hist->hist_array, 0, sizeof(hist->hist_array));
-	hist->below_hist_bound_samples = 0ULL;
-	hist->above_hist_bound_samples = 0ULL;
-	hist->min_lat = LONG_MAX;
-	hist->max_lat = LONG_MIN;
-	hist->total_samples = 0ULL;
-	hist->accumulate_lat = 0LL;
-
-	atomic_inc(&hist->hist_mode);
-}
-
-static ssize_t
-latency_hist_reset(struct file *file, const char __user *a,
-		   size_t size, loff_t *off)
-{
-	int cpu;
-	struct hist_data *hist = NULL;
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-	struct maxlatproc_data *mp = NULL;
-#endif
-	off_t latency_type = (off_t) file->private_data;
-
-	for_each_online_cpu(cpu) {
-
-		switch (latency_type) {
-#ifdef CONFIG_PREEMPT_OFF_HIST
-		case PREEMPTOFF_LATENCY:
-			hist = &per_cpu(preemptoff_hist, cpu);
-			break;
-#endif
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-		case IRQSOFF_LATENCY:
-			hist = &per_cpu(irqsoff_hist, cpu);
-			break;
-#endif
-#if defined(CONFIG_INTERRUPT_OFF_HIST) && defined(CONFIG_PREEMPT_OFF_HIST)
-		case PREEMPTIRQSOFF_LATENCY:
-			hist = &per_cpu(preemptirqsoff_hist, cpu);
-			break;
-#endif
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-		case WAKEUP_LATENCY:
-			hist = &per_cpu(wakeup_latency_hist, cpu);
-			mp = &per_cpu(wakeup_maxlatproc, cpu);
-			break;
-		case WAKEUP_LATENCY_SHAREDPRIO:
-			hist = &per_cpu(wakeup_latency_hist_sharedprio, cpu);
-			mp = &per_cpu(wakeup_maxlatproc_sharedprio, cpu);
-			break;
-#endif
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-		case MISSED_TIMER_OFFSETS:
-			hist = &per_cpu(missed_timer_offsets, cpu);
-			mp = &per_cpu(missed_timer_offsets_maxlatproc, cpu);
-			break;
-#endif
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-		case TIMERANDWAKEUP_LATENCY:
-			hist = &per_cpu(timerandwakeup_latency_hist, cpu);
-			mp = &per_cpu(timerandwakeup_maxlatproc, cpu);
-			break;
-#endif
-		}
-
-		hist_reset(hist);
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-		if (latency_type == WAKEUP_LATENCY ||
-		    latency_type == WAKEUP_LATENCY_SHAREDPRIO ||
-		    latency_type == MISSED_TIMER_OFFSETS ||
-		    latency_type == TIMERANDWAKEUP_LATENCY)
-			clear_maxlatprocdata(mp);
-#endif
-	}
-
-	return size;
-}
-
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-static ssize_t
-show_pid(struct file *file, char __user *ubuf, size_t cnt, loff_t *ppos)
-{
-	char buf[64];
-	int r;
-	unsigned long *this_pid = file->private_data;
-
-	r = snprintf(buf, sizeof(buf), "%lu\n", *this_pid);
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
-}
-
-static ssize_t do_pid(struct file *file, const char __user *ubuf,
-		      size_t cnt, loff_t *ppos)
-{
-	char buf[64];
-	unsigned long pid;
-	unsigned long *this_pid = file->private_data;
-
-	if (cnt >= sizeof(buf))
-		return -EINVAL;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = '\0';
-
-	if (kstrtoul(buf, 10, &pid))
-		return -EINVAL;
-
-	*this_pid = pid;
-
-	return cnt;
-}
-#endif
-
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-static ssize_t
-show_maxlatproc(struct file *file, char __user *ubuf, size_t cnt, loff_t *ppos)
-{
-	int r;
-	struct maxlatproc_data *mp = file->private_data;
-	int strmaxlen = (TASK_COMM_LEN * 2) + (8 * 8);
-	unsigned long long t;
-	unsigned long usecs, secs;
-	char *buf;
-
-	if (mp->pid == -1 || mp->current_pid == -1) {
-		buf = "(none)\n";
-		return simple_read_from_buffer(ubuf, cnt, ppos, buf,
-		    strlen(buf));
-	}
-
-	buf = kmalloc(strmaxlen, GFP_KERNEL);
-	if (buf == NULL)
-		return -ENOMEM;
-
-	t = ns2usecs(mp->timestamp);
-	usecs = do_div(t, USEC_PER_SEC);
-	secs = (unsigned long) t;
-	r = snprintf(buf, strmaxlen,
-	    "%d %d %ld (%ld) %s <- %d %d %s %lu.%06lu\n", mp->pid,
-	    MAX_RT_PRIO-1 - mp->prio, mp->latency, mp->timeroffset, mp->comm,
-	    mp->current_pid, MAX_RT_PRIO-1 - mp->current_prio, mp->current_comm,
-	    secs, usecs);
-	r = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
-	kfree(buf);
-	return r;
-}
-#endif
-
-static ssize_t
-show_enable(struct file *file, char __user *ubuf, size_t cnt, loff_t *ppos)
-{
-	char buf[64];
-	struct enable_data *ed = file->private_data;
-	int r;
-
-	r = snprintf(buf, sizeof(buf), "%d\n", ed->enabled);
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
-}
-
-static ssize_t
-do_enable(struct file *file, const char __user *ubuf, size_t cnt, loff_t *ppos)
-{
-	char buf[64];
-	long enable;
-	struct enable_data *ed = file->private_data;
-
-	if (cnt >= sizeof(buf))
-		return -EINVAL;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-
-	if (kstrtoul(buf, 10, &enable))
-		return -EINVAL;
-
-	if ((enable && ed->enabled) || (!enable && !ed->enabled))
-		return cnt;
-
-	if (enable) {
-		int ret;
-
-		switch (ed->latency_type) {
-#if defined(CONFIG_INTERRUPT_OFF_HIST) || defined(CONFIG_PREEMPT_OFF_HIST)
-		case PREEMPTIRQSOFF_LATENCY:
-			ret = register_trace_preemptirqsoff_hist(
-			    probe_preemptirqsoff_hist, NULL);
-			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_preemptirqsoff_hist "
-				    "to trace_preemptirqsoff_hist\n");
-				return ret;
-			}
-			break;
-#endif
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-		case WAKEUP_LATENCY:
-			ret = register_trace_sched_wakeup(
-			    probe_wakeup_latency_hist_start, NULL);
-			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_wakeup_latency_hist_start "
-				    "to trace_sched_wakeup\n");
-				return ret;
-			}
-			ret = register_trace_sched_wakeup_new(
-			    probe_wakeup_latency_hist_start, NULL);
-			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_wakeup_latency_hist_start "
-				    "to trace_sched_wakeup_new\n");
-				unregister_trace_sched_wakeup(
-				    probe_wakeup_latency_hist_start, NULL);
-				return ret;
-			}
-			ret = register_trace_sched_switch(
-			    probe_wakeup_latency_hist_stop, NULL);
-			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_wakeup_latency_hist_stop "
-				    "to trace_sched_switch\n");
-				unregister_trace_sched_wakeup(
-				    probe_wakeup_latency_hist_start, NULL);
-				unregister_trace_sched_wakeup_new(
-				    probe_wakeup_latency_hist_start, NULL);
-				return ret;
-			}
-			ret = register_trace_sched_migrate_task(
-			    probe_sched_migrate_task, NULL);
-			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_sched_migrate_task "
-				    "to trace_sched_migrate_task\n");
-				unregister_trace_sched_wakeup(
-				    probe_wakeup_latency_hist_start, NULL);
-				unregister_trace_sched_wakeup_new(
-				    probe_wakeup_latency_hist_start, NULL);
-				unregister_trace_sched_switch(
-				    probe_wakeup_latency_hist_stop, NULL);
-				return ret;
-			}
-			break;
-#endif
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-		case MISSED_TIMER_OFFSETS:
-			ret = register_trace_hrtimer_interrupt(
-			    probe_hrtimer_interrupt, NULL);
-			if (ret) {
-				pr_info("wakeup trace: Couldn't assign "
-				    "probe_hrtimer_interrupt "
-				    "to trace_hrtimer_interrupt\n");
-				return ret;
-			}
-			break;
-#endif
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-		case TIMERANDWAKEUP_LATENCY:
-			if (!wakeup_latency_enabled_data.enabled ||
-			    !missed_timer_offsets_enabled_data.enabled)
-				return -EINVAL;
-			break;
-#endif
-		default:
-			break;
-		}
-	} else {
-		switch (ed->latency_type) {
-#if defined(CONFIG_INTERRUPT_OFF_HIST) || defined(CONFIG_PREEMPT_OFF_HIST)
-		case PREEMPTIRQSOFF_LATENCY:
-			{
-				int cpu;
-
-				unregister_trace_preemptirqsoff_hist(
-				    probe_preemptirqsoff_hist, NULL);
-				for_each_online_cpu(cpu) {
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-					per_cpu(hist_irqsoff_counting,
-					    cpu) = 0;
-#endif
-#ifdef CONFIG_PREEMPT_OFF_HIST
-					per_cpu(hist_preemptoff_counting,
-					    cpu) = 0;
-#endif
-#if defined(CONFIG_INTERRUPT_OFF_HIST) && defined(CONFIG_PREEMPT_OFF_HIST)
-					per_cpu(hist_preemptirqsoff_counting,
-					    cpu) = 0;
-#endif
-				}
-			}
-			break;
-#endif
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-		case WAKEUP_LATENCY:
-			{
-				int cpu;
-
-				unregister_trace_sched_wakeup(
-				    probe_wakeup_latency_hist_start, NULL);
-				unregister_trace_sched_wakeup_new(
-				    probe_wakeup_latency_hist_start, NULL);
-				unregister_trace_sched_switch(
-				    probe_wakeup_latency_hist_stop, NULL);
-				unregister_trace_sched_migrate_task(
-				    probe_sched_migrate_task, NULL);
-
-				for_each_online_cpu(cpu) {
-					per_cpu(wakeup_task, cpu) = NULL;
-					per_cpu(wakeup_sharedprio, cpu) = 0;
-				}
-			}
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-			timerandwakeup_enabled_data.enabled = 0;
-#endif
-			break;
-#endif
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-		case MISSED_TIMER_OFFSETS:
-			unregister_trace_hrtimer_interrupt(
-			    probe_hrtimer_interrupt, NULL);
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-			timerandwakeup_enabled_data.enabled = 0;
-#endif
-			break;
-#endif
-		default:
-			break;
-		}
-	}
-	ed->enabled = enable;
-	return cnt;
-}
-
-static const struct file_operations latency_hist_reset_fops = {
-	.open = tracing_open_generic,
-	.write = latency_hist_reset,
-};
-
-static const struct file_operations enable_fops = {
-	.open = tracing_open_generic,
-	.read = show_enable,
-	.write = do_enable,
-};
-
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-static const struct file_operations pid_fops = {
-	.open = tracing_open_generic,
-	.read = show_pid,
-	.write = do_pid,
-};
-
-static const struct file_operations maxlatproc_fops = {
-	.open = tracing_open_generic,
-	.read = show_maxlatproc,
-};
-#endif
-
-#if defined(CONFIG_INTERRUPT_OFF_HIST) || defined(CONFIG_PREEMPT_OFF_HIST)
-static notrace void probe_preemptirqsoff_hist(void *v, int reason,
-	int starthist)
-{
-	int cpu = raw_smp_processor_id();
-	int time_set = 0;
-
-	if (starthist) {
-		u64 uninitialized_var(start);
-
-		if (!preempt_count() && !irqs_disabled())
-			return;
-
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-		if ((reason == IRQS_OFF || reason == TRACE_START) &&
-		    !per_cpu(hist_irqsoff_counting, cpu)) {
-			per_cpu(hist_irqsoff_counting, cpu) = 1;
-			start = ftrace_now(cpu);
-			time_set++;
-			per_cpu(hist_irqsoff_start, cpu) = start;
-		}
-#endif
-
-#ifdef CONFIG_PREEMPT_OFF_HIST
-		if ((reason == PREEMPT_OFF || reason == TRACE_START) &&
-		    !per_cpu(hist_preemptoff_counting, cpu)) {
-			per_cpu(hist_preemptoff_counting, cpu) = 1;
-			if (!(time_set++))
-				start = ftrace_now(cpu);
-			per_cpu(hist_preemptoff_start, cpu) = start;
-		}
-#endif
-
-#if defined(CONFIG_INTERRUPT_OFF_HIST) && defined(CONFIG_PREEMPT_OFF_HIST)
-		if (per_cpu(hist_irqsoff_counting, cpu) &&
-		    per_cpu(hist_preemptoff_counting, cpu) &&
-		    !per_cpu(hist_preemptirqsoff_counting, cpu)) {
-			per_cpu(hist_preemptirqsoff_counting, cpu) = 1;
-			if (!time_set)
-				start = ftrace_now(cpu);
-			per_cpu(hist_preemptirqsoff_start, cpu) = start;
-		}
-#endif
-	} else {
-		u64 uninitialized_var(stop);
-
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-		if ((reason == IRQS_ON || reason == TRACE_STOP) &&
-		    per_cpu(hist_irqsoff_counting, cpu)) {
-			u64 start = per_cpu(hist_irqsoff_start, cpu);
-
-			stop = ftrace_now(cpu);
-			time_set++;
-			if (start) {
-				long latency = ((long) (stop - start)) /
-				    NSECS_PER_USECS;
-
-				latency_hist(IRQSOFF_LATENCY, cpu, latency, 0,
-				    stop, NULL);
-			}
-			per_cpu(hist_irqsoff_counting, cpu) = 0;
-		}
-#endif
-
-#ifdef CONFIG_PREEMPT_OFF_HIST
-		if ((reason == PREEMPT_ON || reason == TRACE_STOP) &&
-		    per_cpu(hist_preemptoff_counting, cpu)) {
-			u64 start = per_cpu(hist_preemptoff_start, cpu);
-
-			if (!(time_set++))
-				stop = ftrace_now(cpu);
-			if (start) {
-				long latency = ((long) (stop - start)) /
-				    NSECS_PER_USECS;
-
-				latency_hist(PREEMPTOFF_LATENCY, cpu, latency,
-				    0, stop, NULL);
-			}
-			per_cpu(hist_preemptoff_counting, cpu) = 0;
-		}
-#endif
-
-#if defined(CONFIG_INTERRUPT_OFF_HIST) && defined(CONFIG_PREEMPT_OFF_HIST)
-		if ((!per_cpu(hist_irqsoff_counting, cpu) ||
-		     !per_cpu(hist_preemptoff_counting, cpu)) &&
-		   per_cpu(hist_preemptirqsoff_counting, cpu)) {
-			u64 start = per_cpu(hist_preemptirqsoff_start, cpu);
-
-			if (!time_set)
-				stop = ftrace_now(cpu);
-			if (start) {
-				long latency = ((long) (stop - start)) /
-				    NSECS_PER_USECS;
-
-				latency_hist(PREEMPTIRQSOFF_LATENCY, cpu,
-				    latency, 0, stop, NULL);
-			}
-			per_cpu(hist_preemptirqsoff_counting, cpu) = 0;
-		}
-#endif
-	}
-}
-#endif
-
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-static DEFINE_RAW_SPINLOCK(wakeup_lock);
-static notrace void probe_sched_migrate_task(void *v, struct task_struct *task,
-	int cpu)
-{
-	int old_cpu = task_cpu(task);
-
-	if (cpu != old_cpu) {
-		unsigned long flags;
-		struct task_struct *cpu_wakeup_task;
-
-		raw_spin_lock_irqsave(&wakeup_lock, flags);
-
-		cpu_wakeup_task = per_cpu(wakeup_task, old_cpu);
-		if (task == cpu_wakeup_task) {
-			put_task_struct(cpu_wakeup_task);
-			per_cpu(wakeup_task, old_cpu) = NULL;
-			cpu_wakeup_task = per_cpu(wakeup_task, cpu) = task;
-			get_task_struct(cpu_wakeup_task);
-		}
-
-		raw_spin_unlock_irqrestore(&wakeup_lock, flags);
-	}
-}
-
-static notrace void probe_wakeup_latency_hist_start(void *v,
-	struct task_struct *p)
-{
-	unsigned long flags;
-	struct task_struct *curr = current;
-	int cpu = task_cpu(p);
-	struct task_struct *cpu_wakeup_task;
-
-	raw_spin_lock_irqsave(&wakeup_lock, flags);
-
-	cpu_wakeup_task = per_cpu(wakeup_task, cpu);
-
-	if (wakeup_pid) {
-		if ((cpu_wakeup_task && p->prio == cpu_wakeup_task->prio) ||
-		    p->prio == curr->prio)
-			per_cpu(wakeup_sharedprio, cpu) = 1;
-		if (likely(wakeup_pid != task_pid_nr(p)))
-			goto out;
-	} else {
-		if (likely(!rt_task(p)) ||
-		    (cpu_wakeup_task && p->prio > cpu_wakeup_task->prio) ||
-		    p->prio > curr->prio)
-			goto out;
-		if ((cpu_wakeup_task && p->prio == cpu_wakeup_task->prio) ||
-		    p->prio == curr->prio)
-			per_cpu(wakeup_sharedprio, cpu) = 1;
-	}
-
-	if (cpu_wakeup_task)
-		put_task_struct(cpu_wakeup_task);
-	cpu_wakeup_task = per_cpu(wakeup_task, cpu) = p;
-	get_task_struct(cpu_wakeup_task);
-	cpu_wakeup_task->preempt_timestamp_hist =
-		ftrace_now(raw_smp_processor_id());
-out:
-	raw_spin_unlock_irqrestore(&wakeup_lock, flags);
-}
-
-static notrace void probe_wakeup_latency_hist_stop(void *v,
-	bool preempt, struct task_struct *prev, struct task_struct *next)
-{
-	unsigned long flags;
-	int cpu = task_cpu(next);
-	long latency;
-	u64 stop;
-	struct task_struct *cpu_wakeup_task;
-
-	raw_spin_lock_irqsave(&wakeup_lock, flags);
-
-	cpu_wakeup_task = per_cpu(wakeup_task, cpu);
-
-	if (cpu_wakeup_task == NULL)
-		goto out;
-
-	/* Already running? */
-	if (unlikely(current == cpu_wakeup_task))
-		goto out_reset;
-
-	if (next != cpu_wakeup_task) {
-		if (next->prio < cpu_wakeup_task->prio)
-			goto out_reset;
-
-		if (next->prio == cpu_wakeup_task->prio)
-			per_cpu(wakeup_sharedprio, cpu) = 1;
-
-		goto out;
-	}
-
-	if (current->prio == cpu_wakeup_task->prio)
-		per_cpu(wakeup_sharedprio, cpu) = 1;
-
-	/*
-	 * The task we are waiting for is about to be switched to.
-	 * Calculate latency and store it in histogram.
-	 */
-	stop = ftrace_now(raw_smp_processor_id());
-
-	latency = ((long) (stop - next->preempt_timestamp_hist)) /
-	    NSECS_PER_USECS;
-
-	if (per_cpu(wakeup_sharedprio, cpu)) {
-		latency_hist(WAKEUP_LATENCY_SHAREDPRIO, cpu, latency, 0, stop,
-		    next);
-		per_cpu(wakeup_sharedprio, cpu) = 0;
-	} else {
-		latency_hist(WAKEUP_LATENCY, cpu, latency, 0, stop, next);
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-		if (timerandwakeup_enabled_data.enabled) {
-			latency_hist(TIMERANDWAKEUP_LATENCY, cpu,
-			    next->timer_offset + latency, next->timer_offset,
-			    stop, next);
-		}
-#endif
-	}
-
-out_reset:
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-	next->timer_offset = 0;
-#endif
-	put_task_struct(cpu_wakeup_task);
-	per_cpu(wakeup_task, cpu) = NULL;
-out:
-	raw_spin_unlock_irqrestore(&wakeup_lock, flags);
-}
-#endif
-
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-static notrace void probe_hrtimer_interrupt(void *v, int cpu,
-	long long latency_ns, struct task_struct *curr,
-	struct task_struct *task)
-{
-	if (latency_ns <= 0 && task != NULL && rt_task(task) &&
-	    (task->prio < curr->prio ||
-	    (task->prio == curr->prio &&
-	    !cpumask_test_cpu(cpu, task->cpus_ptr)))) {
-		long latency;
-		u64 now;
-
-		if (missed_timer_offsets_pid) {
-			if (likely(missed_timer_offsets_pid !=
-			    task_pid_nr(task)))
-				return;
-		}
-
-		now = ftrace_now(cpu);
-		latency = (long) div_s64(-latency_ns, NSECS_PER_USECS);
-		latency_hist(MISSED_TIMER_OFFSETS, cpu, latency, latency, now,
-		    task);
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-		task->timer_offset = latency;
-#endif
-	}
-}
-#endif
-
-static __init int latency_hist_init(void)
-{
-	struct dentry *latency_hist_root = NULL;
-	struct dentry *dentry;
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-	struct dentry *dentry_sharedprio;
-#endif
-	struct dentry *entry;
-	struct dentry *enable_root;
-	int i = 0;
-	struct hist_data *my_hist;
-	char name[64];
-	char *cpufmt = "CPU%d";
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-	char *cpufmt_maxlatproc = "max_latency-CPU%d";
-	struct maxlatproc_data *mp = NULL;
-#endif
-
-	dentry = tracing_init_dentry();
-	latency_hist_root = debugfs_create_dir(latency_hist_dir_root, dentry);
-	enable_root = debugfs_create_dir("enable", latency_hist_root);
-
-#ifdef CONFIG_INTERRUPT_OFF_HIST
-	dentry = debugfs_create_dir(irqsoff_hist_dir, latency_hist_root);
-	for_each_possible_cpu(i) {
-		sprintf(name, cpufmt, i);
-		entry = debugfs_create_file(name, 0444, dentry,
-		    &per_cpu(irqsoff_hist, i), &latency_hist_fops);
-		my_hist = &per_cpu(irqsoff_hist, i);
-		atomic_set(&my_hist->hist_mode, 1);
-		my_hist->min_lat = LONG_MAX;
-	}
-	entry = debugfs_create_file("reset", 0644, dentry,
-	    (void *)IRQSOFF_LATENCY, &latency_hist_reset_fops);
-#endif
-
-#ifdef CONFIG_PREEMPT_OFF_HIST
-	dentry = debugfs_create_dir(preemptoff_hist_dir,
-	    latency_hist_root);
-	for_each_possible_cpu(i) {
-		sprintf(name, cpufmt, i);
-		entry = debugfs_create_file(name, 0444, dentry,
-		    &per_cpu(preemptoff_hist, i), &latency_hist_fops);
-		my_hist = &per_cpu(preemptoff_hist, i);
-		atomic_set(&my_hist->hist_mode, 1);
-		my_hist->min_lat = LONG_MAX;
-	}
-	entry = debugfs_create_file("reset", 0644, dentry,
-	    (void *)PREEMPTOFF_LATENCY, &latency_hist_reset_fops);
-#endif
-
-#if defined(CONFIG_INTERRUPT_OFF_HIST) && defined(CONFIG_PREEMPT_OFF_HIST)
-	dentry = debugfs_create_dir(preemptirqsoff_hist_dir,
-	    latency_hist_root);
-	for_each_possible_cpu(i) {
-		sprintf(name, cpufmt, i);
-		entry = debugfs_create_file(name, 0444, dentry,
-		    &per_cpu(preemptirqsoff_hist, i), &latency_hist_fops);
-		my_hist = &per_cpu(preemptirqsoff_hist, i);
-		atomic_set(&my_hist->hist_mode, 1);
-		my_hist->min_lat = LONG_MAX;
-	}
-	entry = debugfs_create_file("reset", 0644, dentry,
-	    (void *)PREEMPTIRQSOFF_LATENCY, &latency_hist_reset_fops);
-#endif
-
-#if defined(CONFIG_INTERRUPT_OFF_HIST) || defined(CONFIG_PREEMPT_OFF_HIST)
-	entry = debugfs_create_file("preemptirqsoff", 0644,
-	    enable_root, (void *)&preemptirqsoff_enabled_data,
-	    &enable_fops);
-#endif
-
-#ifdef CONFIG_WAKEUP_LATENCY_HIST
-	dentry = debugfs_create_dir(wakeup_latency_hist_dir,
-	    latency_hist_root);
-	dentry_sharedprio = debugfs_create_dir(
-	    wakeup_latency_hist_dir_sharedprio, dentry);
-	for_each_possible_cpu(i) {
-		sprintf(name, cpufmt, i);
-
-		entry = debugfs_create_file(name, 0444, dentry,
-		    &per_cpu(wakeup_latency_hist, i),
-		    &latency_hist_fops);
-		my_hist = &per_cpu(wakeup_latency_hist, i);
-		atomic_set(&my_hist->hist_mode, 1);
-		my_hist->min_lat = LONG_MAX;
-
-		entry = debugfs_create_file(name, 0444, dentry_sharedprio,
-		    &per_cpu(wakeup_latency_hist_sharedprio, i),
-		    &latency_hist_fops);
-		my_hist = &per_cpu(wakeup_latency_hist_sharedprio, i);
-		atomic_set(&my_hist->hist_mode, 1);
-		my_hist->min_lat = LONG_MAX;
-
-		sprintf(name, cpufmt_maxlatproc, i);
-
-		mp = &per_cpu(wakeup_maxlatproc, i);
-		entry = debugfs_create_file(name, 0444, dentry, mp,
-		    &maxlatproc_fops);
-		clear_maxlatprocdata(mp);
-
-		mp = &per_cpu(wakeup_maxlatproc_sharedprio, i);
-		entry = debugfs_create_file(name, 0444, dentry_sharedprio, mp,
-		    &maxlatproc_fops);
-		clear_maxlatprocdata(mp);
-	}
-	entry = debugfs_create_file("pid", 0644, dentry,
-	    (void *)&wakeup_pid, &pid_fops);
-	entry = debugfs_create_file("reset", 0644, dentry,
-	    (void *)WAKEUP_LATENCY, &latency_hist_reset_fops);
-	entry = debugfs_create_file("reset", 0644, dentry_sharedprio,
-	    (void *)WAKEUP_LATENCY_SHAREDPRIO, &latency_hist_reset_fops);
-	entry = debugfs_create_file("wakeup", 0644,
-	    enable_root, (void *)&wakeup_latency_enabled_data,
-	    &enable_fops);
-#endif
-
-#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
-	dentry = debugfs_create_dir(missed_timer_offsets_dir,
-	    latency_hist_root);
-	for_each_possible_cpu(i) {
-		sprintf(name, cpufmt, i);
-		entry = debugfs_create_file(name, 0444, dentry,
-		    &per_cpu(missed_timer_offsets, i), &latency_hist_fops);
-		my_hist = &per_cpu(missed_timer_offsets, i);
-		atomic_set(&my_hist->hist_mode, 1);
-		my_hist->min_lat = LONG_MAX;
-
-		sprintf(name, cpufmt_maxlatproc, i);
-		mp = &per_cpu(missed_timer_offsets_maxlatproc, i);
-		entry = debugfs_create_file(name, 0444, dentry, mp,
-		    &maxlatproc_fops);
-		clear_maxlatprocdata(mp);
-	}
-	entry = debugfs_create_file("pid", 0644, dentry,
-	    (void *)&missed_timer_offsets_pid, &pid_fops);
-	entry = debugfs_create_file("reset", 0644, dentry,
-	    (void *)MISSED_TIMER_OFFSETS, &latency_hist_reset_fops);
-	entry = debugfs_create_file("missed_timer_offsets", 0644,
-	    enable_root, (void *)&missed_timer_offsets_enabled_data,
-	    &enable_fops);
-#endif
-
-#if defined(CONFIG_WAKEUP_LATENCY_HIST) && \
-	defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
-	dentry = debugfs_create_dir(timerandwakeup_latency_hist_dir,
-	    latency_hist_root);
-	for_each_possible_cpu(i) {
-		sprintf(name, cpufmt, i);
-		entry = debugfs_create_file(name, 0444, dentry,
-		    &per_cpu(timerandwakeup_latency_hist, i),
-		    &latency_hist_fops);
-		my_hist = &per_cpu(timerandwakeup_latency_hist, i);
-		atomic_set(&my_hist->hist_mode, 1);
-		my_hist->min_lat = LONG_MAX;
-
-		sprintf(name, cpufmt_maxlatproc, i);
-		mp = &per_cpu(timerandwakeup_maxlatproc, i);
-		entry = debugfs_create_file(name, 0444, dentry, mp,
-		    &maxlatproc_fops);
-		clear_maxlatprocdata(mp);
-	}
-	entry = debugfs_create_file("reset", 0644, dentry,
-	    (void *)TIMERANDWAKEUP_LATENCY, &latency_hist_reset_fops);
-	entry = debugfs_create_file("timerandwakeup", 0644,
-	    enable_root, (void *)&timerandwakeup_enabled_data,
-	    &enable_fops);
-#endif
-	return 0;
-}
-
-device_initcall(latency_hist_init);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -42,6 +42,8 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 			 RINGBUF_TYPE_PADDING);
 	trace_seq_printf(s, "\ttime_extend : type == %d\n",
 			 RINGBUF_TYPE_TIME_EXTEND);
+	trace_seq_printf(s, "\ttime_stamp : type == %d\n",
+			 RINGBUF_TYPE_TIME_STAMP);
 	trace_seq_printf(s, "\tdata max type_len  == %d\n",
 			 RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 
@@ -147,6 +149,9 @@ enum {
 #define skip_time_extend(event) \
 	((struct ring_buffer_event *)((char *)event + RB_LEN_TIME_EXTEND))
 
+#define extended_time(event) \
+	(event->type_len >= RINGBUF_TYPE_TIME_EXTEND)
+
 static inline int rb_null_event(struct ring_buffer_event *event)
 {
 	return event->type_len == RINGBUF_TYPE_PADDING && !event->time_delta;
@@ -187,10 +192,8 @@ rb_event_length(struct ring_buffer_event *event)
 		return  event->array[0] + RB_EVNT_HDR_SIZE;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		return RB_LEN_TIME_EXTEND;
-
 	case RINGBUF_TYPE_TIME_STAMP:
-		return RB_LEN_TIME_STAMP;
+		return RB_LEN_TIME_EXTEND;
 
 	case RINGBUF_TYPE_DATA:
 		return rb_event_data_length(event);
@@ -210,7 +213,7 @@ rb_event_ts_length(struct ring_buffer_event *event)
 {
 	unsigned len = 0;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
+	if (extended_time(event)) {
 		/* time extends include the data event after it */
 		len = RB_LEN_TIME_EXTEND;
 		event = skip_time_extend(event);
@@ -232,7 +235,7 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
 {
 	unsigned length;
 
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 
 	length = rb_event_length(event);
@@ -249,7 +252,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_length);
 static __always_inline void *
 rb_event_data(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 	BUG_ON(event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX);
 	/* If length is in len field, then array[0] has the data */
@@ -276,6 +279,27 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 #define TS_MASK		((1ULL << TS_SHIFT) - 1)
 #define TS_DELTA_TEST	(~TS_MASK)
 
+/**
+ * ring_buffer_event_time_stamp - return the event's extended timestamp
+ * @event: the event to get the timestamp of
+ *
+ * Returns the extended timestamp associated with a data event.
+ * An extended time_stamp is a 64-bit timestamp represented
+ * internally in a special way that makes the best use of space
+ * contained within a ring buffer event.  This function decodes
+ * it and maps it to a straight u64 value.
+ */
+u64 ring_buffer_event_time_stamp(struct ring_buffer_event *event)
+{
+	u64 ts;
+
+	ts = event->array[0];
+	ts <<= TS_SHIFT;
+	ts += event->time_delta;
+
+	return ts;
+}
+
 /* Flag when events were overwritten */
 #define RB_MISSED_EVENTS	(1 << 31)
 /* Missed count stored at end */
@@ -484,6 +508,7 @@ struct ring_buffer {
 	u64				(*clock)(void);
 
 	struct rb_irq_work		irq_work;
+	bool				time_stamp_abs;
 };
 
 struct ring_buffer_iter {
@@ -1378,6 +1403,16 @@ void ring_buffer_set_clock(struct ring_buffer *buffer,
 	buffer->clock = clock;
 }
 
+void ring_buffer_set_time_stamp_abs(struct ring_buffer *buffer, bool abs)
+{
+	buffer->time_stamp_abs = abs;
+}
+
+bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer)
+{
+	return buffer->time_stamp_abs;
+}
+
 static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
 
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
@@ -2208,13 +2243,16 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 }
 
 /* Slow path, do not inline */
-static noinline struct ring_buffer_event *
-rb_add_time_stamp(struct ring_buffer_event *event, u64 delta)
+static struct noinline ring_buffer_event *
+rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 {
-	event->type_len = RINGBUF_TYPE_TIME_EXTEND;
+	if (abs)
+		event->type_len = RINGBUF_TYPE_TIME_STAMP;
+	else
+		event->type_len = RINGBUF_TYPE_TIME_EXTEND;
 
-	/* Not the first event on the page? */
-	if (rb_event_index(event)) {
+	/* Not the first event on the page, or not delta? */
+	if (abs || rb_event_index(event)) {
 		event->time_delta = delta & TS_MASK;
 		event->array[0] = delta >> TS_SHIFT;
 	} else {
@@ -2257,7 +2295,9 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	 * add it to the start of the resevered space.
 	 */
 	if (unlikely(info->add_timestamp)) {
-		event = rb_add_time_stamp(event, delta);
+		bool abs = ring_buffer_time_stamp_abs(cpu_buffer->buffer);
+
+		event = rb_add_time_stamp(event, info->delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
 		delta = 0;
 	}
@@ -2445,7 +2485,7 @@ static __always_inline void rb_end_commit(struct ring_buffer_per_cpu *cpu_buffer
 
 static inline void rb_event_discard(struct ring_buffer_event *event)
 {
-	if (event->type_len == RINGBUF_TYPE_TIME_EXTEND)
+	if (extended_time(event))
 		event = skip_time_extend(event);
 
 	/* array[0] holds the actual length for the discarded event */
@@ -2476,6 +2516,10 @@ rb_update_write_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	u64 delta;
 
+	/* In TIME_STAMP mode, write_stamp is unused, nothing to do */
+	if (event->type_len == RINGBUF_TYPE_TIME_STAMP)
+		return;
+
 	/*
 	 * The event first in the commit queue updates the
 	 * time stamp.
@@ -2489,9 +2533,7 @@ rb_update_write_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 			cpu_buffer->write_stamp =
 				cpu_buffer->commit_page->page->time_stamp;
 		else if (event->type_len == RINGBUF_TYPE_TIME_EXTEND) {
-			delta = event->array[0];
-			delta <<= TS_SHIFT;
-			delta += event->time_delta;
+			delta = ring_buffer_event_time_stamp(event);
 			cpu_buffer->write_stamp += delta;
 		} else
 			cpu_buffer->write_stamp += event->time_delta;
@@ -2675,7 +2717,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (!tail)
+	if (!tail && !ring_buffer_time_stamp_abs(cpu_buffer->buffer))
 		info->delta = 0;
 
 	/* See if we shot pass the end of this buffer page */
@@ -2753,8 +2795,11 @@ rb_reserve_next_event(struct ring_buffer *buffer,
 	/* make sure this diff is calculated here */
 	barrier();
 
-	/* Did the write stamp get updated already? */
-	if (likely(info.ts >= cpu_buffer->write_stamp)) {
+	if (ring_buffer_time_stamp_abs(buffer)) {
+		info.delta = info.ts;
+		rb_handle_timestamp(cpu_buffer, &info);
+	} else /* Did the write stamp get updated already? */
+		if (likely(info.ts >= cpu_buffer->write_stamp)) {
 		info.delta = diff;
 		if (unlikely(test_time_stamp(info.delta)))
 			rb_handle_timestamp(cpu_buffer, &info);
@@ -3436,14 +3481,12 @@ rb_update_read_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = event->array[0];
-		delta <<= TS_SHIFT;
-		delta += event->time_delta;
+		delta = ring_buffer_event_time_stamp(event);
 		cpu_buffer->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		/* In TIME_STAMP mode, write_stamp is unused, nothing to do */
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3467,14 +3510,12 @@ rb_update_iter_read_stamp(struct ring_buffer_iter *iter,
 		return;
 
 	case RINGBUF_TYPE_TIME_EXTEND:
-		delta = event->array[0];
-		delta <<= TS_SHIFT;
-		delta += event->time_delta;
+		delta = ring_buffer_event_time_stamp(event);
 		iter->read_stamp += delta;
 		return;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		/* In TIME_STAMP mode, write_stamp is unused, nothing to do */
 		return;
 
 	case RINGBUF_TYPE_DATA:
@@ -3698,6 +3739,8 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 	struct buffer_page *reader;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
  again:
 	/*
 	 * We repeat when a time extend is encountered.
@@ -3734,12 +3777,17 @@ rb_buffer_peek(struct ring_buffer_per_cpu *cpu_buffer, u64 *ts,
 		goto again;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_reader(cpu_buffer);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = cpu_buffer->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
 							 cpu_buffer->cpu, ts);
@@ -3764,6 +3812,9 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
 
+	if (ts)
+		*ts = 0;
+
 	cpu_buffer = iter->cpu_buffer;
 	buffer = cpu_buffer->buffer;
 
@@ -3816,12 +3867,17 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 		goto again;
 
 	case RINGBUF_TYPE_TIME_STAMP:
-		/* FIXME: not implemented */
+		if (ts) {
+			*ts = ring_buffer_event_time_stamp(event);
+			ring_buffer_normalize_time_stamp(cpu_buffer->buffer,
+							 cpu_buffer->cpu, ts);
+		}
+		/* Internal data, OK to advance */
 		rb_advance_iter(iter);
 		goto again;
 
 	case RINGBUF_TYPE_DATA:
-		if (ts) {
+		if (ts && !(*ts)) {
 			*ts = iter->read_stamp + event->time_delta;
 			ring_buffer_normalize_time_stamp(buffer,
 							 cpu_buffer->cpu, ts);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1164,6 +1164,14 @@ static struct {
 	ARCH_TRACE_CLOCKS
 };
 
+bool trace_clock_in_ns(struct trace_array *tr)
+{
+	if (trace_clocks[tr->clock_id].in_ns)
+		return true;
+
+	return false;
+}
+
 /*
  * trace_parser_get_init - gets the buffer for trace parser
  */
@@ -2086,7 +2094,7 @@ trace_event_buffer_lock_reserve(struct ring_buffer **current_rb,
 
 	*current_rb = trace_file->tr->trace_buffer.buffer;
 
-	if ((trace_file->flags &
+	if (!ring_buffer_time_stamp_abs(*current_rb) && (trace_file->flags &
 	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
 	    (entry = this_cpu_read(trace_buffered_event))) {
 		/* Try to use the per cpu buffer first */
@@ -5889,7 +5897,7 @@ static int tracing_clock_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int tracing_set_clock(struct trace_array *tr, const char *clockstr)
+int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 {
 	int i;
 
@@ -5969,6 +5977,29 @@ static int tracing_clock_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs)
+{
+	mutex_lock(&trace_types_lock);
+
+	ring_buffer_set_time_stamp_abs(tr->trace_buffer.buffer, abs);
+
+	/*
+	 * New timestamps may not be consistent with the previous setting.
+	 * Reset the buffer so that it doesn't have incomparable timestamps.
+	 */
+	tracing_reset_online_cpus(&tr->trace_buffer);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	if (tr->flags & TRACE_ARRAY_FL_GLOBAL && tr->max_buffer.buffer)
+		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, abs);
+	tracing_reset_online_cpus(&tr->max_buffer);
+#endif
+
+	mutex_unlock(&trace_types_lock);
+
+	return 0;
+}
+
 struct ftrace_buffer_info {
 	struct trace_iterator	iter;
 	void			*spare;
@@ -7894,6 +7925,92 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 }
 EXPORT_SYMBOL_GPL(ftrace_dump);
 
+int trace_run_command(const char *buf, int (*createfn)(int, char **))
+{
+	char **argv;
+	int argc, ret;
+
+	argc = 0;
+	ret = 0;
+	argv = argv_split(GFP_KERNEL, buf, &argc);
+	if (!argv)
+		return -ENOMEM;
+
+	if (argc)
+		ret = createfn(argc, argv);
+
+	argv_free(argv);
+
+	return ret;
+}
+
+#define WRITE_BUFSIZE  4096
+
+ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos,
+				int (*createfn)(int, char **))
+{
+	char *kbuf, *buf, *tmp;
+	int ret = 0;
+	size_t done = 0;
+	size_t size;
+
+	kbuf = kmalloc(WRITE_BUFSIZE, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	while (done < count) {
+		size = count - done;
+
+		if (size >= WRITE_BUFSIZE)
+			size = WRITE_BUFSIZE - 1;
+
+		if (copy_from_user(kbuf, buffer + done, size)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		kbuf[size] = '\0';
+		buf = kbuf;
+		do {
+			tmp = strchr(buf, '\n');
+			if (tmp) {
+				*tmp = '\0';
+				size = tmp - buf + 1;
+			} else {
+				size = strlen(buf);
+				if (done + size < count) {
+					if (buf != kbuf)
+						break;
+					/* This can accept WRITE_BUFSIZE - 2 ('\n' + '\0') */
+					pr_warn("Line length is too long: Should be less than %d\n",
+						WRITE_BUFSIZE - 2);
+					ret = -EINVAL;
+					goto out;
+				}
+			}
+			done += size;
+
+			/* Remove comments */
+			tmp = strchr(buf, '#');
+
+			if (tmp)
+				*tmp = '\0';
+
+			ret = trace_run_command(buf, createfn);
+			if (ret)
+				goto out;
+			buf += size;
+
+		} while (done < count);
+	}
+	ret = done;
+
+out:
+	kfree(kbuf);
+
+	return ret;
+}
+
 __init static int tracer_alloc_buffers(void)
 {
 	int ring_buf_size;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -280,6 +280,11 @@ extern struct mutex trace_types_lock;
 extern int trace_array_get(struct trace_array *tr);
 extern void trace_array_put(struct trace_array *tr);
 
+extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
+extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
+
+extern bool trace_clock_in_ns(struct trace_array *tr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
@@ -1189,11 +1194,18 @@ __event_trigger_test_discard(struct trace_event_file *file,
 	unsigned long eflags = file->flags;
 
 	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
-		*tt = event_triggers_call(file, entry);
+		*tt = event_triggers_call(file, entry, event);
 
-	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
-	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
-	     !filter_match_preds(file->filter, entry))) {
+	if (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	    !filter_match_preds(file->filter, entry)) {
+		__trace_event_discard_commit(buffer, event);
+		return true;
+	}
+
+	if (test_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags))
+		return false;
+
+	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags)) {
 		__trace_event_discard_commit(buffer, event);
 		return true;
 	}
@@ -1226,7 +1238,7 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 		trace_buffer_unlock_commit(file->tr, buffer, event, irq_flags, pc);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry);
+		event_triggers_post_call(file, tt, entry, event);
 }
 
 /**
@@ -1259,7 +1271,7 @@ event_trigger_unlock_commit_regs(struct trace_event_file *file,
 						irq_flags, pc, regs);
 
 	if (tt)
-		event_triggers_post_call(file, tt, entry);
+		event_triggers_post_call(file, tt, entry, event);
 }
 
 #define FILTER_PRED_INVALID	((unsigned short)-1)
@@ -1439,6 +1451,8 @@ extern void pause_named_trigger(struct event_trigger_data *data);
 extern void unpause_named_trigger(struct event_trigger_data *data);
 extern void set_named_trigger_data(struct event_trigger_data *data,
 				   struct event_trigger_data *named_data);
+extern struct event_trigger_data *
+get_named_trigger_data(struct event_trigger_data *data);
 extern int register_event_command(struct event_command *cmd);
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
@@ -1482,7 +1496,8 @@ extern int register_trigger_hist_enable_disable_cmds(void);
  */
 struct event_trigger_ops {
 	void			(*func)(struct event_trigger_data *data,
-					void *rec);
+					void *rec,
+					struct ring_buffer_event *rbe);
 	int			(*init)(struct event_trigger_ops *ops,
 					struct event_trigger_data *data);
 	void			(*free)(struct event_trigger_ops *ops,
@@ -1649,6 +1664,13 @@ void trace_printk_start_comm(void);
 int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
 
+#define MAX_EVENT_NAME_LEN	64
+
+extern int trace_run_command(const char *buf, int (*createfn)(int, char**));
+extern ssize_t trace_parse_run_command(struct file *file,
+		const char __user *buffer, size_t count, loff_t *ppos,
+		int (*createfn)(int, char**));
+
 /*
  * Normal trace_printk() and friends allocates special buffers
  * to do the manipulation, as well as saves the print formats
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -299,7 +299,7 @@ int trace_event_reg(struct trace_event_call *call,
 	case TRACE_REG_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->probe,
-					    file);
+					    file, false);
 		return 0;
 
 #ifdef CONFIG_PERF_EVENTS
@@ -310,7 +310,7 @@ int trace_event_reg(struct trace_event_call *call,
 	case TRACE_REG_PERF_UNREGISTER:
 		tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
-					    call);
+					    call, false);
 		return 0;
 	case TRACE_REG_PERF_OPEN:
 	case TRACE_REG_PERF_CLOSE:
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -20,13 +20,37 @@
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/rculist.h>
+#include <linux/tracefs.h>
 
 #include "tracing_map.h"
 #include "trace.h"
 
+#define SYNTH_SYSTEM		"synthetic"
+#define SYNTH_FIELDS_MAX	16
+
 struct hist_field;
 
-typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event);
+typedef u64 (*hist_field_fn_t) (struct hist_field *field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event);
+
+#define HIST_FIELD_OPERANDS_MAX	2
+#define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
+#define HIST_ACTIONS_MAX	8
+
+enum field_op_id {
+	FIELD_OP_NONE,
+	FIELD_OP_PLUS,
+	FIELD_OP_MINUS,
+	FIELD_OP_UNARY_MINUS,
+};
+
+struct hist_var {
+	char				*name;
+	struct hist_trigger_data	*hist_data;
+	unsigned int			idx;
+};
 
 struct hist_field {
 	struct ftrace_event_field	*field;
@@ -34,26 +58,48 @@ struct hist_field {
 	hist_field_fn_t			fn;
 	unsigned int			size;
 	unsigned int			offset;
+	unsigned int                    is_signed;
+	const char			*type;
+	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
+	struct hist_trigger_data	*hist_data;
+	struct hist_var			var;
+	enum field_op_id		operator;
+	char				*name;
+	unsigned int			var_idx;
+	unsigned int			var_ref_idx;
+	bool                            read_once;
 };
 
-static u64 hist_field_none(struct hist_field *field, void *event)
+static u64 hist_field_none(struct hist_field *field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
 	return 0;
 }
 
-static u64 hist_field_counter(struct hist_field *field, void *event)
+static u64 hist_field_counter(struct hist_field *field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	return 1;
 }
 
-static u64 hist_field_string(struct hist_field *hist_field, void *event)
+static u64 hist_field_string(struct hist_field *hist_field,
+			     struct tracing_map_elt *elt,
+			     struct ring_buffer_event *rbe,
+			     void *event)
 {
 	char *addr = (char *)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_dynstring(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
 {
 	u32 str_item = *(u32 *)(event + hist_field->field->offset);
 	int str_loc = str_item & 0xffff;
@@ -62,22 +108,74 @@ static u64 hist_field_dynstring(struct hist_field *hist_field, void *event)
 	return (u64)(unsigned long)addr;
 }
 
-static u64 hist_field_pstring(struct hist_field *hist_field, void *event)
+static u64 hist_field_pstring(struct hist_field *hist_field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
 {
 	char **addr = (char **)(event + hist_field->field->offset);
 
 	return (u64)(unsigned long)*addr;
 }
 
-static u64 hist_field_log2(struct hist_field *hist_field, void *event)
+static u64 hist_field_log2(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
 {
-	u64 val = *(u64 *)(event + hist_field->field->offset);
+	struct hist_field *operand = hist_field->operands[0];
+
+	u64 val = operand->fn(operand, elt, rbe, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
 
+static u64 hist_field_plus(struct hist_field *hist_field,
+			   struct tracing_map_elt *elt,
+			   struct ring_buffer_event *rbe,
+			   void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
+
+	return val1 + val2;
+}
+
+static u64 hist_field_minus(struct hist_field *hist_field,
+			    struct tracing_map_elt *elt,
+			    struct ring_buffer_event *rbe,
+			    void *event)
+{
+	struct hist_field *operand1 = hist_field->operands[0];
+	struct hist_field *operand2 = hist_field->operands[1];
+
+	u64 val1 = operand1->fn(operand1, elt, rbe, event);
+	u64 val2 = operand2->fn(operand2, elt, rbe, event);
+
+	return val1 - val2;
+}
+
+static u64 hist_field_unary_minus(struct hist_field *hist_field,
+				  struct tracing_map_elt *elt,
+				  struct ring_buffer_event *rbe,
+				  void *event)
+{
+	struct hist_field *operand = hist_field->operands[0];
+
+	s64 sval = (s64)operand->fn(operand, elt, rbe, event);
+	u64 val = (u64)-sval;
+
+	return val;
+}
+
 #define DEFINE_HIST_FIELD_FN(type)					\
-static u64 hist_field_##type(struct hist_field *hist_field, void *event)\
+	static u64 hist_field_##type(struct hist_field *hist_field,	\
+				     struct tracing_map_elt *elt,	\
+				     struct ring_buffer_event *rbe,	\
+				     void *event)			\
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
@@ -120,6 +218,14 @@ enum hist_field_flags {
 	HIST_FIELD_FL_SYSCALL		= 128,
 	HIST_FIELD_FL_STACKTRACE	= 256,
 	HIST_FIELD_FL_LOG2		= 512,
+	HIST_FIELD_FL_TIMESTAMP		= 1024,
+	HIST_FIELD_FL_TIMESTAMP_USECS	= 2048,
+	HIST_FIELD_FL_VAR		= 4096,
+	HIST_FIELD_FL_VAR_ONLY		= 8192,
+	HIST_FIELD_FL_EXPR		= 16384,
+	HIST_FIELD_FL_VAR_REF		= 32768,
+	HIST_FIELD_FL_CPU		= 65536,
+	HIST_FIELD_FL_ALIAS		= 131072,
 };
 
 struct hist_trigger_attrs {
@@ -127,25 +233,1284 @@ struct hist_trigger_attrs {
 	char		*vals_str;
 	char		*sort_key_str;
 	char		*name;
+	char		*clock;
 	bool		pause;
 	bool		cont;
 	bool		clear;
+	bool		ts_in_usecs;
 	unsigned int	map_bits;
+
+	char		*assignment_str[TRACING_MAP_VARS_MAX];
+	unsigned int	n_assignments;
+
+	char		*action_str[HIST_ACTIONS_MAX];
+	unsigned int	n_actions;
+};
+
+struct field_var {
+	struct hist_field	*var;
+	struct hist_field	*val;
+};
+
+struct field_var_hist {
+	struct hist_trigger_data	*hist_data;
+	char				*cmd;
 };
 
 struct hist_trigger_data {
-	struct hist_field               *fields[TRACING_MAP_FIELDS_MAX];
+	struct hist_field               *fields[HIST_FIELDS_MAX];
 	unsigned int			n_vals;
 	unsigned int			n_keys;
 	unsigned int			n_fields;
+	unsigned int			n_vars;
+	unsigned int			n_var_only;
 	unsigned int			key_size;
 	struct tracing_map_sort_key	sort_keys[TRACING_MAP_SORT_KEYS_MAX];
 	unsigned int			n_sort_keys;
 	struct trace_event_file		*event_file;
 	struct hist_trigger_attrs	*attrs;
 	struct tracing_map		*map;
+	bool				enable_timestamps;
+	bool				remove;
+	struct hist_field               *var_refs[TRACING_MAP_VARS_MAX];
+	unsigned int			n_var_refs;
+
+	struct action_data		*actions[HIST_ACTIONS_MAX];
+	unsigned int			n_actions;
+
+	struct hist_field		*synth_var_refs[SYNTH_FIELDS_MAX];
+	unsigned int			n_synth_var_refs;
+	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
+	unsigned int			n_field_vars;
+	unsigned int			n_field_var_str;
+	struct field_var_hist		*field_var_hists[SYNTH_FIELDS_MAX];
+	unsigned int			n_field_var_hists;
+
+	struct field_var		*max_vars[SYNTH_FIELDS_MAX];
+	unsigned int			n_max_vars;
+	unsigned int			n_max_var_str;
+	char				*last_err;
 };
 
+struct synth_field {
+	char *type;
+	char *name;
+	unsigned int size;
+	bool is_signed;
+};
+
+struct synth_event {
+	struct list_head			list;
+	char					*name;
+	struct synth_field			**fields;
+	unsigned int				n_fields;
+	struct trace_event_class		class;
+	struct trace_event_call			call;
+	struct tracepoint			*tp;
+};
+
+struct action_data;
+
+typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
+			     struct tracing_map_elt *elt, void *rec,
+			     struct ring_buffer_event *rbe,
+			     struct action_data *data, u64 *var_ref_vals);
+
+struct action_data {
+	action_fn_t		fn;
+	unsigned int		n_params;
+	char			*params[SYNTH_FIELDS_MAX];
+
+	unsigned int		var_ref_idx;
+	char			*match_event;
+	char			*match_event_system;
+	char			*synth_event_name;
+	struct synth_event	*synth_event;
+
+	char			*onmax_var_str;
+	char			*onmax_fn_name;
+	unsigned int		max_var_ref_idx;
+	struct hist_field	*max_var;
+	struct hist_field	*onmax_var;
+};
+
+
+static char *hist_err_str;
+static char *last_hist_cmd;
+
+static int hist_err_alloc(void)
+{
+	int ret = 0;
+
+	last_hist_cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	hist_err_str = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	if (!last_hist_cmd || !hist_err_str)
+		ret = -ENOMEM;
+
+	return ret;
+}
+
+static void last_cmd_set(char *str)
+{
+	if (!last_hist_cmd || !str)
+		return;
+
+	if (strlen(last_hist_cmd) > MAX_FILTER_STR_VAL - 1)
+		return;
+
+	strcpy(last_hist_cmd, str);
+}
+
+static void hist_err(char *str, char *var)
+{
+	int maxlen = MAX_FILTER_STR_VAL - 1;
+
+	if (strlen(hist_err_str))
+		return;
+
+	if (!hist_err_str || !str)
+		return;
+
+	if (!var)
+		var = "";
+
+	if (strlen(hist_err_str) + strlen(str) + strlen(var) > maxlen)
+		return;
+
+	strcat(hist_err_str, str);
+	strcat(hist_err_str, var);
+}
+
+static void hist_err_event(char *str, char *system, char *event, char *var)
+{
+	char err[MAX_FILTER_STR_VAL];
+
+	if (system && var)
+		sprintf(err, "%s.%s.%s", system, event, var);
+	else if (system)
+		sprintf(err, "%s.%s", system, event);
+	else
+		strcpy(err, var);
+
+	hist_err(str, err);
+}
+
+static void hist_err_clear(void)
+{
+	if (!hist_err_str)
+		return;
+
+	hist_err_str[0] = '\0';
+}
+
+static bool have_hist_err(void)
+{
+	if (hist_err_str && strlen(hist_err_str))
+		return true;
+
+	return false;
+}
+
+static LIST_HEAD(synth_event_list);
+static DEFINE_MUTEX(synth_event_mutex);
+
+struct synth_trace_event {
+	struct trace_entry	ent;
+	int			n_fields;
+	u64			fields[];
+};
+
+static int synth_event_define_fields(struct trace_event_call *call)
+{
+	struct synth_trace_event trace;
+	int offset = offsetof(typeof(trace), fields);
+	struct synth_event *event = call->data;
+	unsigned int i, size;
+	char *name, *type;
+	bool is_signed;
+	int ret = 0;
+
+	for (i = 0; i < event->n_fields; i++) {
+		size = event->fields[i]->size;
+		is_signed = event->fields[i]->is_signed;
+		type = event->fields[i]->type;
+		name = event->fields[i]->name;
+		ret = trace_define_field(call, type, name, offset, size,
+					 is_signed, FILTER_OTHER);
+		offset += sizeof(u64);
+	}
+
+	return ret;
+}
+
+static enum print_line_t print_synth_event(struct trace_iterator *iter,
+					   int flags,
+					   struct trace_event *event)
+{
+	struct trace_array *tr = iter->tr;
+	struct trace_seq *s = &iter->seq;
+	struct synth_trace_event *entry;
+	struct synth_event *se;
+	unsigned int i;
+
+	entry = (struct synth_trace_event *)iter->ent;
+	se = container_of(event, struct synth_event, call.event);
+
+	trace_seq_printf(s, "%s: ", se->name);
+
+	for (i = 0; i < entry->n_fields; i++) {
+		if (trace_seq_has_overflowed(s))
+			goto end;
+
+		/* parameter types */
+		if (tr->trace_flags & TRACE_ITER_VERBOSE)
+			trace_seq_printf(s, "%s ", "u64");
+
+		/* parameter values */
+		trace_seq_printf(s, "%s=%llu%s", se->fields[i]->name,
+				 entry->fields[i],
+				 i == entry->n_fields - 1 ? "" : ", ");
+	}
+end:
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions synth_event_funcs = {
+	.trace		= print_synth_event
+};
+
+static notrace void trace_event_raw_event_synth(void *__data,
+						u64 *var_ref_vals,
+						unsigned int var_ref_idx)
+{
+	struct trace_event_file *trace_file = __data;
+	struct synth_trace_event *entry;
+	struct trace_event_buffer fbuffer;
+	int fields_size;
+	unsigned int i;
+
+	struct synth_event *event;
+
+	event = trace_file->event_call->data;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	fields_size = event->n_fields * sizeof(u64);
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry) + fields_size);
+	if (!entry)
+		return;
+
+	entry->n_fields = event->n_fields;
+
+	for (i = 0; i < event->n_fields; i++)
+		entry->fields[i] = var_ref_vals[var_ref_idx + i];
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static void free_synth_event_print_fmt(struct trace_event_call *call)
+{
+	if (call)
+		kfree(call->print_fmt);
+}
+
+static int __set_synth_event_print_fmt(struct synth_event *event,
+				       char *buf, int len)
+{
+	int pos = 0;
+	int i;
+
+	/* When len=0, we just calculate the needed length */
+#define LEN_OR_ZERO (len ? len - pos : 0)
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+	for (i = 0; i < event->n_fields; i++) {
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s: 0x%%0%zulx%s",
+				event->fields[i]->name, sizeof(u64),
+				i == event->n_fields - 1 ? "" : ", ");
+	}
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+
+	for (i = 0; i < event->n_fields; i++) {
+		pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", ((u64)(REC->%s))", event->fields[i]->name);
+	}
+
+#undef LEN_OR_ZERO
+
+	/* return the length of print_fmt */
+	return pos;
+}
+
+static int set_synth_event_print_fmt(struct trace_event_call *call)
+{
+	struct synth_event *event = call->data;
+	char *print_fmt;
+	int len;
+
+	/* First: called with 0 length to calculate the needed length */
+	len = __set_synth_event_print_fmt(event, NULL, 0);
+
+	print_fmt = kmalloc(len + 1, GFP_KERNEL);
+	if (!print_fmt)
+		return -ENOMEM;
+
+	/* Second: actually write the @print_fmt */
+	__set_synth_event_print_fmt(event, print_fmt, len + 1);
+	call->print_fmt = print_fmt;
+
+	return 0;
+}
+
+int dynamic_trace_event_reg(struct trace_event_call *call,
+			    enum trace_reg type, void *data)
+{
+	struct trace_event_file *file = data;
+
+	WARN_ON(!(call->flags & TRACE_EVENT_FL_TRACEPOINT));
+	switch (type) {
+	case TRACE_REG_REGISTER:
+		return dynamic_tracepoint_probe_register(call->tp,
+							 call->class->probe,
+							 file);
+	case TRACE_REG_UNREGISTER:
+		tracepoint_probe_unregister(call->tp,
+					    call->class->probe,
+					    file, true);
+		return 0;
+
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		return dynamic_tracepoint_probe_register(call->tp,
+							 call->class->perf_probe,
+							 call);
+	case TRACE_REG_PERF_UNREGISTER:
+		tracepoint_probe_unregister(call->tp,
+					    call->class->perf_probe,
+					    call, true);
+		return 0;
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		return 0;
+#endif
+	}
+	return 0;
+}
+
+static void free_synth_field(struct synth_field *field)
+{
+	kfree(field->type);
+	kfree(field->name);
+	kfree(field);
+}
+
+static bool synth_field_signed(char *type)
+{
+	if (strncmp(type, "u", 1) == 0)
+		return false;
+
+	return true;
+}
+
+static unsigned int synth_field_size(char *type)
+{
+	unsigned int size = 0;
+
+	if (strcmp(type, "s64") == 0)
+		size = sizeof(s64);
+	else if (strcmp(type, "u64") == 0)
+		size = sizeof(u64);
+	else if (strcmp(type, "s32") == 0)
+		size = sizeof(s32);
+	else if (strcmp(type, "u32") == 0)
+		size = sizeof(u32);
+	else if (strcmp(type, "s16") == 0)
+		size = sizeof(s16);
+	else if (strcmp(type, "u16") == 0)
+		size = sizeof(u16);
+	else if (strcmp(type, "s8") == 0)
+		size = sizeof(s8);
+	else if (strcmp(type, "u8") == 0)
+		size = sizeof(u8);
+	else if (strcmp(type, "char") == 0)
+		size = sizeof(char);
+	else if (strcmp(type, "unsigned char") == 0)
+		size = sizeof(unsigned char);
+	else if (strcmp(type, "int") == 0)
+		size = sizeof(int);
+	else if (strcmp(type, "unsigned int") == 0)
+		size = sizeof(unsigned int);
+	else if (strcmp(type, "long") == 0)
+		size = sizeof(long);
+	else if (strcmp(type, "unsigned long") == 0)
+		size = sizeof(unsigned long);
+	else if (strcmp(type, "pid_t") == 0)
+		size = sizeof(pid_t);
+	else if (strstr(type, "[") == 0)
+		size = sizeof(u64);
+
+	return size;
+}
+
+static struct synth_field *parse_synth_field(char *field_type,
+					     char *field_name)
+{
+	struct synth_field *field;
+	int len, ret = 0;
+	char *array;
+
+	if (field_type[0] == ';')
+		field_type++;
+
+	len = strlen(field_name);
+	if (field_name[len - 1] == ';')
+		field_name[len - 1] = '\0';
+
+	field = kzalloc(sizeof(*field), GFP_KERNEL);
+	if (!field)
+		return ERR_PTR(-ENOMEM);
+
+	len = strlen(field_type) + 1;
+	array = strchr(field_name, '[');
+	if (array)
+		len += strlen(array);
+	field->type = kzalloc(len, GFP_KERNEL);
+	if (!field->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
+	strcat(field->type, field_type);
+	if (array)
+		strcat(field->type, array);
+
+	field->size = synth_field_size(field->type);
+	if (!field->size) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	field->is_signed = synth_field_signed(field->type);
+
+	field->name = kstrdup(field_name, GFP_KERNEL);
+	if (!field->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+ out:
+	return field;
+ free:
+	free_synth_field(field);
+	field = ERR_PTR(ret);
+	goto out;
+}
+
+static void free_synth_tracepoint(struct tracepoint *tp)
+{
+	if (!tp)
+		return;
+
+	kfree(tp->name);
+	kfree(tp);
+}
+
+static struct tracepoint *alloc_synth_tracepoint(char *name)
+{
+	struct tracepoint *tp;
+	int ret = 0;
+
+	tp = kzalloc(sizeof(*tp), GFP_KERNEL);
+	if (!tp) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	tp->name = kstrdup(name, GFP_KERNEL);
+	if (!tp->name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	return tp;
+ free:
+	free_synth_tracepoint(tp);
+
+	return ERR_PTR(ret);
+}
+
+static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
+			       unsigned int var_ref_idx)
+{
+	struct tracepoint *tp = event->tp;
+
+	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
+		struct tracepoint_func *it_func_ptr;
+		void *it_func;
+		void *__data;
+
+		if (!(cpu_online(raw_smp_processor_id())))
+			return;
+
+		it_func_ptr = rcu_dereference_sched((tp)->funcs);
+		if (it_func_ptr) {
+			do {
+				it_func = (it_func_ptr)->func;
+				__data = (it_func_ptr)->data;
+				((void(*)(void *__data, u64 *var_ref_vals, unsigned int var_ref_idx))(it_func))(__data, var_ref_vals, var_ref_idx);
+			} while ((++it_func_ptr)->func);
+		}
+	}
+}
+
+static struct synth_event *find_synth_event(const char *name)
+{
+	struct synth_event *event;
+
+	list_for_each_entry(event, &synth_event_list, list) {
+		if (strcmp(event->name, name) == 0)
+			return event;
+	}
+
+	return NULL;
+}
+
+static int register_synth_event(struct synth_event *event)
+{
+	struct trace_event_call *call = &event->call;
+	int ret = 0;
+
+	event->call.class = &event->class;
+	event->class.system = kstrdup(SYNTH_SYSTEM, GFP_KERNEL);
+	if (!event->class.system) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	event->tp = alloc_synth_tracepoint(event->name);
+	if (IS_ERR(event->tp)) {
+		ret = PTR_ERR(event->tp);
+		event->tp = NULL;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&call->class->fields);
+	call->event.funcs = &synth_event_funcs;
+	call->class->define_fields = synth_event_define_fields;
+
+	ret = register_trace_event(&call->event);
+	if (!ret) {
+		ret = -ENODEV;
+		goto out;
+	}
+	call->flags = TRACE_EVENT_FL_TRACEPOINT;
+	call->class->reg = dynamic_trace_event_reg;
+	call->class->probe = trace_event_raw_event_synth;
+	call->data = event;
+	call->tp = event->tp;
+	ret = trace_add_event_call(call);
+	if (ret) {
+		pr_warn("Failed to register synthetic event: %s\n",
+			trace_event_name(call));
+		goto err;
+	}
+
+	ret = set_synth_event_print_fmt(call);
+	if (ret < 0) {
+		trace_remove_event_call(call);
+		goto err;
+	}
+ out:
+	return ret;
+ err:
+	unregister_trace_event(&call->event);
+	goto out;
+}
+
+static int unregister_synth_event(struct synth_event *event)
+{
+	struct trace_event_call *call = &event->call;
+	int ret;
+
+	ret = trace_remove_event_call(call);
+	if (ret) {
+		pr_warn("Failed to remove synthetic event: %s\n",
+			trace_event_name(call));
+		free_synth_event_print_fmt(call);
+		unregister_trace_event(&call->event);
+	}
+
+	return ret;
+}
+
+static void remove_synth_event(struct synth_event *event)
+{
+	unregister_synth_event(event);
+	list_del(&event->list);
+}
+
+static int add_synth_event(struct synth_event *event)
+{
+	int ret;
+
+	ret = register_synth_event(event);
+	if (ret)
+		return ret;
+
+	list_add(&event->list, &synth_event_list);
+
+	return 0;
+}
+
+static void free_synth_event(struct synth_event *event)
+{
+	unsigned int i;
+
+	if (!event)
+		return;
+
+	for (i = 0; i < event->n_fields; i++)
+		free_synth_field(event->fields[i]);
+
+	kfree(event->fields);
+	kfree(event->name);
+	kfree(event->class.system);
+	free_synth_tracepoint(event->tp);
+	free_synth_event_print_fmt(&event->call);
+	kfree(event);
+}
+
+static struct synth_event *alloc_synth_event(char *event_name, int n_fields,
+					     struct synth_field **fields)
+{
+	struct synth_event *event;
+	unsigned int i;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event) {
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->name = kstrdup(event_name, GFP_KERNEL);
+	if (!event->name) {
+		kfree(event);
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	event->fields = kcalloc(n_fields, sizeof(event->fields), GFP_KERNEL);
+	if (!event->fields) {
+		free_synth_event(event);
+		event = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	for (i = 0; i < n_fields; i++)
+		event->fields[i] = fields[i];
+
+	event->n_fields = n_fields;
+ out:
+	return event;
+}
+
+static void action_trace(struct hist_trigger_data *hist_data,
+			 struct tracing_map_elt *elt, void *rec,
+			 struct ring_buffer_event *rbe,
+			 struct action_data *data, u64 *var_ref_vals)
+{
+	struct synth_event *event = data->synth_event;
+
+	trace_synth(event, var_ref_vals, data->var_ref_idx);
+}
+
+static bool check_hist_action_refs(struct hist_trigger_data *hist_data,
+				   struct synth_event *event)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace && data->synth_event == event)
+			return true;
+	}
+
+	return false;
+}
+
+static LIST_HEAD(hist_action_list);
+static LIST_HEAD(hist_var_list);
+
+struct hist_var_data {
+	struct list_head list;
+	struct hist_trigger_data *hist_data;
+};
+
+static bool check_synth_action_refs(struct synth_event *event)
+{
+	struct hist_var_data *var_data;
+
+	list_for_each_entry(var_data, &hist_action_list, list)
+		if (check_hist_action_refs(var_data->hist_data, event))
+			return true;
+
+	return false;
+}
+
+static int create_synth_event(int argc, char **argv)
+{
+	struct synth_field *fields[SYNTH_FIELDS_MAX];
+	struct synth_event *event = NULL;
+	bool delete_event = false;
+	int i, n_fields = 0, ret = 0;
+	char *name;
+
+	mutex_lock(&synth_event_mutex);
+
+	/*
+	 * Argument syntax:
+	 *  - Add synthetic event: <event_name> field[;field] ...
+	 *  - Remove synthetic event: !<event_name> field[;field] ...
+	 *      where 'field' = type field_name
+	 */
+	if (argc < 1) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	name = argv[0];
+	if (name[0] == '!') {
+		delete_event = true;
+		name++;
+	}
+
+	event = find_synth_event(name);
+	if (event) {
+		if (delete_event) {
+			if (check_synth_action_refs(event)) {
+				ret = -EBUSY;
+				goto out;
+			}
+			remove_synth_event(event);
+			goto err;
+		} else
+			ret = -EEXIST;
+		goto out;
+	} else if (delete_event)
+		goto out;
+
+	if (argc < 2) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	for (i = 1; i < argc - 1; i++) {
+		if (strcmp(argv[i], ";") == 0)
+			continue;
+		if (n_fields == SYNTH_FIELDS_MAX) {
+			ret = -EINVAL;
+			goto out;
+		}
+		fields[n_fields] = parse_synth_field(argv[i], argv[i + 1]);
+		if (!fields[n_fields])
+			goto err;
+		i++; n_fields++;
+	}
+	if (i < argc) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	event = alloc_synth_event(name, n_fields, fields);
+	if (IS_ERR(event)) {
+		ret = PTR_ERR(event);
+		event = NULL;
+		goto err;
+	}
+
+	add_synth_event(event);
+ out:
+	mutex_unlock(&synth_event_mutex);
+
+	return ret;
+ err:
+	for (i = 0; i < n_fields; i++)
+		free_synth_field(fields[i]);
+	free_synth_event(event);
+
+	goto out;
+}
+
+static int release_all_synth_events(void)
+{
+	struct synth_event *event, *e;
+	int ret = 0;
+
+	mutex_lock(&synth_event_mutex);
+
+	list_for_each_entry(event, &synth_event_list, list) {
+		if (check_synth_action_refs(event)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
+	list_for_each_entry_safe(event, e, &synth_event_list, list) {
+		remove_synth_event(event);
+		free_synth_event(event);
+	}
+ out:
+	mutex_unlock(&synth_event_mutex);
+
+	return ret;
+}
+
+
+static void *synth_events_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&synth_event_mutex);
+
+	return seq_list_start(&synth_event_list, *pos);
+}
+
+static void *synth_events_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return seq_list_next(v, &synth_event_list, pos);
+}
+
+static void synth_events_seq_stop(struct seq_file *m, void *v)
+{
+	mutex_unlock(&synth_event_mutex);
+}
+
+static int synth_events_seq_show(struct seq_file *m, void *v)
+{
+	struct synth_field *field;
+	struct synth_event *event = v;
+	unsigned int i;
+
+	seq_printf(m, "%s\t", event->name);
+
+	for (i = 0; i < event->n_fields; i++) {
+		field = event->fields[i];
+
+		/* parameter values */
+		seq_printf(m, "%s %s%s", field->type, field->name,
+			   i == event->n_fields - 1 ? "" : "; ");
+	}
+
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static const struct seq_operations synth_events_seq_op = {
+	.start  = synth_events_seq_start,
+	.next   = synth_events_seq_next,
+	.stop   = synth_events_seq_stop,
+	.show   = synth_events_seq_show
+};
+
+static int synth_events_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
+		ret = release_all_synth_events();
+		if (ret < 0)
+			return ret;
+	}
+
+	return seq_open(file, &synth_events_seq_op);
+}
+
+static ssize_t synth_events_write(struct file *file,
+				  const char __user *buffer,
+				  size_t count, loff_t *ppos)
+{
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_synth_event);
+}
+
+static const struct file_operations synth_events_fops = {
+	.open           = synth_events_open,
+	.write		= synth_events_write,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
+static u64 hist_field_timestamp(struct hist_field *hist_field,
+				struct tracing_map_elt *elt,
+				struct ring_buffer_event *rbe,
+				void *event)
+{
+	struct hist_trigger_data *hist_data = hist_field->hist_data;
+	struct trace_array *tr = hist_data->event_file->tr;
+
+	u64 ts = ring_buffer_event_time_stamp(rbe);
+
+	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
+		ts = ns2usecs(ts);
+
+	return ts;
+}
+
+static u64 hist_field_cpu(struct hist_field *hist_field,
+			  struct tracing_map_elt *elt,
+			  struct ring_buffer_event *rbe,
+			  void *event)
+{
+	int cpu = raw_smp_processor_id();
+
+	return cpu;
+}
+
+static struct hist_field *check_var_ref(struct hist_field *hist_field,
+					struct hist_trigger_data *var_data,
+					unsigned int var_idx)
+{
+	struct hist_field *found = NULL;
+
+	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (hist_field->var.idx == var_idx &&
+		    hist_field->var.hist_data == var_data) {
+			found = hist_field;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
+				       struct hist_trigger_data *var_data,
+				       unsigned int var_idx)
+{
+	struct hist_field *hist_field, *found = NULL;
+	unsigned int i, j;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		found = check_var_ref(hist_field, var_data, var_idx);
+		if (found)
+			return found;
+
+		for (j = 0; j < HIST_FIELD_OPERANDS_MAX; j++) {
+			struct hist_field *operand;
+
+			operand = hist_field->operands[j];
+			found = check_var_ref(operand, var_data, var_idx);
+			if (found)
+				return found;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
+					   unsigned int var_idx)
+{
+	struct hist_field *found = NULL;
+	struct hist_var_data *var_data;
+
+	list_for_each_entry(var_data, &hist_var_list, list) {
+		found = find_var_ref(var_data->hist_data, hist_data, var_idx);
+		if (found)
+			break;
+	}
+
+	return found;
+}
+
+static bool check_var_refs(struct hist_trigger_data *hist_data)
+{
+	struct hist_field *field;
+	bool found = false;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		field = hist_data->fields[i];
+		if (field && field->flags & HIST_FIELD_FL_VAR) {
+			if (find_any_var_ref(hist_data, field->var.idx)) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	return found;
+}
+
+static struct hist_var_data *find_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data, *found = NULL;
+
+	list_for_each_entry(var_data, &hist_var_list, list) {
+		if (var_data->hist_data == hist_data) {
+			found = var_data;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static bool has_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_field *hist_field;
+	bool found = false;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static int save_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_vars(hist_data);
+	if (var_data)
+		return 0;
+
+	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
+	if (!var_data)
+		return -ENOMEM;
+
+	var_data->hist_data = hist_data;
+	list_add(&var_data->list, &hist_var_list);
+
+	return 0;
+}
+
+static void remove_hist_vars(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_hist_vars(hist_data);
+	if (!var_data)
+		return;
+
+	if (WARN_ON(check_var_refs(hist_data)))
+		return;
+
+	list_del(&var_data->list);
+
+	kfree(var_data);
+}
+
+static struct hist_field *find_var_field(struct hist_trigger_data *hist_data,
+					 const char *var_name)
+{
+	struct hist_field *hist_field, *found = NULL;
+	int i;
+
+	for_each_hist_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR &&
+		    strcmp(hist_field->var.name, var_name) == 0) {
+			found = hist_field;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static struct hist_field *find_var(struct trace_event_file *file,
+				   const char *var_name)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *test;
+	struct hist_field *hist_field;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = test->private_data;
+			hist_field = find_var_field(hist_data, var_name);
+			if (hist_field)
+				return hist_field;
+		}
+	}
+
+	return NULL;
+}
+
+static struct trace_event_file *find_var_file(const char *system,
+					      const char *event_name,
+					      const char *var_name)
+{
+	struct hist_trigger_data *var_hist_data;
+	struct hist_var_data *var_data;
+	struct trace_event_call *call;
+	struct trace_event_file *file;
+	const char *name;
+
+	list_for_each_entry(var_data, &hist_var_list, list) {
+		var_hist_data = var_data->hist_data;
+		file = var_hist_data->event_file;
+		call = file->event_call;
+		name = trace_event_name(call);
+
+		if (!system || !event_name) {
+			if (find_var(file, var_name))
+				return file;
+			continue;
+		}
+
+		if (strcmp(event_name, name) != 0)
+			continue;
+		if (strcmp(system, call->class->system) != 0)
+			continue;
+
+		return file;
+	}
+
+	return NULL;
+}
+
+static struct hist_field *find_file_var(struct trace_event_file *file,
+					const char *var_name)
+{
+	struct hist_trigger_data *test_data;
+	struct event_trigger_data *test;
+	struct hist_field *hist_field;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			test_data = test->private_data;
+			hist_field = find_var_field(test_data, var_name);
+			if (hist_field)
+				return hist_field;
+		}
+	}
+
+	return NULL;
+}
+
+static struct hist_field *find_event_var(const char *system,
+					 const char *event_name,
+					 const char *var_name)
+{
+	struct hist_field *hist_field = NULL;
+	struct trace_event_file *file;
+
+	file = find_var_file(system, event_name, var_name);
+	if (!file)
+		return NULL;
+
+	hist_field = find_file_var(file, var_name);
+
+	return hist_field;
+}
+
+struct hist_elt_data {
+	char *comm;
+	u64 *var_ref_vals;
+	char *field_var_str[SYNTH_FIELDS_MAX];
+};
+
+static u64 hist_field_var_ref(struct hist_field *hist_field,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *event)
+{
+	struct hist_elt_data *elt_data;
+	u64 var_val = 0;
+
+	elt_data = elt->private_data;
+	var_val = elt_data->var_ref_vals[hist_field->var_ref_idx];
+
+	return var_val;
+}
+
+static bool resolve_var_refs(struct hist_trigger_data *hist_data, void *key,
+			     u64 *var_ref_vals, bool self)
+{
+	struct hist_trigger_data *var_data;
+	struct tracing_map_elt *var_elt;
+	struct hist_field *hist_field;
+	unsigned int i, var_idx;
+	bool resolved = true;
+	u64 var_val = 0;
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		var_idx = hist_field->var.idx;
+		var_data = hist_field->var.hist_data;
+
+		if (var_data == NULL) {
+			resolved = false;
+			break;
+		}
+
+		if ((self && var_data != hist_data) ||
+		    (!self && var_data == hist_data))
+			continue;
+
+		var_elt = tracing_map_lookup(var_data->map, key);
+		if (!var_elt) {
+			resolved = false;
+			break;
+		}
+
+		if (!tracing_map_var_set(var_elt, var_idx)) {
+			resolved = false;
+			break;
+		}
+
+		if (self || !hist_field->read_once)
+			var_val = tracing_map_read_var(var_elt, var_idx);
+		else
+			var_val = tracing_map_read_var_once(var_elt, var_idx);
+
+		var_ref_vals[i] = var_val;
+	}
+
+	return resolved;
+}
+
+static const char *hist_field_name(struct hist_field *field,
+				   unsigned int level)
+{
+	const char *field_name = "";
+
+	if (level > 1)
+		return field_name;
+
+	if (field->field)
+		field_name = field->field->name;
+	else if (field->flags & HIST_FIELD_FL_LOG2 ||
+		 field->flags & HIST_FIELD_FL_ALIAS)
+		field_name = hist_field_name(field->operands[0], ++level);
+	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
+		field_name = "$common_timestamp";
+	else if (field->flags & HIST_FIELD_FL_CPU)
+		field_name = "cpu";
+	else if (field->flags & HIST_FIELD_FL_EXPR ||
+		 field->flags & HIST_FIELD_FL_VAR_REF)
+		field_name = field->name;
+
+	if (field_name == NULL)
+		field_name = "";
+
+	return field_name;
+}
+
 static hist_field_fn_t select_value_fn(int field_size, int field_is_signed)
 {
 	hist_field_fn_t fn = NULL;
@@ -207,16 +1572,98 @@ static int parse_map_size(char *str)
 
 static void destroy_hist_trigger_attrs(struct hist_trigger_attrs *attrs)
 {
+	unsigned int i;
+
 	if (!attrs)
 		return;
 
+	for (i = 0; i < attrs->n_assignments; i++)
+		kfree(attrs->assignment_str[i]);
+
+	for (i = 0; i < attrs->n_actions; i++)
+		kfree(attrs->action_str[i]);
+
 	kfree(attrs->name);
 	kfree(attrs->sort_key_str);
 	kfree(attrs->keys_str);
 	kfree(attrs->vals_str);
+	kfree(attrs->clock);
 	kfree(attrs);
 }
 
+static int parse_action(char *str, struct hist_trigger_attrs *attrs)
+{
+	int ret = -EINVAL;
+
+	if (attrs->n_actions >= HIST_ACTIONS_MAX)
+		return ret;
+
+	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
+	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
+		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
+		if (!attrs->action_str[attrs->n_actions]) {
+			ret = -ENOMEM;
+			return ret;
+		}
+		attrs->n_actions++;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
+{
+	int ret = 0;
+
+	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
+	    (strncmp(str, "keys=", strlen("keys=")) == 0))
+		attrs->keys_str = kstrdup(str, GFP_KERNEL);
+	else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
+		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
+		 (strncmp(str, "values=", strlen("values=")) == 0))
+		attrs->vals_str = kstrdup(str, GFP_KERNEL);
+	else if (strncmp(str, "sort=", strlen("sort=")) == 0)
+		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
+	else if (strncmp(str, "name=", strlen("name=")) == 0)
+		attrs->name = kstrdup(str, GFP_KERNEL);
+	else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
+		strsep(&str, "=");
+		if (!str) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		str = strstrip(str);
+		attrs->clock = kstrdup(str, GFP_KERNEL);
+	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+		int map_bits = parse_map_size(str);
+
+		if (map_bits < 0) {
+			ret = map_bits;
+			goto out;
+		}
+		attrs->map_bits = map_bits;
+	} else {
+		char *assignment;
+
+		if (attrs->n_assignments == TRACING_MAP_VARS_MAX) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		assignment = kstrdup(str, GFP_KERNEL);
+		if (!assignment) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		attrs->assignment_str[attrs->n_assignments++] = assignment;
+	}
+ out:
+	return ret;
+}
+
 static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 {
 	struct hist_trigger_attrs *attrs;
@@ -229,35 +1676,21 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 	while (trigger_str) {
 		char *str = strsep(&trigger_str, ":");
 
-		if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-		    (strncmp(str, "keys=", strlen("keys=")) == 0))
-			attrs->keys_str = kstrdup(str, GFP_KERNEL);
-		else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-			 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-			 (strncmp(str, "values=", strlen("values=")) == 0))
-			attrs->vals_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "sort=", strlen("sort=")) == 0)
-			attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
-		else if (strncmp(str, "name=", strlen("name=")) == 0)
-			attrs->name = kstrdup(str, GFP_KERNEL);
-		else if (strcmp(str, "pause") == 0)
+		if (strchr(str, '=')) {
+			ret = parse_assignment(str, attrs);
+			if (ret)
+				goto free;
+		} else if (strcmp(str, "pause") == 0)
 			attrs->pause = true;
 		else if ((strcmp(str, "cont") == 0) ||
 			 (strcmp(str, "continue") == 0))
 			attrs->cont = true;
 		else if (strcmp(str, "clear") == 0)
 			attrs->clear = true;
-		else if (strncmp(str, "size=", strlen("size=")) == 0) {
-			int map_bits = parse_map_size(str);
-
-			if (map_bits < 0) {
-				ret = map_bits;
+		else {
+			ret = parse_action(str, attrs);
+			if (ret)
 				goto free;
-			}
-			attrs->map_bits = map_bits;
-		} else {
-			ret = -EINVAL;
-			goto free;
 		}
 	}
 
@@ -266,6 +1699,12 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 		goto free;
 	}
 
+	if (!attrs->clock) {
+		attrs->clock = kstrdup("global", GFP_KERNEL);
+		if (!attrs->clock)
+			goto free;
+	}
+
 	return attrs;
  free:
 	destroy_hist_trigger_attrs(attrs);
@@ -288,65 +1727,183 @@ static inline void save_comm(char *comm, struct task_struct *task)
 	memcpy(comm, task->comm, TASK_COMM_LEN);
 }
 
-static void hist_trigger_elt_comm_free(struct tracing_map_elt *elt)
-{
-	kfree((char *)elt->private_data);
-}
-
-static int hist_trigger_elt_comm_alloc(struct tracing_map_elt *elt)
+static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 {
 	struct hist_trigger_data *hist_data = elt->map->private_data;
+	struct hist_elt_data *private_data = elt->private_data;
+	unsigned int i, n_str;
+
+	n_str = hist_data->n_field_var_str + hist_data->n_max_var_str;
+
+	for (i = 0; i < n_str; i++)
+		kfree(private_data->field_var_str[i]);
+
+	kfree(private_data->comm);
+	kfree(private_data);
+}
+
+static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
+{
+	struct hist_trigger_data *hist_data = elt->map->private_data;
+	unsigned int size = TASK_COMM_LEN + 1;
+	struct hist_elt_data *elt_data;
 	struct hist_field *key_field;
-	unsigned int i;
+	unsigned int i, n_str;
+
+	elt->private_data = elt_data = kzalloc(sizeof(*elt_data), GFP_KERNEL);
+	if (!elt_data)
+		return -ENOMEM;
 
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			unsigned int size = TASK_COMM_LEN + 1;
-
-			elt->private_data = kzalloc(size, GFP_KERNEL);
-			if (!elt->private_data)
+			elt_data->comm = kzalloc(size, GFP_KERNEL);
+			if (!elt_data->comm) {
+				kfree(elt_data);
+				elt->private_data = NULL;
 				return -ENOMEM;
+			}
 			break;
 		}
 	}
 
+	n_str = hist_data->n_field_var_str + hist_data->n_max_var_str;
+
+	for (i = 0; i < n_str; i++) {
+		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);
+		if (!elt_data->field_var_str[i]) {
+			hist_trigger_elt_data_free(elt);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
 }
 
-static void hist_trigger_elt_comm_copy(struct tracing_map_elt *to,
+static void hist_trigger_elt_data_copy(struct tracing_map_elt *to,
 				       struct tracing_map_elt *from)
 {
-	char *comm_from = from->private_data;
-	char *comm_to = to->private_data;
+	struct hist_elt_data *from_data = from->private_data;
+	struct hist_elt_data *to_data = to->private_data;
 
-	if (comm_from)
-		memcpy(comm_to, comm_from, TASK_COMM_LEN + 1);
+	memcpy(to_data, from_data, sizeof(*to));
+
+	if (from_data->comm)
+		memcpy(to_data->comm, from_data->comm, TASK_COMM_LEN + 1);
 }
 
-static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
+static void hist_trigger_elt_data_init(struct tracing_map_elt *elt)
 {
-	char *comm = elt->private_data;
+	struct hist_elt_data *private_data = elt->private_data;
 
-	if (comm)
-		save_comm(comm, current);
+	if (private_data->comm)
+		save_comm(private_data->comm, current);
 }
 
-static const struct tracing_map_ops hist_trigger_elt_comm_ops = {
-	.elt_alloc	= hist_trigger_elt_comm_alloc,
-	.elt_copy	= hist_trigger_elt_comm_copy,
-	.elt_free	= hist_trigger_elt_comm_free,
-	.elt_init	= hist_trigger_elt_comm_init,
+static const struct tracing_map_ops hist_trigger_elt_data_ops = {
+	.elt_alloc	= hist_trigger_elt_data_alloc,
+	.elt_copy	= hist_trigger_elt_data_copy,
+	.elt_free	= hist_trigger_elt_data_free,
+	.elt_init	= hist_trigger_elt_data_init,
 };
 
-static void destroy_hist_field(struct hist_field *hist_field)
+static char *expr_str(struct hist_field *field, unsigned int level)
 {
+	char *expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+
+	if (!expr || level > 1)
+		return NULL;
+
+	if (field->operator == FIELD_OP_UNARY_MINUS) {
+		char *subexpr;
+
+		strcat(expr, "-(");
+		subexpr = expr_str(field->operands[0], ++level);
+		if (!subexpr) {
+			kfree(expr);
+			return NULL;
+		}
+		strcat(expr, subexpr);
+		strcat(expr, ")");
+
+		return expr;
+	}
+
+	if (field->operands[0]->flags & HIST_FIELD_FL_VAR_REF)
+		strcat(expr, "$");
+	strcat(expr, hist_field_name(field->operands[0], 0));
+
+	switch (field->operator) {
+	case FIELD_OP_MINUS:
+		strcat(expr, "-");
+		break;
+	case FIELD_OP_PLUS:
+		strcat(expr, "+");
+		break;
+	default:
+		kfree(expr);
+		return NULL;
+	}
+
+	if (field->operands[1]->flags & HIST_FIELD_FL_VAR_REF)
+		strcat(expr, "$");
+	strcat(expr, hist_field_name(field->operands[1], 0));
+
+	return expr;
+}
+
+static int contains_operator(char *str)
+{
+	enum field_op_id field_op = FIELD_OP_NONE;
+	char *op;
+
+	op = strpbrk(str, "+-");
+	if (!op)
+		return FIELD_OP_NONE;
+
+	switch (*op) {
+	case '-':
+		if (*str == '-')
+			field_op = FIELD_OP_UNARY_MINUS;
+		else
+			field_op = FIELD_OP_MINUS;
+		break;
+	case '+':
+		field_op = FIELD_OP_PLUS;
+		break;
+	default:
+		break;
+	}
+
+	return field_op;
+}
+
+static void destroy_hist_field(struct hist_field *hist_field,
+			       unsigned int level)
+{
+	unsigned int i;
+
+	if (level > 2)
+		return;
+
+	if (!hist_field)
+		return;
+
+	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
+		destroy_hist_field(hist_field->operands[i], ++level);
+
+	kfree(hist_field->var.name);
+	kfree(hist_field->name);
+	kfree(hist_field->type);
+
 	kfree(hist_field);
 }
 
-static struct hist_field *create_hist_field(struct ftrace_event_field *field,
-					    unsigned long flags)
+static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
+					    struct ftrace_event_field *field,
+					    unsigned long flags,
+					    char *var_name)
 {
 	struct hist_field *hist_field;
 
@@ -357,8 +1914,22 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	if (!hist_field)
 		return NULL;
 
+	hist_field->hist_data = hist_data;
+
+	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
+		goto out; /* caller will populate */
+
+	if (flags & HIST_FIELD_FL_VAR_REF) {
+		hist_field->fn = hist_field_var_ref;
+		goto out;
+	}
+
 	if (flags & HIST_FIELD_FL_HITCOUNT) {
 		hist_field->fn = hist_field_counter;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -368,7 +1939,31 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	}
 
 	if (flags & HIST_FIELD_FL_LOG2) {
+		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
 		hist_field->fn = hist_field_log2;
+		hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
+		hist_field->size = hist_field->operands[0]->size;
+		hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
+	if (flags & HIST_FIELD_FL_TIMESTAMP) {
+		hist_field->fn = hist_field_timestamp;
+		hist_field->size = sizeof(u64);
+		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+		goto out;
+	}
+
+	if (flags & HIST_FIELD_FL_CPU) {
+		hist_field->fn = hist_field_cpu;
+		hist_field->size = sizeof(int);
+		hist_field->type = kstrdup("int", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -377,6 +1972,10 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 
 	if (is_string_field(field)) {
 		flags |= HIST_FIELD_FL_STRING;
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 
 		if (field->filter_type == FILTER_STATIC_STRING)
 			hist_field->fn = hist_field_string;
@@ -385,10 +1984,16 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 		else
 			hist_field->fn = hist_field_pstring;
 	} else {
+		hist_field->size = field->size;
+		hist_field->is_signed = field->is_signed;
+		hist_field->type = kstrdup(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
 		hist_field->fn = select_value_fn(field->size,
 						 field->is_signed);
 		if (!hist_field->fn) {
-			destroy_hist_field(hist_field);
+			destroy_hist_field(hist_field, 0);
 			return NULL;
 		}
 	}
@@ -396,29 +2001,1349 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	hist_field->field = field;
 	hist_field->flags = flags;
 
+	if (var_name) {
+		hist_field->var.name = kstrdup(var_name, GFP_KERNEL);
+		if (!hist_field->var.name)
+			goto free;
+	}
+
 	return hist_field;
+ free:
+	destroy_hist_field(hist_field, 0);
+	return NULL;
 }
 
 static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 {
 	unsigned int i;
 
-	for (i = 0; i < TRACING_MAP_FIELDS_MAX; i++) {
+	for (i = 0; i < HIST_FIELDS_MAX; i++) {
 		if (hist_data->fields[i]) {
-			destroy_hist_field(hist_data->fields[i]);
+			destroy_hist_field(hist_data->fields[i], 0);
 			hist_data->fields[i] = NULL;
 		}
 	}
 }
 
+static struct hist_field *create_var_ref(struct hist_field *var_field)
+{
+	unsigned long flags = HIST_FIELD_FL_VAR_REF;
+	struct hist_field *ref_field;
+
+	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
+	if (ref_field) {
+		ref_field->var.idx = var_field->var.idx;
+		ref_field->var.hist_data = var_field->hist_data;
+		ref_field->size = var_field->size;
+		ref_field->is_signed = var_field->is_signed;
+		ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
+		ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
+		if (!ref_field->name || !ref_field->type) {
+			kfree(ref_field->name);
+			kfree(ref_field->type);
+			destroy_hist_field(ref_field, 0);
+			return NULL;
+		}
+	}
+
+	return ref_field;
+}
+
+static bool is_common_field(char *var_name)
+{
+	if (strncmp(var_name, "$common_timestamp", strlen("$common_timestamp")) == 0)
+		return true;
+
+	return false;
+}
+
+static struct hist_field *parse_var_ref(char *system, char *event_name,
+					char *var_name)
+{
+	struct hist_field *var_field = NULL, *ref_field = NULL;
+
+	if (!var_name || strlen(var_name) < 2 || var_name[0] != '$' ||
+	    is_common_field(var_name))
+		return NULL;
+
+	var_name++;
+
+	var_field = find_event_var(system, event_name, var_name);
+	if (var_field)
+		ref_field = create_var_ref(var_field);
+
+	if (!ref_field)
+		hist_err_event("Couldn't find variable: $",
+			       system, event_name, var_name);
+
+	return ref_field;
+}
+
+static struct ftrace_event_field *
+parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
+	    char *field_str, unsigned long *flags)
+{
+	struct ftrace_event_field *field = NULL;
+	char *field_name;
+
+	field_name = strsep(&field_str, ".");
+	if (field_str) {
+		if (strcmp(field_str, "hex") == 0)
+			*flags |= HIST_FIELD_FL_HEX;
+		else if (strcmp(field_str, "sym") == 0)
+			*flags |= HIST_FIELD_FL_SYM;
+		else if (strcmp(field_str, "sym-offset") == 0)
+			*flags |= HIST_FIELD_FL_SYM_OFFSET;
+		else if ((strcmp(field_str, "execname") == 0) &&
+			 (strcmp(field_name, "common_pid") == 0))
+			*flags |= HIST_FIELD_FL_EXECNAME;
+		else if (strcmp(field_str, "syscall") == 0)
+			*flags |= HIST_FIELD_FL_SYSCALL;
+		else if (strcmp(field_str, "log2") == 0)
+			*flags |= HIST_FIELD_FL_LOG2;
+		else if (strcmp(field_str, "usecs") == 0)
+			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
+		else
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (strcmp(field_name, "$common_timestamp") == 0) {
+		*flags |= HIST_FIELD_FL_TIMESTAMP;
+		hist_data->enable_timestamps = true;
+		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+			hist_data->attrs->ts_in_usecs = true;
+	} else if (strcmp(field_name, "cpu") == 0)
+		*flags |= HIST_FIELD_FL_CPU;
+	else {
+		field = trace_find_event_field(file->event_call, field_name);
+		if (!field)
+			return ERR_PTR(-EINVAL);
+	}
+
+	return field;
+}
+
+static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
+				       struct hist_field *var_ref,
+				       char *var_name)
+{
+	struct hist_field *alias = NULL;
+	unsigned long flags = HIST_FIELD_FL_ALIAS | HIST_FIELD_FL_VAR |
+		HIST_FIELD_FL_VAR_ONLY;
+
+	alias = create_hist_field(hist_data, NULL, flags, var_name);
+	if (!alias)
+		return NULL;
+
+	alias->fn = var_ref->fn;
+	alias->operands[0] = var_ref;
+	alias->var.idx = var_ref->var.idx;
+	alias->var.hist_data = var_ref->hist_data;
+	alias->size = var_ref->size;
+	alias->is_signed = var_ref->is_signed;
+	alias->type = kstrdup(var_ref->type, GFP_KERNEL);
+	if (!alias->type) {
+		kfree(alias->type);
+		destroy_hist_field(alias, 0);
+		return NULL;
+	}
+
+	return alias;
+}
+
+struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
+			      struct trace_event_file *file, char *str,
+			      unsigned long *flags, char *var_name)
+{
+	char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
+	struct ftrace_event_field *field = NULL;
+	struct hist_field *hist_field = NULL;
+	int ret = 0;
+
+	s = strchr(str, '.');
+	if (s) {
+		s = strchr(++s, '.');
+		if (s) {
+			ref_system = strsep(&str, ".");
+			ref_event = strsep(&str, ".");
+			ref_var = str;
+		}
+	}
+
+	hist_field = parse_var_ref(ref_system, ref_event, ref_var);
+	if (hist_field) {
+		hist_data->var_refs[hist_data->n_var_refs] = hist_field;
+		hist_field->var_ref_idx = hist_data->n_var_refs++;
+		if (var_name) {
+			hist_field = create_alias(hist_data, hist_field, var_name);
+			if (!hist_field) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+		return hist_field;
+	}
+
+	field = parse_field(hist_data, file, str, flags);
+	if (IS_ERR(field)) {
+		ret = PTR_ERR(field);
+		goto out;
+	}
+
+	hist_field = create_hist_field(hist_data, field, *flags, var_name);
+	if (!hist_field) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	return hist_field;
+ out:
+	return ERR_PTR(ret);
+}
+
+static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *str, unsigned long flags,
+				     char *var_name, unsigned int level);
+
+static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
+				      struct trace_event_file *file,
+				      char *str, unsigned long flags,
+				      char *var_name, unsigned int level)
+{
+	struct hist_field *operand1, *expr = NULL;
+	unsigned long operand_flags;
+	char *operand1_str;
+	int ret = 0;
+	char *s;
+
+	// we support only -(xxx) i.e. explicit parens required
+
+	if (level > 2) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	str++; // skip leading '-'
+
+	s = strchr(str, '(');
+	if (s)
+		str++;
+	else {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	s = strchr(str, ')');
+	if (s)
+		*s = '\0';
+	else {
+		ret = -EINVAL; // no closing ')'
+		goto free;
+	}
+
+	operand1_str = strsep(&str, "(");
+	if (!operand1_str)
+		goto free;
+
+	flags |= HIST_FIELD_FL_EXPR;
+	expr = create_hist_field(hist_data, NULL, flags, var_name);
+	if (!expr) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	operand_flags = 0;
+	operand1 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
+	if (IS_ERR(operand1)) {
+		ret = PTR_ERR(operand1);
+		goto free;
+	}
+
+	if (operand1 == NULL) {
+		operand_flags = 0;
+		operand1 = parse_atom(hist_data, file, operand1_str,
+				      &operand_flags, NULL);
+		if (IS_ERR(operand1)) {
+			ret = PTR_ERR(operand1);
+			goto free;
+		}
+	}
+
+	expr->fn = hist_field_unary_minus;
+	expr->operands[0] = operand1;
+	expr->operator = FIELD_OP_UNARY_MINUS;
+	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	return expr;
+ free:
+	return ERR_PTR(ret);
+}
+
+static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *str, unsigned long flags,
+				     char *var_name, unsigned int level)
+{
+	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
+	unsigned long operand_flags;
+	int field_op, ret = -EINVAL;
+	char *sep, *operand1_str;
+
+	if (level > 2)
+		return NULL;
+
+	field_op = contains_operator(str);
+	if (field_op == FIELD_OP_NONE)
+		return NULL;
+
+	if (field_op == FIELD_OP_UNARY_MINUS)
+		return parse_unary(hist_data, file, str, flags, var_name, ++level);
+
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		sep = "-";
+		break;
+	case FIELD_OP_PLUS:
+		sep = "+";
+		break;
+	default:
+		goto free;
+	}
+
+	operand1_str = strsep(&str, sep);
+	if (!operand1_str || !str)
+		goto free;
+
+	operand_flags = 0;
+	operand1 = parse_atom(hist_data, file, operand1_str,
+			      &operand_flags, NULL);
+	if (IS_ERR(operand1)) {
+		ret = PTR_ERR(operand1);
+		operand1 = NULL;
+		goto free;
+	}
+
+	// rest of string could be another expression e.g. b+c in a+b+c
+	operand_flags = 0;
+	operand2 = parse_expr(hist_data, file, str, operand_flags, NULL, ++level);
+	if (IS_ERR(operand2)) {
+		ret = PTR_ERR(operand2);
+		operand2 = NULL;
+		goto free;
+	}
+	if (!operand2) {
+		operand_flags = 0;
+		operand2 = parse_atom(hist_data, file, str,
+				      &operand_flags, NULL);
+		if (IS_ERR(operand2)) {
+			ret = PTR_ERR(operand2);
+			operand2 = NULL;
+			goto free;
+		}
+	}
+
+	flags |= HIST_FIELD_FL_EXPR;
+	expr = create_hist_field(hist_data, NULL, flags, var_name);
+	if (!expr) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	operand1->read_once = true;
+	operand2->read_once = true;
+
+	expr->operands[0] = operand1;
+	expr->operands[1] = operand2;
+	expr->operator = field_op;
+	expr->name = expr_str(expr, 0);
+	expr->type = kstrdup(operand1->type, GFP_KERNEL);
+	if (!expr->type) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	switch (field_op) {
+	case FIELD_OP_MINUS:
+		expr->fn = hist_field_minus;
+		break;
+	case FIELD_OP_PLUS:
+		expr->fn = hist_field_plus;
+		break;
+	default:
+		goto free;
+	}
+
+	return expr;
+ free:
+	destroy_hist_field(operand1, 0);
+	destroy_hist_field(operand2, 0);
+	destroy_hist_field(expr, 0);
+
+	return ERR_PTR(ret);
+}
+
+static struct hist_var_data *find_actions(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data, *found = NULL;
+
+	list_for_each_entry(var_data, &hist_action_list, list) {
+		if (var_data->hist_data == hist_data) {
+			found = var_data;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static int save_hist_actions(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_actions(hist_data);
+	if (var_data)
+		return 0;
+
+	var_data = kzalloc(sizeof(*var_data), GFP_KERNEL);
+	if (!var_data)
+		return -ENOMEM;
+
+	var_data->hist_data = hist_data;
+	list_add(&var_data->list, &hist_action_list);
+
+	return 0;
+}
+
+static void remove_hist_actions(struct hist_trigger_data *hist_data)
+{
+	struct hist_var_data *var_data;
+
+	var_data = find_actions(hist_data);
+	if (!var_data)
+		return;
+
+	list_del(&var_data->list);
+
+	kfree(var_data);
+}
+
+static char *find_trigger_filter(struct hist_trigger_data *hist_data,
+				 struct trace_event_file *file)
+{
+	struct event_trigger_data *test;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (test->private_data == hist_data)
+				return test->filter_str;
+		}
+	}
+
+	return NULL;
+}
+
+static struct event_command trigger_hist_cmd;
+static int event_hist_trigger_func(struct event_command *cmd_ops,
+				   struct trace_event_file *file,
+				   char *glob, char *cmd, char *param);
+
+static bool compatible_keys(struct hist_trigger_data *target_hist_data,
+			    struct hist_trigger_data *hist_data,
+			    unsigned int n_keys)
+{
+	struct hist_field *target_hist_field, *hist_field;
+	unsigned int n, i, j;
+
+	if (hist_data->n_fields - hist_data->n_vals != n_keys)
+		return false;
+
+	i = hist_data->n_vals;
+	j = target_hist_data->n_vals;
+
+	for (n = 0; n < n_keys; n++) {
+		hist_field = hist_data->fields[i + n];
+		target_hist_field = hist_data->fields[j + n];
+
+		if (strcmp(hist_field->type, target_hist_field->type) != 0)
+			return false;
+		if (hist_field->size != target_hist_field->size)
+			return false;
+		if (hist_field->is_signed != target_hist_field->is_signed)
+			return false;
+	}
+
+	return true;
+}
+
+static struct hist_trigger_data *
+find_compatible_hist(struct hist_trigger_data *target_hist_data,
+		     struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *test;
+	unsigned int n_keys;
+
+	n_keys = target_hist_data->n_fields - target_hist_data->n_vals;
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = test->private_data;
+
+			if (compatible_keys(target_hist_data, hist_data, n_keys))
+				return hist_data;
+		}
+	}
+
+	return NULL;
+}
+
+static struct trace_event_file *event_file(char *system, char *event_name)
+{
+	struct trace_event_file *file;
+	struct trace_array *tr;
+
+	tr = top_trace_array();
+	if (!tr)
+		return ERR_PTR(-ENODEV);
+
+	file = find_event_file(tr, system, event_name);
+	if (!file)
+		return ERR_PTR(-EINVAL);
+
+	return file;
+}
+
+static struct hist_field *
+create_field_var_hist(struct hist_trigger_data *target_hist_data,
+		      char *system, char *event_name, char *field_name)
+{
+	struct hist_field *event_var = ERR_PTR(-EINVAL);
+	struct hist_trigger_data *hist_data;
+	unsigned int i, n, first = true;
+	struct field_var_hist *var_hist;
+	struct trace_event_file *file;
+	struct hist_field *key_field;
+	struct trace_array *tr;
+	char *saved_filter;
+	char *cmd;
+	int ret;
+
+	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
+		hist_err_event("onmatch: Too many field variables defined: ",
+			       system, event_name, field_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	tr = top_trace_array();
+	if (!tr)
+		return ERR_PTR(-ENODEV);
+
+	file = event_file(system, event_name);
+	if (IS_ERR(file)) {
+		hist_err_event("onmatch: Event file not found: ",
+			       system, event_name, field_name);
+		ret = PTR_ERR(file);
+		return ERR_PTR(ret);
+	}
+
+	hist_data = find_compatible_hist(target_hist_data, file);
+	if (!hist_data) {
+		hist_err_event("onmatch: Matching event histogram not found: ",
+			       system, event_name, field_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	var_hist = kzalloc(sizeof(*var_hist), GFP_KERNEL);
+	if (!var_hist)
+		return ERR_PTR(-ENOMEM);
+
+	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	if (!cmd) {
+		kfree(var_hist);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	strcat(cmd, "keys=");
+
+	for_each_hist_key_field(i, hist_data) {
+		key_field = hist_data->fields[i];
+		if (!first)
+			strcat(cmd, ",");
+		strcat(cmd, key_field->field->name);
+		first = false;
+	}
+
+	strcat(cmd, ":synthetic_");
+	strcat(cmd, field_name);
+	strcat(cmd, "=");
+	strcat(cmd, field_name);
+
+	saved_filter = find_trigger_filter(hist_data, file);
+	if (saved_filter) {
+		strcat(cmd, " if ");
+		strcat(cmd, saved_filter);
+	}
+
+	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
+	if (!var_hist->cmd) {
+		kfree(cmd);
+		kfree(var_hist);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	var_hist->hist_data = hist_data;
+
+	ret = event_hist_trigger_func(&trigger_hist_cmd, file,
+				      "", "hist", cmd);
+	if (ret) {
+		kfree(cmd);
+		kfree(var_hist->cmd);
+		kfree(var_hist);
+		hist_err_event("onmatch: Couldn't create histogram for field: ",
+			       system, event_name, field_name);
+		return ERR_PTR(ret);
+	}
+
+	strcpy(cmd, "synthetic_");
+	strcat(cmd, field_name);
+
+	event_var = find_event_var(system, event_name, cmd);
+	if (!event_var) {
+		kfree(cmd);
+		kfree(var_hist->cmd);
+		kfree(var_hist);
+		hist_err_event("onmatch: Couldn't find synthetic variable: ",
+			       system, event_name, field_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	n = target_hist_data->n_field_var_hists;
+	target_hist_data->field_var_hists[n] = var_hist;
+	target_hist_data->n_field_var_hists++;
+
+	return event_var;
+}
+
+static struct hist_field *
+find_target_event_var(struct hist_trigger_data *hist_data,
+		      char *system, char *event_name, char *var_name)
+{
+	struct trace_event_file *file = hist_data->event_file;
+	struct hist_field *hist_field = NULL;
+
+	if (system) {
+		struct trace_event_call *call;
+
+		if (!event_name)
+			return NULL;
+
+		call = file->event_call;
+
+		if (strcmp(system, call->class->system) != 0)
+			return NULL;
+
+		if (strcmp(event_name, trace_event_name(call)) != 0)
+			return NULL;
+	}
+
+	hist_field = find_var_field(hist_data, var_name);
+
+	return hist_field;
+}
+
+static inline void __update_field_vars(struct tracing_map_elt *elt,
+				       struct ring_buffer_event *rbe,
+				       void *rec,
+				       struct field_var **field_vars,
+				       unsigned int n_field_vars,
+				       unsigned int field_var_str_start)
+{
+	struct hist_elt_data *elt_data = elt->private_data;
+	unsigned int i, j, var_idx;
+	u64 var_val;
+
+	for (i = 0, j = field_var_str_start; i < n_field_vars; i++) {
+		struct field_var *field_var = field_vars[i];
+		struct hist_field *var = field_var->var;
+		struct hist_field *val = field_var->val;
+
+		var_val = val->fn(val, elt, rbe, rec);
+		var_idx = var->var.idx;
+
+		if (val->flags & HIST_FIELD_FL_STRING) {
+			char *str = elt_data->field_var_str[j++];
+
+			memcpy(str, (char *)(uintptr_t)var_val,
+			       TASK_COMM_LEN + 1);
+			var_val = (u64)(uintptr_t)str;
+		}
+		tracing_map_set_var(elt, var_idx, var_val);
+	}
+}
+
+static void update_field_vars(struct hist_trigger_data *hist_data,
+			      struct tracing_map_elt *elt,
+			      struct ring_buffer_event *rbe,
+			      void *rec)
+{
+	__update_field_vars(elt, rbe, rec, hist_data->field_vars,
+			    hist_data->n_field_vars, 0);
+}
+
+static void update_max_vars(struct hist_trigger_data *hist_data,
+			    struct tracing_map_elt *elt,
+			    struct ring_buffer_event *rbe,
+			    void *rec)
+{
+	__update_field_vars(elt, rbe, rec, hist_data->max_vars,
+			    hist_data->n_max_vars, hist_data->n_field_var_str);
+}
+
+static struct hist_field *create_var(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file,
+				     char *name, int size, const char *type)
+{
+	struct hist_field *var;
+	int idx;
+
+	if (find_var(file, name) && !hist_data->remove) {
+		var = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	var = kzalloc(sizeof(struct hist_field), GFP_KERNEL);
+	if (!var) {
+		var = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	idx = tracing_map_add_var(hist_data->map);
+	if (idx < 0) {
+		kfree(var);
+		var = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	var->flags = HIST_FIELD_FL_VAR;
+	var->var.idx = idx;
+	var->var.hist_data = var->hist_data = hist_data;
+	var->size = size;
+	var->var.name = kstrdup(name, GFP_KERNEL);
+	var->type = kstrdup(type, GFP_KERNEL);
+	if (!var->var.name || !var->type) {
+		kfree(var->var.name);
+		kfree(var->type);
+		kfree(var);
+		var = ERR_PTR(-ENOMEM);
+	}
+ out:
+	return var;
+}
+
+static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
+					  struct trace_event_file *file,
+					  char *field_name)
+{
+	struct hist_field *val = NULL, *var = NULL;
+	unsigned long flags = HIST_FIELD_FL_VAR;
+	struct field_var *field_var;
+	int ret = 0;
+
+	if (hist_data->n_field_vars >= SYNTH_FIELDS_MAX) {
+		hist_err("Too many field variables defined: ", field_name);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	val = parse_atom(hist_data, file, field_name, &flags, NULL);
+	if (IS_ERR(val)) {
+		hist_err("Couldn't parse field variable: ", field_name);
+		ret = PTR_ERR(val);
+		goto err;
+	}
+
+	var = create_var(hist_data, file, field_name, val->size, val->type);
+	if (IS_ERR(var)) {
+		hist_err("Couldn't create or find variable: ", field_name);
+		kfree(val);
+		ret = PTR_ERR(var);
+		goto err;
+	}
+
+	field_var = kzalloc(sizeof(struct field_var), GFP_KERNEL);
+	if (!field_var) {
+		kfree(val);
+		kfree(var);
+		ret =  -ENOMEM;
+		goto err;
+	}
+
+	field_var->var = var;
+	field_var->val = val;
+ out:
+	return field_var;
+ err:
+	field_var = ERR_PTR(ret);
+	goto out;
+}
+
+static struct field_var *
+create_target_field_var(struct hist_trigger_data *hist_data,
+			char *system, char *event_name, char *var_name)
+{
+	struct trace_event_file *file = hist_data->event_file;
+
+	if (system) {
+		struct trace_event_call *call;
+
+		if (!event_name)
+			return NULL;
+
+		call = file->event_call;
+
+		if (strcmp(system, call->class->system) != 0)
+			return NULL;
+
+		if (strcmp(event_name, trace_event_name(call)) != 0)
+			return NULL;
+	}
+
+	return create_field_var(hist_data, file, var_name);
+}
+
+static void onmax_print(struct seq_file *m,
+			struct hist_trigger_data *hist_data,
+			struct tracing_map_elt *elt,
+			struct action_data *data)
+{
+	unsigned int i, save_var_idx, max_idx = data->max_var->var.idx;
+
+	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
+
+	for (i = 0; i < hist_data->n_max_vars; i++) {
+		struct hist_field *save_val = hist_data->max_vars[i]->val;
+		struct hist_field *save_var = hist_data->max_vars[i]->var;
+		u64 val;
+
+		save_var_idx = save_var->var.idx;
+
+		val = tracing_map_read_var(elt, save_var_idx);
+
+		if (save_val->flags & HIST_FIELD_FL_STRING) {
+			seq_printf(m, "  %s: %-50s", save_var->var.name,
+				   (char *)(uintptr_t)(val));
+		} else
+			seq_printf(m, "  %s: %10llu", save_var->var.name, val);
+	}
+}
+
+static void onmax_save(struct hist_trigger_data *hist_data,
+		       struct tracing_map_elt *elt, void *rec,
+		       struct ring_buffer_event *rbe,
+		       struct action_data *data, u64 *var_ref_vals)
+{
+	unsigned int max_idx = data->max_var->var.idx;
+	unsigned int max_var_ref_idx = data->max_var_ref_idx;
+
+	u64 var_val, max_val;
+
+	var_val = var_ref_vals[max_var_ref_idx];
+	max_val = tracing_map_read_var(elt, max_idx);
+
+	if (var_val <= max_val)
+		return;
+
+	tracing_map_set_var(elt, max_idx, var_val);
+
+	update_max_vars(hist_data, elt, rbe, rec);
+}
+
+static void onmax_destroy(struct action_data *data)
+{
+	unsigned int i;
+
+	destroy_hist_field(data->max_var, 0);
+	destroy_hist_field(data->onmax_var, 0);
+
+	kfree(data->onmax_var_str);
+	kfree(data->onmax_fn_name);
+
+	for (i = 0; i < data->n_params; i++)
+		kfree(data->params[i]);
+
+	kfree(data);
+}
+
+static int onmax_create(struct hist_trigger_data *hist_data,
+			struct action_data *data)
+{
+	struct trace_event_call *call = hist_data->event_file->event_call;
+	struct trace_event_file *file = hist_data->event_file;
+	struct hist_field *var_field, *ref_field, *max_var;
+	unsigned int var_ref_idx = hist_data->n_var_refs;
+	struct field_var *field_var;
+	char *onmax_var_str, *param;
+	const char *event_name;
+	unsigned long flags;
+	unsigned int i;
+	int ret = 0;
+
+	onmax_var_str = data->onmax_var_str;
+	if (onmax_var_str[0] != '$') {
+		hist_err("onmax: For onmax(x), x must be a variable: ", onmax_var_str);
+		return -EINVAL;
+	}
+	onmax_var_str++;
+
+	event_name = trace_event_name(call);
+	var_field = find_target_event_var(hist_data, NULL, NULL, onmax_var_str);
+	if (!var_field) {
+		hist_err("onmax: Couldn't find onmax variable: ", onmax_var_str);
+		return -EINVAL;
+	}
+
+	flags = HIST_FIELD_FL_VAR_REF;
+	ref_field = create_hist_field(hist_data, NULL, flags, NULL);
+	if (!ref_field)
+		return -ENOMEM;
+
+	ref_field->var.idx = var_field->var.idx;
+	ref_field->var.hist_data = hist_data;
+	ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
+	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
+	if (!ref_field->name || !ref_field->type) {
+		destroy_hist_field(ref_field, 0);
+		ret = -ENOMEM;
+		goto out;
+	}
+	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
+	ref_field->var_ref_idx = hist_data->n_var_refs++;
+	data->onmax_var = ref_field;
+
+	data->fn = onmax_save;
+	data->max_var_ref_idx = var_ref_idx;
+	max_var = create_var(hist_data, file, "max", sizeof(u64), "u64");
+	if (IS_ERR(max_var)) {
+		hist_err("onmax: Couldn't create onmax variable: ", "max");
+		ret = PTR_ERR(max_var);
+		goto out;
+	}
+	data->max_var = max_var;
+
+	for (i = 0; i < data->n_params; i++) {
+		param = kstrdup(data->params[i], GFP_KERNEL);
+		if (!param)
+			goto out;
+
+		field_var = create_target_field_var(hist_data, NULL, NULL, param);
+		if (IS_ERR(field_var)) {
+			hist_err("onmax: Couldn't create field variable: ", param);
+			ret = PTR_ERR(field_var);
+			kfree(param);
+			goto out;
+		}
+
+		hist_data->max_vars[hist_data->n_max_vars++] = field_var;
+		if (field_var->val->flags & HIST_FIELD_FL_STRING)
+			hist_data->n_max_var_str++;
+
+		kfree(param);
+	}
+
+	hist_data->actions[hist_data->n_actions++] = data;
+ out:
+	return ret;
+}
+
+static int parse_action_params(char *params, struct action_data *data)
+{
+	char *param, *saved_param;
+	int ret = 0;
+
+	while (params) {
+		if (data->n_params >= SYNTH_FIELDS_MAX)
+			goto out;
+
+		param = strsep(&params, ",");
+		if (!param)
+			goto out;
+
+		param = strstrip(param);
+		if (strlen(param) < 2) {
+			hist_err("Invalid action param: ", param);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		saved_param = kstrdup(param, GFP_KERNEL);
+		if (!saved_param) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		data->params[data->n_params++] = saved_param;
+	}
+ out:
+	return ret;
+}
+
+static struct action_data *onmax_parse(char *str)
+{
+	char *onmax_fn_name, *onmax_var_str;
+	struct action_data *data;
+	int ret = -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	onmax_var_str = strsep(&str, ")");
+	if (!onmax_var_str || !str)
+		return ERR_PTR(-EINVAL);
+	data->onmax_var_str = kstrdup(onmax_var_str, GFP_KERNEL);
+
+	strsep(&str, ".");
+	if (!str)
+		goto free;
+
+	onmax_fn_name = strsep(&str, "(");
+	if (!onmax_fn_name || !str)
+		goto free;
+
+	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
+		char *params = strsep(&str, ")");
+
+		if (!params)
+			goto free;
+
+		ret = parse_action_params(params, data);
+		if (ret)
+			goto free;
+	}
+	data->onmax_fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
+
+	if (!data->onmax_var_str || !data->onmax_fn_name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+ out:
+	return data;
+ free:
+	onmax_destroy(data);
+	data = ERR_PTR(ret);
+	goto out;
+}
+
+static void onmatch_destroy(struct action_data *data)
+{
+	unsigned int i;
+
+	kfree(data->match_event);
+	kfree(data->match_event_system);
+	kfree(data->synth_event_name);
+
+	for (i = 0; i < data->n_params; i++)
+		kfree(data->params[i]);
+
+	kfree(data);
+}
+
+static void destroy_field_var(struct field_var *field_var)
+{
+	if (!field_var)
+		return;
+
+	destroy_hist_field(field_var->var, 0);
+	destroy_hist_field(field_var->val, 0);
+
+	kfree(field_var);
+}
+
+static void destroy_field_vars(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_field_vars; i++)
+		destroy_field_var(hist_data->field_vars[i]);
+}
+
+static void save_field_var(struct hist_trigger_data *hist_data,
+			   struct field_var *field_var)
+{
+	hist_data->field_vars[hist_data->n_field_vars++] = field_var;
+
+	if (field_var->val->flags & HIST_FIELD_FL_STRING)
+		hist_data->n_field_var_str++;
+}
+
+static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_synth_var_refs; i++)
+		destroy_hist_field(hist_data->synth_var_refs[i], 0);
+}
+
+static void save_synth_var_ref(struct hist_trigger_data *hist_data,
+			 struct hist_field *var_ref)
+{
+	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
+
+	hist_data->var_refs[hist_data->n_var_refs] = var_ref;
+	var_ref->var_ref_idx = hist_data->n_var_refs++;
+}
+
+static int check_synth_field(struct synth_event *event,
+			     struct hist_field *hist_field,
+			     unsigned int field_pos)
+{
+	struct synth_field *field;
+
+	if (field_pos >= event->n_fields)
+		return -EINVAL;
+
+	field = event->fields[field_pos];
+
+	if (strcmp(field->type, hist_field->type) != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct hist_field *
+onmatch_find_var(struct hist_trigger_data *hist_data, struct action_data *data,
+		 char *system, char *event, char *var)
+{
+	struct hist_field *hist_field;
+
+	var++; /* skip '$' */
+
+	hist_field = find_target_event_var(hist_data, system, event, var);
+	if (!hist_field) {
+		if (!system) {
+			system = data->match_event_system;
+			event = data->match_event;
+		}
+
+		hist_field = find_event_var(system, event, var);
+	}
+
+	if (!hist_field)
+		hist_err_event("onmatch: Couldn't find onmatch param: $", system, event, var);
+
+	return hist_field;
+}
+
+static struct hist_field *
+onmatch_create_field_var(struct hist_trigger_data *hist_data,
+			 struct action_data *data, char *system,
+			 char *event, char *var)
+{
+	struct hist_field *hist_field = NULL;
+	struct field_var *field_var;
+
+	field_var = create_target_field_var(hist_data, system, event, var);
+	if (IS_ERR(field_var))
+		goto out;
+
+	if (field_var) {
+		save_field_var(hist_data, field_var);
+		hist_field = field_var->var;
+	} else {
+		if (!system) {
+			system = data->match_event_system;
+			event = data->match_event;
+		}
+
+		hist_field = create_field_var_hist(hist_data, system, event, var);
+		if (IS_ERR(hist_field))
+			goto free;
+	}
+ out:
+	return hist_field;
+ free:
+	destroy_field_var(field_var);
+	hist_field = NULL;
+	goto out;
+}
+
+static int onmatch_create(struct hist_trigger_data *hist_data,
+			  struct trace_event_file *file,
+			  struct action_data *data)
+{
+	char *event_name, *param, *system = NULL;
+	struct hist_field *hist_field, *var_ref;
+	unsigned int i, var_ref_idx;
+	unsigned int field_pos = 0;
+	struct synth_event *event;
+	int ret = 0;
+
+	mutex_lock(&synth_event_mutex);
+
+	event = find_synth_event(data->synth_event_name);
+	if (!event) {
+		hist_err("onmatch: Couldn't find synthetic event: ", data->synth_event_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	var_ref_idx = hist_data->n_var_refs;
+
+	for (i = 0; i < data->n_params; i++) {
+		char *p;
+
+		p = param = kstrdup(data->params[i], GFP_KERNEL);
+		if (!param)
+			goto out;
+
+		system = strsep(&param, ".");
+		if (!param) {
+			param = (char *)system;
+			system = event_name = NULL;
+		} else {
+			event_name = strsep(&param, ".");
+			if (!param) {
+				kfree(p);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+		if (param[0] == '$')
+			hist_field = onmatch_find_var(hist_data, data, system,
+						      event_name, param);
+		else
+			hist_field = onmatch_create_field_var(hist_data, data,
+							      system,
+							      event_name,
+							      param);
+
+		if (!hist_field) {
+			kfree(p);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (check_synth_field(event, hist_field, field_pos) == 0) {
+			var_ref = create_var_ref(hist_field);
+			if (!var_ref) {
+				kfree(p);
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			save_synth_var_ref(hist_data, var_ref);
+			field_pos++;
+			kfree(p);
+			continue;
+		}
+
+		hist_err_event("onmatch: Param type doesn't match synthetic event field type: ",
+			       system, event_name, param);
+		kfree(p);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (field_pos != event->n_fields) {
+		hist_err("onmatch: Param count doesn't match synthetic event field count: ", event->name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	data->fn = action_trace;
+	data->synth_event = event;
+	data->var_ref_idx = var_ref_idx;
+	hist_data->actions[hist_data->n_actions++] = data;
+	save_hist_actions(hist_data);
+ out:
+	mutex_unlock(&synth_event_mutex);
+
+	return ret;
+}
+
+static struct action_data *onmatch_parse(char *str)
+{
+	char *match_event, *match_event_system;
+	char *synth_event_name, *params;
+	struct action_data *data;
+	int ret = -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	match_event = strsep(&str, ")");
+	if (!match_event || !str) {
+		hist_err("onmatch: Missing closing paren: ", match_event);
+		goto free;
+	}
+
+	match_event_system = strsep(&match_event, ".");
+	if (!match_event) {
+		hist_err("onmatch: Missing subsystem for match event: ", match_event_system);
+		goto free;
+	}
+
+	if (IS_ERR(event_file(match_event_system, match_event))) {
+		hist_err_event("onmatch: Invalid subsystem or event name: ",
+			       match_event_system, match_event, NULL);
+		goto free;
+	}
+
+	data->match_event = kstrdup(match_event, GFP_KERNEL);
+	data->match_event_system = kstrdup(match_event_system, GFP_KERNEL);
+
+	strsep(&str, ".");
+	if (!str) {
+		hist_err("onmatch: Missing . after onmatch(): ", str);
+		goto free;
+	}
+
+	synth_event_name = strsep(&str, "(");
+	if (!synth_event_name || !str) {
+		hist_err("onmatch: Missing opening paramlist paren: ", synth_event_name);
+		goto free;
+	}
+	data->synth_event_name = kstrdup(synth_event_name, GFP_KERNEL);
+
+	params = strsep(&str, ")");
+	if (!params || !str || (str && strlen(str))) {
+		hist_err("onmatch: Missing closing paramlist paren: ", params);
+		goto free;
+	}
+
+	ret = parse_action_params(params, data);
+	if (ret)
+		goto free;
+
+	if (!data->match_event_system || !data->match_event ||
+	    !data->synth_event_name) {
+		ret = -ENOMEM;
+		goto free;
+	}
+ out:
+	return data;
+ free:
+	onmatch_destroy(data);
+	data = ERR_PTR(ret);
+	goto out;
+}
+
 static int create_hitcount_val(struct hist_trigger_data *hist_data)
 {
 	hist_data->fields[HITCOUNT_IDX] =
-		create_hist_field(NULL, HIST_FIELD_FL_HITCOUNT);
+		create_hist_field(hist_data, NULL, HIST_FIELD_FL_HITCOUNT, NULL);
 	if (!hist_data->fields[HITCOUNT_IDX])
 		return -ENOMEM;
 
 	hist_data->n_vals++;
+	hist_data->n_fields++;
 
 	if (WARN_ON(hist_data->n_vals > TRACING_MAP_VALS_MAX))
 		return -EINVAL;
@@ -429,41 +3354,69 @@ static int create_hitcount_val(struct hist_trigger_data *hist_data)
 static int create_val_field(struct hist_trigger_data *hist_data,
 			    unsigned int val_idx,
 			    struct trace_event_file *file,
-			    char *field_str)
+			    char *field_str, bool var_only)
 {
-	struct ftrace_event_field *field = NULL;
+	struct hist_field *hist_field;
 	unsigned long flags = 0;
-	char *field_name;
+	char *var_name;
 	int ret = 0;
 
-	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX))
+	if (WARN_ON(!var_only && val_idx >= TRACING_MAP_VALS_MAX))
 		return -EINVAL;
 
-	field_name = strsep(&field_str, ".");
-	if (field_str) {
-		if (strcmp(field_str, "hex") == 0)
-			flags |= HIST_FIELD_FL_HEX;
-		else {
+	var_name = strsep(&field_str, "=");
+	if (field_str && var_name) {
+		if (find_var(file, var_name) &&
+		    !hist_data->remove) {
+			hist_err("Variable already defined: ", var_name);
 			ret = -EINVAL;
 			goto out;
 		}
-	}
 
-	field = trace_find_event_field(file->event_call, field_name);
-	if (!field) {
+		flags |= HIST_FIELD_FL_VAR;
+		hist_data->n_vars++;
+		if (hist_data->n_vars > TRACING_MAP_VARS_MAX) {
+			hist_err("Too many variables defined: ", var_name);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (var_only)
+			flags |= HIST_FIELD_FL_VAR_ONLY;
+	} else if (!var_only && var_name != NULL && field_str == NULL) {
+		field_str = var_name;
+		var_name = NULL;
+	} else {
+		hist_err("Malformed assignment: ", var_name);
 		ret = -EINVAL;
 		goto out;
 	}
 
-	hist_data->fields[val_idx] = create_hist_field(field, flags);
-	if (!hist_data->fields[val_idx]) {
-		ret = -ENOMEM;
+	hist_field = parse_expr(hist_data, file, field_str, flags, var_name, 0);
+	if (IS_ERR(hist_field)) {
+		ret = PTR_ERR(hist_field);
 		goto out;
 	}
 
-	++hist_data->n_vals;
+	if (!hist_field) {
+		hist_field = parse_atom(hist_data, file, field_str,
+					&flags, var_name);
+		if (IS_ERR(hist_field)) {
+			hist_err("Unable to parse atom: ", field_str);
+			ret = PTR_ERR(hist_field);
+			goto out;
+		}
+	}
 
-	if (WARN_ON(hist_data->n_vals > TRACING_MAP_VALS_MAX))
+	hist_data->fields[val_idx] = hist_field;
+
+	++hist_data->n_vals;
+	++hist_data->n_fields;
+
+	if (hist_field->flags & HIST_FIELD_FL_VAR_ONLY)
+		hist_data->n_var_only++;
+
+	if (WARN_ON(hist_data->n_vals > TRACING_MAP_VALS_MAX + TRACING_MAP_VARS_MAX))
 		ret = -EINVAL;
  out:
 	return ret;
@@ -473,7 +3426,7 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 			     struct trace_event_file *file)
 {
 	char *fields_str, *field_str;
-	unsigned int i, j;
+	unsigned int i, j = 1;
 	int ret;
 
 	ret = create_hitcount_val(hist_data);
@@ -493,12 +3446,15 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		field_str = strsep(&fields_str, ",");
 		if (!field_str)
 			break;
+
 		if (strcmp(field_str, "hitcount") == 0)
 			continue;
-		ret = create_val_field(hist_data, j++, file, field_str);
+
+		ret = create_val_field(hist_data, j++, file, field_str, false);
 		if (ret)
 			goto out;
 	}
+
 	if (fields_str && (strcmp(fields_str, "hitcount") != 0))
 		ret = -EINVAL;
  out:
@@ -511,70 +3467,74 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			    struct trace_event_file *file,
 			    char *field_str)
 {
-	struct ftrace_event_field *field = NULL;
+	struct hist_field *hist_field = NULL;
+
 	unsigned long flags = 0;
 	unsigned int key_size;
+	char *var_name;
 	int ret = 0;
 
-	if (WARN_ON(key_idx >= TRACING_MAP_FIELDS_MAX))
+	if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
 		return -EINVAL;
 
 	flags |= HIST_FIELD_FL_KEY;
 
+	var_name = strsep(&field_str, "=");
+	if (field_str) {
+		if (find_var(file, var_name) &&
+		    !hist_data->remove)
+			return -EINVAL;
+		flags |= HIST_FIELD_FL_VAR;
+	} else {
+		field_str = var_name;
+		var_name = NULL;
+	}
+
 	if (strcmp(field_str, "stacktrace") == 0) {
 		flags |= HIST_FIELD_FL_STACKTRACE;
 		key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
+		hist_field = create_hist_field(hist_data, NULL, flags, var_name);
 	} else {
-		char *field_name = strsep(&field_str, ".");
+		hist_field = parse_expr(hist_data, file, field_str, flags,
+					var_name, 0);
+		if (IS_ERR(hist_field)) {
+			ret = PTR_ERR(hist_field);
+			goto out;
+		}
 
-		if (field_str) {
-			if (strcmp(field_str, "hex") == 0)
-				flags |= HIST_FIELD_FL_HEX;
-			else if (strcmp(field_str, "sym") == 0)
-				flags |= HIST_FIELD_FL_SYM;
-			else if (strcmp(field_str, "sym-offset") == 0)
-				flags |= HIST_FIELD_FL_SYM_OFFSET;
-			else if ((strcmp(field_str, "execname") == 0) &&
-				 (strcmp(field_name, "common_pid") == 0))
-				flags |= HIST_FIELD_FL_EXECNAME;
-			else if (strcmp(field_str, "syscall") == 0)
-				flags |= HIST_FIELD_FL_SYSCALL;
-			else if (strcmp(field_str, "log2") == 0)
-				flags |= HIST_FIELD_FL_LOG2;
-			else {
-				ret = -EINVAL;
+		if (!hist_field) {
+			hist_field = parse_atom(hist_data, file, field_str,
+						&flags, var_name);
+			if (IS_ERR(hist_field)) {
+				ret = PTR_ERR(hist_field);
 				goto out;
 			}
 		}
 
-		field = trace_find_event_field(file->event_call, field_name);
-		if (!field) {
+		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
+			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
 			goto out;
 		}
 
-		if (is_string_field(field))
-			key_size = MAX_FILTER_STR_VAL;
-		else
-			key_size = field->size;
+		key_size = hist_field->size;
 	}
 
-	hist_data->fields[key_idx] = create_hist_field(field, flags);
-	if (!hist_data->fields[key_idx]) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	hist_data->fields[key_idx] = hist_field;
 
 	key_size = ALIGN(key_size, sizeof(u64));
 	hist_data->fields[key_idx]->size = key_size;
 	hist_data->fields[key_idx]->offset = key_offset;
+
 	hist_data->key_size += key_size;
+
 	if (hist_data->key_size > HIST_KEY_SIZE_MAX) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	hist_data->n_keys++;
+	hist_data->n_fields++;
 
 	if (WARN_ON(hist_data->n_keys > TRACING_MAP_KEYS_MAX))
 		return -EINVAL;
@@ -618,6 +3578,29 @@ static int create_key_fields(struct hist_trigger_data *hist_data,
 	return ret;
 }
 
+static int create_var_fields(struct hist_trigger_data *hist_data,
+			     struct trace_event_file *file)
+{
+	unsigned int i, j, k = hist_data->n_vals;
+	char *str, *field_str;
+	int ret = 0;
+
+	for (i = 0; i < hist_data->attrs->n_assignments; i++) {
+		str = hist_data->attrs->assignment_str[i];
+
+		for (j = 0; j < TRACING_MAP_VARS_MAX; j++) {
+			field_str = strsep(&str, ",");
+			if (!field_str)
+				break;
+			ret = create_val_field(hist_data, k++, file, field_str, true);
+			if (ret)
+				goto out;
+		}
+	}
+ out:
+	return ret;
+}
+
 static int create_hist_fields(struct hist_trigger_data *hist_data,
 			      struct trace_event_file *file)
 {
@@ -627,11 +3610,13 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
 	if (ret)
 		goto out;
 
-	ret = create_key_fields(hist_data, file);
+	ret = create_var_fields(hist_data, file);
 	if (ret)
 		goto out;
 
-	hist_data->n_fields = hist_data->n_vals + hist_data->n_keys;
+	ret = create_key_fields(hist_data, file);
+	if (ret)
+		goto out;
  out:
 	return ret;
 }
@@ -653,10 +3638,9 @@ static int is_descending(const char *str)
 static int create_sort_keys(struct hist_trigger_data *hist_data)
 {
 	char *fields_str = hist_data->attrs->sort_key_str;
-	struct ftrace_event_field *field = NULL;
 	struct tracing_map_sort_key *sort_key;
 	int descending, ret = 0;
-	unsigned int i, j;
+	unsigned int i, j, k;
 
 	hist_data->n_sort_keys = 1; /* we always have at least one, hitcount */
 
@@ -670,7 +3654,9 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 	}
 
 	for (i = 0; i < TRACING_MAP_SORT_KEYS_MAX; i++) {
+		struct hist_field *hist_field;
 		char *field_str, *field_name;
+		const char *test_name;
 
 		sort_key = &hist_data->sort_keys[i];
 
@@ -692,7 +3678,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 			break;
 		}
 
-		if (strcmp(field_name, "hitcount") == 0) {
+		if ((strcmp(field_name, "hitcount") == 0)) {
 			descending = is_descending(field_str);
 			if (descending < 0) {
 				ret = descending;
@@ -702,10 +3688,21 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 			continue;
 		}
 
-		for (j = 1; j < hist_data->n_fields; j++) {
-			field = hist_data->fields[j]->field;
-			if (field && (strcmp(field_name, field->name) == 0)) {
-				sort_key->field_idx = j;
+		for (j = 1, k = 1; j < hist_data->n_fields; j++) {
+			unsigned idx;
+
+			hist_field = hist_data->fields[j];
+			if (hist_field->flags & HIST_FIELD_FL_VAR_ONLY)
+				continue;
+
+			idx = k++;
+
+			test_name = hist_field_name(hist_field, 0);
+
+			if (test_name == NULL)
+				continue;
+			if (strcmp(field_name, test_name) == 0) {
+				sort_key->field_idx = idx;
 				descending = is_descending(field_str);
 				if (descending < 0) {
 					ret = descending;
@@ -720,16 +3717,160 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 			break;
 		}
 	}
+
 	hist_data->n_sort_keys = i;
  out:
 	return ret;
 }
 
+static void destroy_actions(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace)
+			onmatch_destroy(data);
+		else if (data->fn == onmax_save)
+			onmax_destroy(data);
+		else
+			kfree(data);
+	}
+}
+
+static int create_actions(struct hist_trigger_data *hist_data,
+			  struct trace_event_file *file)
+{
+	struct action_data *data;
+	unsigned int i;
+	int ret = 0;
+	char *str;
+
+	for (i = 0; i < hist_data->attrs->n_actions; i++) {
+		str = hist_data->attrs->action_str[i];
+
+		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
+			char *action_str = str + strlen("onmatch(");
+
+			data = onmatch_parse(action_str);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
+
+			ret = onmatch_create(hist_data, file, data);
+			if (ret) {
+				onmatch_destroy(data);
+				return ret;
+			}
+		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
+			char *action_str = str + strlen("onmax(");
+
+			data = onmax_parse(action_str);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
+
+			ret = onmax_create(hist_data, data);
+			if (ret) {
+				onmax_destroy(data);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static void print_actions(struct seq_file *m,
+			  struct hist_trigger_data *hist_data,
+			  struct tracing_map_elt *elt)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == onmax_save)
+			onmax_print(m, hist_data, elt, data);
+	}
+}
+
+static void print_onmax_spec(struct seq_file *m,
+			     struct hist_trigger_data *hist_data,
+			     struct action_data *data)
+{
+	unsigned int i;
+
+	seq_puts(m, ":onmax(");
+	seq_printf(m, "%s", data->onmax_var_str);
+	seq_printf(m, ").%s(", data->onmax_fn_name);
+
+	for (i = 0; i < hist_data->n_max_vars; i++) {
+		seq_printf(m, "%s", hist_data->max_vars[i]->var->var.name);
+		if (i < hist_data->n_max_vars - 1)
+			seq_puts(m, ",");
+	}
+	seq_puts(m, ")");
+}
+
+static void print_onmatch_spec(struct seq_file *m,
+			       struct hist_trigger_data *hist_data,
+			       struct action_data *data)
+{
+	unsigned int i;
+
+	seq_printf(m, ":onmatch(%s.%s).", data->match_event_system,
+		   data->match_event);
+
+	seq_printf(m, "%s(", data->synth_event->name);
+
+	for (i = 0; i < data->n_params; i++) {
+		if (i)
+			seq_puts(m, ",");
+		seq_printf(m, "%s", data->params[i]);
+	}
+
+	seq_puts(m, ")");
+}
+
+static void print_actions_spec(struct seq_file *m,
+			       struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+
+		if (data->fn == action_trace)
+			print_onmatch_spec(m, hist_data, data);
+		else if (data->fn == onmax_save)
+			print_onmax_spec(m, hist_data, data);
+	}
+}
+
+static void destroy_field_var_hists(struct hist_trigger_data *hist_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_field_var_hists; i++) {
+		kfree(hist_data->field_var_hists[i]->cmd);
+		kfree(hist_data->field_var_hists[i]);
+	}
+}
+
 static void destroy_hist_data(struct hist_trigger_data *hist_data)
 {
+	if (!hist_data)
+		return;
+
 	destroy_hist_trigger_attrs(hist_data->attrs);
 	destroy_hist_fields(hist_data);
 	tracing_map_destroy(hist_data->map);
+
+	destroy_actions(hist_data);
+	destroy_field_vars(hist_data);
+	destroy_field_var_hists(hist_data);
+	destroy_synth_var_refs(hist_data);
+
 	kfree(hist_data);
 }
 
@@ -749,6 +3890,9 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 
 			if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
 				cmp_fn = tracing_map_cmp_none;
+			else if (!field)
+				cmp_fn = tracing_map_cmp_num(hist_field->size,
+							     hist_field->is_signed);
 			else if (is_string_field(field))
 				cmp_fn = tracing_map_cmp_string;
 			else
@@ -757,36 +3901,29 @@ static int create_tracing_map_fields(struct hist_trigger_data *hist_data)
 			idx = tracing_map_add_key_field(map,
 							hist_field->offset,
 							cmp_fn);
-
-		} else
+		} else if (!(hist_field->flags & HIST_FIELD_FL_VAR))
 			idx = tracing_map_add_sum_field(map);
 
 		if (idx < 0)
 			return idx;
+
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			idx = tracing_map_add_var(map);
+			if (idx < 0)
+				return idx;
+			hist_field->var.idx = idx;
+			hist_field->var.hist_data = hist_data;
+		}
 	}
 
 	return 0;
 }
 
-static bool need_tracing_map_ops(struct hist_trigger_data *hist_data)
-{
-	struct hist_field *key_field;
-	unsigned int i;
-
-	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
-
-		if (key_field->flags & HIST_FIELD_FL_EXECNAME)
-			return true;
-	}
-
-	return false;
-}
-
 static struct hist_trigger_data *
 create_hist_data(unsigned int map_bits,
 		 struct hist_trigger_attrs *attrs,
-		 struct trace_event_file *file)
+		 struct trace_event_file *file,
+		 bool remove)
 {
 	const struct tracing_map_ops *map_ops = NULL;
 	struct hist_trigger_data *hist_data;
@@ -797,6 +3934,7 @@ create_hist_data(unsigned int map_bits,
 		return ERR_PTR(-ENOMEM);
 
 	hist_data->attrs = attrs;
+	hist_data->remove = remove;
 
 	ret = create_hist_fields(hist_data, file);
 	if (ret)
@@ -806,8 +3944,7 @@ create_hist_data(unsigned int map_bits,
 	if (ret)
 		goto free;
 
-	if (need_tracing_map_ops(hist_data))
-		map_ops = &hist_trigger_elt_comm_ops;
+	map_ops = &hist_trigger_elt_data_ops;
 
 	hist_data->map = tracing_map_create(map_bits, hist_data->key_size,
 					    map_ops, hist_data);
@@ -821,10 +3958,6 @@ create_hist_data(unsigned int map_bits,
 	if (ret)
 		goto free;
 
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto free;
-
 	hist_data->event_file = file;
  out:
 	return hist_data;
@@ -839,18 +3972,40 @@ create_hist_data(unsigned int map_bits,
 }
 
 static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
-				    struct tracing_map_elt *elt,
-				    void *rec)
+				    struct tracing_map_elt *elt, void *rec,
+				    struct ring_buffer_event *rbe,
+				    u64 *var_ref_vals)
 {
+	struct hist_elt_data *elt_data;
 	struct hist_field *hist_field;
-	unsigned int i;
+	unsigned int i, var_idx;
 	u64 hist_val;
 
+	elt_data = elt->private_data;
+	elt_data->var_ref_vals = var_ref_vals;
+
 	for_each_hist_val_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
-		hist_val = hist_field->fn(hist_field, rec);
+		hist_val = hist_field->fn(hist_field, elt, rbe, rec);
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			var_idx = hist_field->var.idx;
+			tracing_map_set_var(elt, var_idx, hist_val);
+			if (hist_field->flags & HIST_FIELD_FL_VAR_ONLY)
+				continue;
+		}
 		tracing_map_update_sum(elt, i, hist_val);
 	}
+
+	for_each_hist_key_field(i, hist_data) {
+		hist_field = hist_data->fields[i];
+		if (hist_field->flags & HIST_FIELD_FL_VAR) {
+			hist_val = hist_field->fn(hist_field, elt, rbe, rec);
+			var_idx = hist_field->var.idx;
+			tracing_map_set_var(elt, var_idx, hist_val);
+		}
+	}
+
+	update_field_vars(hist_data, elt, rbe, rec);
 }
 
 static inline void add_to_key(char *compound_key, void *key,
@@ -877,15 +4032,31 @@ static inline void add_to_key(char *compound_key, void *key,
 	memcpy(compound_key + key_field->offset, key, size);
 }
 
-static void event_hist_trigger(struct event_trigger_data *data, void *rec)
+static void
+hist_trigger_actions(struct hist_trigger_data *hist_data,
+		     struct tracing_map_elt *elt, void *rec,
+		     struct ring_buffer_event *rbe, u64 *var_ref_vals)
+{
+	struct action_data *data;
+	unsigned int i;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		data = hist_data->actions[i];
+		data->fn(hist_data, elt, rec, rbe, data, var_ref_vals);
+	}
+}
+
+static void event_hist_trigger(struct event_trigger_data *data, void *rec,
+			       struct ring_buffer_event *rbe)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	bool use_compound_key = (hist_data->n_keys > 1);
 	unsigned long entries[HIST_STACKTRACE_DEPTH];
+	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
 	char compound_key[HIST_KEY_SIZE_MAX];
+	struct tracing_map_elt *elt = NULL;
 	struct stack_trace stacktrace;
 	struct hist_field *key_field;
-	struct tracing_map_elt *elt;
 	u64 field_contents;
 	void *key = NULL;
 	unsigned int i;
@@ -906,7 +4077,7 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec)
 
 			key = entries;
 		} else {
-			field_contents = key_field->fn(key_field, rec);
+			field_contents = key_field->fn(key_field, elt, rbe, rec);
 			if (key_field->flags & HIST_FIELD_FL_STRING) {
 				key = (void *)(unsigned long)field_contents;
 				use_compound_key = true;
@@ -921,9 +4092,18 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec)
 	if (use_compound_key)
 		key = compound_key;
 
+	if (hist_data->n_var_refs &&
+	    !resolve_var_refs(hist_data, key, var_ref_vals, false))
+		return;
+
 	elt = tracing_map_insert(hist_data->map, key);
-	if (elt)
-		hist_trigger_elt_update(hist_data, elt, rec);
+	if (!elt)
+		return;
+
+	hist_trigger_elt_update(hist_data, elt, rec, rbe, var_ref_vals);
+
+	if (resolve_var_refs(hist_data, key, var_ref_vals, true))
+		hist_trigger_actions(hist_data, elt, rec, rbe, var_ref_vals);
 }
 
 static void hist_trigger_stacktrace_print(struct seq_file *m,
@@ -952,6 +4132,7 @@ hist_trigger_entry_print(struct seq_file *m,
 	struct hist_field *key_field;
 	char str[KSYM_SYMBOL_LEN];
 	bool multiline = false;
+	const char *field_name;
 	unsigned int i;
 	u64 uval;
 
@@ -963,26 +4144,28 @@ hist_trigger_entry_print(struct seq_file *m,
 		if (i > hist_data->n_vals)
 			seq_puts(m, ", ");
 
+		field_name = hist_field_name(key_field, 0);
+
 		if (key_field->flags & HIST_FIELD_FL_HEX) {
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: %llx",
-				   key_field->field->name, uval);
+			seq_printf(m, "%s: %llx", field_name, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
 			uval = *(u64 *)(key + key_field->offset);
 			sprint_symbol_no_offset(str, uval);
-			seq_printf(m, "%s: [%llx] %-45s",
-				   key_field->field->name, uval, str);
+			seq_printf(m, "%s: [%llx] %-45s", field_name,
+				   uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
 			uval = *(u64 *)(key + key_field->offset);
 			sprint_symbol(str, uval);
-			seq_printf(m, "%s: [%llx] %-55s",
-				   key_field->field->name, uval, str);
+			seq_printf(m, "%s: [%llx] %-55s", field_name,
+				   uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
-			char *comm = elt->private_data;
+			struct hist_elt_data *elt_data = elt->private_data;
+			char *comm = elt_data->comm;
 
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: %-16s[%10llu]",
-				   key_field->field->name, comm, uval);
+			seq_printf(m, "%s: %-16s[%10llu]", field_name,
+				   comm, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYSCALL) {
 			const char *syscall_name;
 
@@ -991,8 +4174,8 @@ hist_trigger_entry_print(struct seq_file *m,
 			if (!syscall_name)
 				syscall_name = "unknown_syscall";
 
-			seq_printf(m, "%s: %-30s[%3llu]",
-				   key_field->field->name, syscall_name, uval);
+			seq_printf(m, "%s: %-30s[%3llu]", field_name,
+				   syscall_name, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
 			seq_puts(m, "stacktrace:\n");
 			hist_trigger_stacktrace_print(m,
@@ -1000,15 +4183,14 @@ hist_trigger_entry_print(struct seq_file *m,
 						      HIST_STACKTRACE_DEPTH);
 			multiline = true;
 		} else if (key_field->flags & HIST_FIELD_FL_LOG2) {
-			seq_printf(m, "%s: ~ 2^%-2llu", key_field->field->name,
+			seq_printf(m, "%s: ~ 2^%-2llu", field_name,
 				   *(u64 *)(key + key_field->offset));
 		} else if (key_field->flags & HIST_FIELD_FL_STRING) {
-			seq_printf(m, "%s: %-50s", key_field->field->name,
+			seq_printf(m, "%s: %-50s", field_name,
 				   (char *)(key + key_field->offset));
 		} else {
 			uval = *(u64 *)(key + key_field->offset);
-			seq_printf(m, "%s: %10llu", key_field->field->name,
-				   uval);
+			seq_printf(m, "%s: %10llu", field_name, uval);
 		}
 	}
 
@@ -1021,22 +4203,30 @@ hist_trigger_entry_print(struct seq_file *m,
 		   tracing_map_read_sum(elt, HITCOUNT_IDX));
 
 	for (i = 1; i < hist_data->n_vals; i++) {
+		field_name = hist_field_name(hist_data->fields[i], 0);
+
+		if (hist_data->fields[i]->flags & HIST_FIELD_FL_VAR ||
+		    hist_data->fields[i]->flags & HIST_FIELD_FL_EXPR ||
+		    hist_data->fields[i]->flags & HIST_FIELD_FL_VAR_REF)
+			continue;
+
 		if (hist_data->fields[i]->flags & HIST_FIELD_FL_HEX) {
-			seq_printf(m, "  %s: %10llx",
-				   hist_data->fields[i]->field->name,
+			seq_printf(m, "  %s: %10llx", field_name,
 				   tracing_map_read_sum(elt, i));
 		} else {
-			seq_printf(m, "  %s: %10llu",
-				   hist_data->fields[i]->field->name,
+			seq_printf(m, "  %s: %10llu", field_name,
 				   tracing_map_read_sum(elt, i));
 		}
 	}
 
+	print_actions(m, hist_data, elt);
+
 	seq_puts(m, "\n");
 }
 
 static int print_entries(struct seq_file *m,
-			 struct hist_trigger_data *hist_data)
+			 struct hist_trigger_data *hist_data,
+			 unsigned int *n_dups)
 {
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
@@ -1044,7 +4234,7 @@ static int print_entries(struct seq_file *m,
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
-					     &sort_entries);
+					     &sort_entries, n_dups);
 	if (n_entries < 0)
 		return n_entries;
 
@@ -1063,6 +4253,7 @@ static void hist_trigger_show(struct seq_file *m,
 {
 	struct hist_trigger_data *hist_data;
 	int n_entries, ret = 0;
+	unsigned int n_dups;
 
 	if (n > 0)
 		seq_puts(m, "\n\n");
@@ -1072,15 +4263,15 @@ static void hist_trigger_show(struct seq_file *m,
 	seq_puts(m, "#\n\n");
 
 	hist_data = data->private_data;
-	n_entries = print_entries(m, hist_data);
+	n_entries = print_entries(m, hist_data, &n_dups);
 	if (n_entries < 0) {
 		ret = n_entries;
 		n_entries = 0;
 	}
 
-	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n",
-		   (u64)atomic64_read(&hist_data->map->hits),
-		   n_entries, (u64)atomic64_read(&hist_data->map->drops));
+	seq_printf(m, "\nTotals:\n    Hits: %llu\n    Entries: %u\n    Dropped: %llu\n    Duplicates: %u\n",
+		   (u64)atomic64_read(&hist_data->map->hits), n_entries,
+		   (u64)atomic64_read(&hist_data->map->drops), n_dups);
 }
 
 static int hist_show(struct seq_file *m, void *v)
@@ -1102,6 +4293,11 @@ static int hist_show(struct seq_file *m, void *v)
 			hist_trigger_show(m, data, n++);
 	}
 
+	if (have_hist_err()) {
+		seq_printf(m, "\nERROR: %s\n", hist_err_str);
+		seq_printf(m, "  Last command: %s\n", last_hist_cmd);
+	}
+
  out_unlock:
 	mutex_unlock(&event_mutex);
 
@@ -1136,13 +4332,29 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "syscall";
 	else if (hist_field->flags & HIST_FIELD_FL_LOG2)
 		flags_str = "log2";
+	else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
+		flags_str = "usecs";
 
 	return flags_str;
 }
 
 static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 {
-	seq_printf(m, "%s", hist_field->field->name);
+	const char *field_name = hist_field_name(hist_field, 0);
+
+	if (hist_field->var.name)
+		seq_printf(m, "%s=", hist_field->var.name);
+
+	if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
+		seq_puts(m, "$common_timestamp");
+	else if (hist_field->flags & HIST_FIELD_FL_CPU)
+		seq_puts(m, "cpu");
+	else if (field_name) {
+		if (hist_field->flags & HIST_FIELD_FL_ALIAS)
+			seq_putc(m, '$');
+		seq_printf(m, "%s", field_name);
+	}
+
 	if (hist_field->flags) {
 		const char *flags_str = get_hist_field_flags(hist_field);
 
@@ -1156,7 +4368,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 				    struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
-	struct hist_field *key_field;
+	bool have_var_only = false;
+	struct hist_field *field;
 	unsigned int i;
 
 	seq_puts(m, "hist:");
@@ -1167,25 +4380,47 @@ static int event_hist_trigger_print(struct seq_file *m,
 	seq_puts(m, "keys=");
 
 	for_each_hist_key_field(i, hist_data) {
-		key_field = hist_data->fields[i];
+		field = hist_data->fields[i];
 
 		if (i > hist_data->n_vals)
 			seq_puts(m, ",");
 
-		if (key_field->flags & HIST_FIELD_FL_STACKTRACE)
+		if (field->flags & HIST_FIELD_FL_STACKTRACE)
 			seq_puts(m, "stacktrace");
 		else
-			hist_field_print(m, key_field);
+			hist_field_print(m, field);
 	}
 
 	seq_puts(m, ":vals=");
 
 	for_each_hist_val_field(i, hist_data) {
+		field = hist_data->fields[i];
+		if (field->flags & HIST_FIELD_FL_VAR_ONLY) {
+			have_var_only = true;
+			continue;
+		}
+
 		if (i == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
 		else {
 			seq_puts(m, ",");
-			hist_field_print(m, hist_data->fields[i]);
+			hist_field_print(m, field);
+		}
+	}
+
+	if (have_var_only) {
+		unsigned int n = 0;
+
+		seq_puts(m, ":");
+
+		for_each_hist_val_field(i, hist_data) {
+			field = hist_data->fields[i];
+
+			if (field->flags & HIST_FIELD_FL_VAR_ONLY) {
+				if (n++)
+					seq_puts(m, ",");
+				hist_field_print(m, field);
+			}
 		}
 	}
 
@@ -1193,28 +4428,36 @@ static int event_hist_trigger_print(struct seq_file *m,
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
 		struct tracing_map_sort_key *sort_key;
+		unsigned int idx, first_key_idx;
+
+		/* skip VAR_ONLY vals */
+		first_key_idx = hist_data->n_vals - hist_data->n_var_only;
 
 		sort_key = &hist_data->sort_keys[i];
+		idx = sort_key->field_idx;
+
+		if (WARN_ON(idx >= HIST_FIELDS_MAX))
+			return -EINVAL;
 
 		if (i > 0)
 			seq_puts(m, ",");
 
-		if (sort_key->field_idx == HITCOUNT_IDX)
+		if (idx == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
 		else {
-			unsigned int idx = sort_key->field_idx;
-
-			if (WARN_ON(idx >= TRACING_MAP_FIELDS_MAX))
-				return -EINVAL;
-
+			if (idx >= first_key_idx)
+				idx += hist_data->n_var_only;
 			hist_field_print(m, hist_data->fields[idx]);
 		}
 
 		if (sort_key->descending)
 			seq_puts(m, ".descending");
 	}
-
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
+	if (hist_data->enable_timestamps)
+		seq_printf(m, ":clock=%s", hist_data->attrs->clock);
+
+	print_actions_spec(m, hist_data);
 
 	if (data->filter_str)
 		seq_printf(m, " if %s", data->filter_str);
@@ -1254,7 +4497,13 @@ static void event_hist_trigger_free(struct event_trigger_ops *ops,
 	if (!data->ref) {
 		if (data->name)
 			del_named_trigger(data);
+
 		trigger_data_free(data);
+
+		remove_hist_vars(hist_data);
+
+		remove_hist_actions(hist_data);
+
 		destroy_hist_data(hist_data);
 	}
 }
@@ -1381,6 +4630,16 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 			return false;
 		if (key_field->offset != key_field_test->offset)
 			return false;
+		if (key_field->size != key_field_test->size)
+			return false;
+		if (key_field->is_signed != key_field_test->is_signed)
+			return false;
+		if ((key_field->var.name && !key_field_test->var.name) ||
+		    (!key_field->var.name && key_field_test->var.name))
+			return false;
+		if ((key_field->var.name && key_field_test->var.name) &&
+		     strcmp(key_field->var.name, key_field_test->var.name) != 0)
+			return false;
 	}
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
@@ -1412,6 +4671,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		if (named_data) {
 			if (!hist_trigger_match(data, named_data, named_data,
 						true)) {
+				hist_err("Named hist trigger doesn't match existing named trigger (includes variables): ", hist_data->attrs->name);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1431,13 +4691,16 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 				test->paused = false;
 			else if (hist_data->attrs->clear)
 				hist_clear(test);
-			else
+			else {
+				hist_err("Hist trigger already exists", NULL);
 				ret = -EEXIST;
+			}
 			goto out;
 		}
 	}
  new:
 	if (hist_data->attrs->cont || hist_data->attrs->clear) {
+		hist_err("Can't clear or continue a nonexistent hist trigger", NULL);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -1458,8 +4721,29 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			goto out;
 	}
 
-	list_add_rcu(&data->list, &file->triggers);
+	if (hist_data->enable_timestamps) {
+		char *clock = hist_data->attrs->clock;
+
+		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
+		if (ret) {
+			hist_err("Couldn't set trace_clock: ", clock);
+			goto out;
+		}
+
+		tracing_set_time_stamp_abs(file->tr, true);
+	}
+
 	ret++;
+ out:
+	return ret;
+}
+
+static int hist_trigger_enable(struct event_trigger_data *data,
+			       struct trace_event_file *file)
+{
+	int ret = 0;
+
+	list_add_rcu(&data->list, &file->triggers);
 
 	update_cond_flag(file);
 
@@ -1468,10 +4752,48 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		update_cond_flag(file);
 		ret--;
 	}
- out:
+
 	return ret;
 }
 
+static bool hist_trigger_check_refs(struct event_trigger_data *data,
+				    struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data = data->private_data;
+	struct event_trigger_data *test, *named_data = NULL;
+
+	if (hist_data->attrs->name)
+		named_data = find_named_trigger(hist_data->attrs->name);
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			if (!hist_trigger_match(data, test, named_data, false))
+				continue;
+			hist_data = test->private_data;
+			if (check_var_refs(hist_data))
+				return true;
+			break;
+		}
+	}
+
+	return false;
+}
+
+static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
+{
+	struct trace_event_file *file;
+	unsigned int i;
+	char *cmd;
+	int ret;
+
+	for (i = 0; i < hist_data->n_field_var_hists; i++) {
+		file = hist_data->field_var_hists[i]->hist_data->event_file;
+		cmd = hist_data->field_var_hists[i]->cmd;
+		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
+					      "!hist", "hist", cmd);
+	}
+}
+
 static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
@@ -1487,6 +4809,7 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			if (!hist_trigger_match(data, test, named_data, false))
 				continue;
+			unregister_field_var_hists(test->private_data);
 			unregistered = true;
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
@@ -1497,14 +4820,40 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 
 	if (unregistered && test->ops->free)
 		test->ops->free(test->ops, test);
+
+	if (hist_data->enable_timestamps)
+		tracing_set_time_stamp_abs(file->tr, false);
+}
+
+static bool hist_file_check_refs(struct trace_event_file *file)
+{
+	struct hist_trigger_data *hist_data;
+	struct event_trigger_data *test;
+
+	printk("func: %s\n", __func__);
+
+	list_for_each_entry_rcu(test, &file->triggers, list) {
+		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			hist_data = test->private_data;
+			if (check_var_refs(hist_data))
+				return true;
+			break;
+		}
+	}
+
+	return false;
 }
 
 static void hist_unreg_all(struct trace_event_file *file)
 {
 	struct event_trigger_data *test, *n;
 
+	if (hist_file_check_refs(file))
+	    return;
+
 	list_for_each_entry_safe(test, n, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
+			unregister_field_var_hists(test->private_data);
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 			update_cond_flag(file);
@@ -1523,16 +4872,35 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct hist_trigger_attrs *attrs;
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
-	char *trigger;
+	bool remove = false;
+	char *trigger, *p;
 	int ret = 0;
 
+	if (glob && strlen(glob)) {
+		last_cmd_set(param);
+		hist_err_clear();
+	}
+
 	if (!param)
 		return -EINVAL;
 
+	if (glob[0] == '!')
+		remove = true;
+
 	/* separate the trigger from the filter (k:v [if filter]) */
-	trigger = strsep(&param, " \t");
-	if (!trigger)
-		return -EINVAL;
+	trigger = param;
+	p = strstr(param, " if");
+	if (!p)
+		p = strstr(param, "\tif");
+	if (p) {
+		if (p == trigger)
+			return -EINVAL;
+		param = p + 1;
+		param = strstrip(param);
+		*p = '\0';
+		trigger = strstrip(trigger);
+	} else
+		param = NULL;
 
 	attrs = parse_hist_trigger_attrs(trigger);
 	if (IS_ERR(attrs))
@@ -1541,7 +4909,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (attrs->map_bits)
 		hist_trigger_bits = attrs->map_bits;
 
-	hist_data = create_hist_data(hist_trigger_bits, attrs, file);
+	hist_data = create_hist_data(hist_trigger_bits, attrs, file, remove);
 	if (IS_ERR(hist_data)) {
 		destroy_hist_trigger_attrs(attrs);
 		return PTR_ERR(hist_data);
@@ -1570,13 +4938,19 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 			goto out_free;
 	}
 
-	if (glob[0] == '!') {
+	if (remove) {
+		if (hist_trigger_check_refs(trigger_data, file)) {
+			ret = -EBUSY;
+			goto out_free;
+		}
+
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
 		ret = 0;
 		goto out_free;
 	}
 
 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+
 	/*
 	 * The above returns on success the # of triggers registered,
 	 * but if it didn't register any it returns zero.  Consider no
@@ -1588,24 +4962,52 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		goto out_free;
 	} else if (ret < 0)
 		goto out_free;
+
+	if (get_named_trigger_data(trigger_data))
+		goto enable;
+
+	if (has_hist_vars(hist_data))
+		save_hist_vars(hist_data);
+
+	ret = create_actions(hist_data, file);
+	if (ret)
+		goto out_unreg;
+
+	ret = tracing_map_init(hist_data->map);
+	if (ret)
+		goto out_unreg;
+enable:
+	ret = hist_trigger_enable(trigger_data, file);
+	if (ret)
+		goto out_unreg;
+
 	/* Just return zero, not the number of registered triggers */
 	ret = 0;
  out:
+	if (ret == 0)
+		hist_err_clear();
+
 	return ret;
+ out_unreg:
+	cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
 
-	kfree(trigger_data);
+	remove_hist_vars(hist_data);
 
+	remove_hist_actions(hist_data);
+
+	kfree(trigger_data);
 	destroy_hist_data(hist_data);
+
 	goto out;
 }
 
 static struct event_command trigger_hist_cmd = {
 	.name			= "hist",
 	.trigger_type		= ETT_EVENT_HIST,
-	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.flags			= EVENT_CMD_FL_NEEDS_REC | EVENT_CMD_FL_POST_TRIGGER,
 	.func			= event_hist_trigger_func,
 	.reg			= hist_register_trigger,
 	.unreg			= hist_unregister_trigger,
@@ -1625,7 +5027,8 @@ __init int register_trigger_hist_cmd(void)
 }
 
 static void
-hist_enable_trigger(struct event_trigger_data *data, void *rec)
+hist_enable_trigger(struct event_trigger_data *data, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 	struct event_trigger_data *test;
@@ -1641,7 +5044,8 @@ hist_enable_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-hist_enable_count_trigger(struct event_trigger_data *data, void *rec)
+hist_enable_count_trigger(struct event_trigger_data *data, void *rec,
+			  struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1649,7 +5053,7 @@ hist_enable_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	hist_enable_trigger(data, rec);
+	hist_enable_trigger(data, rec, event);
 }
 
 static struct event_trigger_ops hist_enable_trigger_ops = {
@@ -1754,3 +5158,40 @@ __init int register_trigger_hist_enable_disable_cmds(void)
 
 	return ret;
 }
+
+static __init int trace_events_hist_init(void)
+{
+	struct dentry *entry = NULL;
+	struct trace_array *tr;
+	struct dentry *d_tracer;
+	int err = 0;
+
+	tr = top_trace_array();
+	if (!tr) {
+		err = -ENODEV;
+		goto err;
+	}
+
+	d_tracer = tracing_init_dentry();
+	if (IS_ERR(d_tracer)) {
+		err = PTR_ERR(d_tracer);
+		goto err;
+	}
+
+	entry = tracefs_create_file("synthetic_events", 0644, d_tracer,
+				    tr, &synth_events_fops);
+	if (!entry) {
+		err = -ENODEV;
+		goto err;
+	}
+
+	hist_err_alloc();
+
+	return err;
+ err:
+	pr_warn("Could not create tracefs 'synthetic_events' entry\n");
+
+	return err;
+}
+
+fs_initcall(trace_events_hist_init);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -63,7 +63,8 @@ void trigger_data_free(struct event_trigger_data *data)
  * any trigger that should be deferred, ETT_NONE if nothing to defer.
  */
 enum event_trigger_type
-event_triggers_call(struct trace_event_file *file, void *rec)
+event_triggers_call(struct trace_event_file *file, void *rec,
+		    struct ring_buffer_event *event)
 {
 	struct event_trigger_data *data;
 	enum event_trigger_type tt = ETT_NONE;
@@ -76,7 +77,7 @@ event_triggers_call(struct trace_event_file *file, void *rec)
 		if (data->paused)
 			continue;
 		if (!rec) {
-			data->ops->func(data, rec);
+			data->ops->func(data, rec, event);
 			continue;
 		}
 		filter = rcu_dereference_sched(data->filter);
@@ -86,7 +87,7 @@ event_triggers_call(struct trace_event_file *file, void *rec)
 			tt |= data->cmd_ops->trigger_type;
 			continue;
 		}
-		data->ops->func(data, rec);
+		data->ops->func(data, rec, event);
 	}
 	return tt;
 }
@@ -108,7 +109,7 @@ EXPORT_SYMBOL_GPL(event_triggers_call);
 void
 event_triggers_post_call(struct trace_event_file *file,
 			 enum event_trigger_type tt,
-			 void *rec)
+			 void *rec, struct ring_buffer_event *event)
 {
 	struct event_trigger_data *data;
 
@@ -116,7 +117,7 @@ event_triggers_post_call(struct trace_event_file *file,
 		if (data->paused)
 			continue;
 		if (data->cmd_ops->trigger_type & tt)
-			data->ops->func(data, rec);
+			data->ops->func(data, rec, event);
 	}
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
@@ -504,20 +505,30 @@ clear_event_triggers(struct trace_array *tr)
 void update_cond_flag(struct trace_event_file *file)
 {
 	struct event_trigger_data *data;
-	bool set_cond = false;
+	bool set_cond = false, set_no_discard = false;
 
 	list_for_each_entry_rcu(data, &file->triggers, list) {
 		if (data->filter || event_command_post_trigger(data->cmd_ops) ||
-		    event_command_needs_rec(data->cmd_ops)) {
+		    event_command_needs_rec(data->cmd_ops))
 			set_cond = true;
+
+		if (event_command_post_trigger(data->cmd_ops) &&
+		    event_command_needs_rec(data->cmd_ops))
+			set_no_discard = true;
+
+		if (set_cond && set_no_discard)
 			break;
-		}
 	}
 
 	if (set_cond)
 		set_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
 	else
 		clear_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
+
+	if (set_no_discard)
+		set_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags);
+	else
+		clear_bit(EVENT_FILE_FL_NO_DISCARD_BIT, &file->flags);
 }
 
 /**
@@ -908,8 +919,15 @@ void set_named_trigger_data(struct event_trigger_data *data,
 	data->named_data = named_data;
 }
 
+struct event_trigger_data *
+get_named_trigger_data(struct event_trigger_data *data)
+{
+	return data->named_data;
+}
+
 static void
-traceon_trigger(struct event_trigger_data *data, void *rec)
+traceon_trigger(struct event_trigger_data *data, void *rec,
+		struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
 		return;
@@ -918,7 +936,8 @@ traceon_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceon_count_trigger(struct event_trigger_data *data, void *rec)
+traceon_count_trigger(struct event_trigger_data *data, void *rec,
+		      struct ring_buffer_event *event)
 {
 	if (tracing_is_on())
 		return;
@@ -933,7 +952,8 @@ traceon_count_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceoff_trigger(struct event_trigger_data *data, void *rec)
+traceoff_trigger(struct event_trigger_data *data, void *rec,
+		 struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
 		return;
@@ -942,7 +962,8 @@ traceoff_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-traceoff_count_trigger(struct event_trigger_data *data, void *rec)
+traceoff_count_trigger(struct event_trigger_data *data, void *rec,
+		       struct ring_buffer_event *event)
 {
 	if (!tracing_is_on())
 		return;
@@ -1039,13 +1060,15 @@ static struct event_command trigger_traceoff_cmd = {
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 static void
-snapshot_trigger(struct event_trigger_data *data, void *rec)
+snapshot_trigger(struct event_trigger_data *data, void *rec,
+		 struct ring_buffer_event *event)
 {
 	tracing_snapshot();
 }
 
 static void
-snapshot_count_trigger(struct event_trigger_data *data, void *rec)
+snapshot_count_trigger(struct event_trigger_data *data, void *rec,
+		       struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1053,7 +1076,7 @@ snapshot_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	snapshot_trigger(data, rec);
+	snapshot_trigger(data, rec, event);
 }
 
 static int
@@ -1132,13 +1155,15 @@ static __init int register_trigger_snapshot_cmd(void) { return 0; }
 #define STACK_SKIP 3
 
 static void
-stacktrace_trigger(struct event_trigger_data *data, void *rec)
+stacktrace_trigger(struct event_trigger_data *data, void *rec,
+		   struct ring_buffer_event *event)
 {
 	trace_dump_stack(STACK_SKIP);
 }
 
 static void
-stacktrace_count_trigger(struct event_trigger_data *data, void *rec)
+stacktrace_count_trigger(struct event_trigger_data *data, void *rec,
+			 struct ring_buffer_event *event)
 {
 	if (!data->count)
 		return;
@@ -1146,7 +1171,7 @@ stacktrace_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	stacktrace_trigger(data, rec);
+	stacktrace_trigger(data, rec, event);
 }
 
 static int
@@ -1208,7 +1233,8 @@ static __init void unregister_trigger_traceon_traceoff_cmds(void)
 }
 
 static void
-event_enable_trigger(struct event_trigger_data *data, void *rec)
+event_enable_trigger(struct event_trigger_data *data, void *rec,
+		     struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1219,7 +1245,8 @@ event_enable_trigger(struct event_trigger_data *data, void *rec)
 }
 
 static void
-event_enable_count_trigger(struct event_trigger_data *data, void *rec)
+event_enable_count_trigger(struct event_trigger_data *data, void *rec,
+			   struct ring_buffer_event *event)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
@@ -1233,7 +1260,7 @@ event_enable_count_trigger(struct event_trigger_data *data, void *rec)
 	if (data->count != -1)
 		(data->count)--;
 
-	event_enable_trigger(data, rec);
+	event_enable_trigger(data, rec, event);
 }
 
 int event_enable_trigger_print(struct seq_file *m,
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -13,7 +13,6 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
-#include <trace/events/hist.h>
 
 #include "trace.h"
 
@@ -437,13 +436,11 @@ void start_critical_timings(void)
 {
 	if (preempt_trace() || irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist_rcuidle(TRACE_START, 1);
 }
 EXPORT_SYMBOL_GPL(start_critical_timings);
 
 void stop_critical_timings(void)
 {
-	trace_preemptirqsoff_hist_rcuidle(TRACE_STOP, 0);
 	if (preempt_trace() || irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -453,7 +450,6 @@ EXPORT_SYMBOL_GPL(stop_critical_timings);
 #ifdef CONFIG_PROVE_LOCKING
 void time_hardirqs_on(unsigned long a0, unsigned long a1)
 {
-	trace_preemptirqsoff_hist_rcuidle(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(a0, a1);
 }
@@ -462,7 +458,6 @@ void time_hardirqs_off(unsigned long a0, unsigned long a1)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(a0, a1);
-	trace_preemptirqsoff_hist_rcuidle(IRQS_OFF, 1);
 }
 
 #else /* !CONFIG_PROVE_LOCKING */
@@ -488,7 +483,6 @@ inline void print_irqtrace_events(struct task_struct *curr)
  */
 void trace_hardirqs_on(void)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
@@ -498,13 +492,11 @@ void trace_hardirqs_off(void)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
-	trace_preemptirqsoff_hist(IRQS_ON, 0);
 	if (!preempt_trace() && irq_trace())
 		stop_critical_timing(CALLER_ADDR0, caller_addr);
 }
@@ -514,7 +506,6 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
 	if (!preempt_trace() && irq_trace())
 		start_critical_timing(CALLER_ADDR0, caller_addr);
-	trace_preemptirqsoff_hist(IRQS_OFF, 1);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 
@@ -524,14 +515,12 @@ EXPORT_SYMBOL(trace_hardirqs_off_caller);
 #ifdef CONFIG_PREEMPT_TRACER
 void trace_preempt_on(unsigned long a0, unsigned long a1)
 {
-	trace_preemptirqsoff_hist(PREEMPT_ON, 0);
 	if (preempt_trace() && !irq_trace())
 		stop_critical_timing(a0, a1);
 }
 
 void trace_preempt_off(unsigned long a0, unsigned long a1)
 {
-	trace_preemptirqsoff_hist(PREEMPT_ON, 1);
 	if (preempt_trace() && !irq_trace())
 		start_critical_timing(a0, a1);
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -878,8 +878,8 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	return traceprobe_probes_write(file, buffer, count, ppos,
-			create_trace_kprobe);
+	return trace_parse_run_command(file, buffer, count, ppos,
+				       create_trace_kprobe);
 }
 
 static const struct file_operations kprobe_events_ops = {
@@ -1404,9 +1404,9 @@ static __init int kprobe_trace_self_tests_init(void)
 
 	pr_info("Testing kprobe tracing: ");
 
-	ret = traceprobe_command("p:testprobe kprobe_trace_selftest_target "
-				  "$stack $stack0 +0($stack)",
-				  create_trace_kprobe);
+	ret = trace_run_command("p:testprobe kprobe_trace_selftest_target "
+				"$stack $stack0 +0($stack)",
+				create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function entry.\n");
 		warn++;
@@ -1426,8 +1426,8 @@ static __init int kprobe_trace_self_tests_init(void)
 		}
 	}
 
-	ret = traceprobe_command("r:testprobe2 kprobe_trace_selftest_target "
-				  "$retval", create_trace_kprobe);
+	ret = trace_run_command("r:testprobe2 kprobe_trace_selftest_target "
+				"$retval", create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on probing function return.\n");
 		warn++;
@@ -1497,13 +1497,13 @@ static __init int kprobe_trace_self_tests_init(void)
 			disable_trace_kprobe(tk, file);
 	}
 
-	ret = traceprobe_command("-:testprobe", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe", create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
 	}
 
-	ret = traceprobe_command("-:testprobe2", create_trace_kprobe);
+	ret = trace_run_command("-:testprobe2", create_trace_kprobe);
 	if (WARN_ON_ONCE(ret)) {
 		pr_warn("error on deleting a probe.\n");
 		warn++;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -623,92 +623,6 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
 	kfree(arg->comm);
 }
 
-int traceprobe_command(const char *buf, int (*createfn)(int, char **))
-{
-	char **argv;
-	int argc, ret;
-
-	argc = 0;
-	ret = 0;
-	argv = argv_split(GFP_KERNEL, buf, &argc);
-	if (!argv)
-		return -ENOMEM;
-
-	if (argc)
-		ret = createfn(argc, argv);
-
-	argv_free(argv);
-
-	return ret;
-}
-
-#define WRITE_BUFSIZE  4096
-
-ssize_t traceprobe_probes_write(struct file *file, const char __user *buffer,
-				size_t count, loff_t *ppos,
-				int (*createfn)(int, char **))
-{
-	char *kbuf, *buf, *tmp;
-	int ret = 0;
-	size_t done = 0;
-	size_t size;
-
-	kbuf = kmalloc(WRITE_BUFSIZE, GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-
-	while (done < count) {
-		size = count - done;
-
-		if (size >= WRITE_BUFSIZE)
-			size = WRITE_BUFSIZE - 1;
-
-		if (copy_from_user(kbuf, buffer + done, size)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		kbuf[size] = '\0';
-		buf = kbuf;
-		do {
-			tmp = strchr(buf, '\n');
-			if (tmp) {
-				*tmp = '\0';
-				size = tmp - buf + 1;
-			} else {
-				size = strlen(buf);
-				if (done + size < count) {
-					if (buf != kbuf)
-						break;
-					/* This can accept WRITE_BUFSIZE - 2 ('\n' + '\0') */
-					pr_warn("Line length is too long: Should be less than %d\n",
-						WRITE_BUFSIZE - 2);
-					ret = -EINVAL;
-					goto out;
-				}
-			}
-			done += size;
-
-			/* Remove comments */
-			tmp = strchr(buf, '#');
-
-			if (tmp)
-				*tmp = '\0';
-
-			ret = traceprobe_command(buf, createfn);
-			if (ret)
-				goto out;
-			buf += size;
-
-		} while (done < count);
-	}
-	ret = done;
-
-out:
-	kfree(kbuf);
-
-	return ret;
-}
-
 static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 			   bool is_return)
 {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -42,7 +42,6 @@
 
 #define MAX_TRACE_ARGS		128
 #define MAX_ARGSTR_LEN		63
-#define MAX_EVENT_NAME_LEN	64
 #define MAX_STRING_SIZE		PATH_MAX
 
 /* Reserved field names */
@@ -356,12 +355,6 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
 extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
 
-extern ssize_t traceprobe_probes_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *ppos,
-		int (*createfn)(int, char**));
-
-extern int traceprobe_command(const char *buf, int (*createfn)(int, char**));
-
 /* Sum up total data length for dynamic arraies (strings) */
 static nokprobe_inline int
 __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -651,7 +651,7 @@ static int probes_open(struct inode *inode, struct file *file)
 static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
-	return traceprobe_probes_write(file, buffer, count, ppos, create_trace_uprobe);
+	return trace_parse_run_command(file, buffer, count, ppos, create_trace_uprobe);
 }
 
 static const struct file_operations uprobe_events_ops = {
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -66,6 +66,73 @@ u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i)
 	return (u64)atomic64_read(&elt->fields[i].sum);
 }
 
+/**
+ * tracing_map_set_var - Assign a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ * @n: The value to assign
+ *
+ * Assign n to variable i associated with the specified tracing_map_elt
+ * instance.  The index i is the index returned by the call to
+ * tracing_map_add_var() when the tracing map was set up.
+ */
+void tracing_map_set_var(struct tracing_map_elt *elt, unsigned int i, u64 n)
+{
+	atomic64_set(&elt->vars[i], n);
+	elt->var_set[i] = true;
+}
+
+/**
+ * tracing_map_var_set - Return whether or not a variable has been set
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Return true if the variable has been set, false otherwise.  The
+ * index i is the index returned by the call to tracing_map_add_var()
+ * when the tracing map was set up.
+ */
+bool tracing_map_var_set(struct tracing_map_elt *elt, unsigned int i)
+{
+	return elt->var_set[i];
+}
+
+/**
+ * tracing_map_read_var - Return the value of a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Retrieve the value of the variable i associated with the specified
+ * tracing_map_elt instance.  The index i is the index returned by the
+ * call to tracing_map_add_var() when the tracing map was set
+ * up.
+ *
+ * Return: The variable value associated with field i for elt.
+ */
+u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i)
+{
+	return (u64)atomic64_read(&elt->vars[i]);
+}
+
+/**
+ * tracing_map_read_var_once - Return and reset a tracing_map_elt's variable field
+ * @elt: The tracing_map_elt
+ * @i: The index of the given variable associated with the tracing_map_elt
+ *
+ * Retrieve the value of the variable i associated with the specified
+ * tracing_map_elt instance, and reset the variable to the 'not set'
+ * state.  The index i is the index returned by the call to
+ * tracing_map_add_var() when the tracing map was set up.  The reset
+ * essentially makes the variable a read-once variable if it's only
+ * accessed using this function.
+ *
+ * Return: The variable value associated with field i for elt.
+ */
+u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i)
+{
+	elt->var_set[i] = false;
+	return (u64)atomic64_read(&elt->vars[i]);
+}
+
 int tracing_map_cmp_string(void *val_a, void *val_b)
 {
 	char *a = val_a;
@@ -171,6 +238,28 @@ int tracing_map_add_sum_field(struct tracing_map *map)
 }
 
 /**
+ * tracing_map_add_var - Add a field describing a tracing_map var
+ * @map: The tracing_map
+ *
+ * Add a var to the map and return the index identifying it in the map
+ * and associated tracing_map_elts.  This is the index used for
+ * instance to update a var for a particular tracing_map_elt using
+ * tracing_map_update_var() or reading it via tracing_map_read_var().
+ *
+ * Return: The index identifying the var in the map and associated
+ * tracing_map_elts, or -EINVAL on error.
+ */
+int tracing_map_add_var(struct tracing_map *map)
+{
+	int ret = -EINVAL;
+
+	if (map->n_vars < TRACING_MAP_VARS_MAX)
+		ret = map->n_vars++;
+
+	return ret;
+}
+
+/**
  * tracing_map_add_key_field - Add a field describing a tracing_map key
  * @map: The tracing_map
  * @offset: The offset within the key
@@ -277,6 +366,11 @@ static void tracing_map_elt_clear(struct tracing_map_elt *elt)
 		if (elt->fields[i].cmp_fn == tracing_map_cmp_atomic64)
 			atomic64_set(&elt->fields[i].sum, 0);
 
+	for (i = 0; i < elt->map->n_vars; i++) {
+		atomic64_set(&elt->vars[i], 0);
+		elt->var_set[i] = false;
+	}
+
 	if (elt->map->ops && elt->map->ops->elt_clear)
 		elt->map->ops->elt_clear(elt);
 }
@@ -303,6 +397,8 @@ static void tracing_map_elt_free(struct tracing_map_elt *elt)
 	if (elt->map->ops && elt->map->ops->elt_free)
 		elt->map->ops->elt_free(elt);
 	kfree(elt->fields);
+	kfree(elt->vars);
+	kfree(elt->var_set);
 	kfree(elt->key);
 	kfree(elt);
 }
@@ -330,6 +426,18 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 		goto free;
 	}
 
+	elt->vars = kcalloc(map->n_vars, sizeof(*elt->vars), GFP_KERNEL);
+	if (!elt->vars) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	elt->var_set = kcalloc(map->n_vars, sizeof(*elt->var_set), GFP_KERNEL);
+	if (!elt->var_set) {
+		err = -ENOMEM;
+		goto free;
+	}
+
 	tracing_map_elt_init_fields(elt);
 
 	if (map->ops && map->ops->elt_alloc) {
@@ -833,6 +941,11 @@ static struct tracing_map_elt *copy_elt(struct tracing_map_elt *elt)
 		dup_elt->fields[i].cmp_fn = elt->fields[i].cmp_fn;
 	}
 
+	for (i = 0; i < elt->map->n_vars; i++) {
+		atomic64_set(&dup_elt->vars[i], atomic64_read(&elt->vars[i]));
+		dup_elt->var_set[i] = elt->var_set[i];
+	}
+
 	return dup_elt;
 }
 
@@ -971,6 +1084,7 @@ static void sort_secondary(struct tracing_map *map,
  * @map: The tracing_map
  * @sort_key: The sort key to use for sorting
  * @sort_entries: outval: pointer to allocated and sorted array of entries
+ * @n_dups: outval: pointer to variable receiving a count of duplicates found
  *
  * tracing_map_sort_entries() sorts the current set of entries in the
  * map and returns the list of tracing_map_sort_entries containing
@@ -987,13 +1101,16 @@ static void sort_secondary(struct tracing_map *map,
  * The client should not hold on to the returned array but should use
  * it and call tracing_map_destroy_sort_entries() when done.
  *
- * Return: the number of sort_entries in the struct tracing_map_sort_entry
- * array, negative on error
+ * Return: the number of sort_entries in the struct
+ * tracing_map_sort_entry array, negative on error.  If n_dups is
+ * non-NULL, it will receive the number of duplicate entries found
+ * (and merged) during the sort.
  */
 int tracing_map_sort_entries(struct tracing_map *map,
 			     struct tracing_map_sort_key *sort_keys,
 			     unsigned int n_sort_keys,
-			     struct tracing_map_sort_entry ***sort_entries)
+			     struct tracing_map_sort_entry ***sort_entries,
+			     unsigned int *n_dups)
 {
 	int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
 			      const struct tracing_map_sort_entry **);
@@ -1034,6 +1151,8 @@ int tracing_map_sort_entries(struct tracing_map *map,
 	if (ret < 0)
 		goto free;
 	n_entries -= ret;
+	if (n_dups)
+		*n_dups = ret;
 
 	if (is_key(map, sort_keys[0].field_idx))
 		cmp_entries_fn = cmp_entries_key;
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -5,10 +5,11 @@
 #define TRACING_MAP_BITS_MAX		17
 #define TRACING_MAP_BITS_MIN		7
 
-#define TRACING_MAP_KEYS_MAX		2
+#define TRACING_MAP_KEYS_MAX		3
 #define TRACING_MAP_VALS_MAX		3
 #define TRACING_MAP_FIELDS_MAX		(TRACING_MAP_KEYS_MAX + \
 					 TRACING_MAP_VALS_MAX)
+#define TRACING_MAP_VARS_MAX		16
 #define TRACING_MAP_SORT_KEYS_MAX	2
 
 typedef int (*tracing_map_cmp_fn_t) (void *val_a, void *val_b);
@@ -136,6 +137,8 @@ struct tracing_map_field {
 struct tracing_map_elt {
 	struct tracing_map		*map;
 	struct tracing_map_field	*fields;
+	atomic64_t			*vars;
+	bool				*var_set;
 	void				*key;
 	void				*private_data;
 };
@@ -191,6 +194,7 @@ struct tracing_map {
 	int				key_idx[TRACING_MAP_KEYS_MAX];
 	unsigned int			n_keys;
 	struct tracing_map_sort_key	sort_key;
+	unsigned int			n_vars;
 	atomic64_t			hits;
 	atomic64_t			drops;
 };
@@ -247,6 +251,7 @@ tracing_map_create(unsigned int map_bits,
 extern int tracing_map_init(struct tracing_map *map);
 
 extern int tracing_map_add_sum_field(struct tracing_map *map);
+extern int tracing_map_add_var(struct tracing_map *map);
 extern int tracing_map_add_key_field(struct tracing_map *map,
 				     unsigned int offset,
 				     tracing_map_cmp_fn_t cmp_fn);
@@ -266,7 +271,13 @@ extern int tracing_map_cmp_none(void *val_a, void *val_b);
 
 extern void tracing_map_update_sum(struct tracing_map_elt *elt,
 				   unsigned int i, u64 n);
+extern void tracing_map_set_var(struct tracing_map_elt *elt,
+				unsigned int i, u64 n);
+extern bool tracing_map_var_set(struct tracing_map_elt *elt, unsigned int i);
 extern u64 tracing_map_read_sum(struct tracing_map_elt *elt, unsigned int i);
+extern u64 tracing_map_read_var(struct tracing_map_elt *elt, unsigned int i);
+extern u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i);
+
 extern void tracing_map_set_field_descr(struct tracing_map *map,
 					unsigned int i,
 					unsigned int key_offset,
@@ -275,7 +286,8 @@ extern int
 tracing_map_sort_entries(struct tracing_map *map,
 			 struct tracing_map_sort_key *sort_keys,
 			 unsigned int n_sort_keys,
-			 struct tracing_map_sort_entry ***sort_entries);
+			 struct tracing_map_sort_entry ***sort_entries,
+			 unsigned int *n_dups);
 
 extern void
 tracing_map_destroy_sort_entries(struct tracing_map_sort_entry **entries,
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -192,12 +192,15 @@ static void *func_remove(struct tracepoint_func **funcs,
  * Add the probe function to a tracepoint.
  */
 static int tracepoint_add_func(struct tracepoint *tp,
-			       struct tracepoint_func *func, int prio)
+			       struct tracepoint_func *func, int prio,
+			       bool dynamic)
 {
 	struct tracepoint_func *old, *tp_funcs;
 	int ret;
 
-	if (tp->regfunc && !static_key_enabled(&tp->key)) {
+	if (tp->regfunc &&
+	    ((dynamic && !(atomic_read(&tp->key.enabled) > 0)) ||
+	     !static_key_enabled(&tp->key))) {
 		ret = tp->regfunc();
 		if (ret < 0)
 			return ret;
@@ -219,7 +222,9 @@ static int tracepoint_add_func(struct tracepoint *tp,
 	 * is used.
 	 */
 	rcu_assign_pointer(tp->funcs, tp_funcs);
-	if (!static_key_enabled(&tp->key))
+	if (dynamic && !(atomic_read(&tp->key.enabled) > 0))
+		atomic_inc(&tp->key.enabled);
+	else if (!dynamic && !static_key_enabled(&tp->key))
 		static_key_slow_inc(&tp->key);
 	release_probes(old);
 	return 0;
@@ -232,7 +237,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
  * by preempt_disable around the call site.
  */
 static int tracepoint_remove_func(struct tracepoint *tp,
-		struct tracepoint_func *func)
+				  struct tracepoint_func *func, bool dynamic)
 {
 	struct tracepoint_func *old, *tp_funcs;
 
@@ -246,10 +251,14 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 
 	if (!tp_funcs) {
 		/* Removed last function */
-		if (tp->unregfunc && static_key_enabled(&tp->key))
+		if (tp->unregfunc &&
+		    ((dynamic && (atomic_read(&tp->key.enabled) > 0)) ||
+		     static_key_enabled(&tp->key)))
 			tp->unregfunc();
 
-		if (static_key_enabled(&tp->key))
+		if (dynamic && (atomic_read(&tp->key.enabled) > 0))
+			atomic_dec(&tp->key.enabled);
+		else if (!dynamic && static_key_enabled(&tp->key))
 			static_key_slow_dec(&tp->key);
 	}
 	rcu_assign_pointer(tp->funcs, tp_funcs);
@@ -258,7 +267,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 }
 
 /**
- * tracepoint_probe_register -  Connect a probe to a tracepoint
+ * tracepoint_probe_register_prio -  Connect a probe to a tracepoint
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
@@ -271,7 +280,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
  * within module exit functions.
  */
 int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
-				   void *data, int prio)
+				   void *data, int prio, bool dynamic)
 {
 	struct tracepoint_func tp_func;
 	int ret;
@@ -280,7 +289,7 @@ int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
 	tp_func.func = probe;
 	tp_func.data = data;
 	tp_func.prio = prio;
-	ret = tracepoint_add_func(tp, &tp_func, prio);
+	ret = tracepoint_add_func(tp, &tp_func, prio, dynamic);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
@@ -301,10 +310,18 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
  */
 int tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data)
 {
-	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO);
+	return tracepoint_probe_register_prio(tp, probe, data, TRACEPOINT_DEFAULT_PRIO, false);
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_register);
 
+int dynamic_tracepoint_probe_register(struct tracepoint *tp, void *probe,
+				      void *data)
+{
+	return tracepoint_probe_register_prio(tp, probe, data,
+					      TRACEPOINT_DEFAULT_PRIO, true);
+}
+EXPORT_SYMBOL_GPL(dynamic_tracepoint_probe_register);
+
 /**
  * tracepoint_probe_unregister -  Disconnect a probe from a tracepoint
  * @tp: tracepoint
@@ -313,7 +330,8 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register);
  *
  * Returns 0 if ok, error value on error.
  */
-int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
+int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data,
+				bool dynamic)
 {
 	struct tracepoint_func tp_func;
 	int ret;
@@ -321,7 +339,7 @@ int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 	mutex_lock(&tracepoints_mutex);
 	tp_func.func = probe;
 	tp_func.data = data;
-	ret = tracepoint_remove_func(tp, &tp_func);
+	ret = tracepoint_remove_func(tp, &tp_func, dynamic);
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
diff --git a/localversion-rt b/localversion-rt
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5

Sebastian
