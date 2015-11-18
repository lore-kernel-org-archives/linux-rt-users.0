From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [RFC] [PATCH] fs/proc: add poll()ing support to /proc/interrupts
Date: Wed, 18 Nov 2015 17:16:39 -0600
Message-ID: <564D06D7.4060802@ni.com>
References: <1445462328-14142-1-git-send-email-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <tglx@linutronix.de>, jcartwri <josh.cartwright@ni.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bl2on0128.outbound.protection.outlook.com ([65.55.169.128]:43363
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755389AbbKRXQs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Nov 2015 18:16:48 -0500
In-Reply-To: <1445462328-14142-1-git-send-email-haris.okanovic@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I made this RFC at an awkward time for most regulars on this list, right 
before RTLWS and the Kernel Summit, which might explain the lack of 
response. Otherwise it may just be a terrible idea! Regardless, I'm 
curious if anyone's willing to share an opinion?

Thanks again,
Haris


On 10/21/2015 04:18 PM, Haris Okanovic wrote:
> Implement polling on procfs' "interrupts" file which observes changes
> to IRQ action handlers. A poll()ed file descriptor will be flagged
> EPOLLIN each time an action handler is registered or unregistered.
>
> Use case:
>
> Designing a thread priority policy on a system is critically important
> for the correctness and performance of any application. Present tooling
> for the manipulation/implementation of irqthread priority policies
> assumes a one-shot configuration model, that is, they assume that all
> relevant irqthreads are created at boot.
>
> For example, Red Hat MRG offers two tools, rtctl and tuna, to configure
> irqthreads among other attributes in this manner. They can be run in
> boot scripts to tune irqthreads in early loaded drivers.
>
> However, many systems are much more dynamic: external devices may be
> hotplugged, modules may be loaded/unloaded, which means irqthreads may
> come-and-go throughout the lifetime of the system.
>
> This change implements a mechanism by which usermode might be aware of
> new irqthreads, so that it may act accordingly.
>
> Alternatives considered:
>
> Netlink can provide a similar usermode notification, but can't scope to
> only irqthreads or even kernel threads. It can notify on thread creation
> system wide, which is somewhat heavy handed as it increases the cost of
> all fork()s to capture a relatively limited event.
>
> Device managers like udev could also trigger irqthread configuration in
> some cases, like after hotplug. However, there's no guarantee that
> drivers are only loaded by the system's device manager or that
> irqthreads are only created during driver initialization.
> E.g. e1000 module creates irqthreads on load and on ifup.
>
> Race issue:
>
> Configuration from usermode is not entirely without problems. Daemons
> can't guarantee priority of new irqthreads before they start running.
> New drivers will operate under an invalid priority configuration for a
> period while a process executes to configure them.
>
> I'm not entirely sure how to deal with this or if it's worth added
> complexity. Delayed configuration seems sufficient so long as it's
> guaranteed in a reasonably short period. I believe that's achievable by
> appropriately prioritizing the config process.
>
> I'm curious how other RT developers deal with irqthread priority in a
> forced threading environment. Has anybody else seen a need for more
> dynamic configuration? Is this is a reasonable solution?
>
> Thanks,
> Haris
> ---
>   fs/proc/interrupts.c      | 65 ++++++++++++++++++++++++++++++++++++++++++++---
>   include/linux/interrupt.h |  3 +++
>   kernel/irq/manage.c       | 15 ++++++++++-
>   3 files changed, 79 insertions(+), 4 deletions(-)
>
> diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
> index a352d57..81ca63e 100644
> --- a/fs/proc/interrupts.c
> +++ b/fs/proc/interrupts.c
> @@ -1,9 +1,11 @@
>   #include <linux/fs.h>
> +#include <linux/poll.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
>   #include <linux/irqnr.h>
>   #include <linux/proc_fs.h>
>   #include <linux/seq_file.h>
> +#include <linux/slab.h>
>
>   /*
>    * /proc/interrupts
> @@ -33,16 +35,73 @@ static const struct seq_operations int_seq_ops = {
>   	.show  = show_interrupts
>   };
>
> -static int interrupts_open(struct inode *inode, struct file *filp)
> +struct interrupts_fd_state {
> +	atomic_long_t last_irq_change_count;
> +};
> +
> +static int interrupts_open(struct inode *inode, struct file *file)
> +{
> +	int res;
> +	struct interrupts_fd_state *privdata;
> +	struct seq_file *sf;
> +
> +	privdata = kzalloc(sizeof(struct interrupts_fd_state), GFP_KERNEL);
> +	if (!privdata) {
> +		res = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	res = seq_open(file, &int_seq_ops);
> +	if (res) {
> +		kfree(privdata);
> +		goto exit;
> +	}
> +
> +	sf = file->private_data;
> +	sf->private = privdata;
> +
> +	atomic_long_set(&privdata->last_irq_change_count,
> +		atomic_long_read(&irq_handler_change_count));
> +
> +exit:
> +	return res;
> +}
> +
> +static int interrupts_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *sf = file->private_data;
> +
> +	kfree(sf->private);
> +	return seq_release(inode, file);
> +}
> +
> +static unsigned int interrupts_poll(struct file *file,
> +	struct poll_table_struct *pt)
>   {
> -	return seq_open(filp, &int_seq_ops);
> +	unsigned int mask = 0;
> +	long newcount, oldcount;
> +	struct seq_file *sf = file->private_data;
> +	struct interrupts_fd_state *fds = sf->private;
> +
> +	/* Register for changes to IRQ handlers */
> +	poll_wait(file, &irq_handler_change_wq, pt);
> +
> +	/* Store new change count in priv data */
> +	newcount = atomic_long_read(&irq_handler_change_count);
> +	oldcount = atomic_long_xchg(&fds->last_irq_change_count, newcount);
> +
> +	if (newcount != oldcount)
> +		mask |= POLLIN | POLLRDNORM;
> +
> +	return mask;
>   }
>
>   static const struct file_operations proc_interrupts_operations = {
>   	.open		= interrupts_open,
>   	.read		= seq_read,
> +	.poll		= interrupts_poll,
>   	.llseek		= seq_lseek,
> -	.release	= seq_release,
> +	.release	= interrupts_release,
>   };
>
>   static int __init proc_interrupts_init(void)
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index be7e75c..8d89eef 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -670,4 +670,7 @@ extern int early_irq_init(void);
>   extern int arch_probe_nr_irqs(void);
>   extern int arch_early_irq_init(void);
>
> +extern atomic_long_t irq_handler_change_count;
> +extern wait_queue_head_t irq_handler_change_wq;
> +
>   #endif
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index f974485..5c7b34d 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -18,6 +18,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/rt.h>
>   #include <linux/task_work.h>
> +#include <linux/poll.h>
>
>   #include "internals.h"
>
> @@ -32,6 +33,17 @@ static int __init setup_forced_irqthreads(char *arg)
>   early_param("threadirqs", setup_forced_irqthreads);
>   #endif
>
> +atomic_long_t irq_handler_change_count = ATOMIC_LONG_INIT(0);
> +DECLARE_WAIT_QUEUE_HEAD(irq_handler_change_wq);
> +
> +/* Bump change count and wake up anything waiting on changes to
> + * IRQ handlers */
> +static void __irq_handler_change_event(void)
> +{
> +	atomic_long_inc(&irq_handler_change_count);
> +	wake_up_poll(&irq_handler_change_wq, POLLIN);
> +}
> +
>   static void __synchronize_hardirq(struct irq_desc *desc)
>   {
>   	bool inprogress;
> @@ -1296,7 +1308,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>   	new->dir = NULL;
>   	register_handler_proc(irq, new);
>   	free_cpumask_var(mask);
> -
> +	__irq_handler_change_event();
>   	return 0;
>
>   mismatch:
> @@ -1431,6 +1443,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
>   	}
>
>   	module_put(desc->owner);
> +	__irq_handler_change_event();
>   	return action;
>   }
>
>
