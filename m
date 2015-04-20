From: Carsten Emde <C.Emde@osadl.org>
Subject: [RESOLVED OSADL QA 3.18.9-rt5 #1]
Date: Mon, 20 Apr 2015 23:22:05 +0200
Message-ID: <55356DFD.2030508@osadl.org>
References: <55245FC8.9090509@osadl.org> <5526AE86.7030708@linutronix.de> <20150410123634.GA3057@linutronix.de> <55287A5C.8020402@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:53107 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbbDTVbK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 17:31:10 -0400
In-Reply-To: <55287A5C.8020402@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

>>>> an Intel Bay Trail board (Intel(R) Celeron(R) CPU  J1900  @ 1.99GHz) at
>>>> the OSADL QA Farm rack #b/slot #6 (https://www.osadl.org/?id=1894)
>>>> stops
>>>> working every 12 to 36 hours. The only way to get the board back to
>>>> work
>>> [..]
>> Could you try this:
>> --
>> Subject: [PATCH] kernel/irq_work: fix no_hz deadlock
>>
>> Invoking NO_HZ's irq_work callback from timer irq is not working very
>> well if the callback decides to invoke hrtimer_cancel():
>>
>> |hrtimer_try_to_cancel+0x55/0x5f
>> |hrtimer_cancel+0x16/0x28
>> |tick_nohz_restart+0x17/0x72
>> |__tick_nohz_full_check+0x8e/0x93
>> |nohz_full_kick_work_func+0xe/0x10
>> |irq_work_run_list+0x39/0x57
>> |irq_work_tick+0x60/0x67
>> |update_process_times+0x57/0x67
>> |tick_sched_handle+0x4a/0x59
>> |tick_sched_timer+0x3b/0x64
>> |__run_hrtimer+0x7a/0x149
>> |hrtimer_interrupt+0x1cc/0x2c5
>>
>> and here we deadlock while waiting for the lock which we are holding.
>> To fix this I'm doing the same thing that upstream is doing: is the
>> irq_work dedicated IRQ and use it only for what is marked as "hirq"
>> which should only be the FULL_NO_HZ related work.
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> [..]
> Thanks a lot! Applied the patch and restarted the box. Given the fact
> that it took up to 36 hours until the board stopped, we unfortunately
> need to see at least one week of crash-free operation, before we may
> consider the bug as fixed.
The board survived nine days without a crash -> RESOLVED.

Thanks,
	Carsten.
