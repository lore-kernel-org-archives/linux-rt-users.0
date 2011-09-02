From: Raz <raziebe@gmail.com>
Subject: Re: From vxworks to linux
Date: Fri, 2 Sep 2011 22:48:43 +0300
Message-ID: <CAPB=Z-qrcnvAf7Y3N42PnmiN6ATusQ6TkAwFQ9HwHZUMuV-p8Q@mail.gmail.com>
References: <CAPB=Z-oZNZxKg4qKJMmPy_TPBVAy4vXc4fAwnRfUvG4jPnazFQ@mail.gmail.com>
 <CADr7Lg=3a_1BDF5H2GUMDmTVHuAR5jm8befXbu+bOivbC4ThbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	rasty <rasty@axy-systems.com>, lbrafman@manz.com,
	Torsten Scherer <TScherer@manz.com>
To: YOSHIDA Shigeru <yshigeru@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43575 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032Ab1IBTtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Sep 2011 15:49:05 -0400
Received: by bke11 with SMTP id 11so2938012bke.19
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Sep 2011 12:49:03 -0700 (PDT)
In-Reply-To: <CADr7Lg=3a_1BDF5H2GUMDmTVHuAR5jm8befXbu+bOivbC4ThbA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 2, 2011 at 7:05 PM, YOSHIDA Shigeru <yshigeru@gmail.com> wr=
ote:
> Hi,
>
> I'm also developing VxWorks and Linux application in my job.
> To port VxWorks application to Linux, our approach is to map
> individual VxWorks tasks to POSIX threads.
>
> I consider entire VxWorks address space as one Linux process
> address space.
>
> 2011/9/2 Raz <raziebe@gmail.com>:
>> 1. vxworks rt priority range scales up to 255 and not 100 which is n=
ot enough.
>>
>> =A0=A0=A0=A0=A0=A0=A0 Compiling kernel with RT_MAX_PRIO set to 255 (=
 3.0 even
>> without preemprt rt ) and executing cyclictest crashes kernel
>> =A0=A0=A0=A0=A0=A0=A0 ( NULL pointer in pick_next_task_rt +0x88 ).=A0=
 So naive
>> approach doesn't work.
>>
>> =A0=A0=A0=A0=A0=A0=A0 How do i increase MAX_RT_PRIO to higher value,=
 even in the
>> cost of recompiling an entire system ( all os user space
>> =A0=A0=A0=A0=A0=A0 code is recompiled with a sanitized kernel header=
s ).
>
> Do you really use all 255 VxWorks priority range?
> If your application's priority range can map to Linux's 100 priority =
range,
> I recommend to do so.
i wish to estimate the efforts, fixing and a 15-years old application
versus fixing linux OS. I am not so sure
the latter is such a bad idea.
>
>> 2. global critical section
>>
>> =A0=A0=A0=A0=A0=A0=A0 vxworks does not have the notion of a virtual =
address space.
>> so code that is "user space"
>> =A0=A0=A0=A0=A0=A0=A0 oriented is executing side by side to an inter=
rupt , this
>> leads to "cli"-like global locks
>> =A0=A0=A0=A0=A0=A0=A0 in a vxworks world.
>>
>> =A0=A0=A0=A0=A0=A0=A0 so in linux..
>> =A0=A0=A0=A0=A0=A0=A0 one solution is to "iopl(3)" and then "sti/cli=
" in user space
>> , this is good for UNI processors machines,
>> =A0=A0=A0=A0=A0=A0=A0 but assuming preempt-rt will run smp machines =
it is not good.
>> also, disabling interrupts is considered bad
>> =A0=A0=A0=A0=A0=A0=A0 practice in preempt-rt.
>> =A0=A0=A0=A0=A0=A0=A0 another solution is to increase the executing =
thread priority
>> to the highest value possible, i believe it is
>> =A0=A0=A0=A0=A0=A0=A0 theoretically correct assuming i have full con=
trol over the
>> entire operating system.
>>
>> =A0=A0=A0=A0=A0=A0=A0 anyone experienced with sort of problems ? or =
tried any of the
>> above with success ?
>
> In our task-to-pthread mapping, we use pthread mutex to mutual
> execution.
mutual exclusion is not the case here. i do not have a sync object
like mutex,spin lock .
>> 3. vxworks target shell.
>>
>> =A0=A0=A0=A0=A0=A0=A0 vxworks provides a shell-like access to its sy=
stem, and since
>> all tasks share address space it is possible
>> =A0=A0=A0=A0=A0=A0=A0 to access all globals in the c code just like =
in gdb, examine
>> stacks and so on without disturbing the
>> =A0=A0=A0=A0=A0=A0=A0 rt task=A0 whatsoever.
>>
>> =A0=A0=A0=A0=A0=A0=A0 I need this feature in linux per-process.
>> =A0=A0=A0=A0=A0=A0=A0 At the moment i did not find anything like vx-=
target shell in
>> linux. gdb/ptrace is out of the question as
>> =A0=A0=A0=A0=A0=A0=A0 they influence the rt task behavior.
>> =A0=A0=A0=A0=A0=A0=A0 Currently I think to create a thread that is p=
art of to the
>> process address space. this thread is based on libcli,
>> =A0=A0=A0=A0=A0=A0=A0 and it it means should integrate it with pstac=
k code and nm code.
>>
>> =A0=A0=A0=A0=A0=A0=A0 so before i start writing piles of code, any o=
ther ideas ?
>
> In our task-to-pthread mapping, we can use gdb, and can do
> something like VxWorks shell.
when gdb attaches a task is suspends all threads . ptrace affects
incoming signals to traced task. i need to have something else.
> thanks.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
