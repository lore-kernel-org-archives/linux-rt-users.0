From: ankita@in.ibm.com (Ankita Garg)
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Fri, 19 Oct 2007 16:41:40 +0530
Message-ID: <20071019111140.GA16728@in.ibm.com>
References: <20071018124827.GA22282@in.ibm.com> <20071018.055242.115933276.davem@davemloft.net> <20071018132614.GB22282@in.ibm.com> <Pine.LNX.4.58.0710180934170.10242@gandalf.stny.rr.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Miller <davem@davemloft.net>, linux-rt-users@vger.kernel.org,
	ghaskins@novell.com, mingo@elte.hu, dino@in.ibm.com,
	dvhltc@us.ibm.com, kravetz@us.ibm.com
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP06.au.ibm.com ([202.81.18.175]:53342 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbXJSLLq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 07:11:46 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9JBBgAk014851
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Oct 2007 21:11:42 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9JBBh7c2056292
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Oct 2007 21:11:43 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9JBBg3A028294
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Oct 2007 21:11:43 +1000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0710180934170.10242@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,

On Thu, Oct 18, 2007 at 09:38:44AM -0400, Steven Rostedt wrote:
> 
> --
> When I'm asked what language is my mother tongue,
> I simply answer "C".
> 
> On Thu, 18 Oct 2007, Ankita Garg wrote:
> 
> > > > Any thoughts on where in the code could these large latencies be
> > > > attributed to?
> > >
> > > If the max latency is usually the first one, it's could be the page
> > > fault the signal handler is taking the first time it is executed.
> >
> > Thanks for looking into this. Attaching the entire log from the testrun.
> > It indicates that in each run of the 10000 iterations, there are about 100+
> > failures, with large iterations. Also, on intrumenting the testcode to
> > find out the iterations which see large latencies, I see that as the
> > number of iterations increase, the latencies increase.
> 
> OK, this doesn't look like page faulting issues. But it is still a good
> idea to add mlock to any RT tests.
> 
> Could this possible be simply cache misses that cause this?  There's a bit
> of code to send a signal. What would the impact of cold cache be on this?
> 
> One way is to see the mininum run of running with cached disabled. Not
> sure if there's any way to disable cache via a kernel command line. Of
> course that would make the system very slow to boot ;-)
>

The machines I am working on does not support disabling caches via BIOS
and as Documentation/memory.txt suggests, BIOS seems to be the only way.

Also, mlocking did not make any difference in the latencies.

> -- Steve

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   
