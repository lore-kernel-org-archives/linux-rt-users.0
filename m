From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH -rt] ARM: compile fix for event tracing
Date: Mon, 03 Dec 2007 19:37:51 -0800
Message-ID: <87fxyjruy8.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel <linux-kernel@vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:37348 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbXLDDh1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Dec 2007 22:37:27 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The cycles/usecs conversion macros should be dependent on
CONFIG_EVENT_TRACE instead of CONFIG_LATENCY_TIMING.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

--- a/include/asm-arm/timex.h
+++ b/include/asm-arm/timex.h
@@ -18,7 +18,7 @@ typedef unsigned long cycles_t;
 
 #ifndef mach_read_cycles
  #define mach_read_cycles() (0)
-#ifdef CONFIG_LATENCY_TIMING
+#ifdef CONFIG_EVENT_TRACE
  #define mach_cycles_to_usecs(d) (d)
  #define mach_usecs_to_cycles(d) (d)
 #endif
