From: Andi Kleen <ak@suse.de>
Subject: Re: nmi_watchdog fix for x86_64 to be more like i386
Date: Mon, 1 Oct 2007 23:41:52 +0200
Message-ID: <200710012341.53169.ak@suse.de>
References: <46FA4A800200006C000192FE@sinclair.provo.novell.com> <20071001125626.32eb6d0b@laptopd505.fenrus.org> <alpine.LFD.0.9999.0710012207270.20478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Arjan van de Ven <arjan@infradead.org>,
	David Bahi <dbahi@novell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Gregory Haskins <GHaskins@novell.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47948 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbXJAVni (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 17:43:38 -0400
In-Reply-To: <alpine.LFD.0.9999.0710012207270.20478@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


> IRQ_NOBALANCING is not preventing cpu unplug. It moves the affinity to the
> next CPU, but the check in NMI watchdog for CPU == 0 would not longer
> work.

That cannot happen right now because cpu_disable() on both i386/x86-64
reject CPU #0. So just setting IRQ_NOBALANCING is sufficient and both
do that already. I was wrong earlier in being concerned about this.

>  int tick_do_broadcast(cpumask_t mask)
> @@ -137,6 +147,7 @@ int tick_do_broadcast(cpumask_t mask)
>  		cpu_clear(cpu, mask);
>  		td = &per_cpu(tick_cpu_device, cpu);
>  		td->evtdev->event_handler(td->evtdev);
> +		tick_broadcast_account(cpu);

That would not handle the case with a single CPU running only
irq  0 but not broadcasting I think.

I believe ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/fix-watchdog
is the correct fix

-Andi
