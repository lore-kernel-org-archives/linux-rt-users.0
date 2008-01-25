From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Use the RT Latency Trace? - LET ME KNOW!
Date: Fri, 25 Jan 2008 12:39:16 -0800
Message-ID: <87tzl1od1n.fsf@paris.hilman.org>
References: <Pine.LNX.4.58.0801241049280.31533@gandalf.stny.rr.com>
	<871w85rb10.fsf@paris.hilman.org>
	<Pine.LNX.4.58.0801251452040.28869@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:21728 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbYAYUjz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Jan 2008 15:39:55 -0500
In-Reply-To: <Pine.LNX.4.58.0801251452040.28869@gandalf.stny.rr.com> (Steven Rostedt's message of "Fri\, 25 Jan 2008 14\:54\:42 -0500 \(EST\)")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 25 Jan 2008, Kevin Hilman wrote:
>> > I'm about to gut the RT latency tracer with the version I'm pushing
>> > upstream. This will be some of the changes:
>>
>> Might I request that you follow the mainline stabilization model and
>> wait until the 2.6.25-rcX-rtY series to make a significant change like
>> this?
>>
>> I have nothing against your changes, but am not crazy about seeing
>> something like this happen in the "stable" part of the dev cycle.
>
> ??? - I'm unaware of a stable rt kernel. 

Neither am I. :) 

I just meant the stable part of the development cycle.  Just as I
don't expect any major changes between 2.6.24-rc8 and 2.6.24, I was
hoping for no major changest between the -rt patches against these
kernels as well.  I know the -rt patch has no promises of feature
stability or compatibility, hence the humble plea.

> But I will grant you. I planned on (and announced this) that
> 2.6.24-rt1 will not include the change. 

OK, I missed that in the announcment.  Thanks.

> But I'm hoping to use -rt as a place to show that the code is stable
> enough for mainline, and that is why I'm pushing so hard for this
> now. I want some of the code to be in 2.6.25-rc1.

Understood.  And thanks for the hard work.  I look forward to seeing
it in the 2.6.25-rc series too.

Thanks,

Kevin
