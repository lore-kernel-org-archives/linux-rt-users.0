From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] rtmutex: add BUG_ON if a task attempts to block on
 two locks
Date: Fri, 09 Jul 2010 20:30:25 -0400
Message-ID: <1278721825.1537.171.camel@gandalf.stny.rr.com>
References: <1278714780-788-1-git-send-email-dvhltc@us.ibm.com>
	 <1278714780-788-3-git-send-email-dvhltc@us.ibm.com>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	John Kacur <jkacur@redhat.com>, Mike Galbraith <efault@gmx.de>,
	linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278714780-788-3-git-send-email-dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2010-07-09 at 15:32 -0700, Darren Hart wrote:
> rtmutex proxy locking complicates the logic a bit and opens up
> the possibility for a task to wake and attempt to take another
> sleeping lock without knowing it has been enqueued on another
> lock already. Add a BUG_ON to catch this scenario early.
> 
> Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/rtmutex.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
> index baac7d9..22f9d18 100644
> --- a/kernel/rtmutex.c
> +++ b/kernel/rtmutex.c
> @@ -459,6 +459,9 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
>  		top_waiter = rt_mutex_top_waiter(lock);
>  	plist_add(&waiter->list_entry, &lock->wait_list);
>  
> +	/* Tasks can only block on one lock at a time. */
> +	BUG_ON(task->pi_blocked_on != NULL);

WARN_ON may be better. Since it may not cause a system crash or other
huge bug if it is not true.

-- Steve

> +
>  	task->pi_blocked_on = waiter;
>  
>  	raw_spin_unlock(&task->pi_lock);
