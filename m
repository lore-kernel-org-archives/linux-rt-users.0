From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Doubt: Does RT patch reduce interrupt latency?
Date: Fri, 24 Jul 2009 15:07:46 -0700
Message-ID: <4A6A30B2.5070709@us.ibm.com>
References: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sbs <sbs.pub@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48482 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbZGXWHs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2009 18:07:48 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6OM2YFh032690
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jul 2009 18:02:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n6OM7mGf245446
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jul 2009 18:07:48 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n6OM7ma2031144
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jul 2009 18:07:48 -0400
In-Reply-To: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sbs wrote:
> Hi All,
> 
> (Sorry if I am asking this on a wrong list. Please let me know the
> correct list for this question)
> 
> We have a system which needs to be connected to a device that will
> produce an interrupt during every msec. So, we want interrupt
> latencies less than 1 msec (else we will miss interrupts). We tried
> measuring interrupt latencies with RT patch applied. However, the
> results that he got suggested that after applying patches, the worst
> case latency went up.

As I understand it, if you are doing your processing via interrupts, the 
your latency to start processing interrupts will increase on average 
with the PREEMPT_RT patch.  There is additional scheduling overhead 
involved, and as Sven pointed out, if you don't bump the prio of the 
interrupt you care about, you can see MUCH higher latencies.

The PREEMPT_RT patch adds things like the rt-mutex replacement of most 
spinlocks, which adds preemption points and enable Priority Inheritance 
within the kernel, but this is all geared towards enable real-time 
applications.  If you just want fast OS processing of interrupts, then 
mainline provides you with a nice non-preemptible kernel side interrupt 
implementation that won't be affected by things like applications :-)

Please slap me if I've misrepresented PREEMPT_RT somehow. (I'm sure no 
invitation is actually required ;-)


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
