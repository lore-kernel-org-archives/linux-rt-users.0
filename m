Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628727B51A;
	Thu,  5 Jun 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152454; cv=none; b=AhY3wL1sdDIfb6nFpFTP121XtzDnwY1W7ROgaZoZ0/QiloN5OdH1d9zQbtMWBqnisZlAYOa3drZPmU+JRAU3IAsoOKM3CCx+9cM/JUgt+nkGMPV86tRy4tEHqytlVXT+LQDDxPDcPwNpDCWgf8xx5mqLgkLpc2NLXz0EC7sHCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152454; c=relaxed/simple;
	bh=2mvx1X71WrvMYxe/XtqyJo1Be/It7Ye//vfBMzBgXqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2knsqMxWHWErBd2dHlTkL2YPJU6RNIzucvPPbO5j0G7+VzokqFvCXh6ruKkvNDBMjPJ478LeHc3VyYxuuwLzzEsGgXfPPN3XhhxkkInzKR4rXNujG7obQDT3ASUP2gcgnV4bpeIzXy8w+fLUVdJ0vy8xCuffF6c5Ii0Mxp8Nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B838B100999;
	Thu,  5 Jun 2025 19:40:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 87DC52000E;
	Thu,  5 Jun 2025 19:40:23 +0000 (UTC)
Date: Thu, 5 Jun 2025 15:41:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Flot, Julien" <julien.flot@siemens.com>
Cc: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>, "Ziegler, Andreas"
 <ziegler.andreas@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>
Subject: Re: ftrace regression with PREEMPT_RT kernels
Message-ID: <20250605154141.5b496e2c@gandalf.local.home>
In-Reply-To: <20250605105050.219a4a1c@gandalf.local.home>
References: <240017f656631c7dd4017aa93d91f41f653788ea.camel@siemens.com>
 <20250605082846.179bca96@gandalf.local.home>
 <5f721932e0bbf880d2817498e35b54eabb167d98.camel@siemens.com>
 <20250605105050.219a4a1c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 87DC52000E
X-Stat-Signature: fwmznnr3kpgsix9yntzz9gqty89mcr98
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XCSfPbdO6EAG6bi+7NFMe+E2dijRN0d0=
X-HE-Tag: 1749152423-213065
X-HE-Meta: U2FsdGVkX1/mWpnyohkAkvMJKqq8P/OiHbXDwXf12k+Ov2zoOtDdwxAHkUp3kAxSWFawuBVgB9qERd+FxdkRzprvE+3jtPdCtzgdsHVrr4q7/CaWSHp1qIKDdGHtSmMP8+O/dxkahsl16BccpJ2hKctNpMPO9A/rUeH+f995OCQiMb4mIUN1cpRTAYevduX3kk30dtKY/bY2ZniYJkeKfiXkOGkV8OnEYwCgC5dhXF+yOEJdulLkj/A0Gl/QFlXTodRgV6QLx4AdFAZC5XaICvubFWgyjL4RVWDMImTWXjtmSUG9vKpP+MN6SWcioR8UB0FsSUk8HWVdcs3lcUBCyYnB2rxol6E8vyHBLvZw9sGO4iEmqmACZ6hkAqdOre5WTmOFIFPFuKyMnb+4/FjuPQ==

On Thu, 5 Jun 2025 10:50:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 5 Jun 2025 14:41:43 +0000
> "Flot, Julien" <julien.flot@siemens.com> wrote:
> 
> 
> > I have tried the patch, I am afraid it does not help. I have roughly
> > the same results as in previous versions.  
> 
> Bah, there's three more places that call
> tracepoint_synchronize_unregister() :-p
> 
> Let me try to get rid of those too.

So I decided to enable PREEMPT_RT and yes, I can reproduce this too.

I ran the following:

  # trace-cmd sqlhist -e -n sched_stack  select start.prev_state as state, end.next_comm as comm, TIMESTAMP_DELTA_USECS as delta,  start.STACKTRACE as stack from sched_switch as start join sched_switch as end on start.prev_pid = end.next_pid

The above creates a synthetic event that creates a stack trace when a task
schedules out and records it with the time it scheduled back in. Basically
the time a task is off the CPU. It also records the state of the task when
it left the CPU (running, blocked, sleeping, etc). It also saves the comm
of the task as "comm" (needed for the next command).

  # echo 'hist:keys=state,stack.stacktrace:vals=delta:sort=state,delta if comm == "trace-cmd" &&  state & 3' > /sys/kernel/tracing/events/synthetic/sched_stack/trigger

The above creates a histogram with buckets per state, per stack, and the
value of the total time it was off the CPU for that stack trace. It filters
on tasks with "comm == trace-cmd" and only the sleeping and blocked states
(1 - sleeping, 2 - blocked).

  # trace-cmd record -p function sleep 1

  # cat /sys/kernel/tracing/events/synthetic/sched_stack/hist | tail -50
         path_openat+0x1a36/0x2990
         do_filp_open+0x1c5/0x420
         do_sys_openat2+0xed/0x180
         __x64_sys_openat+0x108/0x1d0
         do_syscall_64+0x7b/0x420
} hitcount:          2  delta:      74781
{ state:          2, stack.stacktrace         __schedule+0x1545/0x3700
         schedule+0xe2/0x390
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_tasks_generic+0x151/0x230
         apply_subsystem_event_filter+0x77c/0x1300
         subsystem_filter_write+0x67/0xc0
         vfs_write+0x1e2/0xeb0
         ksys_write+0xff/0x1d0
         do_syscall_64+0x7b/0x420
         entry_SYSCALL_64_after_hwframe+0x76/0x7e
} hitcount:          1  delta:     210957
{ state:          2, stack.stacktrace         __schedule+0x1545/0x3700
         schedule+0xe2/0x390
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_normal+0x3db/0x5c0
         apply_subsystem_event_filter+0xa30/0x1300
         subsystem_filter_write+0x67/0xc0
         vfs_write+0x1e2/0xeb0
         ksys_write+0xff/0x1d0
         do_syscall_64+0x7b/0x420
         entry_SYSCALL_64_after_hwframe+0x76/0x7e
} hitcount:        237  delta:    6316500
{ state:          2, stack.stacktrace         __schedule+0x1545/0x3700
         schedule+0xe2/0x390
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_tasks_generic+0x151/0x230
         apply_subsystem_event_filter+0xa2b/0x1300
         subsystem_filter_write+0x67/0xc0
         vfs_write+0x1e2/0xeb0
         ksys_write+0xff/0x1d0
         do_syscall_64+0x7b/0x420
         entry_SYSCALL_64_after_hwframe+0x76/0x7e
} hitcount:        237  delta:   99756288  <<--------------- Delta is 99 seconds!

Totals:
    Hits: 525
    Entries: 21
    Dropped: 0


This shows that it is definitely waiting on the synchronize_rcu_tasks() but
I see that it's called by apply_subsystem_event_filter() which I didn't
cover. But I looked at all the tracepoint_synchronize_unregister() in the
trace_events_filter.c code and replaced them with a double call_rcu_task/rcu().

This appears to fix the issue. With that, trace-cmd record is much faster
and the histogram now looks like this:

~# cat /sys/kernel/tracing/events/synthetic/sched_stack/hist | tail -50
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_normal+0x3db/0x5c0
         ring_buffer_reset_online_cpus+0x142/0x350
         tracing_reset_online_cpus+0x14b/0x1e0
         tracing_open+0x335/0x440
         do_dentry_open+0x4c6/0x17a0
         vfs_open+0x82/0x360
         path_openat+0x1a36/0x2990
         do_filp_open+0x1c5/0x420
         do_sys_openat2+0xed/0x180
         __x64_sys_openat+0x108/0x1d0
} hitcount:          2  delta:      61260
{ state:          2, stack.stacktrace         __schedule+0x1545/0x3700
         schedule+0xe2/0x390
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_normal+0x3db/0x5c0
         ring_buffer_reset_online_cpus+0x142/0x350
         tracing_reset_online_cpus+0x14b/0x1e0
         tracing_set_tracer+0x4d5/0xa80
         tracing_set_trace_write+0x138/0x1e0
         vfs_write+0x1e2/0xeb0
         ksys_write+0xff/0x1d0
         do_syscall_64+0x7b/0x420
         entry_SYSCALL_64_after_hwframe+0x76/0x7e
} hitcount:          2  delta:      61699
{ state:          2, stack.stacktrace         __schedule+0x1545/0x3700
         schedule+0xe2/0x390
         schedule_timeout+0x175/0x200
         wait_for_completion_state+0x294/0x440
         __wait_rcu_gp+0x247/0x4f0
         synchronize_rcu_normal+0x3db/0x5c0
         tracing_reset_online_cpus+0x8f/0x1e0
         tracing_open+0x335/0x440
         do_dentry_open+0x4c6/0x17a0
         vfs_open+0x82/0x360
         path_openat+0x1a36/0x2990
         do_filp_open+0x1c5/0x420
         do_sys_openat2+0xed/0x180
         __x64_sys_openat+0x108/0x1d0
         do_syscall_64+0x7b/0x420
} hitcount:          2  delta:      77044

Totals:
    Hits: 55
    Entries: 28
    Dropped: 0


With the max delta wait time of just 77 milliseconds total.

-- Steve

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2048560264bb..3ff782d6b522 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1335,6 +1335,74 @@ static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
 	}
 }
 
+struct filter_list {
+	struct list_head	list;
+	struct event_filter	*filter;
+};
+
+struct filter_head {
+	struct list_head	list;
+	struct rcu_head		rcu;
+};
+
+
+static void free_filter_list(struct rcu_head *rhp)
+{
+	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
+	struct filter_list *filter_item, *tmp;
+
+	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
+		__free_filter(filter_item->filter);
+		list_del(&filter_item->list);
+		kfree(filter_item);
+	}
+	kfree(filter_list);
+}
+
+static void free_filter_list_tasks(struct rcu_head *rhp)
+{
+	call_rcu(rhp, free_filter_list);
+}
+
+/*
+ * The tracepoint_synchronize_unregister() is a double rcu call.
+ * It calls synchronize_rcu_tasks_trace() followed by synchronize_rcu().
+ * Instead of waiting for it, simply call these via the call_rcu*()
+ * variants.
+ */
+static void delay_free_filter(struct filter_head *head)
+{
+	call_rcu_tasks_trace(&head->rcu, free_filter_list_tasks);
+}
+
+static void try_delay_free_filter(struct event_filter *filter)
+{
+	struct filter_head *head;
+	struct filter_list *item;
+
+	head = kmalloc(sizeof(*head), GFP_KERNEL);
+	if (!head)
+		goto free_now;
+
+	INIT_LIST_HEAD(&head->list);
+
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item) {
+		kfree(head);
+		goto free_now;
+	}
+
+	item->filter = filter;
+	list_add_tail(&item->list, &head->list);
+	delay_free_filter(head);
+	return;
+
+ free_now:
+	/* Make sure the filter is not being used */
+	tracepoint_synchronize_unregister();
+	__free_filter(filter);
+}
+
 static inline void __free_subsystem_filter(struct trace_event_file *file)
 {
 	__free_filter(file->filter);
@@ -1342,15 +1410,53 @@ static inline void __free_subsystem_filter(struct trace_event_file *file)
 }
 
 static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
-					  struct trace_array *tr)
+					  struct trace_array *tr,
+					  struct event_filter *filter)
 {
 	struct trace_event_file *file;
+	struct filter_head *head;
+	struct filter_list *item;
+
+	head = kmalloc(sizeof(*head), GFP_KERNEL);
+	if (!head)
+		goto free_now;
+
+	INIT_LIST_HEAD(&head->list);
+
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item) {
+		kfree(head);
+		goto free_now;
+	}
+
+	item->filter = filter;
+	list_add_tail(&item->list, &head->list);
 
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir)
 			continue;
-		__free_subsystem_filter(file);
+		item = kmalloc(sizeof(*item), GFP_KERNEL);
+		if (!item)
+			goto free_now;
+		item->filter = file->filter;
+		list_add_tail(&item->list, &head->list);
+		file->filter = NULL;
+	}
+
+	delay_free_filter(head);
+	return;
+ free_now:
+	tracepoint_synchronize_unregister();
+
+	if (head)
+		free_filter_list(&head->rcu);
+
+	list_for_each_entry(file, &tr->events, list) {
+		if (file->system != dir || !file->filter)
+			continue;
+		__free_filter(file->filter);
 	}
+	__free_filter(filter);
 }
 
 int filter_assign_type(const char *type)
@@ -2131,11 +2237,6 @@ static inline void event_clear_filter(struct trace_event_file *file)
 	RCU_INIT_POINTER(file->filter, NULL);
 }
 
-struct filter_list {
-	struct list_head	list;
-	struct event_filter	*filter;
-};
-
 static int process_system_preds(struct trace_subsystem_dir *dir,
 				struct trace_array *tr,
 				struct filter_parse_error *pe,
@@ -2144,11 +2245,16 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	struct trace_event_file *file;
 	struct filter_list *filter_item;
 	struct event_filter *filter = NULL;
-	struct filter_list *tmp;
-	LIST_HEAD(filter_list);
+	struct filter_head *filter_list;
 	bool fail = true;
 	int err;
 
+	filter_list = kmalloc(sizeof(*filter_list), GFP_KERNEL);
+	if (!filter_list)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&filter_list->list);
+
 	list_for_each_entry(file, &tr->events, list) {
 
 		if (file->system != dir)
@@ -2175,7 +2281,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter_item)
 			goto fail_mem;
 
-		list_add_tail(&filter_item->list, &filter_list);
+		list_add_tail(&filter_item->list, &filter_list->list);
 		/*
 		 * Regardless of if this returned an error, we still
 		 * replace the filter for the call.
@@ -2195,31 +2301,22 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	 * Do a synchronize_rcu() and to ensure all calls are
 	 * done with them before we free them.
 	 */
-	tracepoint_synchronize_unregister();
-	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
-		__free_filter(filter_item->filter);
-		list_del(&filter_item->list);
-		kfree(filter_item);
-	}
+	delay_free_filter(filter_list);
 	return 0;
  fail:
 	/* No call succeeded */
-	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
-		list_del(&filter_item->list);
-		kfree(filter_item);
-	}
+	free_filter_list(&filter_list->rcu);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
 	__free_filter(filter);
+
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
-		tracepoint_synchronize_unregister();
-	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
-		__free_filter(filter_item->filter);
-		list_del(&filter_item->list);
-		kfree(filter_item);
-	}
+		delay_free_filter(filter_list);
+	else
+		free_filter_list(&filter_list->rcu);
+
 	return -ENOMEM;
 }
 
@@ -2361,9 +2458,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 
 		event_clear_filter(file);
 
-		/* Make sure the filter is not being used */
-		tracepoint_synchronize_unregister();
-		__free_filter(filter);
+		try_delay_free_filter(filter);
 
 		return 0;
 	}
@@ -2387,11 +2482,8 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 
 		event_set_filter(file, filter);
 
-		if (tmp) {
-			/* Make sure the call is done with the filter */
-			tracepoint_synchronize_unregister();
-			__free_filter(tmp);
-		}
+		if (tmp)
+			try_delay_free_filter(tmp);
 	}
 
 	return err;
@@ -2417,9 +2509,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		filter = system->filter;
 		system->filter = NULL;
 		/* Ensure all filters are no longer used */
-		tracepoint_synchronize_unregister();
-		filter_free_subsystem_filters(dir, tr);
-		__free_filter(filter);
+		filter_free_subsystem_filters(dir, tr, filter);
 		return 0;
 	}
 
