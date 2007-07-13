From: Kevin Hilman <khilman@mvista.com>
Subject: Re: v2.6.22.1-rt3
Date: Fri, 13 Jul 2007 09:10:32 -0700
Message-ID: <4697A3F8.5040603@mvista.com>
References: <1184325752.12353.312.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:6605 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbXGMQKa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 12:10:30 -0400
In-Reply-To: <1184325752.12353.312.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas,

In  arm-preempt-config.patch, the GENERIC_TIME is removed from the OMAP
arch.  Can you undo that removal?    OMAP is still GENERIC_TIME capable
unless something has been done to break it.

In other words, on top of -rt3:

Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -394,6 +394,7 @@ config ARCH_DAVINCI
 config ARCH_OMAP
        bool "TI OMAP"
        select GENERIC_GPIO
+       select GENERIC_TIME
        help
          Support for TI's OMAP platform (OMAP1 and OMAP2).

Signed-off-by: Kevin Hilman <khilman@mvsita.com>
