From: Kevin Hilman <kevin@hilman.org>
Subject: [PATCH/RFC -rt] local_bh_enable() is safe for irqs_disabled()
Date: Fri, 07 Dec 2007 17:41:24 -0800
Message-ID: <87fxyearp7.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:33001 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbXLHBsA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Dec 2007 20:48:00 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In local_bh_enable() there is a WARN_ON(irqs_disabled()), but looking
at the rest of the code, it seems it expects to be used with
interrupts off, so is this warning really necessary?

I hit this warning in the ads7846 touchscreen driver timer function
where enable_irq() may be called with interrupts disabled.  Since
enable_irq now calls local_bh_disable/enable for IRQ resend, this
warning is triggered.

Patch against 2.6.23.9-rt12

Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4c19017..68149ae 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -207,7 +207,6 @@ void local_bh_enable(void)
 
 	WARN_ON_ONCE(in_irq());
 #endif
-	WARN_ON_ONCE(irqs_disabled());
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_save(flags);
