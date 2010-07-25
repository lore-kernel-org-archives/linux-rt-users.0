From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.6-rt26: consoles not working properly
Date: Sun, 25 Jul 2010 06:16:23 +0200
Message-ID: <1280031383.7487.0.camel@marge.simson.net>
References: <1279895985.9947.10.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750716Ab0GYEPg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jul 2010 00:15:36 -0400
In-Reply-To: <1279895985.9947.10.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-07-23 at 16:39 +0200, Mike Galbraith wrote: 
> Greetings,
> 
> Consoles (serial and vt) are going silent after.
> 
> [    1.100178] Freeing initrd memory: 9348k freed
> [    1.453009] Freeing unused kernel memory: 1000k freed
> [    1.464463] Freeing unused kernel memory: 512k freed
> [    1.469724] Freeing unused kernel memory: 360k freed
> 
> If the kernel is configured PREEMPT_VOLUNTARY, consoles work fine again.
> So far, I've only eyeballed the rt patch, and noticed nothing.  I'll be
> poking around in (shudder) console code soon I suppose, but before I
> start that.. adventure, is this a known issue?

Hm, that was suspiciously easy.

console: really enable interrupts in release_console_mutex()

vprintk()
   raw_local_irq_save()
   acquire_console_mutex_for_printk()
   release_console_mutex()
      raw_spin_unlock_save()
      raw_spin_unlock_irqrestore()
      call_console_drivers()
         _call_console_drivers()
            __call_console_drivers()
               console_atomic_safe() "nope".

Signed-off-by: Mike Galbraith <efault@gmx.de>

---
 kernel/printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip-rt/kernel/printk.c
===================================================================
--- tip-rt.orig/kernel/printk.c
+++ tip-rt/kernel/printk.c
@@ -1072,7 +1072,7 @@ void release_console_mutex(void)
 		 * with interrupts disabled):
 		 */
 #ifdef CONFIG_PREEMPT_RT
-		raw_spin_unlock_irqrestore(&logbuf_lock, flags);
+		raw_spin_unlock_irq(&logbuf_lock);
 #else
 		raw_spin_unlock(&logbuf_lock);
 		stop_critical_timings();	/* don't trace print latency */


