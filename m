From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARNING: amd_iommu. linux-4.4.1-rt6
Date: Sat, 27 Feb 2016 10:25:14 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602271024130.3638@nanos>
References: <56CBA91D.6080909@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: DIXLOR <dixlor@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35485 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115AbcB0J0e (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 04:26:34 -0500
In-Reply-To: <56CBA91D.6080909@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 23 Feb 2016, DIXLOR wrote:
> 
> [    1.828887] iommu: Adding device 0000:00:14.5 to group 10
> [    1.831805] ------------[ cut here ]------------
> [    1.831814] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd_iommu.c:1958
> 0xffffffff812d6449()
>
> static int __attach_device(struct iommu_dev_data *dev_data,
>                            struct protection_domain *domain)
> {
>         int ret;
> 
>         /*
>          * Must be called with IRQs disabled. Warn here to detect early
>          * when its not.
>          */
>         WARN_ON(!irqs_disabled());
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^  WARNING

The patch below fixes that.

Thanks,

	tglx

8<--------------------------------

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1952,10 +1952,10 @@ static int __attach_device(struct iommu_
 	int ret;
 
 	/*
-	 * Must be called with IRQs disabled. Warn here to detect early
-	 * when its not.
+	 * Must be called with IRQs disabled on a non RT kernel. Warn here to
+	 * detect early when its not.
 	 */
-	WARN_ON(!irqs_disabled());
+	WARN_ON_NORT(!irqs_disabled());
 
 	/* lock domain */
 	spin_lock(&domain->lock);
