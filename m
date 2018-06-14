From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH] tracing: Fix some errors in histogram documentation
Date: Thu, 14 Jun 2018 15:48:59 -0700
Message-ID: <20180614224859.55864-1-joel@joelfernandes.org>
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        bigeasy@linutronix.de, mhiramat@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Fix typos, inconsistencies in using quotes, incorrect section number,
etc. in the trace histogram documentation.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/trace/histogram.txt | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index 6e05510afc28..da955cd696f6 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -1730,35 +1730,35 @@ If a variable isn't a key variable or prefixed with 'vals=', the
 associated event field will be saved in a variable but won't be summed
 as a value:
 
-  # echo 'hist:keys=next_pid:ts1=common_timestamp ... >> event/trigger
+  # echo 'hist:keys=next_pid:ts1=common_timestamp ...' >> event/trigger
 
 Multiple variables can be assigned at the same time.  The below would
 result in both ts0 and b being created as variables, with both
 common_timestamp and field1 additionally being summed as values:
 
-  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ... >> \
+  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ...' >> \
 	event/trigger
 
 Note that variable assignments can appear either preceding or
 following their use.  The command below behaves identically to the
 command above:
 
-  # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ... >> \
+  # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ...' >> \
 	event/trigger
 
 Any number of variables not bound to a 'vals=' prefix can also be
 assigned by simply separating them with colons.  Below is the same
 thing but without the values being summed in the histogram:
 
-  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ... >> event/trigger
+  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ...' >> event/trigger
 
 Variables set as above can be referenced and used in expressions on
 another event.
 
 For example, here's how a latency can be calculated:
 
-  # echo 'hist:keys=pid,prio:ts0=common_timestamp ... >> event1/trigger
-  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ... >> event2/trigger
+  # echo 'hist:keys=pid,prio:ts0=common_timestamp ...' >> event1/trigger
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...' >> event2/trigger
 
 In the first line above, the event's timetamp is saved into the
 variable ts0.  In the next line, ts0 is subtracted from the second
@@ -1767,7 +1767,7 @@ yet another variable, 'wakeup_lat'.  The hist trigger below in turn
 makes use of the wakeup_lat variable to compute a combined latency
 using the same key and variable from yet another event:
 
-  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ... >> event3/trigger
+  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
 2.2.2 Synthetic Events
 ----------------------
@@ -1808,10 +1808,11 @@ the command that defined it with a '!':
 At this point, there isn't yet an actual 'wakeup_latency' event
 instantiated in the event subsytem - for this to happen, a 'hist
 trigger action' needs to be instantiated and bound to actual fields
-and variables defined on other events (see Section 6.3.3 below).
+and variables defined on other events (see Section 2.2.3 below on
+how that is done using hist trigger 'onmatch' action). Once that is
+done, the 'wakeup_latency' synthetic event instance is created.
 
-Once that is done, an event instance is created, and a histogram can
-be defined using it:
+A histogram can now be defined for the new synthetic event:
 
   # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
         /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
@@ -1961,7 +1962,7 @@ hist trigger specification.
     back to that pid, the timestamp difference is calculated.  If the
     resulting latency, stored in wakeup_lat, exceeds the current
     maximum latency, the values specified in the save() fields are
-    recoreded:
+    recorded:
 
     # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
             if comm=="cyclictest"' >> \
-- 
2.18.0.rc1.242.g61856ae69a-goog
