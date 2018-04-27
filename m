From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 3/3] tracing: Add field modifier parsing hist error for hist triggers
Date: Thu, 26 Apr 2018 20:04:49 -0500
Message-ID: <b043c59fa79acd06a5f14a1d44dee9e5a3cd1248.1524790601.git.tom.zanussi@linux.intel.com>
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

If the user specifies an invalid field modifier for a hist trigger,
the current code correctly flags that as an error, but doesn't tell
the user what happened.

Fix this by invoking hist_err() with an appropriate message when
invalid modifiers are specified.

Before:

  # echo 'hist:keys=pid:ts0=common_timestamp.junkusecs' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist

After:

  # echo 'hist:keys=pid:ts0=common_timestamp.junkusecs' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
  -su: echo: write error: Invalid argument
  # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
  ERROR: Invalid field modifier: junkusecs
    Last command: keys=pid:ts0=common_timestamp.junkusecs

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f231fa2..b9061ed 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2466,6 +2466,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else {
+			hist_err("Invalid field modifier: ", modifier);
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
-- 
1.9.3
