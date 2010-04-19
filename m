From: Primiano Tucci <p.tucci@gmail.com>
Subject: Re: Strange behavior of pthread_setaffinity_np
Date: Mon, 19 Apr 2010 13:51:33 +0200
Message-ID: <p2zc5b2c05b1004190451x906bd2dehefaded5b8108ced7@mail.gmail.com>
References: <z2hc5b2c05b1004190245od92c276n6933d75f9d4d2669@mail.gmail.com>
	 <j2r921ca19c1004190407zc167abddp4944c46e81fd95fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34031 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab0DSLvh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Apr 2010 07:51:37 -0400
Received: by wyb39 with SMTP id 39so2436247wyb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Apr 2010 04:51:35 -0700 (PDT)
In-Reply-To: <j2r921ca19c1004190407zc167abddp4944c46e81fd95fc@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sujit,
thanks for your reply, but I have not completely understood your point.
Does the kernel make (from the thread viewpoint) differences between
Cores of a Processor, or multiple processors?
In my previous speak I generally used the term CPU #0 and #1 to refer
to two different cores of a same Processor (a quad core Q9550).
Do you mean I need a different API to sett affinity on a per-core
basis rather than a per-processor basis? It sound strange to me, as in
my little knowledge Cores are viewed, by the system, as different
processor, just as in the case of a regular Multi Processor system.

Thanks,
Primiano

On Mon, Apr 19, 2010 at 1:07 PM, Sujit K M <sjt.kar@gmail.com> wrote:
> All these are best guesses.
>
> On Mon, Apr 19, 2010 at 3:15 PM, Primiano Tucci <p.tucci@gmail.com> w=
rote:
>> Hi all,
>> I am an Italian researcher and I am working on a Real Time schedulin=
g
>> infrastructure. I am currently using Linux Kernel 2.6.29.6-rt24-smp
>> (PREEMPT-RT Patch) running on a Intel Q9550 CPU.
>> I am experiencing strange behaviors with the pthread_setaffinity_np =
API.
>>
>> This is my scenario, I have 4 Real Time Threads (SCHED_FIFO)
>> distributed as follows:
>>
>> T0 : CPU 0, Priority 2 (HIGH)
>> T1 : CPU 1, Priority 2 (HIGH)
>> T3 : CPU 0, Priority 1 (LOW)
>> T4 : CPU 1, Priority 1 (LOW)
>
> Could you check with the manual whether the following documentation
> specifies your Processor.
> http://www.intel.com/design/core2quad/documentation.htm
>
> The reason I am asking is that what ever you are stating above in
> terms of thread affinity would not
> even qualify as an Core2duo.
>
>>
>> So T0 and T1 are actually the "big bosses" on CPUs #0 and #1, T3 and
>> T4, instead, never execute (let's assume that each thread is a simpl=
e
>> busy wait that never sleeps/yields)
>> Now, at a certain point, from T0 code, I want to migrate T4 from CPU
>> #1 to #0, keeping its low priority.
>> Therefore I perform a pthread_setaffinity_np from T0 changing T4 mas=
k
>> from CPU #1 to #0.
>
> This approach is not at all correct as the thread affinity should be
> closer to the core than the processor.
> If this is supported.
>
>>
>> In this scenario it happens that T3 (that should never execute since
>> there is T0 with higher priority currently running on the same CPU #=
0)
>> "emerge" and executes for a bit.
>> It seems that the pthread_setaffinity_np syscall is somehow
>> "suspensive" for the time needed to migrate T4 and let the scheduler
>> to execute T3 for that bunch of time.
>
> I think what is happening is that Once you have scheduled the code on
> processor basis, It tends to ignore
> core logic, but depends more on the processor logic.
>
>>
>> Is this behavior expected (I did not find any documentation about
>> this)? How can avoid it?
>
> I think you will have to set the affinity to core level than at proce=
ssor level.
>
>>
>> Thanks in advance,
>> Primiano
>>
>> --
>> =A0Primiano Tucci
>> =A0http://www.primianotucci.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> -- Sujit K M
>
> blog(http://kmsujit.blogspot.com/)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
