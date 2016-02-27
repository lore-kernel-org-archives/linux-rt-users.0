From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARNING: amd_iommu. linux-4.4.1-rt6
Date: Sat, 27 Feb 2016 10:58:12 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602271057270.3638@nanos>
References: <56CBA91D.6080909@gmail.com> <alpine.DEB.2.11.1602271024130.3638@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35561 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbcB0J7c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 04:59:32 -0500
In-Reply-To: <alpine.DEB.2.11.1602271024130.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 Feb 2016, Thomas Gleixner wrote:
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1952,10 +1952,10 @@ static int __attach_device(struct iommu_
>  	int ret;
>  
>  	/*
> -	 * Must be called with IRQs disabled. Warn here to detect early
> -	 * when its not.
> +	 * Must be called with IRQs disabled on a non RT kernel. Warn here to
> +	 * detect early when its not.
>  	 */
> -	WARN_ON(!irqs_disabled());
> +	WARN_ON_NORT(!irqs_disabled());

That wants to be

+	WARN_ON_NONRT(!irqs_disabled());

of course.

-ENOTAWAKEYET
