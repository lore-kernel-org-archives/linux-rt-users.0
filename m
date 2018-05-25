Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-ua0-f171.google.com ([209.85.217.171]:41524 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966128AbeEYPqG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 May 2018 11:46:06 -0400
Received: by mail-ua0-f171.google.com with SMTP id a3-v6so3757568uad.8
        for <linux-rt-users@vger.kernel.org>; Fri, 25 May 2018 08:46:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180525150250.GU1403@jcartwri.amer.corp.natinst.com>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
 <20180522183442.GP1403@jcartwri.amer.corp.natinst.com> <CAGiv7G0Qd-3H6JgJAqtRNLXA-eGcQhchauXMOFPv0hSFWYDysg@mail.gmail.com>
 <20180523160708.GR1403@jcartwri.amer.corp.natinst.com> <CAGiv7G0dTqUG9oegTphJ6waV_dUHFBBshhB6OQkw9pJ4iFuWTQ@mail.gmail.com>
 <CAGiv7G0dp5FVKUkeHXXk=AjTM7RMRazcQmFYfuMc-fLJBCj09g@mail.gmail.com> <20180525150250.GU1403@jcartwri.amer.corp.natinst.com>
From: Jordan Palacios <jordan.palacios@pal-robotics.com>
Date: Fri, 25 May 2018 17:45:44 +0200
Message-ID: <CAGiv7G2CunMyoiWoY_DEpwgpSOneeKsSH_m5LChduvz8qJFi5g@mail.gmail.com>
Subject: Re: Non RT threads impact on RT thread
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org

Thanks Julia. You've been of great help.

Quick question. How do you know the wakeup occurs at timestamp 12321.992480?

At that timestamp the only thing we see is:

  <idle>-0     [003] .n..1.. 12321.992480: rcu_idle_exit <-cpu_startup_entry
  <idle>-0     [003] dn..1.. 12321.992480: rcu_eqs_exit_common.isra.46
<-rcu_idle_exit
  <idle>-0     [003] .n..1.. 12321.992480: arch_cpu_idle_exit
<-cpu_startup_entry
  <idle>-0     [003] .n..1.. 12321.992480: atomic_notifier_call_chain
<-arch_cpu_idle_exit

And we also see this:

  tuators_manager-1512  [003] ....1.. 12321.992495: sys_futex(uaddr:
7f41cc000020, op: 81, val: 1, utime: 7f41e4a60f19, uaddr2: 0, val3:
302e332e312e31)

Can you explain us how is it related to the same futex, please? We see
this call repeatedly across all the trace.

We'll try tracing the other threads to pick who issues the FUTEX_WAKE.

Kind regards,
Jordan.

On 25 May 2018 at 17:02, Julia Cartwright <julia@ni.com> wrote:
> On Fri, May 25, 2018 at 03:38:47PM +0200, Jordan Palacios wrote:
>> Hello,
>>
>> We managed to trace one of the failing cycles. The trace is here:
>>
>> https://pastebin.com/YJBrSQpJ
>>
>> It seems our application is relinquishing the cpu (line 411) due to a
>> sys_futex call (line 350). We still don't understand why though. We
>> are not very familiar with all the kernel functions.
>
> You'll see a futex system call whenever there is contention on a
> userspace mutex.  In this case, your thread is issuing a FUTEX_WAIT,
> which is the futex op used to implement a contended non-PI lock
> operation.
>
> An RT task blocking on a non-PI mutex is game over w.r.t. expecting any
> bound execution time guarantees.
>
> In other words: the traces show that this is a userspace problem, not a
> kernel problem.  Solving this will require you to inspect your
> application's locking.
>
> It may be helpful for you, in this effort, to identify the other thread
> which eventually issues the FUTEX_WAKE (used for non-PI unlock
> operation); the trace you linked only includes traces for CPU3, the
> waker is on another CPU.  The remote wakeup occurs at timestamp
> 12321.992480.
>
>    Julia
