From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH -rt 2/6] Fix typo in new IRQF_TIMER name
Date: Fri, 13 Jul 2007 10:52:16 -0700
Message-ID: <20070713175228.108932770@mvista.com>
References: <20070713175214.336577416@mvista.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: tglx@linutronix.de, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:38940 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760022AbXGMSNH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 14:13:07 -0400
Content-Disposition: inline; filename=irqf-timer.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 include/linux/interrupt.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/interrupt.h
===================================================================
--- linux-2.6.orig/include/linux/interrupt.h
+++ linux-2.6/include/linux/interrupt.h
@@ -52,7 +52,7 @@
 #define IRQF_SAMPLE_RANDOM	0x00000040
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
-#define _IRQF_TIMER		0x00000200
+#define __IRQF_TIMER		0x00000200
 #define IRQF_PERCPU		0x00000400
 #define IRQF_NOBALANCING	0x00000800
 #define IRQF_IRQPOLL		0x00001000

--
