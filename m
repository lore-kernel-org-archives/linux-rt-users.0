From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH -rt 3/9] Fix jiffies wrap issue in update_times
Date: Sun, 29 Jul 2007 19:45:37 -0700
Message-ID: <20070730024719.502748134@mvista.com>
References: <20070730024534.369897977@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:41603 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936098AbXG3CrW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Jul 2007 22:47:22 -0400
Content-Disposition: inline; filename=initialize-last_tick-in-calc_load.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In prior -rt verisons the last_tick value was called wall_jiffies 
and was initialized in this same way as below. If this value isn't
initialized the calc_load function gets skewed for several minutes
right after boot up. Skewed meaning always zero.

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 kernel/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22/kernel/timer.c
===================================================================
--- linux-2.6.22.orig/kernel/timer.c
+++ linux-2.6.22/kernel/timer.c
@@ -987,7 +987,7 @@ void run_local_timers(void)
  */
 static inline void update_times(void)
 {
-	static unsigned long last_tick;
+	static unsigned long last_tick = INITIAL_JIFFIES;
 	unsigned long ticks, flags;
 
 	/*

-- 
