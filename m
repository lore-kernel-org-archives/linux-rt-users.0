Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48552 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966873AbeEYQ0x (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 May 2018 12:26:53 -0400
Date: Fri, 25 May 2018 11:26:27 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: Non RT threads impact on RT thread
Message-ID: <20180525162627.GV1403@jcartwri.amer.corp.natinst.com>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
 <20180522183442.GP1403@jcartwri.amer.corp.natinst.com>
 <CAGiv7G0Qd-3H6JgJAqtRNLXA-eGcQhchauXMOFPv0hSFWYDysg@mail.gmail.com>
 <20180523160708.GR1403@jcartwri.amer.corp.natinst.com>
 <CAGiv7G0dTqUG9oegTphJ6waV_dUHFBBshhB6OQkw9pJ4iFuWTQ@mail.gmail.com>
 <CAGiv7G0dp5FVKUkeHXXk=AjTM7RMRazcQmFYfuMc-fLJBCj09g@mail.gmail.com>
 <20180525150250.GU1403@jcartwri.amer.corp.natinst.com>
 <CAGiv7G2CunMyoiWoY_DEpwgpSOneeKsSH_m5LChduvz8qJFi5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGiv7G2CunMyoiWoY_DEpwgpSOneeKsSH_m5LChduvz8qJFi5g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Jordan Palacios <jordan.palacios@pal-robotics.com>
Cc: linux-rt-users@vger.kernel.org

Hey Jordan-

(Quick administrative note: could you please not top post in your replies?)

On Fri, May 25, 2018 at 05:45:44PM +0200, Jordan Palacios wrote:
> On 25 May 2018 at 17:02, Julia Cartwright <julia@ni.com> wrote:
> > On Fri, May 25, 2018 at 03:38:47PM +0200, Jordan Palacios wrote:
> >> Hello,
> >>
> >> We managed to trace one of the failing cycles. The trace is here:
> >>
> >> https://pastebin.com/YJBrSQpJ
> >>
[..]
> > In other words: the traces show that this is a userspace problem, not a
> > kernel problem.  Solving this will require you to inspect your
> > application's locking.
> >
> > It may be helpful for you, in this effort, to identify the other thread
> > which eventually issues the FUTEX_WAKE (used for non-PI unlock
> > operation); the trace you linked only includes traces for CPU3, the
> > waker is on another CPU.  The remote wakeup occurs at timestamp
> > 12321.992480.
>
> Quick question. How do you know the wakeup occurs at timestamp 12321.992480?

The CPU has gone completely idle in the subsequent traces.

These traces are the first in the exit-from-idle path.  Given that the
CPU then schedules in your task, it's reasonable to assume that this CPU
exitted idle due to a remote wakeup from another CPU.

> At that timestamp the only thing we see is:
>
>   <idle>-0     [003] .n..1.. 12321.992480: rcu_idle_exit <-cpu_startup_entry
>   <idle>-0     [003] dn..1.. 12321.992480: rcu_eqs_exit_common.isra.46 <-rcu_idle_exit
>   <idle>-0     [003] .n..1.. 12321.992480: arch_cpu_idle_exit <-cpu_startup_entry
>   <idle>-0     [003] .n..1.. 12321.992480: atomic_notifier_call_chain <-arch_cpu_idle_exit
>
> And we also see this:
>
>   tuators_manager-1512  [003] ....1.. 12321.992495: sys_futex(uaddr: 7f41cc000020, op: 81, val: 1, utime: 7f41e4a60f19, uaddr2: 0, val3: 302e332e312e31)
>
> Can you explain us how is it related to the same futex, please? We see
> this call repeatedly across all the trace.

This is the same futex, as identified by the uaddr argument, but the
operation is 81, which (according to include/uapi/linux/futex.h is
FUTEX_WAKE | FUTEX_PRIVATE_FLAG).  This is likely an unlock operation.

This makes sense, when you think about it.  Your tuators_manager was
just woken up and completed it's pending FUTEX_WAIT op (it successfully
acquired the lock), then it executed it's critical section, now it's
releasing the lock.  This is why you then see this FUTEX_WAKE.

> We'll try tracing the other threads to pick who issues the FUTEX_WAKE.

Identifying them is just the most obvious and easiest starting point.
You'll need to figure out whether or not it makes sense for your
application to be sharing locks between high priority and low-priority
threads.  If it is necessary, then you will at the very least need to
make use of PI mutexes.

Good luck,
   Julia
