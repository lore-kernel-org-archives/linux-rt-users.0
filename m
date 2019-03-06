Return-Path: <SRS0=D0cg=RJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE073C43381
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Mar 2019 11:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973BD2064A
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Mar 2019 11:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfCFLI4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:08:56 -0500
Received: from foss.arm.com ([217.140.101.70]:59258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfCFLI4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Mar 2019 06:08:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC5B80D;
        Wed,  6 Mar 2019 03:08:56 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73713F71D;
        Wed,  6 Mar 2019 03:08:53 -0800 (PST)
Subject: Re: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190304172053.17340-1-julien.grall@arm.com>
 <545fb96e-0f07-758e-5c79-a725e74e3387@arm.com>
 <20190304220152.nozgclpu2jx3zgvy@linutronix.de>
 <75159b6e-0733-e300-e4f5-d519ca7f6b13@arm.com>
 <20190304181521.06e42396@gandalf.local.home>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <1ba3a2cf-36ff-bce0-8d2d-6e8ed8a81056@arm.com>
Date:   Wed, 6 Mar 2019 11:08:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304181521.06e42396@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steve,

On 04/03/2019 23:15, Steven Rostedt wrote:
> On Mon, 4 Mar 2019 22:25:41 +0000
> Julien Grall <Julien.Grall@arm.com> wrote:
>> On 04/03/2019 22:01, Sebastian Andrzej Siewior wrote:
>>> On 2019-03-04 17:21:57 [+0000], Julien Grall wrote:
>>>> (CC correctly linux-rt-users)
>>>>
>>>> On 04/03/2019 17:20, Julien Grall wrote:
>>>>> At the moment show_lock is implemented using spin_lock_t and called from
>>>>> an interrupt context on Arm64. The following backtrace was triggered by:
>>>>>
>>>>> 42sh# echo l > /proc/sysrq-trigger
>>>>>
>>>>> [ 4432.073756] sysrq: SysRq : Show backtrace of all active CPUs
>>>>> [ 4432.403422] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
>>>>> [ 4432.403424] sysrq: CPU6:
>>>>> [ 4432.403426] in_atomic(): 1, irqs_disabled(): 128, pid: 2410, name: kworker/u16:2
>>>>>
>>>>> [...]
>>>>>
>>>>> [ 4432.403581] Call trace:
>>>>> [ 4432.403584]  dump_backtrace+0x0/0x148
>>>>> [ 4432.403586]  show_stack+0x14/0x20
>>>>> [ 4432.403588]  dump_stack+0x9c/0xd4
>>>>> [ 4432.403592]  ___might_sleep+0x1cc/0x298
>>>>> [ 4432.403595]  rt_spin_lock+0x5c/0x70
>>>>> [ 4432.403596]  showacpu+0x34/0x68
>>>>> [ 4432.403599]  flush_smp_call_function_queue+0xd4/0x278
>>>>> [ 4432.403602]  generic_smp_call_function_single_interrupt+0x10/0x18
>>>>> [ 4432.403605]  handle_IPI+0x26c/0x668
>>>>> [ 4432.403607]  gic_handle_irq+0x9c/0xa0
>>>>> [ 4432.403609]  el1_irq+0xb4/0x13c
>>>>>
>>>>> With RT-patches, spin_lock can now sleep and therefore cannot be used from
>>>>> interrupt context. Use a raw_spin_lock instead to prevent the lock to
>>>>> sleep.
>>>>>
>>>>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>>
>>> I don't have to look at this properly but this looks is wrong.
>>
>> May I ask why does it look wrong? On Arm64, this code is called from an
>> IRQ disabled context (see the check in flush_smp_call_function_queue).
> 
> I'll answer.
>
> It's going to call printk, and depending on consoles and such, it may
> not print anything (a printk without atomic consoles shows nothing).
> 
> That said, perhaps we need to do something like the "safe printk",
> where it only loads it into the log buffers and doesn't do the actual
> prints.
> 
> Hmm, do we do that now? I need to look at the latest printk code in RT.

Thank you for the explanation.

I am not entirely familiar with printk, so I may have overlooked something.

Looking at the printk code (see vprintk_emit), the message will be loaded in the 
log buffer. The log buffer will be printed out by klogd if vprintk_emit were 
called from a context where IRQs or preemption is disabled.

So I think the printk should still happen from atomic context but it will get 
delayed until we are out from the atomic context.

Cheers,

-- 
Julien Grall
