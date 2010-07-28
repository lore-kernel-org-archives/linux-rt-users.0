From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.6-rt26: consoles not working properly
Date: Wed, 28 Jul 2010 04:04:57 +0200
Message-ID: <1280282697.7639.8.camel@marge.simson.net>
References: <1279895985.9947.10.camel@marge.simson.net>
	 <1280031383.7487.0.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007271127540.2672@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36720 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753935Ab0G1CE5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Jul 2010 22:04:57 -0400
In-Reply-To: <alpine.LFD.2.00.1007271127540.2672@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2010-07-27 at 11:41 +0200, Thomas Gleixner wrote:
> On Sun, 25 Jul 2010, Mike Galbraith wrote:
> 
> > On Fri, 2010-07-23 at 16:39 +0200, Mike Galbraith wrote: 
> > > Greetings,
> > > 
> > > Consoles (serial and vt) are going silent after.
> > > 
> > > [    1.100178] Freeing initrd memory: 9348k freed
> > > [    1.453009] Freeing unused kernel memory: 1000k freed
> > > [    1.464463] Freeing unused kernel memory: 512k freed
> > > [    1.469724] Freeing unused kernel memory: 360k freed
> > > 
> > > If the kernel is configured PREEMPT_VOLUNTARY, consoles work fine again.
> > > So far, I've only eyeballed the rt patch, and noticed nothing.  I'll be
> > > poking around in (shudder) console code soon I suppose, but before I
> > > start that.. adventure, is this a known issue?
> > 
> > Hm, that was suspiciously easy.
> > 
> > console: really enable interrupts in release_console_mutex()
> > 
> > vprintk()
> >    raw_local_irq_save()
> >    acquire_console_mutex_for_printk()
> >    release_console_mutex()
> >       raw_spin_unlock_save()
> >       raw_spin_unlock_irqrestore()
> >       call_console_drivers()
> >          _call_console_drivers()
> >             __call_console_drivers()
> >                console_atomic_safe() "nope".
> > 
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > 
> > ---
> >  kernel/printk.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: tip-rt/kernel/printk.c
> > ===================================================================
> > --- tip-rt.orig/kernel/printk.c
> > +++ tip-rt/kernel/printk.c
> > @@ -1072,7 +1072,7 @@ void release_console_mutex(void)
> >  		 * with interrupts disabled):
> >  		 */
> >  #ifdef CONFIG_PREEMPT_RT
> > -		raw_spin_unlock_irqrestore(&logbuf_lock, flags);
> > +		raw_spin_unlock_irq(&logbuf_lock);
> 
> Not really a good idea. If printk is called from an irq disabled
> region, then we unconditionally enabled interrupts here. The comment
> above this is misleading and needs to be removed. We had problems in
> that area before. Does the following patch solve your problem as well ?

Aha.  Yes, it does.

	-Mike

