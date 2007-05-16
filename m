From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.21-rt2
Date: Wed, 16 May 2007 14:47:16 -0700
Message-ID: <1179352036.20519.36.camel@imap.mvista.com>
References: <20070516180447.GA17922@elte.hu>
	 <1179348842.20519.20.camel@imap.mvista.com>
	 <20070516210104.GA17240@elte.hu>
	 <1179350448.20519.25.camel@imap.mvista.com>
	 <20070516213259.GC19850@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:41339 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbXEPVtc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 May 2007 17:49:32 -0400
In-Reply-To: <20070516213259.GC19850@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-05-16 at 23:32 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > > > http://lkml.org/lkml/2007/5/3/368
> > > 
> > > hm - trace_hardirqs_on() should never be called with irqs on - 
> > > lockdep could break for example. Could you try to fix the call site 
> > > instead?
> > 
> > If that's the case why check if they're enabled inside 
> > trace_hardirqs_on() ? If that check fails you still still get the 
> > warning in my original release ..
> 
> yeah, indeed you are right - it checks the soft flag. But even then, the 
> better fix is to check for hardirqs-off first and not to flip around the 
> preempt count check in irqs_off_preempt_count() - i.e. something like 
> the patch below. Does this solve the warning you've triggered with 
> irqsoff-tracing enabled?

I don't know. irqs_off_preempt_count() could get used someplace else,
where you would want to flip the preempt_count() check .. It seems sane
to combine your patch with mine ..

irqs_off_preempt_count() (!__get_cpu_var(trace_cpu_idle) && preempt_count())

You can't call __get_cpu_var() without the a positive preempt_count(),
so the check seems backwards regardless of the other factors ..

Daniel
