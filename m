Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EF21B908;
	Thu,  5 Jun 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128692; cv=none; b=fQ7xx583i1Pbp3M3Q4uiFsErcP554vqM1BjjW1eKWAueoEuKP7jf4U3RqlHST8RRoLMj0tLZJdhu0u6VMy2A5JpJ4SY6LT3EUxOVKwaVTLqDoMvLrNAsD4ksUzN7GM8ps6VqMp5jB0UxXfvs2cZ82XPHfTu1955vDCgHDujs048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128692; c=relaxed/simple;
	bh=Vywb4OV7+GVPOKUqzBtNd9nYZ3QnmvpPSGbxjZAstmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJoFycfuXobY2HFFiL0ajZ1b0pWr6slTvyzOCv3u3GEbeYaOB8OI3WDbF4czpBd0SmWXht7KADyh2ido0erq6zylfX2647XeLiDRqh6zY2xOfZlYEz9qOQuZcWGfStTT2cpLuKLqPVVcjhpwOYpLmIIpiXncSvOh293hZg450ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 7DC00EDC39;
	Thu,  5 Jun 2025 12:27:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 7D8FD20024;
	Thu,  5 Jun 2025 12:27:28 +0000 (UTC)
Date: Thu, 5 Jun 2025 08:28:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Flot, Julien" <julien.flot@siemens.com>
Cc: "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>, "Ziegler, Andreas"
 <ziegler.andreas@siemens.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: ftrace regression with PREEMPT_RT kernels
Message-ID: <20250605082846.179bca96@gandalf.local.home>
In-Reply-To: <240017f656631c7dd4017aa93d91f41f653788ea.camel@siemens.com>
References: <240017f656631c7dd4017aa93d91f41f653788ea.camel@siemens.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iswsogkcqrej7xca85r9wo8i86zw3jo9
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7D8FD20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+7gBsEBuAeFxoo9YWzEKdSnN6yM0MPk70=
X-HE-Tag: 1749126448-266228
X-HE-Meta: U2FsdGVkX182EKI9a7rWWpDD8J/6T4G3+7/NbtFIdjIdi60zL3cjdschd/1cNbhAlVXYYfcnJvH4y+3nlLnmo1HDmis/R1sZraBbweldN0zxaY/MI/ctBhXKsa2qur/E0kN5BbVZdUtHHzf0z8DxP8tjFHXpAtNZ+Y59D5Efd0Dzgw83vBCzp6D4ovYmyFPlA1KLDv3a72ggzHOHhKAOBHk3hP6QjgbkIJl2ieBoWyTjTRGaSlqAgwt/WXdIHOlfY8AHiiEDNWphIKQbqrC/3MODXeU8UIYOyT8LnLc0GPue/vOS3wZd/8dhLbuFdIsC/N0ooJulVjokB/gFDKxdFk0Q9V9IAd/lYX+OWvmd9tfR3g1U6TwQlPeVBXk0/ZzDgmbrg3VlOZnTjaT2eB6bmQ==

On Thu, 5 Jun 2025 09:03:03 +0000
"Flot, Julien" <julien.flot@siemens.com> wrote:

> Hi,
> 
> Sorry to create this duplicate message, the previous one was not
> formatted as plain text ...
> 
> With recent versions of the kernel, ftrace seems to experience some
> latencies when writing events filter files on a real time kernel.  
> Latencies experienced add a extra minute of runtime with trace-cmd
> compare to a regular execution and sometimes `trace-cmd` just hangs for
> multiples minutes.
> 
> The bug has been tested and reproduced with these version of the kernel
> (all with real time enable) : 6.12.19, 6.14-rc7, 6.15 and current
> upstream.  
> The bug has also been reproduced on two machines, both running Ubuntu
> 24.04 with an upstream kernel, one running with an INTEL(R) XEON(R)
> GOLD 5512U, the other a Intel(R) Xeon(R) E-2278GE. The bug also appears
> is virtualised environments (KVM/QEMU).  
> I have run `git-bisect` between v6.12 and v6.15, the faulty commit
> seems to be this one : a363d27cdbc2bc2d1899b5a1520b64e3590fcd9a
> 


> Faulty commit message :  
> ```  
> commit a363d27cdbc2bc2d1899b5a1520b64e3590fcd9a  
> Author: Mathieu Desnoyers
> <[mathieu.desnoyers@efficios.com](mailto:mathieu.desnoyers@efficios.com
> )>    
> Date:   Tue Oct 8 21:07:15 2024 -0400  
> fix  
> tracing: Allow system call tracepoints to handle page faults
> 
> Use Tasks Trace RCU to protect iteration of system call enter/exit  
> tracepoint probes to allow those probes to handle page faults.
> 
> In preparation for this change, all tracers registering to system call
> enter/exit tracepoints should expect those to be called with preemption
> enabled.
> 
> This allows tracers to fault-in userspace system call arguments such as
> path strings within their probe callbacks.
> 

I believe I know the issue. The filter logic calls:

	tracepoint_synchronize_unregister();

And that patch added:

@@ -107,6 +108,7 @@ void for_each_tracepoint_in_module(struct module *mod,
 #ifdef CONFIG_TRACEPOINTS
 static inline void tracepoint_synchronize_unregister(void)
 {
+       synchronize_rcu_tasks_trace();
        synchronize_rcu();
 }


Where synchronize_rcu_tasks_trace() is much more heavy weight call than
synchronize_rcu().

Can you try this patch to see if it helps?

-- Steve

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 10f714c80e4d..a3857c36684b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2158,6 +2158,29 @@ struct filter_list {
 	struct event_filter	*filter;
 };
 
+struct filter_head {
+	struct list_head	list;
+	struct rcu_head		rcu;
+};
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
 static int process_system_preds(struct trace_subsystem_dir *dir,
 				struct trace_array *tr,
 				struct filter_parse_error *pe,
@@ -2167,10 +2190,16 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	struct filter_list *filter_item;
 	struct event_filter *filter = NULL;
 	struct filter_list *tmp;
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
@@ -2197,7 +2226,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter_item)
 			goto fail_mem;
 
-		list_add_tail(&filter_item->list, &filter_list);
+		list_add_tail(&filter_item->list, &filter_list->list);
 		/*
 		 * Regardless of if this returned an error, we still
 		 * replace the filter for the call.
@@ -2217,31 +2246,22 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	 * Do a synchronize_rcu() and to ensure all calls are
 	 * done with them before we free them.
 	 */
-	tracepoint_synchronize_unregister();
-	list_for_each_entry_safe(filter_item, tmp, &filter_list, list) {
-		__free_filter(filter_item->filter);
-		list_del(&filter_item->list);
-		kfree(filter_item);
-	}
+	call_rcu_tasks(&filter_list->rcu, free_filter_list_tasks);
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
+		call_rcu_tasks(&filter_list->rcu, free_filter_list_tasks);
+	else
+		free_filter_list(&filter_list->rcu);
+
 	return -ENOMEM;
 }
 
