From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: patch to fix early printks with PREMPT_RT_FULL
Date: Fri, 04 May 2012 18:07:22 -0700
Message-ID: <4FA47D4A.6020009@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030600090005020403040804"
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5825 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2EEBHX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 May 2012 21:07:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030600090005020403040804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

With PREMPT_RT_FULL I notice couple of issues when early printk is turned on

1)  printks show up only after the full console is enabled
2)  There are double prints for each of the prinkts before the full 
console was enabled.

The attached patch seem to fix the issue, but I am not sure whether this 
is completely with
the lock being acquired in console_trylock_for_printk().

Thanks,
Venkat


--------------030600090005020403040804
Content-Type: text/x-patch;
 name="0001-printk-Allow-early-console-prints-with-PREEMPT_RT_FU.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-printk-Allow-early-console-prints-with-PREEMPT_RT_FU.pa";
 filename*1="tch"

>From 876c0653e4482357823d1d36858aed7b5cd8d1fa Mon Sep 17 00:00:00 2001
From: Venkat Subbiah <venkat.subbiah@cavium.com>
Date: Fri, 4 May 2012 17:53:16 -0700
Subject: [PATCH] printk: Allow early console prints with PREEMPT_RT_FULL

Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
---
 kernel/printk.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index d3f22ec..d2dda2f 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -832,6 +832,8 @@ static inline int can_use_console(unsigned int cpu)
 	return cpu_online(cpu) || have_callable_console();
 }
 
+static int boot_console_active = 1;
+
 /*
  * Try to get console ownership to actually show the kernel
  * messages from a 'printk'. Return true (and with the
@@ -848,7 +850,7 @@ static int console_trylock_for_printk(unsigned int cpu, unsigned long flags)
 	int retval = 0, wake = 0;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int lock = (!early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
-		!preempt_count()) || sysrq_in_progress;
+		!preempt_count()) || sysrq_in_progress || boot_console_active;
 #else
 	int lock = 1;
 #endif
@@ -1653,6 +1655,7 @@ void register_console(struct console *newcon)
 		 */
 		printk(KERN_INFO "console [%s%d] enabled, bootconsole disabled\n",
 			newcon->name, newcon->index);
+		boot_console_active = 0;
 		for_each_console(bcon)
 			if (bcon->flags & CON_BOOT)
 				unregister_console(bcon);
-- 
1.7.7.6


--------------030600090005020403040804--
