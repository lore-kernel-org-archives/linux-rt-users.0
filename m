Return-Path: <SRS0=WXxn=SE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC9FC4360F
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C468208E4
	for <linux-rt-users@archiver.kernel.org>; Tue,  2 Apr 2019 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfDBSfJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfDBSe4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Apr 2019 14:34:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787B521473;
        Tue,  2 Apr 2019 18:34:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBOFJ-0008K3-J1; Tue, 02 Apr 2019 14:34:53 -0400
Message-Id: <20190402183453.489168467@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 02 Apr 2019 14:29:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC][PATCH 2/3] tracing: Have histogram code pass around trace_array for error
 handling
References: <20190402182951.130809543@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Have the trace_array that associates the trace instance of the histogram
passed around to functions so that error handling can display the error
message in the proper instance.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 142 +++++++++++++++++--------------
 1 file changed, 80 insertions(+), 62 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 071c62cacba7..49d373792721 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -619,7 +619,7 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, "hist:%s:%s", system, name);
 }
 
-static void hist_err(u8 err_type, u8 err_pos)
+static void hist_err(struct trace_array *tr, u8 err_type, u8 err_pos)
 {
 	tracing_log_err(last_cmd_loc, last_cmd, err_text, err_type, err_pos);
 }
@@ -1756,7 +1756,7 @@ static struct trace_event_file *find_var_file(struct trace_array *tr,
 
 		if (find_var_field(var_hist_data, var_name)) {
 			if (found) {
-				hist_err(HIST_ERR_VAR_NOT_UNIQUE, errpos(var_name));
+				hist_err(tr, HIST_ERR_VAR_NOT_UNIQUE, errpos(var_name));
 				return NULL;
 			}
 
@@ -1807,7 +1807,8 @@ find_match_var(struct hist_trigger_data *hist_data, char *var_name)
 			hist_field = find_file_var(file, var_name);
 			if (hist_field) {
 				if (found) {
-					hist_err(HIST_ERR_VAR_NOT_UNIQUE, errpos(var_name));
+					hist_err(tr, HIST_ERR_VAR_NOT_UNIQUE,
+						 errpos(var_name));
 					return ERR_PTR(-EINVAL);
 				}
 
@@ -2042,7 +2043,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	return ret;
 }
 
-static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
+static int parse_assignment(struct trace_array *tr,
+			    char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
@@ -2098,7 +2100,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 		char *assignment;
 
 		if (attrs->n_assignments == TRACING_MAP_VARS_MAX) {
-			hist_err(HIST_ERR_TOO_MANY_VARS, errpos(str));
+			hist_err(tr, HIST_ERR_TOO_MANY_VARS, errpos(str));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -2115,7 +2117,8 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 	return ret;
 }
 
-static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
+static struct hist_trigger_attrs *
+parse_hist_trigger_attrs(struct trace_array *tr, char *trigger_str)
 {
 	struct hist_trigger_attrs *attrs;
 	int ret = 0;
@@ -2128,7 +2131,7 @@ static struct hist_trigger_attrs *parse_hist_trigger_attrs(char *trigger_str)
 		char *str = strsep(&trigger_str, ":");
 
 		if (strchr(str, '=')) {
-			ret = parse_assignment(str, attrs);
+			ret = parse_assignment(tr, str, attrs);
 			if (ret)
 				goto free;
 		} else if (strcmp(str, "pause") == 0)
@@ -2684,6 +2687,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 					char *var_name)
 {
 	struct hist_field *var_field = NULL, *ref_field = NULL;
+	struct trace_array *tr = hist_data->event_file->tr;
 
 	if (!is_var_ref(var_name))
 		return NULL;
@@ -2696,7 +2700,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 					   system, event_name);
 
 	if (!ref_field)
-		hist_err(HIST_ERR_VAR_NOT_FOUND, errpos(var_name));
+		hist_err(tr, HIST_ERR_VAR_NOT_FOUND, errpos(var_name));
 
 	return ref_field;
 }
@@ -2707,6 +2711,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 {
 	struct ftrace_event_field *field = NULL;
 	char *field_name, *modifier, *str;
+	struct trace_array *tr = file->tr;
 
 	modifier = str = kstrdup(field_str, GFP_KERNEL);
 	if (!modifier)
@@ -2730,7 +2735,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
 		else {
-			hist_err(HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
+			hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2746,7 +2751,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
-			hist_err(HIST_ERR_FIELD_NOT_FOUND, errpos(field_name));
+			hist_err(tr, HIST_ERR_FIELD_NOT_FOUND, errpos(field_name));
 			field = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -2808,7 +2813,8 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 
 	s = local_field_var_ref(hist_data, ref_system, ref_event, ref_var);
 	if (!s) {
-		hist_field = parse_var_ref(hist_data, ref_system, ref_event, ref_var);
+		hist_field = parse_var_ref(hist_data, ref_system,
+					   ref_event, ref_var);
 		if (hist_field) {
 			if (var_name) {
 				hist_field = create_alias(hist_data, hist_field, var_name);
@@ -2857,7 +2863,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	/* we support only -(xxx) i.e. explicit parens required */
 
 	if (level > 3) {
-		hist_err(HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
+		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
 		ret = -EINVAL;
 		goto free;
 	}
@@ -2912,7 +2918,8 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	return ERR_PTR(ret);
 }
 
-static int check_expr_operands(struct hist_field *operand1,
+static int check_expr_operands(struct trace_array *tr,
+			       struct hist_field *operand1,
 			       struct hist_field *operand2)
 {
 	unsigned long operand1_flags = operand1->flags;
@@ -2940,7 +2947,7 @@ static int check_expr_operands(struct hist_field *operand1,
 
 	if ((operand1_flags & HIST_FIELD_FL_TIMESTAMP_USECS) !=
 	    (operand2_flags & HIST_FIELD_FL_TIMESTAMP_USECS)) {
-		hist_err(HIST_ERR_TIMESTAMP_MISMATCH, 0);
+		hist_err(tr, HIST_ERR_TIMESTAMP_MISMATCH, 0);
 		return -EINVAL;
 	}
 
@@ -2958,7 +2965,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	char *sep, *operand1_str;
 
 	if (level > 3) {
-		hist_err(HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
+		hist_err(file->tr, HIST_ERR_TOO_MANY_SUBEXPR, errpos(str));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3003,7 +3010,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	ret = check_expr_operands(operand1, operand2);
+	ret = check_expr_operands(file->tr, operand1, operand2);
 	if (ret)
 		goto free;
 
@@ -3196,14 +3203,14 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
-		hist_err(HIST_ERR_TOO_MANY_FIELD_VARS, errpos(field_name));
+		hist_err(tr, HIST_ERR_TOO_MANY_FIELD_VARS, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
 	file = event_file(tr, subsys_name, event_name);
 
 	if (IS_ERR(file)) {
-		hist_err(HIST_ERR_EVENT_FILE_NOT_FOUND, errpos(field_name));
+		hist_err(tr, HIST_ERR_EVENT_FILE_NOT_FOUND, errpos(field_name));
 		ret = PTR_ERR(file);
 		return ERR_PTR(ret);
 	}
@@ -3216,7 +3223,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	 */
 	hist_data = find_compatible_hist(target_hist_data, file);
 	if (!hist_data) {
-		hist_err(HIST_ERR_HIST_NOT_FOUND, errpos(field_name));
+		hist_err(tr, HIST_ERR_HIST_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3277,7 +3284,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		kfree(cmd);
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err(HIST_ERR_HIST_CREATE_FAIL, errpos(field_name));
+		hist_err(tr, HIST_ERR_HIST_CREATE_FAIL, errpos(field_name));
 		return ERR_PTR(ret);
 	}
 
@@ -3289,7 +3296,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	if (IS_ERR_OR_NULL(event_var)) {
 		kfree(var_hist->cmd);
 		kfree(var_hist);
-		hist_err(HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
+		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3422,25 +3429,26 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 {
 	struct hist_field *val = NULL, *var = NULL;
 	unsigned long flags = HIST_FIELD_FL_VAR;
+	struct trace_array *tr = file->tr;
 	struct field_var *field_var;
 	int ret = 0;
 
 	if (hist_data->n_field_vars >= SYNTH_FIELDS_MAX) {
-		hist_err(HIST_ERR_TOO_MANY_FIELD_VARS, errpos(field_name));
+		hist_err(tr, HIST_ERR_TOO_MANY_FIELD_VARS, errpos(field_name));
 		ret = -EINVAL;
 		goto err;
 	}
 
 	val = parse_atom(hist_data, file, field_name, &flags, NULL);
 	if (IS_ERR(val)) {
-		hist_err(HIST_ERR_FIELD_VAR_PARSE_FAIL, errpos(field_name));
+		hist_err(tr, HIST_ERR_FIELD_VAR_PARSE_FAIL, errpos(field_name));
 		ret = PTR_ERR(val);
 		goto err;
 	}
 
 	var = create_var(hist_data, file, field_name, val->size, val->type);
 	if (IS_ERR(var)) {
-		hist_err(HIST_ERR_VAR_CREATE_FIND_FAIL, errpos(field_name));
+		hist_err(tr, HIST_ERR_VAR_CREATE_FIND_FAIL, errpos(field_name));
 		kfree(val);
 		ret = PTR_ERR(var);
 		goto err;
@@ -3767,19 +3775,20 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 {
 	struct hist_field *var_field, *ref_field, *track_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
+	struct trace_array *tr = file->tr;
 	char *track_data_var_str;
 	int ret = 0;
 
 	track_data_var_str = data->track_data.var_str;
 	if (track_data_var_str[0] != '$') {
-		hist_err(HIST_ERR_ONX_NOT_VAR, errpos(track_data_var_str));
+		hist_err(tr, HIST_ERR_ONX_NOT_VAR, errpos(track_data_var_str));
 		return -EINVAL;
 	}
 	track_data_var_str++;
 
 	var_field = find_target_event_var(hist_data, NULL, NULL, track_data_var_str);
 	if (!var_field) {
-		hist_err(HIST_ERR_ONX_VAR_NOT_FOUND, errpos(track_data_var_str));
+		hist_err(tr, HIST_ERR_ONX_VAR_NOT_FOUND, errpos(track_data_var_str));
 		return -EINVAL;
 	}
 
@@ -3792,7 +3801,7 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	if (data->handler == HANDLER_ONMAX)
 		track_var = create_var(hist_data, file, "__max", sizeof(u64), "u64");
 	if (IS_ERR(track_var)) {
-		hist_err(HIST_ERR_ONX_VAR_CREATE_FAIL, 0);
+		hist_err(tr, HIST_ERR_ONX_VAR_CREATE_FAIL, 0);
 		ret = PTR_ERR(track_var);
 		goto out;
 	}
@@ -3800,7 +3809,7 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	if (data->handler == HANDLER_ONCHANGE)
 		track_var = create_var(hist_data, file, "__change", sizeof(u64), "u64");
 	if (IS_ERR(track_var)) {
-		hist_err(HIST_ERR_ONX_VAR_CREATE_FAIL, 0);
+		hist_err(tr, HIST_ERR_ONX_VAR_CREATE_FAIL, 0);
 		ret = PTR_ERR(track_var);
 		goto out;
 	}
@@ -3811,7 +3820,8 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	return ret;
 }
 
-static int parse_action_params(char *params, struct action_data *data)
+static int parse_action_params(struct trace_array *tr, char *params,
+			       struct action_data *data)
 {
 	char *param, *saved_param;
 	bool first_param = true;
@@ -3819,20 +3829,20 @@ static int parse_action_params(char *params, struct action_data *data)
 
 	while (params) {
 		if (data->n_params >= SYNTH_FIELDS_MAX) {
-			hist_err(HIST_ERR_TOO_MANY_PARAMS, 0);
+			hist_err(tr, HIST_ERR_TOO_MANY_PARAMS, 0);
 			goto out;
 		}
 
 		param = strsep(&params, ",");
 		if (!param) {
-			hist_err(HIST_ERR_PARAM_NOT_FOUND, 0);
+			hist_err(tr, HIST_ERR_PARAM_NOT_FOUND, 0);
 			ret = -EINVAL;
 			goto out;
 		}
 
 		param = strstrip(param);
 		if (strlen(param) < 2) {
-			hist_err(HIST_ERR_INVALID_PARAM, errpos(param));
+			hist_err(tr, HIST_ERR_INVALID_PARAM, errpos(param));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3856,7 +3866,7 @@ static int parse_action_params(char *params, struct action_data *data)
 	return ret;
 }
 
-static int action_parse(char *str, struct action_data *data,
+static int action_parse(struct trace_array *tr, char *str, struct action_data *data,
 			enum handler_id handler)
 {
 	char *action_name;
@@ -3864,14 +3874,14 @@ static int action_parse(char *str, struct action_data *data,
 
 	strsep(&str, ".");
 	if (!str) {
-		hist_err(HIST_ERR_ACTION_NOT_FOUND, 0);
+		hist_err(tr, HIST_ERR_ACTION_NOT_FOUND, 0);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	action_name = strsep(&str, "(");
 	if (!action_name || !str) {
-		hist_err(HIST_ERR_ACTION_NOT_FOUND, 0);
+		hist_err(tr, HIST_ERR_ACTION_NOT_FOUND, 0);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3880,12 +3890,12 @@ static int action_parse(char *str, struct action_data *data,
 		char *params = strsep(&str, ")");
 
 		if (!params) {
-			hist_err(HIST_ERR_NO_SAVE_PARAMS, 0);
+			hist_err(tr, HIST_ERR_NO_SAVE_PARAMS, 0);
 			ret = -EINVAL;
 			goto out;
 		}
 
-		ret = parse_action_params(params, data);
+		ret = parse_action_params(tr, params, data);
 		if (ret)
 			goto out;
 
@@ -3894,7 +3904,7 @@ static int action_parse(char *str, struct action_data *data,
 		else if (handler == HANDLER_ONCHANGE)
 			data->track_data.check_val = check_track_val_changed;
 		else {
-			hist_err(HIST_ERR_ACTION_MISMATCH, errpos(action_name));
+			hist_err(tr, HIST_ERR_ACTION_MISMATCH, errpos(action_name));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3906,7 +3916,7 @@ static int action_parse(char *str, struct action_data *data,
 		char *params = strsep(&str, ")");
 
 		if (!str) {
-			hist_err(HIST_ERR_NO_CLOSING_PAREN, errpos(params));
+			hist_err(tr, HIST_ERR_NO_CLOSING_PAREN, errpos(params));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3916,7 +3926,7 @@ static int action_parse(char *str, struct action_data *data,
 		else if (handler == HANDLER_ONCHANGE)
 			data->track_data.check_val = check_track_val_changed;
 		else {
-			hist_err(HIST_ERR_ACTION_MISMATCH, errpos(action_name));
+			hist_err(tr, HIST_ERR_ACTION_MISMATCH, errpos(action_name));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3931,7 +3941,7 @@ static int action_parse(char *str, struct action_data *data,
 			data->use_trace_keyword = true;
 
 		if (params) {
-			ret = parse_action_params(params, data);
+			ret = parse_action_params(tr, params, data);
 			if (ret)
 				goto out;
 		}
@@ -3984,7 +3994,7 @@ static struct action_data *track_data_parse(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	ret = action_parse(str, data, handler);
+	ret = action_parse(hist_data->event_file->tr, str, data, handler);
 	if (ret)
 		goto free;
  out:
@@ -4054,6 +4064,7 @@ trace_action_find_var(struct hist_trigger_data *hist_data,
 		      struct action_data *data,
 		      char *system, char *event, char *var)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_field *hist_field;
 
 	var++; /* skip '$' */
@@ -4069,7 +4080,7 @@ trace_action_find_var(struct hist_trigger_data *hist_data,
 	}
 
 	if (!hist_field)
-		hist_err(HIST_ERR_PARAM_NOT_FOUND, errpos(var));
+		hist_err(tr, HIST_ERR_PARAM_NOT_FOUND, errpos(var));
 
 	return hist_field;
 }
@@ -4127,6 +4138,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 static int trace_action_create(struct hist_trigger_data *hist_data,
 			       struct action_data *data)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	char *event_name, *param, *system = NULL;
 	struct hist_field *hist_field, *var_ref;
 	unsigned int i, var_ref_idx;
@@ -4144,7 +4156,7 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 
 	event = find_synth_event(synth_event_name);
 	if (!event) {
-		hist_err(HIST_ERR_SYNTH_EVENT_NOT_FOUND, errpos(synth_event_name));
+		hist_err(tr, HIST_ERR_SYNTH_EVENT_NOT_FOUND, errpos(synth_event_name));
 		return -EINVAL;
 	}
 
@@ -4205,14 +4217,14 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 			continue;
 		}
 
-		hist_err(HIST_ERR_SYNTH_TYPE_MISMATCH, errpos(param));
+		hist_err(tr, HIST_ERR_SYNTH_TYPE_MISMATCH, errpos(param));
 		kfree(p);
 		ret = -EINVAL;
 		goto err;
 	}
 
 	if (field_pos != event->n_fields) {
-		hist_err(HIST_ERR_SYNTH_COUNT_MISMATCH, errpos(event->name));
+		hist_err(tr, HIST_ERR_SYNTH_COUNT_MISMATCH, errpos(event->name));
 		ret = -EINVAL;
 		goto err;
 	}
@@ -4231,6 +4243,7 @@ static int action_create(struct hist_trigger_data *hist_data,
 			 struct action_data *data)
 {
 	struct trace_event_file *file = hist_data->event_file;
+	struct trace_array *tr = file->tr;
 	struct track_data *track_data;
 	struct field_var *field_var;
 	unsigned int i;
@@ -4258,7 +4271,7 @@ static int action_create(struct hist_trigger_data *hist_data,
 	if (data->action == ACTION_SAVE) {
 		if (hist_data->n_save_vars) {
 			ret = -EEXIST;
-			hist_err(HIST_ERR_TOO_MANY_SAVE_ACTIONS, 0);
+			hist_err(tr, HIST_ERR_TOO_MANY_SAVE_ACTIONS, 0);
 			goto out;
 		}
 
@@ -4271,7 +4284,8 @@ static int action_create(struct hist_trigger_data *hist_data,
 
 			field_var = create_target_field_var(hist_data, NULL, NULL, param);
 			if (IS_ERR(field_var)) {
-				hist_err(HIST_ERR_FIELD_VAR_CREATE_FAIL, errpos(param));
+				hist_err(tr, HIST_ERR_FIELD_VAR_CREATE_FAIL,
+					 errpos(param));
 				ret = PTR_ERR(field_var);
 				kfree(param);
 				goto out;
@@ -4305,18 +4319,18 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 
 	match_event = strsep(&str, ")");
 	if (!match_event || !str) {
-		hist_err(HIST_ERR_NO_CLOSING_PAREN, errpos(match_event));
+		hist_err(tr, HIST_ERR_NO_CLOSING_PAREN, errpos(match_event));
 		goto free;
 	}
 
 	match_event_system = strsep(&match_event, ".");
 	if (!match_event) {
-		hist_err(HIST_ERR_SUBSYS_NOT_FOUND, errpos(match_event_system));
+		hist_err(tr, HIST_ERR_SUBSYS_NOT_FOUND, errpos(match_event_system));
 		goto free;
 	}
 
 	if (IS_ERR(event_file(tr, match_event_system, match_event))) {
-		hist_err(HIST_ERR_INVALID_SUBSYS_EVENT, errpos(match_event));
+		hist_err(tr, HIST_ERR_INVALID_SUBSYS_EVENT, errpos(match_event));
 		goto free;
 	}
 
@@ -4332,7 +4346,7 @@ static struct action_data *onmatch_parse(struct trace_array *tr, char *str)
 		goto free;
 	}
 
-	ret = action_parse(str, data, HANDLER_ONMATCH);
+	ret = action_parse(tr, str, data, HANDLER_ONMATCH);
 	if (ret)
 		goto free;
  out:
@@ -4401,13 +4415,14 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 			    struct trace_event_file *file,
 			    char *var_name, char *expr_str)
 {
+	struct trace_array *tr = hist_data->event_file->tr; 
 	unsigned long flags = 0;
 
 	if (WARN_ON(val_idx >= TRACING_MAP_VALS_MAX + TRACING_MAP_VARS_MAX))
 		return -EINVAL;
 
 	if (find_var(hist_data, file, var_name) && !hist_data->remove) {
-		hist_err(HIST_ERR_DUPLICATE_VAR, errpos(var_name));
+		hist_err(tr, HIST_ERR_DUPLICATE_VAR, errpos(var_name));
 		return -EINVAL;
 	}
 
@@ -4464,8 +4479,8 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			    struct trace_event_file *file,
 			    char *field_str)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	struct hist_field *hist_field = NULL;
-
 	unsigned long flags = 0;
 	unsigned int key_size;
 	int ret = 0;
@@ -4488,7 +4503,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 		}
 
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-			hist_err(HIST_ERR_INVALID_REF_KEY, errpos(field_str));
+			hist_err(tr, HIST_ERR_INVALID_REF_KEY, errpos(field_str));
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
 			goto out;
@@ -4589,6 +4604,7 @@ static void free_var_defs(struct hist_trigger_data *hist_data)
 
 static int parse_var_defs(struct hist_trigger_data *hist_data)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	char *s, *str, *var_name, *field_str;
 	unsigned int i, j, n_vars = 0;
 	int ret = 0;
@@ -4602,13 +4618,14 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 
 			var_name = strsep(&field_str, "=");
 			if (!var_name || !field_str) {
-				hist_err(HIST_ERR_MALFORMED_ASSIGNMENT, errpos(var_name));
+				hist_err(tr, HIST_ERR_MALFORMED_ASSIGNMENT,
+					 errpos(var_name));
 				ret = -EINVAL;
 				goto free;
 			}
 
 			if (n_vars == TRACING_MAP_VARS_MAX) {
-				hist_err(HIST_ERR_TOO_MANY_VARS, errpos(var_name));
+				hist_err(tr, HIST_ERR_TOO_MANY_VARS, errpos(var_name));
 				ret = -EINVAL;
 				goto free;
 			}
@@ -5829,6 +5846,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 {
 	struct hist_trigger_data *hist_data = data->private_data;
 	struct event_trigger_data *test, *named_data = NULL;
+	struct trace_array *tr = file->tr;
 	int ret = 0;
 
 	if (hist_data->attrs->name) {
@@ -5836,7 +5854,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		if (named_data) {
 			if (!hist_trigger_match(data, named_data, named_data,
 						true)) {
-				hist_err(HIST_ERR_NAMED_MISMATCH, errpos(hist_data->attrs->name));
+				hist_err(tr, HIST_ERR_NAMED_MISMATCH, errpos(hist_data->attrs->name));
 				ret = -EINVAL;
 				goto out;
 			}
@@ -5857,7 +5875,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 			else if (hist_data->attrs->clear)
 				hist_clear(test);
 			else {
-				hist_err(HIST_ERR_TRIGGER_EEXIST, 0);
+				hist_err(tr, HIST_ERR_TRIGGER_EEXIST, 0);
 				ret = -EEXIST;
 			}
 			goto out;
@@ -5865,7 +5883,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 	}
  new:
 	if (hist_data->attrs->cont || hist_data->attrs->clear) {
-		hist_err(HIST_ERR_TRIGGER_ENOENT_CLEAR, 0);
+		hist_err(tr, HIST_ERR_TRIGGER_ENOENT_CLEAR, 0);
 		ret = -ENOENT;
 		goto out;
 	}
@@ -5890,7 +5908,7 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 
 		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
 		if (ret) {
-			hist_err(HIST_ERR_SET_CLOCK_FAIL, errpos(clock));
+			hist_err(tr, HIST_ERR_SET_CLOCK_FAIL, errpos(clock));
 			goto out;
 		}
 
@@ -6108,7 +6126,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		trigger = strstrip(trigger);
 	}
 
-	attrs = parse_hist_trigger_attrs(trigger);
+	attrs = parse_hist_trigger_attrs(file->tr, trigger);
 	if (IS_ERR(attrs))
 		return PTR_ERR(attrs);
 
-- 
2.20.1


