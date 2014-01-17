From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/8] Linux 3.2.53-rt76-rc1
Date: Fri, 17 Jan 2014 08:21:11 -0500
Message-ID: <20140117082111.294930fe@gandalf.local.home>
References: <20140116015824.201732155@goodmis.org>
	<52D92990.1020904@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Rolf Peukert <rolf.peukert@imms.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:53677 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751958AbaAQNVM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jan 2014 08:21:12 -0500
In-Reply-To: <52D92990.1020904@imms.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 17 Jan 2014 14:01:04 +0100
Rolf Peukert <rolf.peukert@imms.de> wrote:

> On 16.01.2014 02:58, Steven Rostedt wrote:
> ...
> > Please scream at me if I messed something up. Please test the patches too.
> >
> 
> Hi Steven,
> 
> i just tried the incremental patch on our kernel and it applied without
> problems. But when I try to build it with only "Basic RT" configured, I
> get this error message:
> 
> kernel/softirq.c: In function 'invoke_softirq':
> kernel/softirq.c:626:2: error: 'else' without a previous 'if'
> 
> The source code before that line currently looks like this
> 
> #ifndef CONFIG_PREEMPT_RT_FULL
> 	if (!force_irqthreads)
> 		lockdep_softirq_from_hardirq();
> 		__do_softirq();
> 	else {
> 
> Is one of the lines in the wrong place or is it just missing brackets?

Looks to be missing brackets. Thanks for reporting this. This was
probably a bad merge.

I'll fix this up and do an official release of 3.2.53-rt76.

I guess I should test that config too. :-/

Thanks,

-- Steve

