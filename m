From: Noah Watkins <nwatkins@ittc.ku.edu>
Subject: Re: [BUG] 2.6.23-rc1-rt2
Date: Wed, 25 Jul 2007 16:07:16 -0500
Message-ID: <20070725210716.GA2858@ittc.ku.edu>
References: <20070725175925.GA2992@ittc.ku.edu> <1185389357.2573.229.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from stephens.ittc.ku.edu ([129.237.125.220]:36560 "EHLO
	stephens.ittc.ku.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbXGYVHa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 17:07:30 -0400
Content-Disposition: inline
In-Reply-To: <1185389357.2573.229.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This patches solves the problem, thx. The slowness still persists, as
well as the super-active timer soft-irqs. Is there a way to find out
which timers are being fired?

- noah

On 25/07/07 11:49 -0700, Daniel Walker wrote:
> On Wed, 2007-07-25 at 12:59 -0500, Noah Watkins wrote:
> > dmesg below shows two BUGs, one in the middle, one at the end. here are
> > system specs (config attached):
> > 
> > Also, this kernel boots up EXTREMELY slow. once it is booted, the timer
> > soft-irqs on both cpus run (according to top) at about 4% of the CPU
> > constantly. X is very jerky, I assume because of the soft-irqs running
> > so much...?
> 
> I don't know about the slowness, but I think the BUG warnings are from
> CONFIG_DEBUG_SHIRQ .
> 
> Try this patch,
> 
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
> 
> ---
>  kernel/irq/manage.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.22/kernel/irq/manage.c
> ===================================================================
> --- linux-2.6.22.orig/kernel/irq/manage.c
> +++ linux-2.6.22/kernel/irq/manage.c
> @@ -578,9 +578,9 @@ int request_irq(unsigned int irq, irq_ha
>  		if (irqflags & IRQF_DISABLED) {
>  			unsigned long flags;
>  
> -			local_irq_save(flags);
> +			local_irq_save_nort(flags);
>  			handler(irq, dev_id);
> -			local_irq_restore(flags);
> +			local_irq_restore_nort(flags);
>  		} else
>  			handler(irq, dev_id);
>  	}
> 
