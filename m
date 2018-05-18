Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.monom.org ([188.138.9.77]:39018 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbeERGxc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 May 2018 02:53:32 -0400
Subject: Re: How to investigate different timings of 2 HW with same kernel ?
References: <CAJ2oMhJmqTn5S-6Pk7j3-dwQMgK1Aii=B_spJFJmaj4iGOVGYw@mail.gmail.com>
From: Daniel Wagner <wagi@monom.org>
Message-ID: <893c67d2-576d-7033-53dc-85daa5379b73@monom.org>
Date: Fri, 18 May 2018 08:53:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ2oMhJmqTn5S-6Pk7j3-dwQMgK1Aii=B_spJFJmaj4iGOVGYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

Hi Ran,

> Testing is done using:
> https://github.com/nma/preempt-rt/blob/master/test-rt.c

I just noticed this:

#define MY_PRIORITY (49) /* we use 49 as the PRREMPT_RT use 50
                             as the priority of kernel tasklets
                             and interrupt handler by default */

...
         param.sched_priority = MY_PRIORITY;
         if(sched_setscheduler(0, SCHED_FIFO, &param) == -1) {
                 perror("sched_setscheduler failed");
                 exit(-1);
         }
...

The man page on sched_setscheduler:

        SCHED_FIFO    a first-in, first-out policy; and
        SCHED_RR      a round-robin policy.

        For each of the above policies, param->sched_priority specifies
        a scheduling priority for the thread.  This is a number in the
        range  returned  by calling  sched_get_priority_min(2)  and
        sched_get_priority_max(2) with the specified policy.  On Linux,
        these system calls return, respectively, 1 and 99.

Thus you should pick a priority higher then the default IRQ thread
priorities, e.g. 51 should do the trick.

Thanks,
Daniel
