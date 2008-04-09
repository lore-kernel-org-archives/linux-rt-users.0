From: Ankita Garg <ankita@in.ibm.com>
Subject: [PATCH] Fix conversion of task state to char in latency tracer
Date: Wed, 9 Apr 2008 23:46:31 +0530
Message-ID: <20080409181631.GB7764@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	Chirag Jog <chirag@linux.vnet.ibm.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP02.au.ibm.com ([202.81.18.163]:40389 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167AbYDISQh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Apr 2008 14:16:37 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m39IGca9008202
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Apr 2008 04:16:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m39IKQ1l210636
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Apr 2008 04:20:26 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m39IGXo1001660
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Apr 2008 04:16:34 +1000
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

The conversion of task states to a character in the sched_switch tracer (part
of latency tracer infrastructure), seems to be incorrect. We currently do it
by indexing into the state_to_char array using the state value. The state
values do not map directly into the array index and are thus incorrect. The
following patch addresses this issue. This is also what is being done even
in the show_task() routine in kernel/sched.c

The patch has been compile and run tested.

Signed-off-by: Ankita Garg <ankita@in.ibm.com> 

Index: linux-2.6.24.3/kernel/trace/trace.c
===================================================================
--- linux-2.6.24.3.orig/kernel/trace/trace.c	2008-04-09 15:30:54.000000000 +0530
+++ linux-2.6.24.3/kernel/trace/trace.c	2008-04-09 23:37:03.000000000 +0530
@@ -1086,6 +1086,7 @@
 	char *comm;
 	unsigned long nr;
 	int S;
+	unsigned state;
 
 	if (!next_entry)
 		next_entry = entry;
@@ -1114,8 +1115,8 @@
 		seq_puts(m, ")\n");
 		break;
 	case TRACE_CTX:
-		S = entry->ctx.prev_state < sizeof(state_to_char) ?
-			state_to_char[entry->ctx.prev_state] : 'X';
+		state = entry->ctx.prev_state ? __ffs(entry->ctx.prev_state) + 1 : 0;
+		S = state < sizeof(state_to_char) - 1 ? state_to_char[state] : 'X';
 		comm = trace_find_cmdline(entry->ctx.next_pid);
 		seq_printf(m, " %d:%d:%c --> %d:%d %s\n",
 			   entry->ctx.prev_pid,


-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
