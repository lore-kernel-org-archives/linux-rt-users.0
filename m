From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: A question about cpu_idle()
Date: Tue, 20 Oct 2009 22:47:39 -0600
Message-ID: <4ADE5A2B0200005A00057082@sinclair.provo.novell.com>
References: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: "yi li" <liyi.dev@gmail.com>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On 10/20/2009 at 11:07 PM, in message
<a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>, yi li
<liyi.dev@gmail.com> wrote: 
> Hi RT users,
> 
> While reading patch-2.6.31.4-rt14, there is a patch for cpu_idle()
> which I cannot understand.
> 
> Could anyone kindly enough to tell me what is patch used for?

Hi Yi,

I believe that logic is ensuring that the task is put to sleep instead of simply being preempted.  The difference is that a preemption leaves the task on the RQ, whereas calling schedule() may or may not leave the caller on the RQ, depending on the status of current->state.  The local_irq_disable+__preempt_enable_no_resched dance is a way of legally calling schedule() while effectively preventing preemption (since interrupts-off also disables preemption).  The difference is that its legal to call __schedule() with interrupts off, but you can't with preempt_disable().

Long story short, the enable_no_resched() + schedule() pattern is only ever used when you want to make sure the task fully sleeps.  However without this patch to disable interrupts, the original code appears racy and thus probably had issues achieving its intended goal.

HTH,
-Greg

> 
> 
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index ebefb54..c8d0ece 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -152,9 +152,11 @@ void cpu_idle(void)
>                 }
> 
>                 tick_nohz_restart_sched_tick();
> -               preempt_enable_no_resched();
> -               schedule();
> +               local_irq_disable();
> +               __preempt_enable_no_resched();
> +               __schedule();
>                 preempt_disable();
> +               local_irq_enable();
>         }
>  }
> 
> Regards,
> -Yi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



