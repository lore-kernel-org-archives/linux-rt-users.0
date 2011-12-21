From: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Subject: [PATCH 2/2] priority System V Semaphores
Date: Wed, 21 Dec 2011 19:31:59 +0100
Message-ID: <4EF2261F.4050002@colorfullife.com>
References: <1324419795.20886.3.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lior Brafman <LBrafman@manz.com>,
	Torsten Scherer <TScherer@manz.com>,
	Rasty Slutsker <RSlutsker@manz.com>
To: raz ben yehuda <raziebe@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1324419795.20886.3.camel@raz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi raz,


On 12/20/2011 11:23 PM, raz ben yehuda wrote:
> > From 25aa166505aff2561dd715c927c654d0bbb432ba Mon Sep 17 00:00:00 2001
> From: raz<raziebe@gmail.com>
> Date: Tue, 20 Dec 2011 22:54:56 +0200
>
>
> Add positioning routine find_pos. find_pos returns
> the place where to put the sleeper before.
> I sort only rt tasks, OTHER policy is pushed back in
> queue. I do not distinct between SCHED_RR and SCHED_FIFO
> policies and they are treated as a single policy
> for the sorting algorithm.
>
> SETPRIO operates only when user issues a single semop
> operation and not an array of opretions.
As far as I can see, the advantages of sysvsem are backward 
compatibility and the ability to use complex ops.
You propose to add a new feature that doesn't work on complex ops.

Are there any apps that use SETPRIO?
What is the use case?
> SETFIFO is the default for backward compatbility.
>
> Signed-off-by: raz<raziebe@gmail.com>
> ---
>   ipc/sem.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 90dc5a1..921056d 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -1343,6 +1343,51 @@ static int get_queue_result(struct sem_queue *q)
>   	return error;
>   }
>
> +/*
> + * find the best place to put the task sorted by rt prio
> +*/
> +static struct list_head *find_pos(struct sem *curr, int alter,
> +		struct task_struct *p)
> +{
> +	struct sem_queue *q;
> +	struct sem_queue *ret_pos = NULL;
> +	struct list_head *tasks_queue =&curr->sem_pending;
> +
> +	if (!alter)
> +		return tasks_queue;
> +
Tasks that do not alter anything end up first - IMHO correct.

> +	if (!(curr->flags&  PRIO_SEM))
> +		return tasks_queue;
> +	/*
> +	 *  make no effort to sort SCHED_OTHER,
> +	 *  just push task to the back of the queue.
> +	*/
> +	if (!(p->policy == SCHED_FIFO || p->policy == SCHED_RR))
> +		return tasks_queue;
> +	/*
> +	 *  make no distinction between SCHED_FIFO
> +	 *  and SCHED_RR policies.
> +	 */
> +	list_for_each_entry(q, tasks_queue, simple_list) {
> +		struct task_struct *t;
> +
> +		t  = q->sleeper;
> +		if (current->rt_priority == t->rt_priority) {
> +			/*
> +			* push in a FIFO manner
> +			* tasks in same priority
> +			*/
> +			ret_pos = q;
> +			continue;
> +		}
> +		if (current->rt_priority<  t->rt_priority)
> +			continue;
> +		return&q->simple_list;
> +	}
Here in the loop, non-alter tasks are evaluated as well.
I think that's wrong, it could starve non-alter tasks.

e.g. queue:
- high prio non-alter
- low prio non-alter.

Now a medium prio alter task is added.
I think it will end up in the wrong position (before the low-prio 
non-alter task), correct?

--
     Manfred
