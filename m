From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: sched_deadline behaviour when a real time process is throttled,
 with setting of /proc/sys/kernel/sched_rt_runtime_us is 950000
Date: Tue, 21 Nov 2017 08:48:56 +0100
Message-ID: <20171121074856.lmhlxunrx4vocolj@localhost.localdomain>
References: <CA+bpL9KJXCD3G790pmKhTsHZMjOM3WOxAOX-BDZ6Jzm95XjcJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: bhargavb <bhargavaramudu@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:38087 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdKUHtB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Nov 2017 02:49:01 -0500
Received: by mail-wr0-f170.google.com with SMTP id z75so9065993wrc.5
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Nov 2017 23:49:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+bpL9KJXCD3G790pmKhTsHZMjOM3WOxAOX-BDZ6Jzm95XjcJg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 20/11/17 22:41, bhargavb wrote:
> Hello,
> 
> Kindly help in understanding below things related to deadline
> scheduler of linux.(HRT enabled,sched_rt_runtime_us = 950000, only 1
> process with deadline scheduler policy, linux kernel 4.4, x86_64)
> 
> 1)Uniprocessor case: When a real time process(deadline scheduled) is
> throttled, ie exceeds its deadline say exceeded 900000 nanosec, it
> will be throttled assuming no other real time process is running and
> would be left to run till more 50000 nanoseconds but how does
> scheduler behave beyond the sched_rt_runtime_us? Will the process
> continue to run or the remaining 50000 ns allocated for non real time
> processes?

Not at all (if I understand your question correctly :). In the SCHED_
DEADLINE case, sched_rt_runtime_us is only used at admission control
time (i.e., when calling sched_setattr()). After that a task dynamic
runtime and deadline are managed by the scheduler itself, and without
looking at other tasks (let's leave GRUB out of the picture for
simplicity). So, your 900000us (?) task will be throttled after it has
depleted its runtime (not deadline) of 900000us.

> 
> 2) Does it become any complex if it is a multiprocessor (SMP)? Does
> the scheduler try to move this real time process to another processor
> if feasible?

Nope. SMP makes a difference at admission control time (as sched_rt_
runtime_us/sched_rt_period_us worth of bandwidth is "replicated" across
the available CPUs), but then tasks run inside theirs reservation
parameters (and can't execute for more than 1 CPU worth of time).

Please, refer to the docs for a way better explanation of how this all
works :)

https://elixir.free-electrons.com/linux/latest/source/Documentation/scheduler/sched-deadline.txt#L503

Best,

Juri
