From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.14.23-rt20 - x86, UV: raw_spinlock conversion
Date: Tue, 17 Feb 2015 14:02:49 +0100
Message-ID: <20150217130249.GK26177@linutronix.de>
References: <20141031170326.1491a63f@gandalf.local.home>
 <1414910967.5380.81.camel@marge.simpson.net>
 <1414913497.5380.116.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43640 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbbBQNCw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 08:02:52 -0500
Content-Disposition: inline
In-Reply-To: <1414913497.5380.116.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2014-11-02 08:31:37 [+0100]:

>Shrug.  Lots of hobbyists have a beast in their basement, right?

I can take this as is if you want.

>--- a/arch/x86/platform/uv/uv_time.c
>+++ b/arch/x86/platform/uv/uv_time.c
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

but do you really want a migrate_disable() in here? The only problem I
can imagine is that you switch CPUs between uv_blade_processor_id()
and the actual read. I recommend preempt_disable() and sending this
upstream as well since it is not limited to -RT.

Sebastian
