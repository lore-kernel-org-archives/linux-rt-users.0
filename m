From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/8] Linux 3.2.53-rt76-rc1
Date: Fri, 17 Jan 2014 10:40:20 -0500
Message-ID: <20140117104020.33c2f9ea@gandalf.local.home>
References: <20140116015824.201732155@goodmis.org>
	<52D92990.1020904@imms.de>
	<20140117082111.294930fe@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Rolf Peukert <rolf.peukert@imms.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:50689 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752032AbaAQPkW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jan 2014 10:40:22 -0500
In-Reply-To: <20140117082111.294930fe@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 17 Jan 2014 08:21:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:


> > The source code before that line currently looks like this
> > 
> > #ifndef CONFIG_PREEMPT_RT_FULL
> > 	if (!force_irqthreads)
> > 		lockdep_softirq_from_hardirq();
> > 		__do_softirq();
> > 	else {
> > 
> > Is one of the lines in the wrong place or is it just missing brackets?
> 
> Looks to be missing brackets. Thanks for reporting this. This was
> probably a bad merge.
> 
> I'll fix this up and do an official release of 3.2.53-rt76.
> 
> I guess I should test that config too. :-/

Ah, the bug was in the #ifdef __ARCH_IRQ_EXIT_IRQS_DISABLED section.
Which is not compiled with x86.

OK, I need to start testing against PPC and ARM. I'll add that to my
todo list.

-- Steve

