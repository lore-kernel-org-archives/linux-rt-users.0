From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 12/21] tracing: Account for variables in named trigger compatibility
Date: Wed,  8 Feb 2017 11:25:08 -0600
Message-ID: <88d17e7197f809ade0dd150712ae1d6b86b26b6b.1486569306.git.tom.zanussi@linux.intel.com>
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

Named triggers must also have the same set of variables in order to be
considered compatible - update the trigger match test to account for
that.

The reason for this requirement is that named triggers with variables
are meant to allow one or more events to set the same variable.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e707577..889455e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1576,6 +1576,10 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 			return false;
 		if (key_field->is_signed != key_field_test->is_signed)
 			return false;
+		if ((key_field->var_name && !key_field_test->var_name) ||
+		    (!key_field->var_name && key_field_test->var_name) ||
+		    strcmp(key_field->var_name, key_field_test->var_name) != 0)
+			return false;
 	}
 
 	for (i = 0; i < hist_data->n_sort_keys; i++) {
-- 
1.9.3
