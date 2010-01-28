From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Replacement for Xenomai's Message queues?
Date: Thu, 28 Jan 2010 13:12:54 -0800
Message-ID: <4B61FDD6.2080409@us.ibm.com>
References: <4B61DDF2.6010309@us.ibm.com> <21390406.1264666196447.JavaMail.ngmail@webmail08.arcor-online.net> <5579824.1264709193179.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "M. Koehrer" <mathias_koehrer@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:45836 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab0A1VNU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jan 2010 16:13:20 -0500
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SLAaxd028009
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 14:10:36 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o0SLCulu102434
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 14:13:01 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o0SLCt0H030204
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Jan 2010 14:12:55 -0700
In-Reply-To: <5579824.1264709193179.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

M. Koehrer wrote:
> Hi Darren,
> 
> thanks for the response.
> You are right, I should clarify the needs I have...
> I have two real time applications (two processes), each running a few real time threads.
> For inter process communication I want to exchange data between the two applications.
> For this I want to use two queues - one for direction A->B and one for B->A.
> Now I have the situation that one thread in B that handles the A->B queue is waiting for data from A.
> Whenever A has the data available, it writes the data into the A->B queue.
> Immediately after receiving data from A, B unblocks and computes some answer data that is written
> into the B->A queue. 
> The time between sending the data in A and getting the data back from B should be as low as possible 
> (real time requirements: at max tens of microseconds...).
> 
> The functionality of mq_send, mq_receive looks suitable.
> However I am not sure if this can fulfil my performance needs...
> Perhaps I still have the "Xenomai" thinking which means that only some special API functions are real time capable
> all others are not... With the RT_PREEMPT patch this seems to be much easier as I can use all suitable functionality
> (or did I miss some important thing here?!?).

You would need to look into how glibc implements the mq_* functions. If 
there are internal locks that are not PI aware (seems likely) then you 
will have limited RT functionality in that an unbounded priority 
inversion would be possible if you aren't very careful in how you 
program your application. Since I haven't examined these paths myself, I 
can't say if there are other issues with using them in a real-time 
system. If you do dig into this, please share what you find, perhaps 
there is something that can be done to improve these interfaces if they 
do not meet your needs.

There are also commercial messaging middleware products that are aimed 
at meeting your requirements of low latency.

Thanks,

--
Darren Hart


> Regards
> 
> Mathias
> 
> 
>>> Hi all,
>>>
>>> I am about to switch an realtime application from Xenomai to the
>> RT_PREEMPTION patch.
>>> Everything works really smooth, however I have one question.
>>> With my Xenomai application I use the message queue which combine transfer
>> (including queuing)
>>> of data with activation of the thread.
>>> In my Xenomai application I use this feature quite frequently. Now, I am
>> not sure how to do an equivalent
>>> with the RT_PREEMPT patch.
>>> (see
>> http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__native__que
>> ue.html)
>>> Of course I could use condition variables and a struct or array to hold
>> the data I want to pass with the activation
>>> of a thread. However, using this approach I do not have the queuing (which
>> is some extra effort I could spent...).
>>> Another idea I have: I could use sockets which realize the queuing but the
>> overhead is too high.
>>> Is there any suitable way to implement a message queue like approach using
>> RT_PREEMPT patch?
>>> I am running x86 (Dual/Quad Cores).
>> I don't if we have many xenomai experts on this list. It would help to 
>> understand which aspects of the Xenomai message queue are important to 
>> you (other than the ability to block on a queue and wake when a message 
>> is available). For a basic message queueing system with the ability to 
>> prioritize messages, you can look to the POSIX.4 Message Queues. A 
>> google search will provide plenty of howto's, and the API appears at 
>> least similar to what you were using with Xenomai.
>>
>> I haven't looked, but I don't think Linux supports message driven 
>> Priority Inheritance 
>> (http://www.qnx.com/developers/docs/6.3.2/neutrino/sys_arch/kernel.html#Prio
>> rity_inheritance_messages).
>>
>> -- 
> 
> 


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
