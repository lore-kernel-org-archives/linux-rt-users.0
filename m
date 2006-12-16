From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ARM 920T build problems for patch-2.6.19-rt1 - the second try
Date: Sat, 16 Dec 2006 10:25:39 +0100
Message-ID: <1166261139.29505.230.camel@localhost.localdomain>
References: <200612152153.45910.pisa@cmp.felk.cvut.cz>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:56551 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965354AbWLPJlx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Dec 2006 04:41:53 -0500
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
In-Reply-To: <200612152153.45910.pisa@cmp.felk.cvut.cz>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2006-12-15 at 21:53 +0100, Pavel Pisa wrote:
> Index: linux-2.6.19-rt/include/asm-arm/atomic.h
> ===================================================================
> --- linux-2.6.19-rt.orig/include/asm-arm/atomic.h
> +++ linux-2.6.19-rt/include/asm-arm/atomic.h
> @@ -188,10 +188,10 @@ static inline unsigned long __cmpxchg(vo
>  	volatile unsigned long *p = ptr;
>  
>  	if (size == 4) {
> -		local_irq_save(flags);
> +		raw_local_irq_save(flags);
>  		if ((prev = *p) == old)
>  			*p = new;
> -		local_irq_restore(flags);
> +		raw_local_irq_restore(flags);
>  		return(prev);
>  	} else
>  		return wrong_size_cmpxchg(ptr);

Ok

> ===================================================================
> 
> Even with this patch there are some missing symbols during link stage:
>   warp_check_clock_was_changed
>   usecs_to_cycles
> 
> The next changes allowed me to build ARM kernel with included
> high resolution timers for our board.
> 
> Index: linux-2.6.19-rt/kernel/hrtimer.c
> ===================================================================
> --- linux-2.6.19-rt.orig/kernel/hrtimer.c
> +++ linux-2.6.19-rt/kernel/hrtimer.c
> @@ -33,6 +33,7 @@
>  
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/percpu.h>
>  #include <linux/hrtimer.h>
> Index: linux-2.6.19-rt/arch/arm/Kconfig

ok

> ===================================================================
> --- linux-2.6.19-rt.orig/arch/arm/Kconfig
> +++ linux-2.6.19-rt/arch/arm/Kconfig
> @@ -19,7 +19,11 @@ config ARM
>  
>  config GENERIC_TIME
>  	bool
> -	default n
> +	default y
> +
> +config GENERIC_CLOCKEVENTS
> +	bool
> +	default y
 
No. Both have to be set to default n and selected when the mach has the
support for it.

>  config MMU
>  	bool
> @@ -203,6 +207,7 @@ config ARCH_H720X
>  config ARCH_IMX
>  	bool "IMX"
> +	select GENERIC_TIME

  +	  select GENERIC_CLOCKEVENTS

I fix that up.

	tglx
