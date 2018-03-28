From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/4] tracing: Don't add flag strings when displaying variable references
Date: Wed, 28 Mar 2018 15:10:54 -0500
Message-ID: <913318a5610ef6b24af2522575f671fa6ee19b6b.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1522256721.git.tom.zanussi@linux.intel.com>
References: <cover.1522256721.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Variable references should never have flags appended when displayed -
prevent that from happening.

Before:

  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0.usecs:...

After:

  hist:keys=next_pid:vals=hitcount:wakeup_lat=common_timestamp.usecs-$ts0:...

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fb81447..468e43f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2052,7 +2052,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 	strcat(expr, hist_field_name(field, 0));
 
-	if (field->flags) {
+	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
 		if (flags_str) {
-- 
1.9.3
