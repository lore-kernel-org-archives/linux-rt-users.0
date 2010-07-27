From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33.6-rt26: consoles not working properly
Date: Tue, 27 Jul 2010 11:41:29 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007271127540.2672@localhost.localdomain>
References: <1279895985.9947.10.camel@marge.simson.net> <1280031383.7487.0.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51328 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab0G0Jle (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Jul 2010 05:41:34 -0400
In-Reply-To: <1280031383.7487.0.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 25 Jul 2010, Mike Galbraith wrote:

> On Fri, 2010-07-23 at 16:39 +0200, Mike Galbraith wrote: 
> > Greetings,
> > 
> > Consoles (serial and vt) are going silent after.
> > 
> > [    1.100178] Freeing initrd memory: 9348k freed
> > [    1.453009] Freeing unused kernel memory: 1000k freed
> > [    1.464463] Freeing unused kernel memory: 512k freed
> > [    1.469724] Freeing unused kernel memory: 360k freed
> > 
> > If the kernel is configured PREEMPT_VOLUNTARY, consoles work fine again.
> > So far, I've only eyeballed the rt patch, and noticed nothing.  I'll be
> > poking around in (shudder) console code soon I suppose, but before I
> > start that.. adventure, is this a known issue?
> 
> Hm, that was suspiciously easy.
> 
> console: really enable interrupts in release_console_mutex()
> 
> vprintk()
>    raw_local_irq_save()
>    acquire_console_mutex_for_printk()
>    release_console_mutex()
>       raw_spin_unlock_save()
>       raw_spin_unlock_irqrestore()
>       call_console_drivers()
>          _call_console_drivers()
>             __call_console_drivers()
>                console_atomic_safe() "nope".
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> ---
>  kernel/printk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: tip-rt/kernel/printk.c
> ===================================================================
> --- tip-rt.orig/kernel/printk.c
> +++ tip-rt/kernel/printk.c
> @@ -1072,7 +1072,7 @@ void release_console_mutex(void)
>  		 * with interrupts disabled):
>  		 */
>  #ifdef CONFIG_PREEMPT_RT
> -		raw_spin_unlock_irqrestore(&logbuf_lock, flags);
> +		raw_spin_unlock_irq(&logbuf_lock);

Not really a good idea. If printk is called from an irq disabled
region, then we unconditionally enabled interrupts here. The comment
above this is misleading and needs to be removed. We had problems in
that area before. Does the following patch solve your problem as well ?

Thanks,

	tglx

diff --git a/kernel/printk.c b/kernel/printk.c
index bbce874..3b22cf4 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -797,8 +797,11 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * will release 'logbuf_lock' regardless of whether it
 	 * actually gets the mutex or not.
 	 */
-	if (acquire_console_mutex_for_printk(this_cpu))
+	if (acquire_console_mutex_for_printk(this_cpu)) {
+		raw_local_irq_restore(flags);
 		release_console_mutex();
+		raw_local_irq_save(flags);
+	}
 
 	lockdep_on();
 out:




