From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: proposed FAQ entry for rt.wiki.kernel.org
Date: Thu, 22 Oct 2009 11:52:09 -0700
Message-ID: <4AE0A9D9.6050604@us.ibm.com>
References: <20091022120832.4bfd29e2@torg>	<4AE0A17B.9020201@us.ibm.com> <20091022132948.480d3d03@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:59416 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZJVSwO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 14:52:14 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9MIpBTY011716
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 12:51:11 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n9MIqDkb156458
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 12:52:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id n9MIqCYL020500
	for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2009 12:52:13 -0600
In-Reply-To: <20091022132948.480d3d03@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams wrote:
> How's this:
> 
> Q. How does Real-Time Linux (aka the PREEMPT_RT patch) improve
> "latency"?

Works for me

>> I'm not sure the bit about "spinlocks have a context to return to" makes 
>> sense in an elevator-type pitch, might be too low level, and detract 
>> from the high-level message?
>>
> 
> Well, some of the people that have asked were actually looking for a
> more technical description than was available in, ahem, Marketing
> Literature. So I guess I was attempting to straddle that fence. I will
> re-arrange that last sentence to put prioritization first or may be
> split it into two sections. How about this:
> 
> This means that interrupt service order may be prioritized by
> assigning appropriate realtime priorities to the interrupt threads. 

I was specifically thinking that the balance between application and 
interrupt thread should be mentioned, while this seems to focus on the 
relative priorities of just the interrupt threads.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
