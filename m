From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: 2.6.33.2-rt13: RFC: fix serial console
Date: Wed, 21 Apr 2010 15:59:02 +0400
Message-ID: <201004211559.03022@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stas Bezzubtsev <stas@lvk.cs.msu.su>,
	Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:37339 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab0DUL7I (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Apr 2010 07:59:08 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

We've found that serial console stops showing printk messages after system 
boot completes. Kernel 2.6.33.2-rt13, 32-bit x86.

After some analysis, I found that output is blocked by 
console_atomic_safe() macro

#ifdef CONFIG_PREEMPT_RT
# define console_atomic_safe(con)		\
	(((con)->flags & CON_ATOMIC) ||		\
	 (!in_atomic() && !irqs_disabled()) ||	\
	 (system_state != SYSTEM_RUNNING) ||	\
	 oops_in_progress)
#else
# define console_atomic_safe(con) (1)
#endif


After adding CON_ATOMIC flag to 8250 console, I got serial console working 
again.

--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2814,7 +2814,7 @@ static struct console serial8250_console = {
        .device         = uart_console_device,
        .setup          = serial8250_console_setup,
        .early_setup    = serial8250_console_early_setup,
-       .flags          = CON_PRINTBUFFER,
+       .flags          = CON_PRINTBUFFER | CON_ATOMIC,
        .index          = -1,
        .data           = &serial8250_reg,
 };

Although I believe this patch is correct (serial8250_console_write() looks 
safe against calls in atomic context), it is unclear for me why this 
helped.
console_atomic_safe() should return 1 if printk was called from non-atomic 
context. However, no printk showed anything in serial - including printk() 
from module init routine, which is definitly not in atomic context.
So there is likely a bug elsewhere.

Any comments?

