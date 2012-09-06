From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] irq: Set CPU affinity as soon as the irq thread is
 created
Date: Wed, 05 Sep 2012 20:09:15 -0400
Message-ID: <1346890155.27919.80.camel@gandalf.local.home>
References: <CAFQPvXckDMhH6MCkXC44wF0t13Ov=yQwER8GZgRRA4aq5=_w9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFQPvXckDMhH6MCkXC44wF0t13Ov=yQwER8GZgRRA4aq5=_w9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2012-09-05 at 18:07 -0500, Sankara Muthukrishnan wrote:
> Hi there,

This also affects mainline. Please Cc LKML (as I did).

> 
> As irq_thread_check_affinity is called inside the while loop in the
> IRQ thread, the core affinity is set only when an interrupt happens.
> It does not seem to be a bad idea to set the core affinity soon after
> the thread is created also (as shown in the patch).
> irq_thread_check_affinity calls kmalloc_node that can sleep.

Note, it only calls kmalloc if you enable CONFIG_CPUMASK_OFFSTACK, which
you probably don't on an embedded device. But you might. Your embedded
device may have more than 32 or 64 CPUs.

I'd be more worried about calling set_cpus_allowed_ptr() than kmalloc().

>  In an
> embedded target where IRQ affinities are pre-configured during
> boot-time (and not modified through /proc/irq/../smp_affinity) during
> run-time, the extra latency due to irq_thread_check_affinity can be
> avoided during processing of the first interrupt with this patch.
> Thoughts?
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 87dc053..bf2cdc2 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -791,6 +791,7 @@ static int irq_thread(void *data)
> 
>         sched_setscheduler(current, SCHED_FIFO, &param);
>         current->irqaction = action;
> +       irq_thread_check_affinity(desc, action);
> 
>         while (!irq_wait_for_interrupt(action)) {

I see no problem with this patch.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
