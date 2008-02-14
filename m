From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2.6.24-rt1] SMC91x: Use special_lock when
 CONFIG_PREEMPT_[HARD|SOFT]IRQS
Date: Thu, 14 Feb 2008 09:03:09 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802140902460.2732@xanadu.home>
References: <1202952946-10511-1-git-send-email-khilman@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:15475 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbYBNODL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Feb 2008 09:03:11 -0500
In-reply-to: <1202952946-10511-1-git-send-email-khilman@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 13 Feb 2008, Kevin Hilman wrote:

> The smc_special_locks should also be used when either softIRQs or hard
> IRQs are preempted which may lead to the same problems as under SMP.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>

Acked-by: Nicolas Pitre <nico@cam.org>

> 
> ---
>  drivers/net/smc91x.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
> index f198c49..be62616 100644
> --- a/drivers/net/smc91x.c
> +++ b/drivers/net/smc91x.c
> @@ -530,7 +530,8 @@ static inline void  smc_rcv(struct net_device *dev)
>  	}
>  }
>  
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_SMP) ||						\
> +    defined(CONFIG_PREEMPT_SOFTIRQS) || defined(CONFIG_PREEMPT_HARDIRQS)
>  /*
>   * On SMP we have the following problem:
>   *
> -- 
> 1.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Nicolas
