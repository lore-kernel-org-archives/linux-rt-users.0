From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: Kernel ISR Latency
Date: Wed, 12 Apr 2017 19:50:46 -0400
Message-ID: <CAEYdEeS=7sCZB3FKE9M_BHH-oqp1NjYNmmxpHW5kryPXS-dyLQ@mail.gmail.com>
References: <CAEYdEeQ5UVR6Zn6ZysnqcW1kDBPriMvEVUrW0a3NUhfeuM+Hxw@mail.gmail.com>
 <20170410195536.GK16052@jcartwri.amer.corp.natinst.com> <CAEYdEeR4Y138B9NinTso3hvJ6trEUa5OprsNEecDHFFrmP8j4Q@mail.gmail.com>
 <CAEYdEeR19sXd79DsZnYKy2+YFnEADSLzAiDq64Hw5kOiTqLLGw@mail.gmail.com> <20170411170656.2eda2c21@tagon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33472 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbdDLXur (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Apr 2017 19:50:47 -0400
Received: by mail-io0-f181.google.com with SMTP id k87so43182470ioi.0
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Apr 2017 16:50:47 -0700 (PDT)
In-Reply-To: <20170411170656.2eda2c21@tagon>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

thank you for all the suggestions.  I made some findings, so I thought
I would share them with anyone watching this thread. The delays shown
on the scope screen capture I shared in an earlier email resulted form
either of the lower priority threads using some kernel calls into some
optimized CRC routines.  The kernel operating at a higher priority
than the ISR, I believe invoked a priority inversion upon the user
space threads causing them to periodically preempt the ISR.  When I
swap those CRC routines with ones not embedded in the kernel, the ISR
does not incur the delay as seen in the scope.

One problem I've had; however, is I can't verify this with ftrace.
After building the kernel with ftrace support, attempts to use the
kernel optimized CRC calls cause the entire system to crash.  I don't
know why.  To use these optimized calls requires establishing a socket
between the user space thread and the kernel.  Calling bind() upon
that socket seems to cause the crash.  So I can only guess that ftrace
somehow obstructs creating some kinds of sockets between user space
and kernel space.

The outstanding problem for me to solve is that the user space threads
don't perform the CRCs fast enough before needing to read the next
batch of SPI transfer data from shared memory space, that is the
memory shared with the kernel module of the ISR that does the SPI
transfers.  I've tried running the ISR at priority 80 (nothing else
higher except for the kernel threads that run at priority 99) and the
user space threads that perform the CRCs at priority 60 (nothing else
higher other than the aforementioned ISR and again the kernel threads
that run at 99).

I attempted to use processor affinity with cpuset to isolate the user
space threads.  I must have been using it improperly because I had to
shield 3 (of 4) cores for the executable that spawns the two user
space RT threads to run just one of them to completion.  Any number of
cores less, and the executable just hangs.  Nonetheless, the single
user space RT thread that did run to completion didn't seem to get any
speedup in its CRC processing, so by my observations PREEMPT RT is
doing just fine giving it what it needs from a priority standpoint.

It may simply be that I've squeezed all I can out of this processor.

On Tue, Apr 11, 2017 at 6:06 PM, Clark Williams <williams@redhat.com> wrote=
:
> On Mon, 10 Apr 2017 17:31:52 -0400
> Brian Wrenn <dcbrianw@gmail.com> wrote:
>
>> I imagine that it would be a bad idea to prioritize my ISR ahead of
>> any one of these?
>>
>>    12  FF     99 139   - [posixcputmr/0]
>>    14  FF     99 139   - [migration/0]
>>    15  FF     99 139   - [watchdog/0]
>>    16  FF     99 139   - [watchdog/1]
>>    17  FF     99 139   - [migration/1]
>>    21  FF     99 139   - [posixcputmr/1]
>>    24  FF     99 139   - [watchdog/2]
>>    25  FF     99 139   - [migration/2]
>>    29  FF     99 139   - [posixcputmr/2]
>>    32  FF     99 139   - [watchdog/3]
>>    33  FF     99 139   - [migration/3]
>>    37  FF     99 139   - [posixcputmr/3]
>>
>> At this stage, that's all that prioritized higher.
>
> Yeah, it's never a good idea to use FIFO:99 and compete with these guys.
>
>>
>> On Mon, Apr 10, 2017 at 4:48 PM, Brian Wrenn <dcbrianw@gmail.com> wrote:
>> > On Mon, Apr 10, 2017 at 3:55 PM, Julia Cartwright <julia@ni.com> wrote=
:
>> >> On Mon, Apr 10, 2017 at 03:12:28PM -0400, Brian Wrenn wrote:
>> >>> Hi, I'm trying to track down the source of some ISR latency that I'm
>> >>> observing on a logic analyzer.
>> >>>
>> >>> Just for some background, my setup is the following.  I'm running
>> >>> Linaro 4.4.9 with PREEMPT RT Patch 17 on a Variscite SD410 SOM devki=
t.
>> >>> My kernel has the following PREEMPT RT options.
>> >> [..]
>> >>>
>> >>> I have a micro-controller attached to a GPIO pin and two separate SP=
I
>> >>> ports.  Every 10 milliseconds the micro-controller writes 18 Kbytes =
of
>> >>> data to each of 2 SPI ports (total of 36 Kbytes between the two) and
>> >>> issues an interrupt on the GPIO.  A kernel module has an ISR
>> >>> registered to the GPIO pin.  When the ISR executes, it copies 18
>> >>> Kbytes of data from each SPI.  There are two RT threads executing in
>> >>> user space as SCHED_RR with identical priorities less than (i.e. low=
er
>> >>> than) 50, where as I understand the kernel runs at priority 50.
>> >>
>> >> It's a bit more complicated than "the kernel runs at priority 50".
>> >
>> > Yes, better stated, my kernel space IRQ gets a priority of 50.  (Most
>> > of the others seem to have 50 as well.)
>
> The RT kernel assigns all threaded IRQs  default priority of fifo:50.
>
>> >
>> >>
>> >> Perhaps what you're getting at is that by default, with irq forced
>> >> threading enabled (which is the default with -rt build kernels) the
>> >> irqthreads have the default scheduling policy FIFO with priority 50.
>> >> It's up to the administrator/system integrator to appropriately
>> >> prioritize these irqthreads to suit the application.
>> >>
>> >
>> > Pursuant to that, I'm reviewing this to gain a better understanding of
>> > such things.  Please forgive me; I hadn't found this link prior to
>> > messaging the listserve.
>> >
>> > http://subversion.ffado.org/wiki/IrqPriorities
>> >
>> >> For your usecase, this means that likely _all_ of the peripheral
>> >> interrupts, including the low priority stuff you might not care about
>> >> for your application (like networking or uart or whatever) are being
>> >> prioritized right alongside your latency sensitive gpio handler.
>> >>
>> >>> Each of those user space threads copies data from some shared memory
>> >>> within the kernel module and performs some basic data integrity
>> >>> checks, i.e.  a SHA1.
>> >>
>> >> Just to better understand: how are your RT threads signalled by your
>> >> gpio handler?
>> >
>> > The user space RT threads have mmap'ed memory shared with the kernel
>> > module.  The kernel module writes to a designated memory location the
>> > current read offset so that the user space RT threads know where to
>> > read from iteration to iteration.
>> >
>> >>
>> >>> The vast majority of interrupts incur a delay in range of tens of
>> >>> MICROseconds, meaning the ISR executes within such amount of time of
>> >>> the micro-controller raising the GPIO pin of the ISR.  However,
>> >>> occasionally, more than six MILLIseconds passes between the time of
>> >>> the micro-controller issuing the GPIO interrupt and the ISR beginnin=
g
>> >>> to execute.
>> >>
>> >> Also: how are you measuring this latency?  In particular, where is yo=
ur
>> >> test point for the "ISR beginning"?
>> >>>
>> >
>> > Upon detection of a bad CRC or bad sequence number, the user space
>> > threads raise another GPIO, not the GPIO of the ISR, another one that
>> > triggers a logic analyzer to dump a forward captured buffer.  Then, I
>> > got back through the capture and identify the high latency ISR
>> > execution.  (See attached image.)
>> >
>> >>> I'm trying to track down the cause of the 6+ MILLIsecond latency,
>> >>> which I would not expect to happen.  Are there any well practiced
>> >>> techniques for determining what factor(s) may be introducing this
>> >>> latency?  I looked at the description for RT Watchdog, but I don't
>> >>> think it would help me much because the only two RT threads other th=
an
>> >>> the kernel have a lower priority.
>> >>
>> >> I don't think the RT watchdog will help you here, however, I would
>> >> recommend that you get acquainted with using ftrace/trace-cmd and the
>> >> irq and sched traceevents.
>> >>
>> >>    Julia
>> >
>> > It sounds like to me that maybe you've confirmed that I'm looking in
>> > the right direction w.r.t. modifying the kernel ISRs with something
>> > like 'chrt' and 'rtiq'.  Yes?  But I also will look into
>> > ftrace/trace-cmd and irq and sched trace events.
>
> I'd suggest using chrt to boost your irq(s) up above the default 50 to sa=
y 51. That would insure that they're scheduled in before the other interrup=
t threads are processed.
>
> Of course that just means your interrupt gets serviced first and does not=
hing to help if some other interrupt (or other entity) is delaying the sche=
duling of your user-space threads. As Julia said, you probably want to look=
 at ftrace and run your application with some tracepoints enabled. That wil=
l let you look at the timestamps when various events are hit and hopefully =
give you an idea of what's happening when your latency spike hits.
>
> If you want to get fancy, look at what cyclictest (from the rt-tests pack=
age) does when the --breaktrace option is used. It takes a threshold value =
and stops processing when the threshold is exceeded. In addition it stops a=
ny active trace and writes a message to the trace buffers, so it's quite ob=
vious when you've hit a spike and you get a nice event trace leading up to =
the spike.
>
> Clark
>
> --
> The United States Coast Guard
> Ruining Natural Selection since 1790
