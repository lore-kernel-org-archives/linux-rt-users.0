From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Question regarding pthread_cond_wait/pthread_cond_signal latencies
Date: Sun, 22 May 2011 17:18:33 +0200
Message-ID: <4DD92949.4010401@steinhoff.de>
References: <1305890110.10494.32.camel@laika> <4DD9235D.50900@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52379 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1EVPKi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 May 2011 11:10:38 -0400
In-Reply-To: <4DD9235D.50900@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Armin Steinhoff wrote:
> Pedro Gonnet wrote:
>> Hi guys,
>>
>> I'm currently working on a shared-memory parallel Molecular Dynamics
>> simulation library (http://mdcore.sourceforge.net/) geared towards
>> multi-core systems.
>>
>> The library uses pthreads (plus some OpenMP for some simple loops) and
>> uses pthread_cond_wait and pthread_cond_signal to coordinate a group of
>> worker threads.
>>
>> I've been profiling the library on different machines and kernels and
>> have noticed that in many cases there are significant (several ms,
>> measured with Intel's Vtune-thing) lags between calls to
>> pthread_cond_signal and the waiting thread actually getting back to
>> work.
>
> At what priority are the worker threads running ?
>
> In order to schedule these threads by the real-time part of the CFS 
> scheduler they should run at lest at a priority of 20 (rt_sched_class)


     ... and you have to use SCHED_RR or SCHED_FIFO for the scheduling 
method

--Armin

>
> Regards
>
> --Armin
>
>
>> I've tried the Ubuntu -rt and -preempt kernels, and the whole simulation
>> runs twice as slowly, despite following the advice given here:
>>
>>          
>> https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application
>>
>> My question is the following: which kernel (or set of configuration
>> options) will minimize these latencies? And if linux-rt is the answer,
>> in what ways do I have to be careful when porting the simulation for
>> this kernel?
>>
>> Cheers and thanks,
>> Pedro
>>
>>
>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

