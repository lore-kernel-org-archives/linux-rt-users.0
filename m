From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT 2/2] ftrace: fix elevated preempt_count in
	wakeup-tracer
Date: Tue, 19 Aug 2008 15:12:36 +0200
Message-ID: <1219151556.10800.383.camel@twins>
References: <20080819091817.21725.81831.stgit@dev.haskins.net>
	 <20080819091923.21725.41087.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:39388 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbYHSNMf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 09:12:35 -0400
In-Reply-To: <20080819091923.21725.41087.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2008-08-19 at 05:19 -0400, Gregory Haskins wrote:
> Suggested by Steve Rostedt to fix an observed "+1" in the preempt-count
> 
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
> 
>  kernel/trace/trace_sched_wakeup.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index c3a15bd..ae523fd 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -70,7 +70,9 @@ wakeup_tracer_call(unsigned long ip, unsigned long parent_ip)
>  	if (task_cpu(wakeup_task) != cpu)
>  		goto unlock;
>  
> +	preempt_enable_no_resched_notrace();
>  	trace_function(tr, data, ip, parent_ip, flags);
> +	preempt_disable_notrace();

Is preempt_count > 1 at all times here?

If not, it might drop to 0 and any interrupt might cause preemption -
and its not obvious to me that that is actually correct.

Just asking, as neither the changelog nor the code fragment enlightens
me on the subject.

