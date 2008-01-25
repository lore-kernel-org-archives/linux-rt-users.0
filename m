From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Use the RT Latency Trace? - LET ME KNOW!
Date: Fri, 25 Jan 2008 14:54:42 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801251452040.28869@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
 <871w85rb10.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Kevin Hilman <khilman@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:54174 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbYAYTzv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jan 2008 14:55:51 -0500
In-Reply-To: <871w85rb10.fsf@paris.hilman.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 25 Jan 2008, Kevin Hilman wrote:
> > I'm about to gut the RT latency tracer with the version I'm pushing
> > upstream. This will be some of the changes:
>
> Might I request that you follow the mainline stabilization model and
> wait until the 2.6.25-rcX-rtY series to make a significant change like
> this?
>
> I have nothing against your changes, but am not crazy about seeing
> something like this happen in the "stable" part of the dev cycle.


??? - I'm unaware of a stable rt kernel. But I will grant you. I planned
on (and announced this) that 2.6.24-rt1 will not include the change. But
I'm hoping to use -rt as a place to show that the code is stable enough
for mainline, and that is why I'm pushing so hard for this now. I want
some of the code to be in 2.6.25-rc1.

-- Steve
