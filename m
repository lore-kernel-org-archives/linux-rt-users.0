From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] Add schedule_work_prio() and queue_work_prio().
Date: Mon, 30 Jun 2008 08:47:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806300846590.13037@gandalf.stny.rr.com>
References: <c384c5ea0806281023y6fcfb0f4o1a41aef3856bda9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:54984 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbYF3Mre (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 08:47:34 -0400
In-Reply-To: <c384c5ea0806281023y6fcfb0f4o1a41aef3856bda9e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>




On Sat, 28 Jun 2008, Leon Woestenberg wrote:

>
> Against 2.6.25.8-rt7, only compile tested.
>
> Adds schedule_work_prio() and queue_work_prio() so that work can be
> scheduled with a different priority than the caller.
>
> Under PREEMPT RT, schedule_work() and therefore queue_work() makes
> the work inherit the caller's priority.
>
> If a real-time thread, such as an interrupt handler, defers work it
> may want the deferred work to be of lower priority so it does not
> race with succeeding interrupt handling.
>
> Signed-off-by: Leon Woestenberg <leon@sidebranch.com>
>
> Index: linux-2.6.25.8/kernel/workqueue.c
> ===================================================================
> --- linux-2.6.25.8.orig/kernel/workqueue.c	2008-06-28 16:52:40.000000000 +0200
> +++ linux-2.6.25.8/kernel/workqueue.c	2008-06-28 18:29:19.000000000 +0200
> @@ -162,9 +162,10 @@
>  }
>
>  /**
> - * queue_work - queue work on a workqueue
> + * queue_work_prio - queue work on a workqueue and set work priority
>   * @wq: workqueue to use
>   * @work: work to queue
> + * @prio: priority of work
>   *
>   * Returns 0 if @work was already on a queue, non-zero otherwise.
>   *
> @@ -173,7 +174,7 @@
>   *
>   * Especially no such guarantee on PREEMPT_RT.
>   */
> -int queue_work(struct workqueue_struct *wq, struct work_struct *work)
> +int queue_work_prio(struct workqueue_struct *wq, struct work_struct
> *work, int prio)
>  {
>  	int ret = 0, cpu = raw_smp_processor_id();
>
> @@ -184,6 +185,25 @@
>  	}
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(queue_work_prio);

This function doesn't look like it does anything with the new "prio"
field.

-- Steve


> +
> +/**
> + * queue_work - queue work on a workqueue. work inherits caller's prio.
> + * @wq: workqueue to use
> + * @work: work to queue
> + *
> + * Returns 0 if @work was already on a queue, non-zero otherwise.
> + *
> + * We queue the work to the CPU it was submitted, but there is no
> + * guarantee that it will be processed by that CPU.
> + *
> + * Especially no such guarantee on PREEMPT_RT.
> + */
> +int queue_work(struct workqueue_struct *wq, struct work_struct *work)
> +{
> +  return queue_work(struct workqueue_struct *wq, struct work_struct *work,
> +    current->normal_prio);
> +}
>  EXPORT_SYMBOL_GPL(queue_work);
>
>  static void delayed_work_timer_fn(unsigned long __data)
> @@ -626,7 +646,8 @@
>   * schedule_work - put work task in global workqueue
>   * @work: job to be done
>   *
> - * This puts a job in the kernel-global workqueue.
> + * This puts a job in the kernel-global workqueue. The job inherits the
> + * caller's priority.
>   */
>  int schedule_work(struct work_struct *work)
>  {
> @@ -635,6 +656,19 @@
>  EXPORT_SYMBOL(schedule_work);
>
>  /**
> + * schedule_work_prio - put work task in global workqueue, set work prio
> + * @work: job to be done
> + *
> + * This puts a job in the kernel-global workqueue. The job gets the specified
> + * priority.
> + */
> +int schedule_work_prio(struct work_struct *work, int prio)
> +{
> +	return queue_work_prio(keventd_wq, work, prio);
> +}
> +EXPORT_SYMBOL(schedule_work_prio);
> +
> +/**
>   * schedule_delayed_work - put work task in global workqueue after delay
>   * @dwork: job to be done
>   * @delay: number of jiffies to wait or 0 for immediate execution
>
> --
> Leon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
