From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/2] fix printk flush of messages
Date: Fri, 24 Aug 2012 23:49:01 -0400
Message-ID: <20120825035051.968542677@goodmis.org>
References: <20120825034900.144648579@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Frank <Frank_Rowand@sonyusa.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:19860 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab2HYDux (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2012 23:50:53 -0400
Content-Disposition: inline; filename=0001-fix-printk-flush-of-messages.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Updates console-make-rt-friendly.patch

#ifdef CONFIG_PREEMPT_RT_FULL, printk() output is never flushed by
printk() because:

   # some liberties taken in this pseudo-code to make it easier to follow
   printk()
      vprintk()
         raw_spin_lock(&logbuf_lock)
            # increment preempt_count():
            preempt_disable()
      result = console_trylock_for_printk()
         retval = 0
         # lock will always be false, because preempt_count() will be >= 1
         lock = ... && !preempt_count()
         if (lock)
            retval = 1
         return retval
      # result will always be false since lock will always be false
      if (result)
         console_unlock()
            # this is where the printk() output would be flushed

On system boot some printk() output is flushed because register_console()
and tty_open() call console_unlock().

This change also fixes the problem that was previously fixed by
preempt-rt-allow-immediate-magic-sysrq-output-for-preempt_rt_full.patch

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Cc: Frank <Frank_Rowand@sonyusa.com>
Link: http://lkml.kernel.org/r/4FB44FD0.4090800@am.sony.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 60f4290..f2c459f 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -835,7 +835,7 @@ static int console_trylock_for_printk(unsigned int cpu, unsigned long flags)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int lock = (!early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
-		!preempt_count()) || sysrq_in_progress;
+		(preempt_count() <= 1)) || sysrq_in_progress;
 #else
 	int lock = 1;
 #endif
-- 
1.7.10.4


