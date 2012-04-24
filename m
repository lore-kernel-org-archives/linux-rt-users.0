From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Tue, 24 Apr 2012 05:42:12 -0400
Message-ID: <4F967574.8030104@cfl.rr.com>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>	<4F966AFC.7070803@cfl.rr.com> <CAF-VNaq3bkC=LCB-Emsx20xTm-Vm1v3kduC5MpyXQA_GS6SOhg@mail.gmail.com>
Reply-To: dmarkh@cfl.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-kernel-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:15526 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab2DXJmN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Apr 2012 05:42:13 -0400
In-Reply-To: <CAF-VNaq3bkC=LCB-Emsx20xTm-Vm1v3kduC5MpyXQA_GS6SOhg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/24/2012 05:08 AM, Lars Segerlund wrote:
>   This is not based on facts, rt-preempt does provide hard realtime and
> strive to provide hard realtime, where have you come up with the
> notion that it does not ?
>
>   Please, don't spread misinformation, this is pure FUD .......
>
>   Check osadl.org and their test rack, it will perhaps shed some light
> on the quality assurance they try to do.
>   It is hard to argue with numbers, also check a recent kernel and a
> 'good' system.
>   Some system have latency problems, but most are fine, atleast a
> worstcase of 50 usor so under hard load and normal times in the low 10
> to 20 us range.
>
>   / regards, Lars Segerlund.
>
>
> 2012/4/24 Mark Hounschell<dmarkh@cfl.rr.com>:
>> On 04/24/2012 01:46 AM, Anisha Kaul wrote:
>>>
>>> From:
>>> https://rt.wiki.kernel.org/articles/f/r/e/Frequently_Asked_Questions_7407.html
>>>
>>>> Real-time only has impact on the kernel; Userspace does not notice the
>>>> difference except for better real time behavior.
>>>
>>>
>>> Does it mean that if we write the applications in user space, they
>>> won't get the hard real time effect?
>>> The threads running in the userspace won't get the hard real time effect?
>>>
>>
>> You use the term "hard real time". The RT patch set does not even come close
>> to providing a "hard real time" environment, and isn't even attempting to.
>> It does however provide user land applications a much better chance for a
>> "soft real time" environment. The phrase you quot above just means the
>> patches are applied to the kernel and there are no patches required for user
>> land glibc or your application.
>>

Your in lala land. The Linux kernel, even with the RT patch has so much 
"per CPU" crap in it, there is no way to prevent it from steeling usecs 
from your application. The per CPU timer interrupt alone takes a few usecs 
away from your application every HZ. A hard RT env is one in which you can 
always, every time, do a predefined work in the same amount of time. Fast 
or slow isn't the key. It's determinism. The timer interrupt alone prevents 
that. And it's not the only thing. I've got 8 cpus on my machine but the 
kernel has to have a piece of every one of them. Until there is isolation 
from the kernel, there cannot be "Hard RT". This is fact.

Mark
