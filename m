From: "K.R. Foley" <kr@cybsft.com>
Subject: Re: v2.6.21-rt3
Date: Mon, 21 May 2007 11:04:32 -0500
Message-ID: <4651C310.1090008@cybsft.com>
References: <20070517194143.GA25394@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020805030708060904050208"
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay00.pair.com ([209.68.5.9]:4558 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754957AbXEUQEf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2007 12:04:35 -0400
In-Reply-To: <20070517194143.GA25394@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------020805030708060904050208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i'm pleased to announce the v2.6.21-rt3 kernel, which can be downloaded 
> from the usual place:
> 

This is actually regarding v2.6.21-rt5 but I don't remember seeing an
announcement for that one. The attached patch is necessary if you happen
to have RTC_HISTOGRAM enabled, which I'm guessing most folks don't.

BTW, what was the consensus on pagefault_enable and pagefault_disable?

-- 
   kr

--------------020805030708060904050208
Content-Type: text/x-patch;
 name="fixrtc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixrtc.patch"

--- linux-2.6.21/drivers/char/rtc.c.orig	2007-05-21 08:32:42.000000000 -0500
+++ linux-2.6.21/drivers/char/rtc.c	2007-05-21 08:33:49.000000000 -0500
@@ -93,6 +93,10 @@
 #include <asm/isa.h>
 #endif
 
+static unsigned long rtc_port;
+static int rtc_irq = PCI_IRQ_NONE;
+#endif
+
 #ifdef CONFIG_MIPS
 # include <asm/time.h>
 #endif
@@ -119,10 +123,6 @@ enum rtc_states {
 
 #endif
 
-static unsigned long rtc_port;
-static int rtc_irq = PCI_IRQ_NONE;
-#endif
-
 #ifdef	CONFIG_HPET_RTC_IRQ
 #undef	RTC_IRQ
 #endif

--------------020805030708060904050208--
