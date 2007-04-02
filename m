From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Poor UDP performance using 2.6.21-rc5-rt5
Date: Mon, 2 Apr 2007 11:37:40 +0200
Message-ID: <20070402093740.GA10091@elte.hu>
References: <461004CE.1030009@ieee.org> <20070402072111.GA21356@elte.hu> <4610BC15.5030800@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Dave Sperry <dave_sperry@ieee.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41253 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965301AbXDBJhn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Apr 2007 05:37:43 -0400
Content-Disposition: inline
In-Reply-To: <4610BC15.5030800@ieee.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Dave Sperry <dave_sperry@ieee.org> wrote:

> I checked the clock source and in both the vanilla and rt cases and 
> they were both acpi_pm

ok, thanks for double-checking that.

> Here's the oprofile for my vanilla case:

i tried your workload and i think i managed to optimize it some more: i 
have uploaded the -rt8 kernel with these improvements included - could 
you try it? Is there any measurable improvement relative to -rt5?

one more thing to improve netperf performance is to do this before 
running it:

  chrt -f -p 50 $$

this will put netperf on the same priority level as the net hardirq and 
the net softirq (which both default to SCHED_FIFO:50), and should result 
in a (much) reduced context-switch rate.

Or, if networking is not latency-critical, then you could move the net 
hardirq and softirq threads to SCHED_BATCH, and run netperf under 
SCHED_BATCH as well, using:

  chrt -b -p 0 $$

and figuring out the active softirq hardirq thread PIDs and "chrt -b" 
-ing them too.

	Ingo
