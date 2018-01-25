From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.14.15-rt12
Date: Thu, 25 Jan 2018 16:17:06 +0100
Message-ID: <20180125151706.v6pgbeixt2jfpph2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.15-rt12 patch set. 

Changes since v4.14.15-rt11:

  - Drop ping-sysrq. Since it won't reach mainline in its current shape,
    lets drop. Suggested by Carsten Emde.

  - Tom Zanussi's "tracing: Inter-event (e.g. latency) support" patch
    has been updated to v9.
  
Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.15-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.15-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.15-rt12

The RT patch against v4.14.15 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.15-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.15-rt12.tar.xz

Sebastian

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 934563e4dbb8..7b9035c01a2e 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -77,18 +77,6 @@ On all
 
 		echo t > /proc/sysrq-trigger
 
-On all
-        Enable network SysRq by writing a cookie to icmp_echo_sysrq, e.g.::
-
-                echo 0x01020304 >/proc/sys/net/ipv4/icmp_echo_sysrq
-
-        Send an ICMP echo request with this pattern plus the particular
-        SysRq command key. Example::
-
-                ping -c1 -s57 -p0102030468
-
-        will trigger the SysRq-H (help) command.
-
 What are the 'command' keys?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 93164a31ec51..8fcff2837484 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -79,7 +79,6 @@ struct netns_ipv4 {
 
 	int sysctl_icmp_echo_ignore_all;
 	int sysctl_icmp_echo_ignore_broadcasts;
-	int sysctl_icmp_echo_sysrq;
 	int sysctl_icmp_ignore_bogus_error_responses;
 	int sysctl_icmp_ratelimit;
 	int sysctl_icmp_ratemask;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8a00d4da91f2..e47b56632367 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1108,7 +1108,7 @@ static int release_all_synth_events(void)
 {
 	struct list_head release_events;
 	struct synth_event *event, *e;
-	int ret = 0, err = 0;
+	int ret = 0;
 
 	INIT_LIST_HEAD(&release_events);
 
@@ -1121,8 +1121,7 @@ static int release_all_synth_events(void)
 		}
 	}
 
-	list_for_each_entry_safe(event, e, &synth_event_list, list)
-		list_move(&event->list, &release_events);
+	list_splice_init(&event->list, &release_events);
 
 	mutex_unlock(&synth_event_mutex);
 
@@ -1133,9 +1132,6 @@ static int release_all_synth_events(void)
 		add_or_delete_synth_event(event, !ret);
 	}
 
-	if (err)
-		ret = err;
-
 	return ret;
 }
 
@@ -1267,7 +1263,7 @@ check_field_for_var_refs(struct hist_trigger_data *hist_data,
 	struct hist_field *found = NULL;
 	unsigned int i;
 
-	if (level > 2)
+	if (level > 3)
 		return found;
 
 	if (!hist_field)
@@ -1373,7 +1369,7 @@ static bool field_has_hist_vars(struct hist_field *hist_field,
 {
 	int i;
 
-	if (level > 2)
+	if (level > 3)
 		return false;
 
 	if (!hist_field)
@@ -2040,6 +2036,23 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 	return flags_str;
 }
 
+static void expr_field_str(struct hist_field *field, char *expr)
+{
+	if (field->flags & HIST_FIELD_FL_VAR_REF)
+		strcat(expr, "$");
+
+	strcat(expr, hist_field_name(field, 0));
+
+	if (field->flags) {
+		const char *flags_str = get_hist_field_flags(field);
+
+		if (flags_str) {
+			strcat(expr, ".");
+			strcat(expr, flags_str);
+		}
+	}
+}
+
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
 	char *expr;
@@ -2051,6 +2064,11 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	if (!expr)
 		return NULL;
 
+	if (!field->operands[0]) {
+		expr_field_str(field, expr);
+		return expr;
+	}
+
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
 		char *subexpr;
 
@@ -2068,17 +2086,7 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 		return expr;
 	}
 
-	if (field->operands[0]->flags & HIST_FIELD_FL_VAR_REF)
-		strcat(expr, "$");
-	strcat(expr, hist_field_name(field->operands[0], 0));
-	if (field->operands[0]->flags) {
-		const char *flags_str = get_hist_field_flags(field->operands[0]);
-
-		if (flags_str) {
-			strcat(expr, ".");
-			strcat(expr, flags_str);
-		}
-	}
+	expr_field_str(field->operands[0], expr);
 
 	switch (field->operator) {
 	case FIELD_OP_MINUS:
@@ -2092,17 +2100,7 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 		return NULL;
 	}
 
-	if (field->operands[1]->flags & HIST_FIELD_FL_VAR_REF)
-		strcat(expr, "$");
-	strcat(expr, hist_field_name(field->operands[1], 0));
-	if (field->operands[1]->flags) {
-		const char *flags_str = get_hist_field_flags(field->operands[1]);
-
-		if (flags_str) {
-			strcat(expr, ".");
-			strcat(expr, flags_str);
-		}
-	}
+	expr_field_str(field->operands[1], expr);
 
 	return expr;
 }
@@ -2138,7 +2136,7 @@ static void destroy_hist_field(struct hist_field *hist_field,
 {
 	unsigned int i;
 
-	if (level > 2)
+	if (level > 3)
 		return;
 
 	if (!hist_field)
@@ -2290,6 +2288,8 @@ static int init_var_ref(struct hist_field *ref_field,
 	ref_field->var.hist_data = var_field->hist_data;
 	ref_field->size = var_field->size;
 	ref_field->is_signed = var_field->is_signed;
+	ref_field->flags |= var_field->flags &
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
 
 	if (system) {
 		ref_field->system = kstrdup(system, GFP_KERNEL);
@@ -2305,10 +2305,18 @@ static int init_var_ref(struct hist_field *ref_field,
 		}
 	}
 
-	ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
-	if (!ref_field->name) {
-		err = -ENOMEM;
-		goto free;
+	if (var_field->var.name) {
+		ref_field->name = kstrdup(var_field->var.name, GFP_KERNEL);
+		if (!ref_field->name) {
+			err = -ENOMEM;
+			goto free;
+		}
+	} else if (var_field->name) {
+		ref_field->name = kstrdup(var_field->name, GFP_KERNEL);
+		if (!ref_field->name) {
+			err = -ENOMEM;
+			goto free;
+		}
 	}
 
 	ref_field->type = kstrdup(var_field->type, GFP_KERNEL);
@@ -2496,9 +2504,9 @@ static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
 	return alias;
 }
 
-struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
-			      struct trace_event_file *file, char *str,
-			      unsigned long *flags, char *var_name)
+static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
+				     struct trace_event_file *file, char *str,
+				     unsigned long *flags, char *var_name)
 {
 	char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
 	struct ftrace_event_field *field = NULL;
@@ -2575,7 +2583,8 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 
 	// we support only -(xxx) i.e. explicit parens required
 
-	if (level > 2) {
+	if (level > 3) {
+		hist_err("Too many subexpressions (3 max): ", str);
 		ret = -EINVAL;
 		goto free;
 	}
@@ -2590,7 +2599,7 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	s = strchr(str, ')');
+	s = strrchr(str, ')');
 	if (s)
 		*s = '\0';
 	else {
@@ -2598,12 +2607,6 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
-	strsep(&str, "(");
-	if (!str) {
-		ret = -EINVAL;
-		goto free;
-	}
-
 	flags |= HIST_FIELD_FL_EXPR;
 	expr = create_hist_field(hist_data, NULL, flags, var_name);
 	if (!expr) {
@@ -2618,6 +2621,8 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		goto free;
 	}
 
+	expr->flags |= operand1->flags &
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
 	expr->fn = hist_field_unary_minus;
 	expr->operands[0] = operand1;
 	expr->operator = FIELD_OP_UNARY_MINUS;
@@ -2679,8 +2684,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 	int field_op, ret = -EINVAL;
 	char *sep, *operand1_str;
 
-	if (level > 2)
+	if (level > 3) {
+		hist_err("Too many subexpressions (3 max): ", str);
 		return ERR_PTR(-EINVAL);
+	}
 
 	field_op = contains_operator(str);
 
@@ -2728,6 +2735,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		goto free;
 
 	flags |= HIST_FIELD_FL_EXPR;
+
+	flags |= operand1->flags &
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+
 	expr = create_hist_field(hist_data, NULL, flags, var_name);
 	if (!expr) {
 		ret = -ENOMEM;
diff --git a/localversion-rt b/localversion-rt
index 05c35cb58077..6e44e540b927 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 574d2a3c86a0..0310ea93f877 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -69,7 +69,6 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/fcntl.h>
-#include <linux/sysrq.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/inet.h>
@@ -924,30 +923,6 @@ static bool icmp_redirect(struct sk_buff *skb)
 	return true;
 }
 
-/*
- * 32bit and 64bit have different timestamp length, so we check for
- * the cookie at offset 20 and verify it is repeated at offset 50
- */
-#define CO_POS0		20
-#define CO_POS1		50
-#define CO_SIZE		sizeof(int)
-#define ICMP_SYSRQ_SIZE	57
-
-/*
- * We got a ICMP_SYSRQ_SIZE sized ping request. Check for the cookie
- * pattern and if it matches send the next byte as a trigger to sysrq.
- */
-static void icmp_check_sysrq(struct net *net, struct sk_buff *skb)
-{
-	int cookie = htonl(net->ipv4.sysctl_icmp_echo_sysrq);
-	char *p = skb->data;
-
-	if (!memcmp(&cookie, p + CO_POS0, CO_SIZE) &&
-	    !memcmp(&cookie, p + CO_POS1, CO_SIZE) &&
-	    p[CO_POS0 + CO_SIZE] == p[CO_POS1 + CO_SIZE])
-		handle_sysrq(p[CO_POS0 + CO_SIZE]);
-}
-
 /*
  *	Handle ICMP_ECHO ("ping") requests.
  *
@@ -975,11 +950,6 @@ static bool icmp_echo(struct sk_buff *skb)
 		icmp_param.data_len	   = skb->len;
 		icmp_param.head_len	   = sizeof(struct icmphdr);
 		icmp_reply(&icmp_param, skb);
-
-		if (skb->len == ICMP_SYSRQ_SIZE &&
-		    net->ipv4.sysctl_icmp_echo_sysrq) {
-			icmp_check_sysrq(net, skb);
-		}
 	}
 	/* should there be an ICMP stat for ignored echos? */
 	return true;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 747ba53a8100..0989e739d098 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -771,13 +771,6 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
-	{
-		.procname	= "icmp_echo_sysrq",
-		.data		= &init_net.ipv4.sysctl_icmp_echo_sysrq,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
 	{
 		.procname	= "icmp_ignore_bogus_error_responses",
 		.data		= &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
