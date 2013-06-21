From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [rfc patch] x86,uv: -rt conversions
Date: Fri, 21 Jun 2013 16:45:38 +0200
Message-ID: <1371825938.5953.28.camel@marge.simpson.net>
References: <1371651978.5845.75.camel@marge.simpson.net>
	 <20130621135204.GD21228@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52077 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161419Ab3FUOpm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 10:45:42 -0400
In-Reply-To: <20130621135204.GD21228@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-06-21 at 15:52 +0200, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2013-06-19 16:26:18 [+0200]:
> 
> >
> >The below is what I use to run -rt on UV boxen, diff generated against
> >3.8-rt.  Should the lock conversions perhaps wander to mainline?
> 
> They seem to come from NMI or irq off region so if you can't change this
> why not.

Maybe SGI can, they know what a bau is.  I only made their locks happy.

> >Signed-off-by: Mike Galbraith <bitbucket@online.de>
> >
> >Index: linux-2.6/arch/x86/platform/uv/uv_time.c
> >===================================================================
> >--- linux-2.6.orig/arch/x86/platform/uv/uv_time.c
> >+++ linux-2.6/arch/x86/platform/uv/uv_time.c
> >@@ -300,13 +300,18 @@ static int uv_rtc_unset_timer(int cpu, i
> > static cycle_t uv_read_rtc(struct clocksource *cs)
> > {
> > 	unsigned long offset;
> >+	cycle_t cycles;
> > 
> >+	migrate_disable();
> > 	if (uv_get_min_hub_revision_id() == 1)
> > 		offset = 0;
> > 	else
> > 		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
> > 
> >-	return (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
> >+	cycles = (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
> >+	migrate_enable();
> >+
> >+	return cycles;
> > }

> You try to ensure not to switch CPUs between uv_blade_processor_id() and
> uv_read_local_mmr()'s final HW access, right?

Yeah.  I originally did preempt_disable/enable() a couple years ago
while convincing a UV to boot/run 2.6.33-rt (x2apic dmar intr_remap
etc), it turned into migrate_disable/enable() as time passed.  I'm not
so sure it's really enough, but I was recently given a UV2000 to tinker
with, and both it and old UV100 box boot and (seem to) run fine as is.

-Mike

