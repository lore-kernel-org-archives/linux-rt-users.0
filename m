Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35059 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbeEYNjI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 May 2018 09:39:08 -0400
Received: by mail-ua0-f196.google.com with SMTP id a2-v6so3486013uak.2
        for <linux-rt-users@vger.kernel.org>; Fri, 25 May 2018 06:39:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGiv7G0dTqUG9oegTphJ6waV_dUHFBBshhB6OQkw9pJ4iFuWTQ@mail.gmail.com>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
 <20180522183442.GP1403@jcartwri.amer.corp.natinst.com> <CAGiv7G0Qd-3H6JgJAqtRNLXA-eGcQhchauXMOFPv0hSFWYDysg@mail.gmail.com>
 <20180523160708.GR1403@jcartwri.amer.corp.natinst.com> <CAGiv7G0dTqUG9oegTphJ6waV_dUHFBBshhB6OQkw9pJ4iFuWTQ@mail.gmail.com>
From: Jordan Palacios <jordan.palacios@pal-robotics.com>
Date: Fri, 25 May 2018 15:38:47 +0200
Message-ID: <CAGiv7G0dp5FVKUkeHXXk=AjTM7RMRazcQmFYfuMc-fLJBCj09g@mail.gmail.com>
Subject: Re: Non RT threads impact on RT thread
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org

Hello,

We managed to trace one of the failing cycles. The trace is here:
https://pastebin.com/YJBrSQpJ

It seems our application is relinquishing the cpu (line 411) due to a
sys_futex call (line 350). We still don't understand why though. We
are not very familiar with all the kernel functions.

Kind regards.

Jordan.

On 23 May 2018 at 18:19, Jordan Palacios
<jordan.palacios@pal-robotics.com> wrote:
> On 23 May 2018 at 18:07, Julia Cartwright <julia@ni.com> wrote:
>> On Wed, May 23, 2018 at 05:43:57PM +0200, Jordan Palacios wrote:
>>> Hello,
>>>
>>> Thanks for the answers.
>>>
>>> We don't have any nvidia card installed on the system.
>>>
>>> We'll try the isolcpus in conjunct with our cpuset setup and we'll
>>> look into the irq_smp_affinity.
>>
>> Given the spike magnitudes you are seeing, I doubt they are task
>> migration related; meaning I don't think that isolcpus will make a
>> difference.
>>
>>> These are some of the specs of the system. Let me know if you need
>>> something else that might be relevant.
>>>
>>> Active module: Congatec conga-TS77/i7-3612QE
>>> Carrier: Connect Tech CCG008
>>> DDR3L-SODIMM-1600 (8GB)
>>> Crucial MX200 250GB mSATA SSD
>>>
>>> I have uploaded one graph with an example of our issue here:
>>>
>>> https://i.imgur.com/8KoxzNV.png
>>>
>>> In blue the time between cycles and in green the execution time of
>>> each loop. X is in seconds and Y in microseconds. As you can see the
>>> execution time is quite constant until we run some intensive IO tasks.
>>> In this case those spikes are caused by a hdparm -tT /dev/sda. In this
>>> particular instance the spike is no issue since its less than our task
>>> period.
>>
>> Interesting.  Does that 2-second higher-latency window directly coincide
>> with the starting/stopping of the hdparm load?
>
> Yes. It coincides with the part that tests cache reads to be more precise.
>
>>> The problem arises when spikes that are particularly nasty make us go
>>> over the 1ms limit, resulting in an overrun. Here is an example:
>>>
>>> https://i.imgur.com/77sgj3S.png
>>>
>>> Till now we have only used tracing in our example application but we
>>> haven't been able to draw any conclusions. I'll try to obtain a trace
>>> of our main update cycle when one of these spikes happen.
>>
>> This would be most helpful.  The first step will be to confirm the
>> assumption that nothing else is executing on the CPU with this RT task.
>>
>> Also, keep in mind that tracing induces some overhead, so you might need
>> to adjust your threshold accordingly.  I've found that most of the
>> latency issues I've debugged can be via the irq, sched, and timer trace
>> events (maybe syscalls as well) so that's where I typically start.
>>
>> It may also be worth a test with a later -rt kernel series like 4.14-rt
>> or even 4.16-rt to see if you can reproduce the issue there.
>>
>>    Julia
>
> Thanks Julia. I'll look into it and report back.
>
> Kind regards.
>
> Jordan.
