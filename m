From: Ankita Garg <ankita@in.ibm.com>
Subject: [PATCH] Disable tracing when current_tracer is set to "none"
Date: Mon, 9 Jun 2008 14:10:25 +0530
Message-ID: <20080609084025.GC7796@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3]:50142 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYFIIlE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jun 2008 04:41:04 -0400
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m598exWU006999
	for <linux-rt-users@vger.kernel.org>; Mon, 9 Jun 2008 14:10:59 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m598eLBo815130
	for <linux-rt-users@vger.kernel.org>; Mon, 9 Jun 2008 14:10:21 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m598ewMK003226
	for <linux-rt-users@vger.kernel.org>; Mon, 9 Jun 2008 14:10:58 +0530
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Found that inspite of setting the current_tracer to "none", trace from
the previous trace type continued to be collected. The patch below fixes
this and causes the trace to be disabled when the "none" type is
selected.

Compile and boot tested the patch for functionality.

Signed-off-by: Ankita Garg <ankita@in.ibm.com> 

Index: linux-2.6.25.4-rt6/kernel/trace/trace.c
===================================================================
--- linux-2.6.25.4-rt6.orig/kernel/trace/trace.c	2008-06-08 11:14:51.000000000 -0700
+++ linux-2.6.25.4-rt6/kernel/trace/trace.c	2008-06-09 01:10:57.000000000 -0700
@@ -46,11 +46,6 @@
 #define for_each_tracing_cpu(cpu)	\
 	for_each_cpu_mask_nr(cpu, tracing_buffer_mask)
 
-/* dummy trace to disable tracing */
-static struct tracer no_tracer __read_mostly = {
-	.name		= "none",
-};
-
 static int trace_alloc_page(void);
 static int trace_free_page(void);
 
@@ -139,6 +134,23 @@
 /* trace_flags holds iter_ctrl options */
 unsigned long trace_flags = TRACE_ITER_PRINT_PARENT;
 
+static notrace void no_trace_init(struct trace_array *tr)
+{
+	int cpu;
+
+	if(tr->ctrl)
+		for_each_online_cpu(cpu)
+			tracing_reset(tr->data[cpu]);
+	tracer_enabled = 0;
+}
+
+/* dummy trace to disable tracing */
+static struct tracer no_tracer __read_mostly = {
+	.name		= "none",
+	.init		= no_trace_init
+};
+
+
 /**
  * trace_wake_up - wake up tasks waiting for trace input
  *

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
