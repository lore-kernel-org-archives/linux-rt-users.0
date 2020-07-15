Return-Path: <SRS0=VnrO=A2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CA3C433E1
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jul 2020 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C85520657
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jul 2020 19:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGOTgf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgGOTgf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jul 2020 15:36:35 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC1820657;
        Wed, 15 Jul 2020 19:36:34 +0000 (UTC)
Date:   Wed, 15 Jul 2020 15:36:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Itai Handler <itai.handler@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: aarch64 boot time increases with rt
Message-ID: <20200715153632.3f9dc5d3@oasis.local.home>
In-Reply-To: <CAFpOueRmBfzhPFb-q_pB1xpCQq4Cuo7rCCsc2eUPsGdaei-+3A@mail.gmail.com>
References: <CAFpOueS0rvys4Q81D3HEYX2U1vM808qQ4w+z6QxCWi1KJBGXXQ@mail.gmail.com>
 <20200713212054.2e675557@oasis.local.home>
 <CAFpOueRmBfzhPFb-q_pB1xpCQq4Cuo7rCCsc2eUPsGdaei-+3A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 14 Jul 2020 15:18:01 +0300
Itai Handler <itai.handler@gmail.com> wrote:

> Hi Steven,
> 
> On Tue, Jul 14, 2020 at 4:20 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > You mean compared to non PREEMPT_RT_FULL of the same kernel?  
> 
> Yes.
> 
> > I'd suggest trying 5.4 or even 5.6-rt.  
> 
> I tried 5.4.47-rt28, and the problem still persists.
> 
> > Well, you could try: ftrace=function_graph ftrace_graph_filter workqueue_prepare_cpu
> >
> > If workqueue_prepare_cpu is a traceable function (not inlined nor notrace set).  
> 
> I tried "ftrace=function_graph ftrace_graph_filter=workqueue_prepare_cpu",
> however, the trace appears to be empty.
> The function workqueue_prepare_cpu is not defined inline nor notrace.
> 
> Please see log below:
> # mount -t debugfs none /sys/kernel/debug
> # cd /sys/kernel/debug/tracing/
> # cat trace
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
> # cat set_graph_function
> workqueue_prepare_cpu
> # cat tracing_on
> 1
> 
> Do you have any idea why it's empty?

To rule out that this may be an issue with the function_graph tracer,
can you also try it with:

 ftrace=function ftrace_filter=worqueue_prepare_cpu

And see if the function tracer shows anything.

/me just looked at the code.

Yes, the function tracer is set up to trace really early, but the
function_graph tracer is initialized by core_initcall(), which is much
later.

Perhaps try this patch (note, it's from latest mainline):

And retry the function_graph tracer.

-- Steve


diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4aab712f9567..35bcac3edcee 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9475,6 +9475,7 @@ __init static int tracer_alloc_buffers(void)
 
 	/* Function tracing may start here (via kernel command line) */
 	init_function_trace();
+	init_graph_trace();
 
 	/* All seems OK, enable tracing */
 	tracing_disabled = 0;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f21607f87189..d861bd34dfb6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1129,6 +1129,11 @@ void ftrace_init_tracefs_toplevel(struct trace_array *tr,
 void ftrace_clear_pids(struct trace_array *tr);
 int init_function_trace(void);
 void ftrace_pid_follow_fork(struct trace_array *tr, bool enable);
+# ifdef CONFIG_FUNCTION_GRAPH_TRACER
+int init_graph_trace(void);
+# else
+static inline int init_graph_trace(void) { return 0; }
+# endif
 #else
 static inline int ftrace_trace_task(struct trace_array *tr)
 {
@@ -1149,6 +1154,7 @@ static inline void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d)
 static inline void ftrace_init_tracefs_toplevel(struct trace_array *tr, struct dentry *d) { }
 static inline void ftrace_clear_pids(struct trace_array *tr) { }
 static inline int init_function_trace(void) { return 0; }
+static inline int init_graph_trace(void) { return 0; }
 static inline void ftrace_pid_follow_fork(struct trace_array *tr, bool enable) { }
 /* ftace_func_t type is not defined, use macro instead of static inline */
 #define ftrace_init_array_ops(tr, func) do { } while (0)
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 4a9c49c08ec9..e18cc90585fb 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1349,7 +1349,7 @@ static __init int init_graph_tracefs(void)
 }
 fs_initcall(init_graph_tracefs);
 
-static __init int init_graph_trace(void)
+__init int init_graph_trace(void)
 {
 	max_bytes_for_cpu = snprintf(NULL, 0, "%u", nr_cpu_ids - 1);
 
@@ -1365,5 +1365,3 @@ static __init int init_graph_trace(void)
 
 	return register_tracer(&graph_trace);
 }
-
-core_initcall(init_graph_trace);
