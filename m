From: Antoine Nourry <nourry@free.fr>
Subject: Re: Real-Time & Determinism
Date: Sat, 23 May 2009 15:58:43 +0200
Message-ID: <4A180113.8030203@free.fr>
References: <4A17F444.6070005@free.fr> <c384c5ea0905230609q5cce9b01ya2004b312b98b1e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp20.orange.fr ([193.252.22.31]:29328 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbZEWN6j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 May 2009 09:58:39 -0400
In-Reply-To: <c384c5ea0905230609q5cce9b01ya2004b312b98b1e1@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


>> why can we read everywhere that Preempt_RT offers hard real time
>> capabilities while on another hand we can find in some papers that it is not
>> deterministic and only gives assurance to obtain low latencies ? is it real
>>
>>     
> Can you give some links of one and the other?
>
>   
For hard real time capabilities it is said (among numerous others) in 
http://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#About_the_RT-Preempt_Patch 


/"The standard Linux kernel only meets soft real-time requirements: it 
provides basic POSIX operations for userspace time handling but has no 
guarantees for hard timing deadlines. With Ingo Molnar's Realtime 
Preemption patch (referenced to as RT-Preempt in this document) and 
Thomas Gleixner's generic clock event layer with high resolution 
support, the kernel gains hard realtime capabilities."/


For lack of determinism :

http://lwn.net/Articles/106010/ :

/"NOTE: deterministic hard-rt is not about speed, it's about 
determinism. While Ingo's work is great at reducing latency, it cannot 
*guarantee* response times regardless of the load, kernel configuration, 
and driver set. RTAI/fusion, and the Adeos interrupt pipeline on a 
smaller scale, can provide such guarantees."/

Actually, as you guessed i'm a beginner in real time sphere. I used 
Xenomai for a previous work : turn a native linux driver for an USB DAQ 
device into a real time one to ensure acquisitions within a definite 
cycle. The problem is that i had to use a real time USB stack and only 
found USB4RT which works but with some bugs and limitations. I'm now 
interested with the RT_Preempt patch that would make me able to use the 
native Linux USB stack (i'm not sure of this point...,  Is it only 
possible to obtain *constant execution times* using USB with RT_Preempt ?).

>> time or not (deterministic) ? if yes, is it hard or soft RT ? Please excuse
>> me if i've missed something important.
>>
>>     
>
> This is a simplistic summary as I learned it:
>
> It's hard real-time behaviour.
>
> However, as the kernel consist of a large amount of code, every piece
> of code must behave properly with regard to locking etc. so that the
> real-time scheduler is actually able to pre-empt with low latency
> intervals.
>
> The tracing code has been included to find those long no-pre-empt
> spots in the kernel code.
>
>   
So, Is gaining total determinism under RT_Preempt just a matter of 
testing that your particular code will not call "those long no-preempt 
spots" which hadn't or couldn't been cut off from the kernel ?

Thank you very much,
Antoine

