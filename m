From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: Kernel ISR Latency
Date: Mon, 10 Apr 2017 17:31:52 -0400
Message-ID: <CAEYdEeR19sXd79DsZnYKy2+YFnEADSLzAiDq64Hw5kOiTqLLGw@mail.gmail.com>
References: <CAEYdEeQ5UVR6Zn6ZysnqcW1kDBPriMvEVUrW0a3NUhfeuM+Hxw@mail.gmail.com>
 <20170410195536.GK16052@jcartwri.amer.corp.natinst.com> <CAEYdEeR4Y138B9NinTso3hvJ6trEUa5OprsNEecDHFFrmP8j4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33527 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdDJVby (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Apr 2017 17:31:54 -0400
Received: by mail-io0-f181.google.com with SMTP id t68so81809628iof.0
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Apr 2017 14:31:53 -0700 (PDT)
In-Reply-To: <CAEYdEeR4Y138B9NinTso3hvJ6trEUa5OprsNEecDHFFrmP8j4Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I imagine that it would be a bad idea to prioritize my ISR ahead of
any one of these?

   12  FF     99 139   - [posixcputmr/0]
   14  FF     99 139   - [migration/0]
   15  FF     99 139   - [watchdog/0]
   16  FF     99 139   - [watchdog/1]
   17  FF     99 139   - [migration/1]
   21  FF     99 139   - [posixcputmr/1]
   24  FF     99 139   - [watchdog/2]
   25  FF     99 139   - [migration/2]
   29  FF     99 139   - [posixcputmr/2]
   32  FF     99 139   - [watchdog/3]
   33  FF     99 139   - [migration/3]
   37  FF     99 139   - [posixcputmr/3]

At this stage, that's all that prioritized higher.

On Mon, Apr 10, 2017 at 4:48 PM, Brian Wrenn <dcbrianw@gmail.com> wrote:
> On Mon, Apr 10, 2017 at 3:55 PM, Julia Cartwright <julia@ni.com> wrote:
>> On Mon, Apr 10, 2017 at 03:12:28PM -0400, Brian Wrenn wrote:
>>> Hi, I'm trying to track down the source of some ISR latency that I'm
>>> observing on a logic analyzer.
>>>
>>> Just for some background, my setup is the following.  I'm running
>>> Linaro 4.4.9 with PREEMPT RT Patch 17 on a Variscite SD410 SOM devkit.
>>> My kernel has the following PREEMPT RT options.
>> [..]
>>>
>>> I have a micro-controller attached to a GPIO pin and two separate SPI
>>> ports.  Every 10 milliseconds the micro-controller writes 18 Kbytes of
>>> data to each of 2 SPI ports (total of 36 Kbytes between the two) and
>>> issues an interrupt on the GPIO.  A kernel module has an ISR
>>> registered to the GPIO pin.  When the ISR executes, it copies 18
>>> Kbytes of data from each SPI.  There are two RT threads executing in
>>> user space as SCHED_RR with identical priorities less than (i.e. lower
>>> than) 50, where as I understand the kernel runs at priority 50.
>>
>> It's a bit more complicated than "the kernel runs at priority 50".
>
> Yes, better stated, my kernel space IRQ gets a priority of 50.  (Most
> of the others seem to have 50 as well.)
>
>>
>> Perhaps what you're getting at is that by default, with irq forced
>> threading enabled (which is the default with -rt build kernels) the
>> irqthreads have the default scheduling policy FIFO with priority 50.
>> It's up to the administrator/system integrator to appropriately
>> prioritize these irqthreads to suit the application.
>>
>
> Pursuant to that, I'm reviewing this to gain a better understanding of
> such things.  Please forgive me; I hadn't found this link prior to
> messaging the listserve.
>
> http://subversion.ffado.org/wiki/IrqPriorities
>
>> For your usecase, this means that likely _all_ of the peripheral
>> interrupts, including the low priority stuff you might not care about
>> for your application (like networking or uart or whatever) are being
>> prioritized right alongside your latency sensitive gpio handler.
>>
>>> Each of those user space threads copies data from some shared memory
>>> within the kernel module and performs some basic data integrity
>>> checks, i.e.  a SHA1.
>>
>> Just to better understand: how are your RT threads signalled by your
>> gpio handler?
>
> The user space RT threads have mmap'ed memory shared with the kernel
> module.  The kernel module writes to a designated memory location the
> current read offset so that the user space RT threads know where to
> read from iteration to iteration.
>
>>
>>> The vast majority of interrupts incur a delay in range of tens of
>>> MICROseconds, meaning the ISR executes within such amount of time of
>>> the micro-controller raising the GPIO pin of the ISR.  However,
>>> occasionally, more than six MILLIseconds passes between the time of
>>> the micro-controller issuing the GPIO interrupt and the ISR beginning
>>> to execute.
>>
>> Also: how are you measuring this latency?  In particular, where is your
>> test point for the "ISR beginning"?
>>>
>
> Upon detection of a bad CRC or bad sequence number, the user space
> threads raise another GPIO, not the GPIO of the ISR, another one that
> triggers a logic analyzer to dump a forward captured buffer.  Then, I
> got back through the capture and identify the high latency ISR
> execution.  (See attached image.)
>
>>> I'm trying to track down the cause of the 6+ MILLIsecond latency,
>>> which I would not expect to happen.  Are there any well practiced
>>> techniques for determining what factor(s) may be introducing this
>>> latency?  I looked at the description for RT Watchdog, but I don't
>>> think it would help me much because the only two RT threads other than
>>> the kernel have a lower priority.
>>
>> I don't think the RT watchdog will help you here, however, I would
>> recommend that you get acquainted with using ftrace/trace-cmd and the
>> irq and sched traceevents.
>>
>>    Julia
>
> It sounds like to me that maybe you've confirmed that I'm looking in
> the right direction w.r.t. modifying the kernel ISRs with something
> like 'chrt' and 'rtiq'.  Yes?  But I also will look into
> ftrace/trace-cmd and irq and sched trace events.
>
> Thanks,
> Brian
