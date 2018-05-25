Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:42588 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964823AbeEYPYz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 May 2018 11:24:55 -0400
Date: Fri, 25 May 2018 10:02:50 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: Non RT threads impact on RT thread
Message-ID: <20180525150250.GU1403@jcartwri.amer.corp.natinst.com>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
 <20180522183442.GP1403@jcartwri.amer.corp.natinst.com>
 <CAGiv7G0Qd-3H6JgJAqtRNLXA-eGcQhchauXMOFPv0hSFWYDysg@mail.gmail.com>
 <20180523160708.GR1403@jcartwri.amer.corp.natinst.com>
 <CAGiv7G0dTqUG9oegTphJ6waV_dUHFBBshhB6OQkw9pJ4iFuWTQ@mail.gmail.com>
 <CAGiv7G0dp5FVKUkeHXXk=AjTM7RMRazcQmFYfuMc-fLJBCj09g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGiv7G0dp5FVKUkeHXXk=AjTM7RMRazcQmFYfuMc-fLJBCj09g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Jordan Palacios <jordan.palacios@pal-robotics.com>
Cc: linux-rt-users@vger.kernel.org

On Fri, May 25, 2018 at 03:38:47PM +0200, Jordan Palacios wrote:
> Hello,
> 
> We managed to trace one of the failing cycles. The trace is here:
>
> https://pastebin.com/YJBrSQpJ
> 
> It seems our application is relinquishing the cpu (line 411) due to a
> sys_futex call (line 350). We still don't understand why though. We
> are not very familiar with all the kernel functions.

You'll see a futex system call whenever there is contention on a
userspace mutex.  In this case, your thread is issuing a FUTEX_WAIT,
which is the futex op used to implement a contended non-PI lock
operation.

An RT task blocking on a non-PI mutex is game over w.r.t. expecting any
bound execution time guarantees.

In other words: the traces show that this is a userspace problem, not a
kernel problem.  Solving this will require you to inspect your
application's locking.

It may be helpful for you, in this effort, to identify the other thread
which eventually issues the FUTEX_WAKE (used for non-PI unlock
operation); the trace you linked only includes traces for CPU3, the
waker is on another CPU.  The remote wakeup occurs at timestamp
12321.992480.

   Julia
