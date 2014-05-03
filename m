From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT] blk-mq: revert raw locks, post pone notifier to
 POST_DEAD
Date: Sat, 03 May 2014 19:03:07 +0200
Message-ID: <1399136587.5158.29.camel@marge.simpson.net>
References: <1399135344-5349-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:56221 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaECRDK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 May 2014 13:03:10 -0400
Received: by mail-ee0-f43.google.com with SMTP id e51so4058252eek.30
        for <linux-rt-users@vger.kernel.org>; Sat, 03 May 2014 10:03:08 -0700 (PDT)
In-Reply-To: <1399135344-5349-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2014-05-03 at 18:42 +0200, Sebastian Andrzej Siewior wrote: 
> The blk_mq_cpu_notify_lock should be raw because some CPU down levels
> are called with interrupts off. The notifier itself calls currently one
> function that is blk_mq_hctx_notify().
> That function acquires the ctx->lock lock which is sleeping and I would
> prefer to keep it that way. That function only moves IO-requests from
> the CPU that is going offline to another CPU and it is currently the
> only one. Therefore I revert the list lock back to sleeping spinlocks
> and let the notifier run at POST_DEAD time.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Mike, I see that lockdep splat (sleeping while atomic) during cpu-hotplug.
> Don't you see this, too?

Nope, didn't.

> block/blk-mq-cpu.c | 17 ++++++++++-------
>  block/blk-mq.c     |  2 +-
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq-cpu.c b/block/blk-mq-cpu.c
> index 136ef86..37acc3a 100644
> --- a/block/blk-mq-cpu.c
> +++ b/block/blk-mq-cpu.c
> @@ -11,7 +11,7 @@
>  #include "blk-mq.h"
>  
>  static LIST_HEAD(blk_mq_cpu_notify_list);
> -static DEFINE_RAW_SPINLOCK(blk_mq_cpu_notify_lock);
> +static DEFINE_SPINLOCK(blk_mq_cpu_notify_lock);
>  
>  static int blk_mq_main_cpu_notify(struct notifier_block *self,
>  				  unsigned long action, void *hcpu)
> @@ -19,12 +19,15 @@ static int blk_mq_main_cpu_notify(struct notifier_block *self,
>  	unsigned int cpu = (unsigned long) hcpu;
>  	struct blk_mq_cpu_notifier *notify;
>  
> -	raw_spin_lock(&blk_mq_cpu_notify_lock);
> +	if (action != CPU_POST_DEAD && action != CPU_POST_DEAD)
> +		return NOTIFY_OK;
> +
> +	spin_lock(&blk_mq_cpu_notify_lock);
>  
>  	list_for_each_entry(notify, &blk_mq_cpu_notify_list, list)
>  		notify->notify(notify->data, action, cpu);
>  
> -	raw_spin_unlock(&blk_mq_cpu_notify_lock);
> +	spin_unlock(&blk_mq_cpu_notify_lock);
>  	return NOTIFY_OK;
>  }
>  
> @@ -32,16 +35,16 @@ void blk_mq_register_cpu_notifier(struct blk_mq_cpu_notifier *notifier)
>  {
>  	BUG_ON(!notifier->notify);
>  
> -	raw_spin_lock(&blk_mq_cpu_notify_lock);
> +	spin_lock(&blk_mq_cpu_notify_lock);
>  	list_add_tail(&notifier->list, &blk_mq_cpu_notify_list);
> -	raw_spin_unlock(&blk_mq_cpu_notify_lock);
> +	spin_unlock(&blk_mq_cpu_notify_lock);
>  }
>  
>  void blk_mq_unregister_cpu_notifier(struct blk_mq_cpu_notifier *notifier)
>  {
> -	raw_spin_lock(&blk_mq_cpu_notify_lock);
> +	spin_lock(&blk_mq_cpu_notify_lock);
>  	list_del(&notifier->list);
> -	raw_spin_unlock(&blk_mq_cpu_notify_lock);
> +	spin_unlock(&blk_mq_cpu_notify_lock);
>  }
>  
>  void blk_mq_init_cpu_notifier(struct blk_mq_cpu_notifier *notifier,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index da3af9f..d5e73d8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -971,7 +971,7 @@ static void blk_mq_hctx_notify(void *data, unsigned long action,
>  	struct blk_mq_ctx *ctx;
>  	LIST_HEAD(tmp);
>  
> -	if (action != CPU_DEAD && action != CPU_DEAD_FROZEN)
> +	if (action != CPU_POST_DEAD && action != CPU_POST_DEAD)
>  		return;
>  
>  	/*


