From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [v1][PATCH] cpu_down: move migrate_enable() back
Date: Mon, 11 Nov 2013 10:32:55 -0500
Message-ID: <5280F8A7.4070608@windriver.com>
References: <1383789967-5885-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <stable-rt@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: Tiejun Chen <tiejun.chen@windriver.com>, <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57100 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab3KKPcY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Nov 2013 10:32:24 -0500
In-Reply-To: <1383789967-5885-1-git-send-email-tiejun.chen@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 13-11-06 09:06 PM, Tiejun Chen wrote:
> Commit 08c1ab68, "hotplug-use-migrate-disable.patch", intends to
> use migrate_enable()/migrate_disable() to replace that combination

Since you quote a commit ID, it would be nice if you mentioned that
it is in v3.8-rt from the stable-rt repo, instead of making people
look it up.

Also, since you have cc'd stable-rt@vger, there should be some mention
of what versions it might be appropriate for (3.4?  3.10?).

> of preempt_enable() and preempt_disable(), but actually in
> !CONFIG_PREEMPT_RT_FULL case, migrate_enable()/migrate_disable()
> are still equal to preempt_enable()/preempt_disable(). So that
> followed cpu_hotplug_begin()/cpu_unplug_begin(cpu) would go schedule()
> to trigger schedule_debug() like this:
> 
> _cpu_down()
> 	|
> 	+ migrate_disable() = preempt_disable()
> 	|
> 	+ cpu_hotplug_begin() or cpu_unplug_begin()
> 		|
> 		+ schedule()
> 			|
> 			+ __schedule()
> 				|
> 				+ preempt_disable();
> 				|
> 				+ __schedule_bug() is true!
> 
> So we should move migrate_enable() as the original scheme.

It is unclear to me what context you are thinking of/referencing
as the "original scheme"...

> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  kernel/cpu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 98f2ea3..da6e128 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -594,6 +594,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  		err = -EBUSY;
>  		goto restore_cpus;
>  	}
> +	migrate_enable();
>  

So, what happens if we now get migrated right here, before the
hotplug_begin call below?

P.
--

>  	cpu_hotplug_begin();
>  	err = cpu_unplug_begin(cpu);
> @@ -647,7 +648,6 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  out_release:
>  	cpu_unplug_done(cpu);
>  out_cancel:
> -	migrate_enable();
>  	cpu_hotplug_done();
>  	if (!err)
>  		cpu_notify_nofail(CPU_POST_DEAD | mod, hcpu);
> 
