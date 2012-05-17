From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH RT 2/2] fix printk flush of messages
Date: Wed, 16 May 2012 18:09:36 -0700
Message-ID: <4FB44FD0.4090800@am.sony.com>
References: <4FB44EF1.9050809@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Rowand, Frank" <Frank_Rowand@sonyusa.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FB44EF1.9050809@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


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

---
 kernel/printk.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/kernel/printk.c
===================================================================
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -847,7 +847,7 @@ static int console_trylock_for_printk(un
 	int retval = 0, wake = 0;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	int lock = !early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
-		!preempt_count();
+		(preempt_count() <= 1);
 #else
 	int lock = 1;
 #endif
