From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v8 11/22] tracing: Add hist trigger onchange() handler Documentation
Date: Mon, 10 Dec 2018 18:01:25 -0600
Message-ID: <1376631284f39481a0a188ec8b2566b620b9e48c.1544483273.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add Documentation for the hist:onchange($var) handler.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Documentation/trace/histogram.rst | 98 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 353317bc3825..79476c906b1a 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1869,6 +1869,7 @@ The available handlers are:
 
   - onmatch(matching.event)    - invoke action on any addition or update
   - onmax(var)                 - invoke action if var exceeds current max
+  - onchange(var)              - invoke action if var changes
 
 The available actions are:
 
@@ -2140,6 +2141,103 @@ The following commonly-used handler.action pairs are available:
       <...>-2102  [005] d..4   309.875185: sched_wake_idle_without_ipi: cpu=1
      <idle>-0     [001] d..3   309.875200: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=cyclictest next_pid=2103 next_prio=19
 
+  - onchange(var).save(field,..	.)
+
+    The 'onchange(var).save(field,...)' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    changes.
+
+    The end result is that the trace event fields specified as the
+    onchange.save() params will be saved if 'var' changes for that
+    hist trigger entry.  This allows context from the event that
+    changed the value to be saved for later reference.  When the
+    histogram is displayed, additional fields displaying the saved
+    values will be printed.
+
+  - onchange(var).snapshot()
+
+    The 'onchange(var).snapshot()' hist trigger action is invoked
+    whenever the value of 'var' associated with a histogram entry
+    changes.
+
+    The end result is that a global snapshot of the trace buffer will
+    be saved in the tracing/snapshot file if 'var' changes for any
+    hist trigger entry.
+
+    Note that in this case the changed value is a global variable
+    associated withe current trace instance.  The key of the specific
+    trace event that caused the value to change and the global value
+    itself are displayed, along with a message stating that a snapshot
+    has been taken and where to find it.  The user can use the key
+    information displayed to locate the corresponding bucket in the
+    histogram for even more detail.
+
+    As an example the below defines a hist trigger on the tcp_probe
+    event, keyed on dport.  Whenever a tcp_probe event occurs, the
+    cwnd field is checked against the current value stored in the
+    $cwnd variable.  If the value has changed, a snapshot is taken.
+    As part of the setup, all the scheduler and tcp events are also
+    enabled, which are the events that will show up in the snapshot
+    when it is taken at some point:
+
+    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+    # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
+
+    # echo 'hist:keys=dport:cwnd=snd_cwnd: \
+            onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
+	    onchange($cwnd).snapshot()' >> \
+	    /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
+
+    When the histogram is displayed, for each bucket the tracked value
+    and the saved values corresponding to that value are displayed
+    following the rest of the fields.
+
+    If a snaphot was taken, there is also a message indicating that,
+    along with the value and event that triggered the snapshot:
+
+    # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
+      { dport:       1521 } hitcount:          8
+	changed:         10  snd_wnd:      35456  srtt:     154262  rcv_wnd:      42112
+
+      { dport:         80 } hitcount:         23
+	changed:         10  snd_wnd:      28960  srtt:      19604  rcv_wnd:      29312
+
+      { dport:       9001 } hitcount:        172
+	changed:         10  snd_wnd:      48384  srtt:     260444  rcv_wnd:      55168
+
+      { dport:        443 } hitcount:        211
+	changed:         10  snd_wnd:      26960  srtt:      17379  rcv_wnd:      28800
+
+    Snapshot taken (see tracing/snapshot).  Details:
+        triggering value { onchange($cwnd) }:         10
+        triggered by event with key: { dport:         80 }
+
+    Totals:
+        Hits: 414
+        Entries: 4
+        Dropped: 0
+
+    In the above case, the event that triggered the snapshot has the
+    key with dport == 80.  If you look at the bucket that has 80 as
+    the key, you'll find the additional values save()'d along with the
+    changed value for that bucket, which should be the same as the
+    global changed value (since that was the same value that triggered
+    the global snapshot).
+
+    And finally, looking at the snapshot data should show at or near
+    the end the event that triggered the snapshot:
+
+    # cat /sys/kernel/debug/tracing/snapshot
+
+       gnome-shell-1261  [006] dN.3    49.823113: sched_stat_runtime: comm=gnome-shell pid=1261 runtime=49347 [ns] vruntime=1835730389 [ns]
+     kworker/u16:4-773   [003] d..3    49.823114: sched_switch: prev_comm=kworker/u16:4 prev_pid=773 prev_prio=120 prev_state=R+ ==> next_comm=kworker/3:2 next_pid=135 next_prio=120
+       gnome-shell-1261  [006] d..3    49.823114: sched_switch: prev_comm=gnome-shell prev_pid=1261 prev_prio=120 prev_state=R+ ==> next_comm=kworker/6:2 next_pid=387 next_prio=120
+       kworker/3:2-135   [003] d..3    49.823118: sched_stat_runtime: comm=kworker/3:2 pid=135 runtime=5339 [ns] vruntime=17815800388 [ns]
+       kworker/6:2-387   [006] d..3    49.823120: sched_stat_runtime: comm=kworker/6:2 pid=387 runtime=9594 [ns] vruntime=14589605367 [ns]
+       kworker/6:2-387   [006] d..3    49.823122: sched_switch: prev_comm=kworker/6:2 prev_pid=387 prev_prio=120 prev_state=R+ ==> next_comm=gnome-shell next_pid=1261 next_prio=120
+       kworker/3:2-135   [003] d..3    49.823123: sched_switch: prev_comm=kworker/3:2 prev_pid=135 prev_prio=120 prev_state=T ==> next_comm=swapper/3 next_pid=0 next_prio=120
+            <idle>-0     [004] ..s7    49.823798: tcp_probe: src=10.0.0.10:54326 dest=23.215.104.193:80 mark=0x0 length=32 snd_nxt=0xe3ae2ff5 snd_una=0xe3ae2ecd snd_cwnd=10 ssthresh=2147483647 snd_wnd=28960 srtt=19604 rcv_wnd=29312
+
 3. User space creating a trigger
 --------------------------------
 
-- 
2.14.1
