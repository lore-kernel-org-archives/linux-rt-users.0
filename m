From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Thu, 13 May 2010 10:01:12 +0200
Message-ID: <4BEBB1C8.90606@steinhoff.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53764 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab0EMIuO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 04:50:14 -0400
In-Reply-To: <1273680443.27703.33.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven Rostedt wrote:
> On Tue, 2010-05-11 at 17:30 +0200, Asier Tamayo wrote:
>   
>> Hello Nivedita,
>>
>> Thanks for your answer.
>>
>>     
>>> What are your criteria?  Do you care about anything other
>>> than performance (availability, upgrades, cost, support,
>>> compatibility, tools, ...)?
>>>
>>> (...) you're best off testing the solutions that you can 
>>> get hold of with your own workload, in your own environment.
>>>
>>>       
>> Performance is a must. Besides, costs and tools are very important.
>> Support is also important, but I guess I'd find some good support for
>> any of the solutions.
>>
>> My new CPU has an Intel Atom N270 @1.6 GHz processor. At the moment
>> (during the porting it might be optimized), I have 5 drivers requering
>> hard real-time (no loop can be skipped) and being called every 2 to 10
>> ms. In fact, at the beginning I was using 1 ms, but I had some
>> problems with the hard real-time and changed the timing to 2 ms. I do
>> not consider using a legacy OS emulation.
>>     
>
> If tuned properly, PREEMPT_RT can easily handle 1ms requirements. On a
> standard x86 CPU (we support others than x86) our goal is never to be
>   

I did a test with user space based CAN driver.
Already the standard distribution of SUSE 11.2 (non RT) was able to 
handle 1000 frames per seconds sent by a QNX6 machine !!

The PREEMPT_RT version of SUSE 11.2 is much, much faster :-)
> over 100us in reaction time.
>   

The latency test of PREEMPT_RT shows a latency of ~10us for a dual-core 
box at 1.8GHz.

--Armin

http://www.steinhoff-automation.com


