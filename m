From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/3] tracing: Add field parsing hist error for hist triggers
Date: Thu, 26 Apr 2018 20:04:48 -0500
Message-ID: <fdc8746969d16906120f162b99dd71c741e0b62c.1524790601.git.tom.zanussi@linux.intel.com>
References: <cover.1524790601.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524790601.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1524790601.git.tom.zanussi@linux.intel.com>
References: <cover.1524790601.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

If the user specifies a nonexistent field for a hist trigger, the
current code correctly flags that as an error, but doesn't tell the
user what happened.

Fix this by invoking hist_err() with an appropriate message when
nonexistent fields are specified.

Before:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist

After:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
  ERROR: Couldn't find field: pid
    Last command: keys=pid:ts0=common_timestamp.usecs

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 66c87be..f231fa2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2481,6 +2481,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
+			hist_err("Couldn't find field: ", field_name);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
-- 
1.9.3
