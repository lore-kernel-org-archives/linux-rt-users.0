From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Mon, 12 Jun 2017 12:16:43 -0500
Message-ID: <9e37f030-9500-9be2-bcec-b081a2f8bccc@mvista.com>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
 <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
 <593EC529.80508@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Chris Friesen <chris.friesen@windriver.com>, rolf.freitag@email.de,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36309 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbdFLRQr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2017 13:16:47 -0400
Received: by mail-pg0-f51.google.com with SMTP id a70so47592283pge.3
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2017 10:16:47 -0700 (PDT)
In-Reply-To: <593EC529.80508@windriver.com>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/12/2017 11:45 AM, Chris Friesen wrote:
> On 06/12/2017 06:57 AM, Corey Minyard wrote:
>> On 06/10/2017 01:13 PM, rolf.freitag@email.de wrote:
>>> Hi,
>>>
>>> I tried ping as a minimal latency test, e. g.
>>>
>>> ionice -c3 -p $$
>>> renice +19 -p $$
>>> ping -q -s 28 -l 1 -p 0f1e2d3c4b5a6978 -i 0.001 localhost
>>>
>>> but when cyclictest shows a worst-case latency of 40 mikroseconds,
>>> ping shows more than 10,000 (after 1 day run).
>>> I tried different kernels, e. g.
>>> SMP PREEMPT RT Debian 4.6.4-1~bpo8+1 (2016-08-11) x86_64
>>> but with the same result, low cyclictest values, high ping values.
>>> What is the reason?
>>
>> Since no one else has answered, I guess I will.
>>
>> Creating a real-time *system* is hard work.  Just running a program on a
>> real-time OS does not magically make it a real-time system.  You really
>> have to know what you are doing.  I suggest you read "POSIX.4
>> Programmers Guide: Programming for the Real World" for an intro to
>> the subject.  It's fairly close to what Linux does, though there are 
>> things
>> that Linux does beyond what is in there.
>>
>> A few notes on what you have done:
>>
>>   * ionice doesn't affect network I/O.
>>   * renice does not set real-time priorities.
>
> Good point...the OP probably wants something like "sudo chrt <prio> 
> <cmd> ...."
>
>>   * You don't do anything with memory locking.  What happens
>>     if memory in your program gets paged out then is required?
>
> I suppose this would require a custom "ping" client to ensure all 
> necessary memory is allocated and locked before starting the actual ping.
>

Yes, I don't know if there is a way to do this without doing it in the 
application.

>>   * Something on the other end of the ping is running, too.  It
>>     also needs to be real-time, too, and it's not by default.
>
> The standard ICMP ping would be handled by the kernel.  With linux-rt 
> I guess you'd have the ethernet interrupt thread involved as well as 
> ksoftirqd?
>

I didn't look at what would be required, but those are likely candidates.

I didn't mean the above as a comprehensive list or anything like that.  
I just
wanted to drive home the point that this requires end-to-end thinking
and careful design.  It's hard.

-corey
