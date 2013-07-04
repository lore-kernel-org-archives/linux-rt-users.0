From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: Searching a Bug on Raspberry Pi
Date: Thu, 04 Jul 2013 12:45:16 +0200
Message-ID: <51D5523C.3060605@autostatic.com>
References: <51CF4035.8090100@schorsch-tech.de> <CAFSh4Uz7B8L5Y0nsp1bW4pgPkyqHtXDSM0R-PiRLZQfd+URFYw@mail.gmail.com> <51CFB71F.5090401@schorsch-tech.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090301060108000700050805"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:57865 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3GDKpU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jul 2013 06:45:20 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so557159bkc.34
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Jul 2013 03:45:19 -0700 (PDT)
Received: from [192.168.1.98] (s5146f5f9.adsl.online.nl. [81.70.245.249])
        by mx.google.com with ESMTPSA id px7sm667215bkb.9.2013.07.04.03.45.17
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 03:45:18 -0700 (PDT)
In-Reply-To: <51CFB71F.5090401@schorsch-tech.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090301060108000700050805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/30/2013 06:42 AM, Georg Gast wrote:
> Hi Tom,
> 
> the problem occurs even if i set enable_llm=0. The while loop is now not
> touched and the rpi deadlocks too.
> 
> As far as i understand it, the sdhci.c is the base for all sdhci card
> readers and the sdhci-*.c implement the ops for the specific hardware.
> 
> My problem is, that i dont have an other sdhci card reader here. It wont
> be possible to boot from, but i could try to read from it on a rt
> kernel. If i compile the sdhci_bcm2708 as a module, i could not get a
> device info from the rpi reader. Maybe an other reader works, then the
> real problem sits in sdhci_bcm2708.c (or at bad luck, it shows an bigger
> problem in sdhci.c).
> 
> Georg
> 

Here's a quick and dirty hack to get things going.

Regards,

Jeremy

--------------090301060108000700050805
Content-Type: text/x-patch;
 name="sdhci.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sdhci.c.diff"

--- linux/drivers/mmc/host/sdhci.c	2013-07-03 11:54:06.306455988 +0200
+++ linux-rt/drivers/mmc/host/sdhci.c	2013-07-03 16:49:33.298601044 +0200
@@ -162,9 +162,17 @@
 			preempt_schedule();
 		}
 		spin_lock_irqsave(&host->lock,*flags);
+#ifdef CONFIG_PREEMPT_RT_FULL
+		disable_irq_nosync(host->irq);
+#else
 		disable_irq(host->irq);
+#endif
 		if(host->second_irq)
+#ifdef CONFIG_PREEMPT_RT_FULL
+			disable_irq_nosync(host->second_irq);
+#else
 			disable_irq(host->second_irq);
+#endif
 		local_irq_enable();
 	}
 	else
@@ -1834,7 +1842,11 @@
 	host = mmc_priv(mmc);
 
 	sdhci_runtime_pm_get(host);
+#ifdef CONFIG_PREEMPT_RT_FULL
+	disable_irq_nosync(host->irq);
+#else
 	disable_irq(host->irq);
+#endif
 	spin_lock(&host->lock);
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -1935,7 +1947,11 @@
 		wait_event_interruptible_timeout(host->buf_ready_int,
 					(host->tuning_done == 1),
 					msecs_to_jiffies(50));
+#ifdef CONFIG_PREEMPT_RT_FULL
+		disable_irq_nosync(host->irq);
+#else
 		disable_irq(host->irq);
+#endif
 		spin_lock(&host->lock);
 
 		if (!host->tuning_done) {

--------------090301060108000700050805--
