From: Joel Fernandes <joelaf@google.com>
Subject: [PATCH RFC] tracing: Call triggers only if event passes filter checks
Date: Thu, 14 Jun 2018 18:01:13 -0700
Message-ID: <20180615010113.127718-1-joel@joelfernandes.org>
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org,
        mathieu.desnoyers@efficios.com, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>, peterz@infradead.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently, trace event triggers are called regardless of if the event
filter checks pass or fail. Thus if one were to enable event triggers
and filters at the same time, then the triggers will always be called
even if the filter checks didn't pass.

This is a problem for a usecase I was experimenting with: measuring the
time preemption is disabled using synthetic events and dump the stack
using the stacktrace trigger if the total preempt off time was greater
than a threshold. Following are the commands for the same:

Create synthetic event:

echo 'preemptdisable u64 lat' >> \
	      /sys/kernel/debug/tracing/synthetic_events

echo 'hist:keys=cpu:ts0=common_timestamp.usecs:scpu=cpu' >> \
	      /sys/kernel/debug/tracing/events/preemptirq/preempt_disable/trigger

echo 'hist:keys=cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
onmatch(preemptirq.preempt_disable).preemptdisable($wakeup_lat)' >> \
	        /sys/kernel/debug/tracing/events/preemptirq/preempt_enable/trigger

Enable synthetic event:

echo stacktrace > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
echo 'lat > 400' > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/filter
echo 1 > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/enable

With the patch, the stacktrace is triggered only if the filter checks
passed. It also seems sensible to call triggers only if filter checks
pass so lets do that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 630c5a24b2b2..b0b5df288924 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1296,13 +1296,14 @@ __event_trigger_test_discard(struct trace_event_file *file,
 			     enum event_trigger_type *tt)
 {
 	unsigned long eflags = file->flags;
+	bool filtered = (file->flags & EVENT_FILE_FL_FILTERED) &&
+			 !filter_match_preds(file->filter, entry);
 
-	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
+	if (!filtered && (eflags & EVENT_FILE_FL_TRIGGER_COND))
 		*tt = event_triggers_call(file, entry, event);
 
 	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
-	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
-	     !filter_match_preds(file->filter, entry))) {
+	    filtered) {
 		__trace_event_discard_commit(buffer, event);
 		return true;
 	}
-- 
2.18.0.rc1.244.gcf134e6275-goog
