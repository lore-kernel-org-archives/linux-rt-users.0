From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch] x86,uv: -rt conversions
Date: Fri, 21 Jun 2013 15:52:04 +0200
Message-ID: <20130621135204.GD21228@linutronix.de>
References: <1371651978.5845.75.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39383 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161356Ab3FUNwH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 09:52:07 -0400
Content-Disposition: inline
In-Reply-To: <1371651978.5845.75.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-06-19 16:26:18 [+0200]:

>
>The below is what I use to run -rt on UV boxen, diff generated against
>3.8-rt.  Should the lock conversions perhaps wander to mainline?

They seem to come from NMI or irq off region so if you can't change this
why not.

>Signed-off-by: Mike Galbraith <bitbucket@online.de>
>
>Index: linux-2.6/arch/x86/platform/uv/uv_time.c
>===================================================================
>--- linux-2.6.orig/arch/x86/platform/uv/uv_time.c
>+++ linux-2.6/arch/x86/platform/uv/uv_time.c
>@@ -300,13 +300,18 @@ static int uv_rtc_unset_timer(int cpu, i
> static cycle_t uv_read_rtc(struct clocksource *cs)
> {
> 	unsigned long offset;
>+	cycle_t cycles;
> 
>+	migrate_disable();
> 	if (uv_get_min_hub_revision_id() == 1)
> 		offset = 0;
> 	else
> 		offset = (uv_blade_processor_id() * L1_CACHE_BYTES) % PAGE_SIZE;
> 
>-	return (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
>+	cycles = (cycle_t)uv_read_local_mmr(UVH_RTC | offset);
>+	migrate_enable();
>+
>+	return cycles;
> }
You try to ensure not to switch CPUs between uv_blade_processor_id() and
uv_read_local_mmr()'s final HW access, right?

Sebastian
