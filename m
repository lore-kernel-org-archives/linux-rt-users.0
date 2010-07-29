From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] drivers/dca: convert dca_lock to a raw spinlock V2
Date: Thu, 29 Jul 2010 06:24:57 +0200
Message-ID: <1280377497.9275.9.camel@marge.simson.net>
References: <1278491341.7926.4.camel@marge.simson.net>
	 <1279880285.2791.42.camel@marge.simson.net>
	 <AANLkTi=tp3NvXnEpko-9OHWePOMunCDUVFH7Nx_9yruG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:40898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750767Ab0G2EYt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jul 2010 00:24:49 -0400
In-Reply-To: <AANLkTi=tp3NvXnEpko-9OHWePOMunCDUVFH7Nx_9yruG@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-07-28 at 23:29 +0200, John Kacur wrote:

> Since the above looks slightly cleaner, maybe you just need to spin a
> clean-up patch
> of what is in tip/rt/2.6.33

Ok, dinky delta below.

drivers/dca: minor cleanup of dca-core.c

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- a/drivers/dca/dca-core.c	2010-07-29 05:43:34.000000000 +0200
+++ b/drivers/dca/dca-core.c	2010-07-28 05:00:05.000000000 +0200
@@ -297,17 +297,19 @@ int register_dca_provider(struct dca_pro
 	int err;
 	unsigned long flags;
 	struct dca_domain *domain, *newdomain = NULL;
+        struct pci_bus *rc;
 
 	err = dca_sysfs_add_provider(dca, dev);
 	if (err)
 		return err;
 
 	raw_spin_lock_irqsave(&dca_lock, flags);
+	rc = dca_pci_rc_from_dev(dev);
 	domain = dca_get_domain(dev);
 	if (!domain) {
 		raw_spin_unlock_irqrestore(&dca_lock, flags);
 
-		newdomain = dca_allocate_domain(dca_pci_rc_from_dev(dev));
+		newdomain = dca_allocate_domain(rc);
 		if (!newdomain)
 			return -ENODEV;
 


