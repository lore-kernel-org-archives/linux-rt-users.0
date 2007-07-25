From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [BUG] 2.6.23-rc1-rt2
Date: Wed, 25 Jul 2007 11:49:17 -0700
Message-ID: <1185389357.2573.229.camel@imap.mvista.com>
References: <20070725175925.GA2992@ittc.ku.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org
To: Noah Watkins <nwatkins@ittc.ku.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:10007 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbXGYSve (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 14:51:34 -0400
In-Reply-To: <20070725175925.GA2992@ittc.ku.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-07-25 at 12:59 -0500, Noah Watkins wrote:
> dmesg below shows two BUGs, one in the middle, one at the end. here are
> system specs (config attached):
> 
> Also, this kernel boots up EXTREMELY slow. once it is booted, the timer
> soft-irqs on both cpus run (according to top) at about 4% of the CPU
> constantly. X is very jerky, I assume because of the soft-irqs running
> so much...?

I don't know about the slowness, but I think the BUG warnings are from
CONFIG_DEBUG_SHIRQ .

Try this patch,

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 kernel/irq/manage.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22/kernel/irq/manage.c
===================================================================
--- linux-2.6.22.orig/kernel/irq/manage.c
+++ linux-2.6.22/kernel/irq/manage.c
@@ -578,9 +578,9 @@ int request_irq(unsigned int irq, irq_ha
 		if (irqflags & IRQF_DISABLED) {
 			unsigned long flags;
 
-			local_irq_save(flags);
+			local_irq_save_nort(flags);
 			handler(irq, dev_id);
-			local_irq_restore(flags);
+			local_irq_restore_nort(flags);
 		} else
 			handler(irq, dev_id);
 	}
