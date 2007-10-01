From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Mon, 1 Oct 2007 23:58:07 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710012349160.20478@localhost.localdomain>
References: <46FA4A800200006C000192FE@sinclair.provo.novell.com> <20071001125626.32eb6d0b@laptopd505.fenrus.org> <alpine.LFD.0.9999.0710012207270.20478@localhost.localdomain> <200710012341.53169.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Arjan van de Ven <arjan@infradead.org>,
	David Bahi <dbahi@novell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <GHaskins@novell.com>
To: Andi Kleen <ak@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:36501 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbXJAV7J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 17:59:09 -0400
In-Reply-To: <200710012341.53169.ak@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 1 Oct 2007, Andi Kleen wrote:
> 
> > IRQ_NOBALANCING is not preventing cpu unplug. It moves the affinity to the
> > next CPU, but the check in NMI watchdog for CPU == 0 would not longer
> > work.
> 
> That cannot happen right now because cpu_disable() on both i386/x86-64
> reject CPU #0. So just setting IRQ_NOBALANCING is sufficient and both
> do that already. I was wrong earlier in being concerned about this.
> 
> >  int tick_do_broadcast(cpumask_t mask)
> > @@ -137,6 +147,7 @@ int tick_do_broadcast(cpumask_t mask)
> >  		cpu_clear(cpu, mask);
> >  		td = &per_cpu(tick_cpu_device, cpu);
> >  		td->evtdev->event_handler(td->evtdev);
> > +		tick_broadcast_account(cpu);
> 
> That would not handle the case with a single CPU running only
> irq  0 but not broadcasting I think.

Hmm. The only situation where this can happen is when you add
"nolapic_timer" to the command line on a single CPU system. We do not
register the lapic "dummy" clock event device then.

> I believe 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/fix-watchdog
> is the correct fix

Yup, I completely missed the fact, that we reject CPU#0 unplugging, so
your fix seems indeed to be more correct and simpler.

OTOH, the accounting hook would allow us to remove the IRQ#0 -> CPU#0
restriction. Not sure whether it's worth the trouble.

     tglx
