From: Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v4.14.12-rt10
Date: Tue, 9 Jan 2018 09:29:19 -0500
Message-ID: <201801090929.19444.gheskett@shentel.net>
References: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from barracuda1.shentel.net ([204.111.1.144]:36894 "EHLO
        barracuda3.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753201AbeAIO3h (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jan 2018 09:29:37 -0500
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda3.shentel.net with ESMTP id hnRnHh6ygZEIhX3X for <linux-rt-users@vger.kernel.org>; Tue, 09 Jan 2018 09:29:23 -0500 (EST)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id 2479A21B8D
        for <linux-rt-users@vger.kernel.org>; Tue,  9 Jan 2018 09:29:23 -0500 (EST)
In-Reply-To: <20180109123433.u3dh7e2zbr5kgzub@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 09 January 2018 07:34:33 Sebastian Andrzej Siewior wrote:

> Dear RT folks!
>
> I'm pleased to announce the v4.14.12-rt10 patch set.
>
> Changes since v4.14.8-rt9:
>
>   - updated to v4.14.12
>
>   - An additional include to avoid a build failure on ARM after a
> header disappeared somewhere during the stable update.
>
>   - The patch "nohz: Prevent erroneous tick stop invocations" was
> merged differently upstream. The original issue where a slow box could
> lock up with a pending timer remained. I currently assume that this is
> a RT only issue and keep the patch as RT only.
>
> Known issues
>      - A warning triggered in "rcu_note_context_switch" originated
> from SyS_timer_gettime(). The issue was always there, it is now
> visible. Reported by Grygorii Strashko and Daniel Wagner.
>
> You can get this release via the git tree at:
>
>    
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> v4.14.12-rt10

No such file or directory. Browsing the site, I am pulling 
v4.14.y.rt10.tar.gz. Is this the correct file?

> The RT patch against v4.14.12 can be found here:
>
>    
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4
>.14.12-rt10.patch.xz
>
> The split quilt queue is available at:
>
>    
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches
>-4.14.12-rt10.tar.xz
>
> The RT-specific delta is appended below.
>
> Sebastian
> diff --git a/include/linux/spinlock_types_raw.h
> b/include/linux/spinlock_types_raw.h ---
> a/include/linux/spinlock_types_raw.h
> +++ b/include/linux/spinlock_types_raw.h
> @@ -1,6 +1,8 @@
>  #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
>  #define __LINUX_SPINLOCK_TYPES_RAW_H
>
> +#include <linux/types.h>
> +
>  #if defined(CONFIG_SMP)
>  # include <asm/spinlock_types.h>
>  #else
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -838,8 +838,13 @@ static inline void tick_irq_exit(void)
>  	int cpu = smp_processor_id();
>
>  	/* Make sure that timer wheel updates are propagated */
> +#ifdef CONFIG_PREEMPT_RT_BASE
>  	if ((idle_cpu(cpu) || tick_nohz_full_cpu(cpu)) &&
> -	    !need_resched() && !local_softirq_pending()) {
> +	    !need_resched() && !local_softirq_pending())
> +#else
> +	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu))
> +#endif
> +	{
>  		if (!in_interrupt())
>  			tick_nohz_irq_exit();
>  	}
> diff --git a/localversion-rt b/localversion-rt
> --- a/localversion-rt
> +++ b/localversion-rt
> @@ -1 +1 @@
> --rt9
> +-rt10
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers, Gene Heskett
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
