From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFD 5/5] tracing: Add trace_irqsoff tracepoints
Date: Mon, 04 May 2015 17:41:45 +0200
Message-ID: <55479339.6080707@monom.org>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>	<1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>	<1430446492.17922.32.camel@picadillo> <20150430225411.37cbb7cc@grimm.local.home> <55434624.6060109@monom.org> <55477C98.3020909@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>, Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38368 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbbEDPlt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 May 2015 11:41:49 -0400
Received: by wiun10 with SMTP id n10so114614807wiu.1
        for <linux-rt-users@vger.kernel.org>; Mon, 04 May 2015 08:41:47 -0700 (PDT)
In-Reply-To: <55477C98.3020909@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/04/2015 04:05 PM, Daniel Wagner wrote:
> On 05/01/2015 11:23 AM, Daniel Wagner wrote:
>> On 05/01/2015 02:54 AM, Steven Rostedt wrote:
>>> On Thu, 30 Apr 2015 21:14:52 -0500
>>> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
>>>
>>>
>>>>> 'hist:key=latency.bucket:val=hitcount:sort=latency if cpu==0'
>>>>>
>>>>> but I haven't got this working. I didn't spend much time figuring out
>>>>> why this doesn't work. Even if the above is working you still
>>>>
>>>> I think it doesn't work because the tracepoint doesn't actually have a
>>>> 'cpu' field to use in the filter...
>>>
>>> Perhaps we should add special fields that don't use the tracepoint
>>> field, but can use generically know fields that are always known when
>>> the tracepoint is triggered. COMM could be one, as well as CPU.

Here my second attempt.

Changes v0:
  - Added COMM filter predicate
  - Avoid API break in format by introducing a new list for
    generic fields



>From 10a58dcc9157ef29514b237aa5d5d8412365a389 Mon Sep 17 00:00:00 2001
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Mon, 4 May 2015 15:44:24 +0200
Subject: [PATCH] tracing: Allow triggers to filter for CPUs and COMM

By extending the filter rules by more generic fields
we can write triggers filters like

  echo 'stacktrace if cpu == 1' > \
	/sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger

or

  echo 'stacktrace if comm == sshd'  > \
	/sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger

We don't want to change the API for the format files. Therefore a new
list (ftrace_generic_fields) is introduced and by this we avoid
getting them listed.

Not for inclusion!

Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 kernel/trace/trace_events.c        | 25 ++++++++++++++++++
 kernel/trace/trace_events_filter.c | 54 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c4de47f..805cb75 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -30,6 +30,7 @@
 DEFINE_MUTEX(event_mutex);
 
 LIST_HEAD(ftrace_events);
+static LIST_HEAD(ftrace_generic_fields);
 static LIST_HEAD(ftrace_common_fields);
 
 #define GFP_TRACE (GFP_KERNEL | __GFP_ZERO)
@@ -94,6 +95,10 @@ trace_find_event_field(struct ftrace_event_call *call, char *name)
 	struct ftrace_event_field *field;
 	struct list_head *head;
 
+	field = __find_event_field(&ftrace_generic_fields, name);
+	if (field)
+		return field;
+
 	field = __find_event_field(&ftrace_common_fields, name);
 	if (field)
 		return field;
@@ -144,6 +149,13 @@ int trace_define_field(struct ftrace_event_call *call, const char *type,
 }
 EXPORT_SYMBOL_GPL(trace_define_field);
 
+#define __generic_field(type, item, filter_type)			\
+	ret = __trace_define_field(&ftrace_generic_fields, #type,	\
+				   #item, 0, 0, is_signed_type(type),	\
+				   filter_type);			\
+	if (ret)							\
+		return ret;
+
 #define __common_field(type, item)					\
 	ret = __trace_define_field(&ftrace_common_fields, #type,	\
 				   "common_" #item,			\
@@ -153,6 +165,16 @@ EXPORT_SYMBOL_GPL(trace_define_field);
 	if (ret)							\
 		return ret;
 
+static int trace_define_generic_fields(void)
+{
+	int ret;
+
+	__generic_field(int, cpu, FILTER_OTHER);
+	__generic_field(char *, comm, FILTER_PTR_STRING);
+
+	return ret;
+}
+
 static int trace_define_common_fields(void)
 {
 	int ret;
@@ -2671,6 +2693,9 @@ static __init int event_trace_init(void)
 	if (!entry)
 		pr_warn("Could not create tracefs 'available_events' entry\n");
 
+	if (trace_define_generic_fields())
+		pr_warn("tracing: Failed to allocated generic fields");
+
 	if (trace_define_common_fields())
 		pr_warn("tracing: Failed to allocate common fields");
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index ced69da..74feaf4 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -252,6 +252,50 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
 	return match;
 }
 
+/* Filter predicate for CPUs. */
+static int filter_pred_cpu(struct filter_pred *pred, void *event)
+{
+	int cpu, cmp;
+	int match = 0;
+
+	cpu = raw_smp_processor_id();
+	cmp = pred->val;
+
+	switch (pred->op) {
+	case OP_EQ:
+		match = cpu == cmp;
+		break;
+	case OP_LT:
+		match = cpu < cmp;
+		break;
+	case OP_LE:
+		match = cpu <= cmp;
+		break;
+	case OP_GT:
+		match = cpu > cmp;
+		break;
+	case OP_GE:
+		match = cpu >= cmp;
+		break;
+	default:
+		break;
+	}
+
+	return !!match == !pred->not;
+}
+
+/* Filter predicate for COMM. */
+static int filter_pred_comm(struct filter_pred *pred, void *event)
+{
+	int cmp, match;
+
+	cmp = pred->regex.match(current->comm, &pred->regex,
+				pred->regex.field_len);
+	match = cmp ^ pred->not;
+
+	return match;
+}
+
 static int filter_pred_none(struct filter_pred *pred, void *event)
 {
 	return 0;
@@ -1002,7 +1046,10 @@ static int init_pred(struct filter_parse_state *ps,
 	if (is_string_field(field)) {
 		filter_build_regex(pred);
 
-		if (field->filter_type == FILTER_STATIC_STRING) {
+		if (!strcmp(field->name, "comm")) {
+			fn = filter_pred_comm;
+			pred->regex.field_len = TASK_COMM_LEN;
+		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			fn = filter_pred_string;
 			pred->regex.field_len = field->size;
 		} else if (field->filter_type == FILTER_DYN_STRING)
@@ -1025,7 +1072,10 @@ static int init_pred(struct filter_parse_state *ps,
 		}
 		pred->val = val;
 
-		fn = select_comparison_fn(pred->op, field->size,
+		if (!strcmp(field->name, "cpu"))
+			fn = filter_pred_cpu;
+		else
+			fn = select_comparison_fn(pred->op, field->size,
 					  field->is_signed);
 		if (!fn) {
 			parse_error(ps, FILT_ERR_INVALID_OP, 0);
-- 
2.1.0



