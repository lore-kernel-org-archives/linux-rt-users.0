From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH -rt 1/6] Re-add GENERIC_TIME to OMAP
Date: Fri, 13 Jul 2007 10:52:15 -0700
Message-ID: <20070713175227.687367584@mvista.com>
References: <20070713175214.336577416@mvista.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: tglx@linutronix.de, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:38942 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760352AbXGMSNI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 14:13:08 -0400
Content-Disposition: inline; filename=omap-fix.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -394,6 +394,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
 	bool "TI OMAP"
 	select GENERIC_GPIO
+	select GENERIC_TIME
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 

--
