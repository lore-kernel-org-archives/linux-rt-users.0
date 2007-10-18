From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Thu, 18 Oct 2007 09:38:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710180934170.10242@gandalf.stny.rr.com>
References: <20071018124827.GA22282@in.ibm.com> <20071018.055242.115933276.davem@davemloft.net>
 <20071018132614.GB22282@in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Miller <davem@davemloft.net>, linux-rt-users@vger.kernel.org,
	ghaskins@novell.com, mingo@elte.hu, dino@in.ibm.com,
	dvhltc@us.ibm.com, kravetz@us.ibm.com
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:60001 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358AbXJRNkC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Oct 2007 09:40:02 -0400
In-Reply-To: <20071018132614.GB22282@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
When I'm asked what language is my mother tongue,
I simply answer "C".

On Thu, 18 Oct 2007, Ankita Garg wrote:

> > > Any thoughts on where in the code could these large latencies be
> > > attributed to?
> >
> > If the max latency is usually the first one, it's could be the page
> > fault the signal handler is taking the first time it is executed.
>
> Thanks for looking into this. Attaching the entire log from the testrun.
> It indicates that in each run of the 10000 iterations, there are about 100+
> failures, with large iterations. Also, on intrumenting the testcode to
> find out the iterations which see large latencies, I see that as the
> number of iterations increase, the latencies increase.

OK, this doesn't look like page faulting issues. But it is still a good
idea to add mlock to any RT tests.

Could this possible be simply cache misses that cause this?  There's a bit
of code to send a signal. What would the impact of cold cache be on this?

One way is to see the mininum run of running with cached disabled. Not
sure if there's any way to disable cache via a kernel command line. Of
course that would make the system very slow to boot ;-)

-- Steve
