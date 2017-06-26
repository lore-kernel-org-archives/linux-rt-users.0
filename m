From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 17/32] tracing: Account for variables in named trigger compatibility
Date: Mon, 26 Jun 2017 17:49:18 -0500
Message-ID: <de0a6847d86031f0883285a523cb85116b283c56.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1498510759.git.tom.zanussi@linux.intel.com>
References: <cover.1498510759.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Named triggers must also have the same set of variables in order to be
considered compatible - update the trigger match test to account for
that.

The reason for this requirement is that named triggers with variables
are meant to allow one or more events to set the same variable.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 75cac76..fa8f607 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1545,7 +1545,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 		sort_key = &hist_data->sort_keys[i];
 		idx = sort_key->field_idx;
 
-		if (WARN_ON(idx >= TRACING_MAP_FIELDS_MAX))
+		if (WARN_ON(idx >= HIST_FIELDS_MAX))
 			return -EINVAL;
 
 		if (i > 0)
@@ -1733,6 +1733,12 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 			return false;
 		if (key_field->is_signed != key_field_test->is_signed)
 			return false;
+		if ((key_field->var.name && !key_field_test->var.name) ||
+		    (!key_field->var.name && key_field_test->var.name))
+			return false;
+		if ((key_field->var.name && key_field_test->var.name) &&
+		     strcmp(key_field->var.name, key_field_test->var.name) != 0)
+			return false;
 	}
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
-- 
1.9.3
