From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 21/21] tracing: Add inter-event hist trigger Documentation
Date: Wed,  8 Feb 2017 11:25:17 -0600
Message-ID: <5b024478574b01c4ad03d219851533617b939047.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1486569306.git.tom.zanussi@linux.intel.com>
References: <cover.1486569306.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add background and details on inter-event hist triggers, including
hist variables, synthetic events, and actions.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/events.txt | 330 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 330 insertions(+)

diff --git a/Documentation/trace/events.txt b/Documentation/trace/events.txt
index 2cc08d4..e3fb774 100644
--- a/Documentation/trace/events.txt
+++ b/Documentation/trace/events.txt
@@ -571,6 +571,7 @@ The following commands are supported:
 	.sym-offset display an address as a symbol and offset
 	.syscall    display a syscall id as a system call name
 	.execname   display a common_pid as a program name
+	.usecs      display a common_timestamp in microseconds
 
   Note that in general the semantics of a given field aren't
   interpreted when applying a modifier to it, but there are some
@@ -2064,3 +2065,332 @@ The following commands are supported:
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
+pseudo-field to all events named 'common_timestamp' which can be used
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
+    a synthetic field named 'common_timestamp' which can be used in
+    histograms as if it were any other event field.  By default it is
+    in units of nanoseconds; appending '.usecs' to a common_timestamp
+    field changes the units to microseconds.
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
+  # echo 'hist:keys=next_pid:vals=ts0=common_timestamp ... >> event/trigger
+
+The ts0 variable can be accessed by any subsequent event having the
+same pid as 'next_pid'.  Because 'vals=' is used, the common_timestamp
+variable value will also be summed as a normal histogram value would
+(though for a timestamp it makes little sense).
+
+The below shows that a key value can also be saved in the same way:
+
+  # echo 'hist:key=timer_pid=common_pid ...' >> event/trigger
+
+If a variable isn't a key variable or prefixed with 'vals=', the
+associated event field will be saved in a variable but won't be summed
+as a value:
+
+  # echo 'hist:keys=next_pid:ts1=common_timestamp ... >> event/trigger
+
+Multiple variables can be assigned at the same time.  The below would
+result in both ts0 and b being created as variables, with both
+common_timestamp and field1 additionally being summed as values:
+
+  # echo 'hist:keys=pid:vals=ts0=common_timestamp,b=field1 ... >> event/trigger
+
+Any number of variables not bound to a 'vals=' prefix can also be
+assigned by simply separating them with colons.  Below is the same
+thing but without the values being summed in the histogram:
+
+  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ... >> event/trigger
+
+Variables set as above can be referenced and used in expressions on
+another event.
+
+For example, here's how a latency can be calculated:
+
+  # echo 'hist:keys=pid,prio:ts0=common_timestamp ... >> event1/trigger
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-ts0 ... >> event2/trigger
+
+In the first line above, the event's timetamp is saved into the
+variable ts0.  In the next line, ts0 is subtracted from the second
+event's timestamp to produce the latency, which is then assigned into
+yet another variable, 'wakeup_lat'.  The hist trigger below in turn
+makes use of the wakeup_lat variable to compute a combined latency
+using the same key and variable from yet another event:
+
+  # echo 'hist:key=pid:wakeupswitch_lat=wakeup_lat+switchtime_lat ... >> event3/trigger
+
+6.3.2 Synthetic Events
+----------------------
+
+Synthetic events are user-defined events generated from hist trigger
+variables associated with one or more other events.  Their purpose is
+to provide a mechanism for displaying data spanning multiple events
+consistent with the existing and already familiar usage for normal
+events.
+
+Because they are derived from one or more other hist triggers, using
+them requires that those other triggers be defined before the
+synthetic event can be full resolved and generated.  A synthetic event
+can be defined before or after those events, but can't be used until
+all references to other events are resolved.
+
+To define a synthetic event, the user writes a simple specification
+consisting of the name of the new event along with one or more
+variables defined on other events, to the tracing/synthetic_events
+file.
+
+For instance, the following creates a new event named 'wakeup_latency'
+with 3 fields: lat, pid, and prio.  Each of those fields is simply a
+variable reference to a variable on another event:
+
+  # echo 'wakeup_latency \
+          lat=sched_switch:wakeup_lat \
+          pid=sched_switch:woken_pid \
+	  prio=sched_switch:woken_prio' >> \
+	  /sys/kernel/debug/tracing/synthetic_events
+
+Reading the tracing/synthetic_events file lists all the currently
+defined synthetic events, in this case the event defined above:
+
+  # cat /sys/kernel/debug/tracing/synthetic_events
+    wakeup_latency lat=sched_switch:wakeup_lat*, \
+                   pid=sched_switch:woken_pid*, \
+                   prio=sched_switch:woken_prio*
+
+Any event field that hasn't yet been 'resolved' is shown with an
+asterisk following it.  A field will be unresolved if another event
+defining the specified variable hasn't been defined yet.  Once the
+second event below is added, those variables are defined:
+
+  # echo 'hist:keys=pid,prio:ts0=common_timestamp.usecs' >> \
+          /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+
+  # echo 'hist:keys=woken_pid=next_pid,woken_prio=next_prio:\
+          wakeup_lat=common_timestamp.usecs-ts0:' >> \
+          /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+
+At that point the variables are defined and displaying the
+synthetic_event no longer displays the asterisks:
+
+  # cat /sys/kernel/debug/tracing/synthetic_events
+        wakeup_latency \
+	lat=sched:sched_switch:wakeup_lat, \
+        pid=sched:sched_switch:woken_pid, \
+	prio=sched:sched_switch:woken_prio
+
+At this point, the synthetic event is ready to use, and a histogram
+can be defined using it:
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
+Although a histogram can be defined for a synthetic event, it won't be
+populated until actions that actually trace that event occur.  To set
+that up, the user associates a 'trace' action naming the synthetic
+event with a triggering event.  This causes the synthetic event to be
+traced whenever a match occurs (see Section 6.3.3 below).
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
+  - onmatch().trace(synthetic_event_name)
+
+    The 'onmatch().trace(event)' hist trigger action is invoked
+    whenever an event matches and the histogram entry would be or is
+    added or updated.  It causes the named synthetic event to be
+    generated with the values of the set of resolved variables named
+    in the given synthetic event.  The result is the generation of a
+    synthetic event that consists of the values contained in those
+    variables at the time the invoking event was hit.
+
+    As an example the below defines a simple synthetic event using a
+    variable defined on the sched_wakeup_new event, and shows the
+    event definition with unresolved fields, since the
+    sched_wakeup_new event with the testpid variable hasn't been
+    defined yet:
+
+    # echo 'wakeup_new_test pid=sched_wakeup_new:testpid' >> \
+           /sys/kernel/debug/tracing/synthetic_events
+
+    # cat /sys/kernel/debug/tracing/synthetic_events
+          wakeup_new_test pid=sched_wakeup_new:testpid*
+
+    The following hist trigger both defines the missing testpid
+    variable and specifies an onmatch().trace action that generates a
+    wakeup_new_test synthetic event whenever a sched_wakeup_new event
+    occurs, which because of the 'if comm == "cyclictest"' filter only
+    happens when the executable is cyclictest:
+
+    # echo 'hist:keys=testpid=pid:onmatch().trace(wakeup_new_test) \
+            if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+
+    Creating and displaying a histogram based on those events is now
+    just a matter of using the fields and new synthetic event in the
+    tracing/events/synthetic directory, as usual:
+
+    # echo 'hist:keys=pid:sort=pid' >> \
+           /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
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
+    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
+            if comm=="cyclictest"' >> \
+            /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+
+    # echo 'hist:keys=next_pid:\
+            wakeup_lat=common_timestamp.usecs-ts0:\
+            onmax(wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
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
-- 
1.9.3
