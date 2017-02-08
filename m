From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [RFC][PATCH 02/21] tracing: Reimplement log2
Date: Wed,  8 Feb 2017 11:24:58 -0600
Message-ID: <b247aa8251fe3d92695d63ec974d82f80ee4e711.1486569306.git.tom.zanussi@linux.intel.com>
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

log2 as currently implemented applies only to u64 trace_event_field
derived fields, and assumes that anything it's applied to is a u64
field.

To prepare for synthetic fields like latencies, log2 should be
applicable to those as well, so take the opportunity now to fix the
current problems as well as expand to more general uses.

log2 should be thought of as a chaining function rather than a field
type.  To enable this as well as possible future function
implementations, add a hist_field operand array into the hist_field
definition for this purpose, and make use of it to implement the log2
'function'.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 37347d7..afd766a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -27,12 +27,16 @@
 
 typedef u64 (*hist_field_fn_t) (struct hist_field *field, void *event);
 
+#define HIST_FIELD_OPERANDS_MAX	2
+
 struct hist_field {
 	struct ftrace_event_field	*field;
 	unsigned long			flags;
 	hist_field_fn_t			fn;
 	unsigned int			size;
 	unsigned int			offset;
+	unsigned int                    is_signed;
+	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 };
 
 static u64 hist_field_none(struct hist_field *field, void *event)
@@ -70,7 +74,9 @@ static u64 hist_field_pstring(struct hist_field *hist_field, void *event)
 
 static u64 hist_field_log2(struct hist_field *hist_field, void *event)
 {
-	u64 val = *(u64 *)(event + hist_field->field->offset);
+	struct hist_field *operand = hist_field->operands[0];
+
+	u64 val = operand->fn(operand, event);
 
 	return (u64) ilog2(roundup_pow_of_two(val));
 }
@@ -151,6 +157,8 @@ static const char *hist_field_name(struct hist_field *field)
 
 	if (field->field)
 		field_name = field->field->name;
+	else if (field->flags & HIST_FIELD_FL_LOG2)
+		field_name = hist_field_name(field->operands[0]);
 
 	return field_name;
 }
@@ -351,6 +359,14 @@ static void hist_trigger_elt_comm_init(struct tracing_map_elt *elt)
 
 static void destroy_hist_field(struct hist_field *hist_field)
 {
+	unsigned int i;
+
+	if (!hist_field)
+		return;
+
+	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
+		destroy_hist_field(hist_field->operands[i]);
+
 	kfree(hist_field);
 }
 
@@ -377,7 +393,10 @@ static struct hist_field *create_hist_field(struct ftrace_event_field *field,
 	}
 
 	if (flags & HIST_FIELD_FL_LOG2) {
+		unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
 		hist_field->fn = hist_field_log2;
+		hist_field->operands[0] = create_hist_field(field, fl);
+		hist_field->size = hist_field->operands[0]->size;
 		goto out;
 	}
 
-- 
1.9.3
