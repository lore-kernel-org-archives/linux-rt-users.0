From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v7 16/37] tracing: Account for variables in named trigger compatibility
Date: Wed,  6 Dec 2017 16:37:57 -0600
Message-ID: <c0fb90eedb9221487288a66cbec99b2d18abf4fe.1512593081.git.tom.zanussi@linux.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel.opensrc@gmail.com, joelaf@google.com,
        mathieu.desnoyers@efficios.com, baohong.liu@intel.com,
        rajvi.jingar@intel.com, julia@ni.com, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1512593081.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1512593081.git.tom.zanussi@linux.intel.com>
References: <cover.1512593081.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Named triggers must also have the same set of variables in order to be
considered compatible - update the trigger match test to account for
that.

The reason for this requirement is that named triggers with variables
are meant to allow one or more events to set the same variable.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c385e56..10b79ec 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1610,7 +1610,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 		sort_key = &hist_data->sort_keys[i];
 		idx = sort_key->field_idx;
 
-		if (WARN_ON(idx >= TRACING_MAP_FIELDS_MAX))
+		if (WARN_ON(idx >= HIST_FIELDS_MAX))
 			return -EINVAL;
 
 		if (i > 0)
@@ -1798,6 +1798,11 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 			return false;
 		if (key_field->is_signed != key_field_test->is_signed)
 			return false;
+		if (!!key_field->var.name != !!key_field_test->var.name)
+			return false;
+		if (key_field->var.name &&
+		    strcmp(key_field->var.name, key_field_test->var.name) != 0)
+			return false;
 	}
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
-- 
1.9.3
