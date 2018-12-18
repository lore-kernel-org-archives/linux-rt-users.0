From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 6/7] tracing: Remove hist trigger synth_var_refs
Date: Tue, 18 Dec 2018 14:33:25 -0600
Message-ID: <b4d3470526b8f0426dcec125399dad9ad9b8589d.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Cc: tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

All var_refs are now handled uniformly and there's no reason to treat
the synth_refs in a special way now, so remove them and associated
functions.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 725d22f5372f..e66dd764e057 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -279,8 +279,6 @@ struct hist_trigger_data {
 	struct action_data		*actions[HIST_ACTIONS_MAX];
 	unsigned int			n_actions;
 
-	struct hist_field               *synth_var_refs[SYNTH_FIELDS_MAX];
-	unsigned int                    n_synth_var_refs;
 	struct field_var		*field_vars[SYNTH_FIELDS_MAX];
 	unsigned int			n_field_vars;
 	unsigned int			n_field_var_str;
@@ -3602,20 +3600,6 @@ static void save_field_var(struct hist_trigger_data *hist_data,
 }
 
 
-static void destroy_synth_var_refs(struct hist_trigger_data *hist_data)
-{
-	unsigned int i;
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++)
-		destroy_hist_field(hist_data->synth_var_refs[i], 0);
-}
-
-static void save_synth_var_ref(struct hist_trigger_data *hist_data,
-			 struct hist_field *var_ref)
-{
-	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-}
-
 static int check_synth_field(struct synth_event *event,
 			     struct hist_field *hist_field,
 			     unsigned int field_pos)
@@ -3775,7 +3759,6 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 				goto err;
 			}
 
-			save_synth_var_ref(hist_data, var_ref);
 			field_pos++;
 			kfree(p);
 			continue;
@@ -4519,7 +4502,6 @@ static void destroy_hist_data(struct hist_trigger_data *hist_data)
 	destroy_actions(hist_data);
 	destroy_field_vars(hist_data);
 	destroy_field_var_hists(hist_data);
-	destroy_synth_var_refs(hist_data);
 
 	kfree(hist_data);
 }
-- 
2.14.1
