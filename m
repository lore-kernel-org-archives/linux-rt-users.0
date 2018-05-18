Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41758 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeERJma (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 May 2018 05:42:30 -0400
Received: by mail-qk0-f195.google.com with SMTP id d125-v6so5907402qkb.8
        for <linux-rt-users@vger.kernel.org>; Fri, 18 May 2018 02:42:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <893c67d2-576d-7033-53dc-85daa5379b73@monom.org>
References: <CAJ2oMhJmqTn5S-6Pk7j3-dwQMgK1Aii=B_spJFJmaj4iGOVGYw@mail.gmail.com>
 <893c67d2-576d-7033-53dc-85daa5379b73@monom.org>
From: Ran Shalit <ranshalit@gmail.com>
Date: Fri, 18 May 2018 12:42:28 +0300
Message-ID: <CAJ2oMh+tCSVT9mHkEzDP25FdwgBKkLCx3oLnkq+9ch6wpk1nhA@mail.gmail.com>
Subject: Re: How to investigate different timings of 2 HW with same kernel ?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On Fri, May 18, 2018 at 9:53 AM, Daniel Wagner <wagi@monom.org> wrote:
> Hi Ran,
>
>> Testing is done using:
>> https://github.com/nma/preempt-rt/blob/master/test-rt.c
>
>
> I just noticed this:
>
> #define MY_PRIORITY (49) /* we use 49 as the PRREMPT_RT use 50
>                             as the priority of kernel tasklets
>                             and interrupt handler by default */
>
> ...
>         param.sched_priority = MY_PRIORITY;
>         if(sched_setscheduler(0, SCHED_FIFO, &param) == -1) {
>                 perror("sched_setscheduler failed");
>                 exit(-1);
>         }
> ...
>
> The man page on sched_setscheduler:
>
>        SCHED_FIFO    a first-in, first-out policy; and
>        SCHED_RR      a round-robin policy.
>
>        For each of the above policies, param->sched_priority specifies
>        a scheduling priority for the thread.  This is a number in the
>        range  returned  by calling  sched_get_priority_min(2)  and
>        sched_get_priority_max(2) with the specified policy.  On Linux,
>        these system calls return, respectively, 1 and 99.
>
> Thus you should pick a priority higher then the default IRQ thread
> priorities, e.g. 51 should do the trick.


That's interesting.
I've assumed that the test founded in git is a good tool for testing
the real-time.
If this is the case, it probably means that is using a more standard
tool for rt-test like  cyclictest, would have been better.
Anyway, I will try your suggestion.
If it shows improvement than it probably mean that in that board
(portwell) there is some high IRQ inputs from some input device.
Anyway, after checking as you suggested, I'll have more information.

Thank you,
Ran

>
> Thanks,
> Daniel
