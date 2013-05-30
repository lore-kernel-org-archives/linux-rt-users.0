From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] RFC: Set irq thread to RT priority on creation
Date: Thu, 30 May 2013 10:53:22 -0400
Message-ID: <1369925602.26799.5.camel@gandalf.local.home>
References: <1369915975-28797-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:22721 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab3E3OxY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 May 2013 10:53:24 -0400
In-Reply-To: <1369915975-28797-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-05-30 at 14:12 +0200, Ivo Sieben wrote:

>  kernel/irq/manage.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index fa17855..0ffe37b 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -950,6 +950,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  	 */
>  	if (new->thread_fn && !nested) {
>  		struct task_struct *t;
> +		static const struct sched_param param = {
> +			.sched_priority = MAX_USER_RT_PRIO/2,
> +		};
>  
>  		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
>  				   new->name);
> @@ -957,6 +960,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  			ret = PTR_ERR(t);
>  			goto out_mput;
>  		}
> +
> +		sched_setscheduler(t, SCHED_FIFO, &param);
> +

If you are adding this here, might as well remove the
sched_set_scheduler() from irq_thread() as well. No need to do it twice.

-- Steve

>  		/*
>  		 * We keep the reference to the task struct even if
>  		 * the thread dies to avoid that the interrupt code


