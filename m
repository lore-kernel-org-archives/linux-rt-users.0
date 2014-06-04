From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rtmutex: Handle when top lock owner changes
Date: Thu, 5 Jun 2014 01:03:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1406050041280.18296@nanos>
References: <alpine.DEB.2.10.1406042217140.18296@nanos> <1401920557-21387-1-git-send-email-brad.mouring@ni.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Brad Mouring <brad.mouring@ni.com>
To: Brad Mouring <bmouring@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41789 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaFDXDj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Jun 2014 19:03:39 -0400
In-Reply-To: <1401920557-21387-1-git-send-email-brad.mouring@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 4 Jun 2014, Brad Mouring wrote:

> If, during walking the priority chain on a task blocking on a rtmutex,
> and the task is examining the waiter blocked on the lock owned by a task
> that is not blocking (the end of the chain), the current task is ejected
> from the processor and the owner of the end lock is scheduled in,
> releasing that lock, before the original task is scheduled back in, the
> task misses the fact that the previous owner of the current lock no
> longer holds it.

-ENOPARSE,
 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index fbf152b..8ad7f7d 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -384,6 +384,26 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
>  
>  	/* Deadlock detection */

Does not apply against 3.15-rc8

>  	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
> +		/*
> +		 * If the prio chain has changed out from under us, set the task
> +		 * to the current owner of the lock in the current waiter and
> +		 * continue walking the prio chain
> +		 */

You are still describing what the code is doing, not WHY.

    Why can it happen that the prio chain changed under us?

    Why do we set task to the current owner of the lock ?

    Why makes it sense to retry the chain walk from the very
    beginning?

    What are the conditions which make us go into that code path?

> +		if (rt_mutex_owner(lock) && rt_mutex_owner(lock) != task &&
> +			rt_mutex_owner(lock) != top_task) {
> +			/* Release the old task (blocked before the chain chaged) */

chaged?

old task ?

Again:

> We really want to be more than careful about the comments here. The
> damned thing is complex enough already, so confusing comments are
> actually worse than no comments.

This is not a speed code contest. Take your time, think about it, run
it through your coworkers and then post again.

Last warning.

Thanks,

	tglx
