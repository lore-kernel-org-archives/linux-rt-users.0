From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 3.2.9-rt15
Date: Mon, 05 Mar 2012 20:15:48 -0800
Message-ID: <4F558F74.5050704@localhost>
References: <alpine.LFD.2.02.1203021743040.2742@ionos> <1330985640.25686.342.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:40910 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964934Ab2CFEPw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Mar 2012 23:15:52 -0500
In-Reply-To: <1330985640.25686.342.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/05/2012 02:14 PM, Steven Rostedt wrote:
> Thomas,
>
> Please fold this change into
>
>     cpu-rt-make-hotplug-lock-a-sleeping-spinlock-on-rt.patch

Thanks, this fixed the panic on shutdown I was experiencing!
-- Fernando


> As the patch was never tested (nor even compiled) it introduced a nasty
> bug into taking a CPU down instead of fixing one.
>
> Thanks,
>
> -- Steve
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index c25b5ff..66dfb74 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -59,16 +59,20 @@ static struct {
>   	int refcount;
>   } cpu_hotplug = {
>   	.active_writer = NULL,
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	.lock = __SPIN_LOCK_UNLOCKED(cpu_hotplug.lock),
> +#else
>   	.lock = __MUTEX_INITIALIZER(cpu_hotplug.lock),
> +#endif
>   	.refcount = 0,
>   };
>
>   #ifdef CONFIG_PREEMPT_RT_FULL
> -# define hotplug_lock() spin_lock(&cpu_hotplug.lock)
> -# define hotplug_unlock() spin_unlock(&cpu_hotplug.lock)
> +# define hotplug_lock() rt_spin_lock(&cpu_hotplug.lock)
> +# define hotplug_unlock() rt_spin_unlock(&cpu_hotplug.lock)
>   #else
>   # define hotplug_lock() mutex_lock(&cpu_hotplug.lock)
> -# define hotplug_lock() mutex_unlock(&cpu_hotplug.lock)
> +# define hotplug_unlock() mutex_unlock(&cpu_hotplug.lock)
>   #endif
>
>   struct hotplug_pcp {
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
