From: Gregory Haskins <gregory.haskins.ml@gmail.com>
Subject: Re: [PATCH [RT] 05/14] rearrange rt_spin_lock sleep
Date: Fri, 22 Feb 2008 08:29:20 -0500
Message-ID: <47BECE30.8030100@gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net> <20080221152651.4804.4702.stgit@novell1.haskins.net>
Reply-To: gregory.haskins@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, gregkh@suse.de, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:41130 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361AbYBVN3g (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Feb 2008 08:29:36 -0500
Received: by py-out-1112.google.com with SMTP id u52so730582pyb.10
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Feb 2008 05:29:36 -0800 (PST)
In-Reply-To: <20080221152651.4804.4702.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Gregory Haskins wrote:
> @@ -732,14 +741,15 @@ rt_spin_lock_slowlock(struct rt_mutex *lock)
>  
>  		debug_rt_mutex_print_deadlock(&waiter);
>  
> -		schedule_rt_mutex(lock);
> +		update_current(TASK_UNINTERRUPTIBLE, &saved_state);

I have a question for everyone out there about this particular part of 
the code. Patch 6/14 adds an optimization that is predicated on the 
order in which we modify the state==TASK_UNINTERRUPTIBLE vs reading the 
waiter.task below.

My assumption is that the xchg() (inside update_current()) acts as an 
effective wmb().  If xchg() does not have this property, then this code 
is broken and patch 6/14 should also add a:


+               smp_wmb();


> +		if (waiter.task)
> +			schedule_rt_mutex(lock);
> +		else
> +			update_current(TASK_RUNNING_MUTEX, &saved_state);
>  
>  		spin_lock_irqsave(&lock->wait_lock, flags);
>  		current->flags |= saved_flags;
>  		current->lock_depth = saved_lock_depth;
> -		state = xchg(&current->state, TASK_UNINTERRUPTIBLE);
> -		if (unlikely(state == TASK_RUNNING))
> -			saved_state = TASK_RUNNING;


Does anyone know the answer to this?

Regards,
-Greg
