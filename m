From: John Kacur <jkacur@redhat.com>
Subject: Re: [patch] drivers/dca: convert dca_lock to a raw spinlock V2
Date: Thu, 29 Jul 2010 20:44:52 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007292043410.21570@localhost.localdomain>
References: <1278491341.7926.4.camel@marge.simson.net> <1279880285.2791.42.camel@marge.simson.net> <AANLkTi=tp3NvXnEpko-9OHWePOMunCDUVFH7Nx_9yruG@mail.gmail.com> <1280377497.9275.9.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43683 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab0G2SpE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jul 2010 14:45:04 -0400
In-Reply-To: <1280377497.9275.9.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 29 Jul 2010, Mike Galbraith wrote:

> On Wed, 2010-07-28 at 23:29 +0200, John Kacur wrote:
> 
> > Since the above looks slightly cleaner, maybe you just need to spin a
> > clean-up patch
> > of what is in tip/rt/2.6.33
> 
> Ok, dinky delta below.
> 
> drivers/dca: minor cleanup of dca-core.c
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> --- a/drivers/dca/dca-core.c	2010-07-29 05:43:34.000000000 +0200
> +++ b/drivers/dca/dca-core.c	2010-07-28 05:00:05.000000000 +0200
> @@ -297,17 +297,19 @@ int register_dca_provider(struct dca_pro
>  	int err;
>  	unsigned long flags;
>  	struct dca_domain *domain, *newdomain = NULL;
> +        struct pci_bus *rc;
>  
>  	err = dca_sysfs_add_provider(dca, dev);
>  	if (err)
>  		return err;
>  
>  	raw_spin_lock_irqsave(&dca_lock, flags);
> +	rc = dca_pci_rc_from_dev(dev);
>  	domain = dca_get_domain(dev);
>  	if (!domain) {
>  		raw_spin_unlock_irqrestore(&dca_lock, flags);
>  
> -		newdomain = dca_allocate_domain(dca_pci_rc_from_dev(dev));
> +		newdomain = dca_allocate_domain(rc);
>  		if (!newdomain)
>  			return -ENODEV;
>  
> 
> 
> --

Thanks Mike, I've applied this to my own tree for testing.
Acked-by: John Kacur <jkacur@redhat.com>
