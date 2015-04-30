From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFD 3/5] tracing: Add option to quantize key values
Date: Thu, 30 Apr 2015 12:06:23 +0200
Message-ID: <1430388385-29558-4-git-send-email-daniel.wagner@bmw-carit.de>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:49352 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751508AbbD3KGa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2015 06:06:30 -0400
In-Reply-To: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Let's group some values together. This avoids a too detailed
histogram. Some sort of logarythmic scale could be useful
for latency plots.

Now we can write something like:

'hist:key=latency.bucket:val=hitcount:sort=latency'

latency:          0 hitcount:     166440
latency:        256 hitcount:      21104
latency:        512 hitcount:       7754
latency:        768 hitcount:       3269
latency:       1024 hitcount:       1647
latency:       1280 hitcount:        841
latency:       1536 hitcount:        524
latency:       1792 hitcount:        371
latency:       2048 hitcount:        302
latency:       2304 hitcount:        240
latency:       2560 hitcount:        207
latency:       2816 hitcount:        149
latency:       3072 hitcount:        123
latency:       3328 hitcount:        119
latency:       3584 hitcount:        102
latency:       3840 hitcount:         94
latency:       4096 hitcount:         89
latency:       4352 hitcount:         79
latency:       4608 hitcount:         88

One thing I struggled with the grammatic above is that I haven't found
a nice way to pass in arguments, for example the bucket size. There a lot
of options to do it. Just a couple random ideas, not necessarly consistent
or clever:

'hist:key=latency.bucket[10,1.5]:val=hitcount:sort=latency'
   where [x,y]: x first bucket size, y scaling factor

'hist:key=latency:val=hitcount:sort=latency:bucket=latency,10,1.5'

Not for inclusion!

Not-Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 kernel/trace/trace_events_hist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fe06707..cac94a6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -84,6 +84,7 @@ enum hist_field_flags {
 	HIST_FIELD_STRING	= 8,
 	HIST_FIELD_EXECNAME	= 16,
 	HIST_FIELD_SYSCALL	= 32,
+	HIST_FIELD_BUCKET	= 64,
 };
 
 struct hist_trigger_sort_key {
@@ -400,6 +401,8 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 				flags |= HIST_FIELD_EXECNAME;
 			else if (!strcmp(field_str, "syscall"))
 				flags |= HIST_FIELD_SYSCALL;
+			else if (!strcmp(field_str, "bucket"))
+				flags |= HIST_FIELD_BUCKET;
 		}
 
 		field = trace_find_event_field(file->event_call, field_name);
@@ -900,6 +903,9 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec)
 		key = entries;
 	} else {
 		field_contents = hist_data->key->fn(hist_data->key, rec);
+		if (hist_data->key->flags & HIST_FIELD_BUCKET)
+			field_contents &= ~0xff;
+
 		if (hist_data->key->flags & HIST_FIELD_STRING)
 			key = (void *)field_contents;
 		else
@@ -1343,6 +1349,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "hex";
 	else if (hist_field->flags & HIST_FIELD_SYSCALL)
 		flags_str = "syscall";
+	else if (hist_field->flags & HIST_FIELD_BUCKET)
+		flags_str = "bucket";
 	else if (hist_field->flags & HIST_FIELD_EXECNAME)
 		flags_str = "execname";
 
-- 
2.1.0

