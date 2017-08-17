From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: Does calling sched_yield() in a SCHED_DEADLINE thread guarantee
 wakeup at beginning of next period?
Date: Thu, 17 Aug 2017 18:31:44 +0200
Message-ID: <ef939f8a-dd96-cff2-7f90-6ee8e88737e7@santannapisa.it>
References: <CANf15E_4N-BZDLFmYXUFqfMrX6T+7btTsQGYsYs7J_HNDXzSCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: luca abeni <luca.abeni@santannapisa.it>,
        Juri Lelli <juri.lelli@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Bjarke Freund-Hansen <bjarkefh@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.santannapisa.it ([193.205.80.98]:60550 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbdHQRb5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Aug 2017 13:31:57 -0400
In-Reply-To: <CANf15E_4N-BZDLFmYXUFqfMrX6T+7btTsQGYsYs7J_HNDXzSCg@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[ cc-ing a few others who might have a say in this regard and linux-rt-users@ - see below for my comments... ]

On 17/08/2017 12:21, Bjarke Freund-Hansen wrote:
> Hi Tommaso
> 
> In the Linux kernel in 'Documentation/scheduler/sched-deadline.txt' you write:
> 
>  >> This behavior of sched_yield() allows the task to wake-up exactly at the beginning of the next period. Also, this may be useful in the future with bandwidth reclaiming mechanisms, where sched_yield() will make the leftoever runtime available for reclamation by other SCHED_DEADLINE tasks. <<
> 
> Does this mean that thread is guaranteed to wake up at the beginning of the next period if sched_yield() is called in the current period to relinquish the remaining runtime?

Yes, sched_yield() in such case blocks the task till the next period starts. At that time, the task is woken up (back to ready to run) with full runtime and absolute deadline set to the absolute period start-time plus its relative deadline, but it will be scheduled only once it gets among the m SCHED_DEADLINE tasks with the earliest absolute deadline, where 'm' is the number of CPUs in the scheduling domain. That's a convenience behavior that saves you setting an app-level timer if all you need is a periodic task, and lets you easily sync-up with the time(r) as seen/used by the SCHED_DEADLINE scheduler.

Note: when calling sched_yield(), one should be really sure that the leftover runtime is sufficient to not let the task be throttled during the yield() call itself. The problem being that, if I'm close enough to ending my runtime, and I call sched_yield(), but I'm throttled before sched_yield() can get to do some real work in the kernel, then I'll be throttled till the next period starts, then once I'll be unthrottled the sched_yield() will actually occur, forcing me to skipping one whole period -- guess that's NEVER what one expects. If you set-up an app-level timer instead, and you sleep till an absolute time, then in the worst-and-bad-case (of being unexpectedly throttled) you ask to sleep till a time back in time, that is a no-op returning back immediately to the task.

About the note for future extensions, AFAIK Luca Abeni (in cc) recently worked on a work-conserving extension of SCHED_DEADLINE based on GRUB (that should be [almost] mainline), but I'm not sure about what sched_yield() is doing in such extension (Luca?).

Feel free to write again, should you have further doubts about the use of SCHED_DEADLINE. With more information about your use-case, we might be able to help more of course :-)!

Bye,

	T.
-- 
Tommaso Cucinotta, Computer Engineering PhD
Associate Professor at the Real-Time Systems Laboratory (ReTiS)
Scuola Superiore Sant'Anna, Pisa, Italy
http://retis.sssup.it/people/tommaso
