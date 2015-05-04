From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFD 5/5] tracing: Add trace_irqsoff tracepoints
Date: Mon, 4 May 2015 16:05:12 +0200
Message-ID: <55477C98.3020909@bmw-carit.de>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>	<1430388385-29558-6-git-send-email-daniel.wagner@bmw-carit.de>	<1430446492.17922.32.camel@picadillo> <20150430225411.37cbb7cc@grimm.local.home> <55434624.6060109@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>, Carsten Emde <C.Emde@osadl.org>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: Daniel Wagner <wagi@monom.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52395 "EHLO
	mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbbEDOFR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 May 2015 10:05:17 -0400
In-Reply-To: <55434624.6060109@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/01/2015 11:23 AM, Daniel Wagner wrote:
> On 05/01/2015 02:54 AM, Steven Rostedt wrote:
>> On Thu, 30 Apr 2015 21:14:52 -0500
>> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
>>
>>
>>>> 'hist:key=latency.bucket:val=hitcount:sort=latency if cpu==0'
>>>>
>>>> but I haven't got this working. I didn't spend much time figuring out
>>>> why this doesn't work. Even if the above is working you still
>>>
>>> I think it doesn't work because the tracepoint doesn't actually have a
>>> 'cpu' field to use in the filter...
>>
>> Perhaps we should add special fields that don't use the tracepoint
>> field, but can use generically know fields that are always known when
>> the tracepoint is triggered. COMM could be one, as well as CPU.

Here a first attempt:

>From fcd910836179dd738b3300dbf93a30f352e90996 Mon Sep 17 00:00:00 2001
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Mon, 4 May 2015 15:44:24 +0200
Subject: [PATCH] tracing: Allow triggers to filter for CPUs

By extending the filter rules by more 'generically know' fields
we can write triggers filters like

'stacktrace:5 if cpu == 1'

We add a new element to ftrace_common_fields which describes
the new 'generically know' field. This change is visiable to user space.
E.g. the format file changes for kmem:kmalloc changes to

name: kmalloc
ID: 395
format:
        field:int cpu;  offset:0;       size:0; signed:1;
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:unsigned long call_site;  offset:8;       size:8; signed:0;
        field:const void * ptr; offset:16;      size:8; signed:0;
        field:size_t bytes_req; offset:24;      size:8; signed:0;
        field:size_t bytes_alloc;       offset:32;      size:8; signed:0;
        field:gfp_t gfp_flags;  offset:40;      size:4; signed:0;

I think that is not complete correct since the field cpu doesn't
really exists in trace event entry. Propably moving those known fields
their own list is a way to overcome this problem. What do you think?

And yes, I am still marveling on this comment

  /* If not of not match is equal to not of not, then it is a match */

from DEFINE_COMPARISON_PRED. This led me to copy it for
filter_pred_cpu() :)

Not for inclusion!

Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 kernel/trace/trace_events.c        |  8 ++++++++
 kernel/trace/trace_events_filter.c | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c4de47f..3f51f2b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -144,6 +144,13 @@ int trace_define_field(struct ftrace_event_call *call, const char *type,
 }
 EXPORT_SYMBOL_GPL(trace_define_field);
 
+#define __trace_field(type, item)					\
+	ret = __trace_define_field(&ftrace_common_fields, #type,	\
+				   #item, 0, 0, is_signed_type(type),	\
+				   FILTER_OTHER);			\
+	if (ret)							\
+		return ret;
+
 #define __common_field(type, item)					\
 	ret = __trace_define_field(&ftrace_common_fields, #type,	\
 				   "common_" #item,			\
@@ -158,6 +165,7 @@ static int trace_define_common_fields(void)
 	int ret;
 	struct trace_entry ent;
 
+	__trace_field(int, cpu);
 	__common_field(unsigned short, type);
 	__common_field(unsigned char, flags);
 	__common_field(unsigned char, preempt_count);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index ced69da..af2a6bb 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -252,6 +252,38 @@ static int filter_pred_strloc(struct filter_pred *pred, void *event)
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
 static int filter_pred_none(struct filter_pred *pred, void *event)
 {
 	return 0;
@@ -1025,7 +1057,10 @@ static int init_pred(struct filter_parse_state *ps,
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

