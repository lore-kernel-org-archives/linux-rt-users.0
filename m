From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Real-Time & Determinism
Date: Tue, 26 May 2009 16:22:02 -0700
Message-ID: <20090526232202.GC7006@linux.vnet.ibm.com>
References: <4A17F444.6070005@free.fr> <c384c5ea0905230609q5cce9b01ya2004b312b98b1e1@mail.gmail.com> <4A180113.8030203@free.fr>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leon Woestenberg <leon.woestenberg@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Antoine Nourry <nourry@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34200 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760589AbZEZXWB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2009 19:22:01 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4QNHWcs002746
	for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2009 19:17:32 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n4QNM2eU254668
	for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2009 19:22:02 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n4QNM2Lq005071
	for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2009 19:22:02 -0400
Content-Disposition: inline
In-Reply-To: <4A180113.8030203@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, May 23, 2009 at 03:58:43PM +0200, Antoine Nourry wrote:
>>> why can we read everywhere that Preempt_RT offers hard real time
>>> capabilities while on another hand we can find in some papers that it is 
>>> not deterministic and only gives assurance to obtain low latencies ?
>>> is it real
>>>     
>> Can you give some links of one and the other?
>>   
> For hard real time capabilities it is said (among numerous others) in 
> http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#About_the_RT-Preempt_Patch
>
> /"The standard Linux kernel only meets soft real-time requirements: it 
> provides basic POSIX operations for userspace time handling but has no 
> guarantees for hard timing deadlines. With Ingo Molnar's Realtime 
> Preemption patch (referenced to as RT-Preempt in this document) and Thomas 
> Gleixner's generic clock event layer with high resolution support, the 
> kernel gains hard realtime capabilities."/
>
> For lack of determinism :
>
> http://lwn.net/Articles/106010/ :
>
> /"NOTE: deterministic hard-rt is not about speed, it's about determinism. 
> While Ingo's work is great at reducing latency, it cannot *guarantee* 
> response times regardless of the load, kernel configuration, and driver 
> set. RTAI/fusion, and the Adeos interrupt pipeline on a smaller scale, can 
> provide such guarantees."/
>
> Actually, as you guessed i'm a beginner in real time sphere. I used Xenomai 
> for a previous work : turn a native linux driver for an USB DAQ device into 
> a real time one to ensure acquisitions within a definite cycle. The problem 
> is that i had to use a real time USB stack and only found USB4RT which 
> works but with some bugs and limitations. I'm now interested with the 
> RT_Preempt patch that would make me able to use the native Linux USB stack 
> (i'm not sure of this point...,  Is it only possible to obtain *constant 
> execution times* using USB with RT_Preempt ?).

The USB hardware itself is non-deterministic, from what I hear from the
USB guys.  But it all depends on what you need.

>>> time or not (deterministic) ? if yes, is it hard or soft RT ? Please 
>>> excuse me if i've missed something important.
>>
>> This is a simplistic summary as I learned it:
>>
>> It's hard real-time behaviour.
>>
>> However, as the kernel consist of a large amount of code, every piece
>> of code must behave properly with regard to locking etc. so that the
>> real-time scheduler is actually able to pre-empt with low latency
>> intervals.
>>
>> The tracing code has been included to find those long no-pre-empt
>> spots in the kernel code.
>>
> So, Is gaining total determinism under RT_Preempt just a matter of testing 
> that your particular code will not call "those long no-preempt spots" which 
> hadn't or couldn't been cut off from the kernel ?

That is indeed one definition that real users actually use for "hard
realtime".  Such users will provide a test suite based on what their
real-time application will be doing.  Not particularly satisfying from a
theoretical viewpoint, perhaps, but this is what really happens for some
sorts of applications.

There are a number of other definitions, see for example:

	http://www.linuxjournal.com/article/9361

In theory, one could analyze the Linux kernel to identify the longest
section of code running with preemption disabled, but as far as I know
this has not yet been done.

So if you need a mathematical proof that your real-time OS will respond
within a bounded time, then RT Linux might not be the right tool for
your job.  But a surprisingly large number of RT applications do not
need that level of assurance.

And I would not be surprised to hear that someone decided to bite the
bullet and actually mechanically analyze the Linux source/binary for
maximum latency.  ;-)

							Thanx, Paul
