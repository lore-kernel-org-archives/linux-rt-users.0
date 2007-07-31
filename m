From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH] Add cpu_clock declaration
Date: Tue, 31 Jul 2007 00:47:15 -0700
Message-ID: <1185868035.10219.19.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>
To: RT Users List <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:60497 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbXGaHrT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 31 Jul 2007 03:47:19 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



This patch should go before softlockup-use-cpu-clock.patch in the RT
queue.


Add extern declaration for the sched.c cpu_clock function to
resolve the implicit declaration in softlockup.c.


signed-off-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>


Index: linux-2.6.22/include/linux/sched.h
===================================================================
--- linux-2.6.22.orig/include/linux/sched.h
+++ linux-2.6.22/include/linux/sched.h
@@ -302,6 +302,7 @@ extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
 extern void scheduler_tick(void);
+extern unsigned long long cpu_clock(int cpu);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
 extern int debug_direct_keyboard;
