From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: error in 2.6.20-rt8
Date: Tue, 6 Mar 2007 15:09:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703061509340.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:53866 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965036AbXCFOJr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2007 09:09:47 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

I believe here:

Index: linux/drivers/char/lpptest.c
===================================================================
--- /dev/null
+++ linux/drivers/char/lpptest.c
@@ -0,0 +1,178 @@
+/*
+ * /dev/lpptest device: test IRQ handling latencies over parallel port

[snip]

+/*
+ * API wrappers so that the code can be shared with the -rt tree:
+ */
+#ifndef local_irq_disable
+# define local_irq_disable     local_irq_disable
+# define local_irq_enable      local_irq_enable
+#endif

that's, probably, not what was meant there...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
