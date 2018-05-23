Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43781 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeEWPoS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 May 2018 11:44:18 -0400
Received: by mail-vk0-f67.google.com with SMTP id x191-v6so13414495vke.10
        for <linux-rt-users@vger.kernel.org>; Wed, 23 May 2018 08:44:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522183442.GP1403@jcartwri.amer.corp.natinst.com>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
 <20180522183442.GP1403@jcartwri.amer.corp.natinst.com>
From: Jordan Palacios <jordan.palacios@pal-robotics.com>
Date: Wed, 23 May 2018 17:43:57 +0200
Message-ID: <CAGiv7G0Qd-3H6JgJAqtRNLXA-eGcQhchauXMOFPv0hSFWYDysg@mail.gmail.com>
Subject: Re: Non RT threads impact on RT thread
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org

Hello,

Thanks for the answers.

We don't have any nvidia card installed on the system.

We'll try the isolcpus in conjunct with our cpuset setup and we'll
look into the irq_smp_affinity.

These are some of the specs of the system. Let me know if you need
something else that might be relevant.

Active module: Congatec conga-TS77/i7-3612QE
Carrier: Connect Tech CCG008
DDR3L-SODIMM-1600 (8GB)
Crucial MX200 250GB mSATA SSD

I have uploaded one graph with an example of our issue here:
https://i.imgur.com/8KoxzNV.png

In blue the time between cycles and in green the execution time of
each loop. X is in seconds and Y in microseconds. As you can see the
execution time is quite constant until we run some intensive IO tasks.
In this case those spikes are caused by a hdparm -tT /dev/sda. In this
particular instance the spike is no issue since its less than our task
period.

The problem arises when spikes that are particularly nasty make us go
over the 1ms limit, resulting in an overrun. Here is an example:
https://i.imgur.com/77sgj3S.png

Till now we have only used tracing in our example application but we
haven't been able to draw any conclusions. I'll try to obtain a trace
of our main update cycle when one of these spikes happen.

Kind regards,

Jordan.

On 22 May 2018 at 20:34, Julia Cartwright <julia@ni.com> wrote:
> On Tue, May 22, 2018 at 12:00:27PM +0200, Jordan Palacios wrote:
>> Hello,
>
> Hello Jordan-
>
>> We are currently running a version of the linux kernel (3.18.24) with
>> the RT-PREEMPT patch. In our system there are several non RT tasks and
>> one RT task. The RT process runs in the FIFO scheduler with 95
>> priority and a control loop of 1ms.
>>
>> We have achieved latencies of about 5us which are perfect for us.
>>
>> Our issue is that the RT task sometimes misses one of its cycles due
>> to an unexpected very long execution time of its control loop. In our
>> system this is a critical failure.
>>
>> We enabled tracing in the kernel and started measuring the execution
>> time of the RT thread. The execution time is quite constant (about
>> 200us), which random spikes every now and then. Thing is, the less non
>> RT tasks running in the system the better the RT task behaves.
>>
>> We wrote a very simple RT application that does some light work and
>> writes its execution time using the trace_marker. Execution time is
>> constant but IO intensive stuff, like a stress --io 32 or a hdparm,
>> will have and impact on its execution time. This is surprising because
>> the test does not any kind of work related to IO. Nor does the RT task
>> in our system for that matter.
>
> You haven't specified anything about your hardware setup, nor any
> numbers here showing the magnitude of these latency spikes.  Could you
> elaborate?
>
>> Our question is: Is this behaviour normal? Why are non RT tasks
>> affecting the RT task performance?  Is there any other kind of test
>> that we could run that would shed some light on this issue?
>
> I think it's "normal" that there will be _some_ impact from non-RT
> tasks.  Even across CPUs in the case where CPUs share some level of
> cache.  The question is what magnitude of impact should be expected.
>
> Another thing you might want to look at is irq_smp_affinity, in the case
> where your RT task is still serving interrupts it should not be.
>
> Your test already has some scaffolding for tracing.  Start a run with
> tracing enabled and stop tracing once you observe a latency larger than
> expected; dump the trace buffer; inspect.
>
>   Julia
