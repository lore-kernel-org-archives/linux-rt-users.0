From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] intel_idle: convert i7300_idle_lock to raw spinlock
Date: Wed, 07 Dec 2011 08:05:13 -0500
Message-ID: <1323263113.2832.7.camel@pippen.local.home>
References: <1323258522.5057.73.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:64841 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab1LGNFV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Dec 2011 08:05:21 -0500
In-Reply-To: <1323258522.5057.73.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Looks as this should also go mainline (Cc'd LKML)

Note, as I want to release 3.0.12-rt30 today, this wont make it. It will
have to wait till -rt31.

-- Steve

On Wed, 2011-12-07 at 12:48 +0100, Mike Galbraith wrote:
> 24 core Intel box's first exposure to 3.0.12-rt30-rc3 didn't go well.
> 
> [   27.104159] i7300_idle: loaded v1.55
> [   27.104192] BUG: scheduling while atomic: swapper/2/0/0x00000002
> [   27.104309] Pid: 0, comm: swapper/2 Tainted: G           N  3.0.12-rt30-rc3-rt #1
> [   27.104317] Call Trace:
> [   27.104338]  [<ffffffff810046a5>] dump_trace+0x85/0x2e0
> [   27.104372]  [<ffffffff8144eb00>] thread_return+0x12b/0x30b
> [   27.104381]  [<ffffffff8144f1b9>] schedule+0x29/0xb0
> [   27.104389]  [<ffffffff814506e5>] rt_spin_lock_slowlock+0xc5/0x240
> [   27.104401]  [<ffffffffa01f818f>] i7300_idle_notifier+0x3f/0x360 [i7300_idle]
> [   27.104415]  [<ffffffff814546c7>] notifier_call_chain+0x37/0x70
> [   27.104426]  [<ffffffff81454748>] __atomic_notifier_call_chain+0x48/0x70
> [   27.104439]  [<ffffffff81001a39>] cpu_idle+0x89/0xb0
> [   27.104449] bad: scheduling from the idle thread!
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> ---
>  drivers/idle/i7300_idle.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-3.2-rt/drivers/idle/i7300_idle.c
> ===================================================================
> --- linux-3.2-rt.orig/drivers/idle/i7300_idle.c
> +++ linux-3.2-rt/drivers/idle/i7300_idle.c
> @@ -75,7 +75,7 @@ static unsigned long past_skip;
>  
>  static struct pci_dev *fbd_dev;
>  
> -static spinlock_t i7300_idle_lock;
> +static raw_spinlock_t i7300_idle_lock;
>  static int i7300_idle_active;
>  
>  static u8 i7300_idle_thrtctl_saved;
> @@ -457,7 +457,7 @@ static int i7300_idle_notifier(struct no
>  		idle_begin_time = ktime_get();
>  	}
>  
> -	spin_lock_irqsave(&i7300_idle_lock, flags);
> +	raw_spin_lock_irqsave(&i7300_idle_lock, flags);
>  	if (val == IDLE_START) {
>  
>  		cpumask_set_cpu(smp_processor_id(), idle_cpumask);
> @@ -506,7 +506,7 @@ static int i7300_idle_notifier(struct no
>  		}
>  	}
>  end:
> -	spin_unlock_irqrestore(&i7300_idle_lock, flags);
> +	raw_spin_unlock_irqrestore(&i7300_idle_lock, flags);
>  	return 0;
>  }
>  
> @@ -554,7 +554,7 @@ struct debugfs_file_info {
>  
>  static int __init i7300_idle_init(void)
>  {
> -	spin_lock_init(&i7300_idle_lock);
> +	raw_spin_lock_init(&i7300_idle_lock);
>  	total_us = 0;
>  
>  	if (i7300_idle_platform_probe(&fbd_dev, &ioat_dev, forceload))
> 


