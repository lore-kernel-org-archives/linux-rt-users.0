From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Use the RT Latency Trace? - LET ME KNOW!
Date: Thu, 24 Jan 2008 22:06:19 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801242201100.20902@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
 <1201229483.18044.1.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38856 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYAYDHJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Jan 2008 22:07:09 -0500
In-Reply-To: <1201229483.18044.1.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 24 Jan 2008, Daniel Walker wrote:

>
> On Thu, 2008-01-24 at 15:36 -0500, Steven Rostedt wrote:
> > Hi all,
> >
> > I'm about to gut the RT latency tracer with the version I'm pushing
> > upstream. This will be some of the changes:
> >
>
> Do you have all the functionality of the prior tracer ? Specifically the
> histogram support .. I can vouch for the fact that it's getting used.. I
> would prefer you don't gut the current tracer unless you have the same
> level of functionality ..

OK, I didn't even know the histogram worked.

Which histogram did you use? all both? I'll try to implement it for
upstream then, and port that over to -rt.

Whenever there's a push to get part of the -rt kernel upstream, we replace
what is in RT for what goes mainline. I'm trying hard to keep the same
functionality, but the way it works changes a bit so we gain some more
functionality while losing a bit of others. One thing is that we always
trace all CPUS (except for preempt/irqs off max).

Another is that we don't print traces on oops (yet). Although I did
scalvage the PREEMPT_TRACE to print that.

Let me know if you use all the histograms and I'll see if I can get them
in tomorrow.

-- Steve
