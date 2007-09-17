From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [PATCH] Fix compilation of 2.6.23rc4-rt1 without
	CONFIG_PREEMPT_RT
Date: Mon, 17 Sep 2007 09:02:54 -0700
Message-ID: <1190044974.4374.80.camel@sven.thebigcorporation.com>
References: <200709171752.37772.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:35722 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbXIQQDG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 12:03:06 -0400
In-Reply-To: <200709171752.37772.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-09-17 at 17:52 +0200, Andi Kleen wrote:
> count_active_rt_tasks() is undefined otherwise.
> 

This does fix the compile issue, but RT tasks can exist in !PREEMPT_RT
as well.

Sven

> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux-2.6.23-rc4-rt1/kernel/timer.c
> ===================================================================
> --- linux-2.6.23-rc4-rt1.orig/kernel/timer.c
> +++ linux-2.6.23-rc4-rt1/kernel/timer.c
> @@ -919,18 +919,20 @@ static unsigned long count_active_tasks(
>  #endif
>  }
>  
> -#ifdef CONFIG_PREEMPT_RT
>  /*
>   * Nr of active tasks - counted in fixed-point numbers
>   */
>  static unsigned long count_active_rt_tasks(void)
>  {
> +#ifdef CONFIG_PREEMPT_RT
>  	extern unsigned long rt_nr_running(void);
>  	extern unsigned long rt_nr_uninterruptible(void);
>  
>  	return (rt_nr_running() + rt_nr_uninterruptible()) * FIXED_1;
> -}
> +#else
> +	return 0;
>  #endif
> +}
>  
>  /*
>   * Hmm.. Changed this, as the GNU make sources (load.c) seems to
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Sven-Thorsten Dietrich
+1 (415) 694-2930
