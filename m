From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 21:37:52 +0200
Message-ID: <4F970110.8020402@steinhoff.de>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>	<4F966AFC.7070803@cfl.rr.com> <CAF-VNaq3bkC=LCB-Emsx20xTm-Vm1v3kduC5MpyXQA_GS6SOhg@mail.gmail.com> <4F967574.8030104@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-rt <linux-rt-users@vger.kernel.org>
To: dmarkh@cfl.rr.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62767 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab2DXSc4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 14:32:56 -0400
In-Reply-To: <4F967574.8030104@cfl.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mark Hounschell wrote:
> On 04/24/2012 05:08 AM, Lars Segerlund wrote:
>>   This is not based on facts, rt-preempt does provide hard realtime and
>> strive to provide hard realtime, where have you come up with the
>> notion that it does not ?
>>
>>   Please, don't spread misinformation, this is pure FUD .......
>>
>>   Check osadl.org and their test rack, it will perhaps shed some light
>> on the quality assurance they try to do.
>>   It is hard to argue with numbers, also check a recent kernel and a
>> 'good' system.
>>   Some system have latency problems, but most are fine, atleast a
>> worstcase of 50 usor so under hard load and normal times in the low 10
>> to 20 us range.
>>
>>   / regards, Lars Segerlund.
>>
>>
>> 2012/4/24 Mark Hounschell<dmarkh@cfl.rr.com>:
>>> On 04/24/2012 01:46 AM, Anisha Kaul wrote:
>>>>
>>>> From:
>>>> https://rt.wiki.kernel.org/articles/f/r/e/Frequently_Asked_Questions_7407.html 
>>>>
>>>>
>>>>> Real-time only has impact on the kernel; Userspace does not notice 
>>>>> the
>>>>> difference except for better real time behavior.
>>>>
>>>>
>>>> Does it mean that if we write the applications in user space, they
>>>> won't get the hard real time effect?
>>>> The threads running in the userspace won't get the hard real time 
>>>> effect?
>>>>
>>>
>>> You use the term "hard real time". The RT patch set does not even 
>>> come close
>>> to providing a "hard real time" environment, and isn't even 
>>> attempting to.
>>> It does however provide user land applications a much better chance 
>>> for a
>>> "soft real time" environment. The phrase you quot above just means the
>>> patches are applied to the kernel and there are no patches required 
>>> for user
>>> land glibc or your application.
>>>
>
> Your in lala land. The Linux kernel, even with the RT patch has so 
> much "per CPU" crap in it, there is no way to prevent it from steeling 
> usecs from your application.


Not only the kernel steals CPU time :)  Also the SMI interrupt can steal 
a lot of time from any CPU core!  And these effects are much higher then 
the actions at the kernel level.
The OS AND the hardware must provide the environment for hard real-time 
processing. The definition of the a deadline includes also a time 
resolution (or variation) for meeting the deadlines ... and this is 
defined by the real-time application and not by theOS. The OS has just 
to profide the technological base to support this requirement.  In some 
cases is a time resolution of 1ms OK for meeting a deadline ...  and 
this still a hard-realtime application.


> The per CPU timer interrupt alone takes a few usecs away from your 
> application every HZ. A hard RT env is one in which you can always, 
> every time, do a predefined work in the same amount of time. Fast or 
> slow isn't the key. It's determinism. The timer interrupt alone 
> prevents that. And it's not the only thing. I've got 8 cpus on my 
> machine but the kernel has to have a piece of every one of them. Until 
> there is isolation from the kernel, there cannot be "Hard RT". This is 
> fact.

Your understanding of hard real-time is far too narrow ...

--armin

>
> Mark
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

