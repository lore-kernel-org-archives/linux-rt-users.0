Return-Path: <SRS0=9Pks=WM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0696FC3A59C
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E5821721
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfHPPSY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:18:24 -0400
Received: from foss.arm.com ([217.140.110.172]:57942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbfHPPSY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Aug 2019 11:18:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E372344;
        Fri, 16 Aug 2019 08:18:23 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293BA3F694;
        Fri, 16 Aug 2019 08:18:22 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
Subject: Re: KVM Arm64 and Linux-RT issues
To:     Marc Zyngier <maz@kernel.org>, bigeasy@linutronix.de
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        anna-maria@linutronix.de,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <b9867c43-7fe3-5d64-9939-b1a7ab7f1061@arm.com>
 <cd310858-2c0f-6af1-bf82-ee1e01a2cfb8@arm.com>
 <alpine.DEB.2.21.1907270053360.1791@nanos.tec.linutronix.de>
 <86zhkzn319.wl-maz@kernel.org> <960b5ed1-6d0f-3cee-da37-6061b4946c1a@arm.com>
 <20190813125835.5v26s4iuv44lw2xg@linutronix.de>
 <adc0b2e2-3a2e-5685-8eb5-2ce927d2139e@arm.com> <865zn1nidx.wl-maz@kernel.org>
Message-ID: <1f76c277-665a-e962-8cbe-b3c4ecad41b0@arm.com>
Date:   Fri, 16 Aug 2019 16:18:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <865zn1nidx.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

On 13/08/2019 17:24, Marc Zyngier wrote:
> On Tue, 13 Aug 2019 16:44:21 +0100,
> Julien Grall <julien.grall@arm.com> wrote:
>>
>> Hi Sebastian,
>>
>> On 8/13/19 1:58 PM, bigeasy@linutronix.de wrote:
>>> On 2019-07-27 14:37:11 [+0100], Julien Grall wrote:
>>>>>> 8<------------
>>>>>> --- a/virt/kvm/arm/arch_timer.c
>>>>>> +++ b/virt/kvm/arm/arch_timer.c
>>>>>> @@ -80,7 +80,7 @@ static inline bool userspace_irqchip(str
>>>>>>     static void soft_timer_start(struct hrtimer *hrt, u64 ns)
>>>>>>     {
>>>>>>     	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
>>>>>> -		      HRTIMER_MODE_ABS);
>>>>>> +		      HRTIMER_MODE_ABS_HARD);
>>>>>>     }
>>>>>
>>>>> That's pretty neat, and matches the patch you already have for
>>>>> x86. Feel free to add my
>>>>>
>>>>> Acked-by: Marc Zyngier <maz@kernel.org>
>>>>
>>>> I can confirm the warning now disappeared. Feel free to added my tested-by:
>>>>
>>>> Tested-by: Julien Grall <julien.grall@arm.com>
>>>>
>>>
>>> |kvm_hrtimer_expire()
>>> | kvm_timer_update_irq()
>>> |   kvm_vgic_inject_irq()
>>> |     vgic_lazy_init()
>>> |                if (unlikely(!vgic_initialized(kvm))) {
>>> |                 if (kvm->arch.vgic.vgic_model != KVM_DEV_TYPE_ARM_VGIC_V2)
>>> |                         return -EBUSY;
>>> |
>>> |                 mutex_lock(&kvm->lock);
>>>
>>> Is this possible path of any concern? This should throw a warning also
>>> for !RT so probably not…
>>
>> Hmmm, theoretically yes. In practice, it looks like the hrtimer will
>> not be started before kvm_vcpu_first_run_init() is called on the first
>> run.
> 
> Exactly. Even if you restore the timer in a "firing" configuration,
> you'll have to execute the vgic init before any background timer gets
> programmed, let alone expired.
> 
> Yes, the interface is terrible.
> 
>> The function will call kvm_vgic_map_resources() which will initialize
>> the vgic if not already done.
>>
>> Looking around, I think this is here to cater the case where
>> KVM_IRQ_LINE is called before running.
>>
>> I am not yet familiar with the vgic, so I may have missed something.
>>
>>>
>>> I prepared the patch below. This one could go straight to tglx's timer tree
>>> since he has the _HARD bits there. I *think* it requires to set the bits
>>> _HARD during _init() and _start() otherwise there is (or was) a warning…
>>>
>>> Sebastian
>>> 8<------------
>>>
>>> From: Thomas Gleixner <tglx@linutronix.de>
>>> Date: Tue, 13 Aug 2019 14:29:41 +0200
>>> Subject: [PATCH] KVM: arm/arm64: Let the timer expire in hardirq context on RT
>>>
>>> The timers are canceled from an preempt-notifier which is invoked with
>>> disabled preemption which is not allowed on PREEMPT_RT.
>>> The timer callback is short so in could be invoked in hard-IRQ context
>>> on -RT.
>>>
>>> Let the timer expire on hard-IRQ context even on -RT.
>>>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> Acked-by: Marc Zyngier <maz@kernel.org>
>>> Tested-by: Julien Grall <julien.grall@arm.com>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>>    virt/kvm/arm/arch_timer.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
>>> index 1be486d5d7cb4..0bfa7c5b5c890 100644
>>> --- a/virt/kvm/arm/arch_timer.c
>>> +++ b/virt/kvm/arm/arch_timer.c
>>> @@ -80,7 +80,7 @@ static inline bool userspace_irqchip(struct kvm *kvm)
>>>    static void soft_timer_start(struct hrtimer *hrt, u64 ns)
>>>    {
>>>    	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
>>> -		      HRTIMER_MODE_ABS);
>>> +		      HRTIMER_MODE_ABS_HARD);
>>>    }
>>>      static void soft_timer_cancel(struct hrtimer *hrt)
>>> @@ -697,11 +697,11 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>>>    	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
>>>    	ptimer->cntvoff = 0;
>>>    -	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC,
>>> HRTIMER_MODE_ABS);
>>> +	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>>>    	timer->bg_timer.function = kvm_bg_timer_expire;
>>>    -	hrtimer_init(&vtimer->hrtimer, CLOCK_MONOTONIC,
>>> HRTIMER_MODE_ABS);
>>> -	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
>>> +	hrtimer_init(&vtimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>>> +	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>>>    	vtimer->hrtimer.function = kvm_hrtimer_expire;
>>>    	ptimer->hrtimer.function = kvm_hrtimer_expire;
>>>    
> 
> Patch looks fine, please add it to the pile of RT stuff! ;-)

Sadly, I managed to hit the same BUG_ON() today with this patch
applied on top v5.2-rt1-rebase. :/ Although, it is more difficult
to hit than previously.

[  157.449545] 000: BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
[  157.449569] 000: in_atomic(): 1, irqs_disabled(): 0, pid: 990, name: kvm-vcpu-1
[  157.449579] 000: 2 locks held by kvm-vcpu-1/990:
[  157.449592] 000:  #0: 00000000c2fc8217 (&vcpu->mutex){+.+.}, at: kvm_vcpu_ioctl+0x70/0xae0
[  157.449638] 000:  #1: 0000000096863801 (&cpu_base->softirq_expiry_lock){+.+.}, at: hrtimer_grab_expiry_lock+0x24/0x40
[  157.449677] 000: Preemption disabled at:
[  157.449679] 000: [<ffff0000111a4538>] schedule+0x30/0xd8
[  157.449702] 000: CPU: 0 PID: 990 Comm: kvm-vcpu-1 Tainted: G        W 5.2.0-rt1-00001-gd368139e892f #104
[  157.449712] 000: Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
[  157.449718] 000: Call trace:
[  157.449722] 000:  dump_backtrace+0x0/0x130
[  157.449730] 000:  show_stack+0x14/0x20
[  157.449738] 000:  dump_stack+0xbc/0x104
[  157.449747] 000:  ___might_sleep+0x198/0x238
[  157.449756] 000:  rt_spin_lock+0x5c/0x70
[  157.449765] 000:  hrtimer_grab_expiry_lock+0x24/0x40
[  157.449773] 000:  hrtimer_cancel+0x1c/0x38
[  157.449780] 000:  kvm_timer_vcpu_load+0x78/0x3e0
[  157.449791] 000:  kvm_arch_vcpu_load+0x130/0x298
[  157.449800] 000:  kvm_sched_in+0x38/0x68
[  157.449808] 000:  finish_task_switch+0x14c/0x300
[  157.449816] 000:  __schedule+0x2b8/0x8d0
[  157.449826] 000:  schedule+0x38/0xd8
[  157.449833] 000:  kvm_vcpu_block+0xac/0x790
[  157.449841] 000:  kvm_handle_wfx+0x210/0x520
[  157.449852] 000:  handle_exit+0x134/0x1d0
[  157.449861] 000:  kvm_arch_vcpu_ioctl_run+0x650/0xbb8
[  157.449869] 000:  kvm_vcpu_ioctl+0x3a0/0xae0
[  157.449877] 000:  do_vfs_ioctl+0xbc/0x910
[  157.449887] 000:  ksys_ioctl+0x78/0xa8
[  157.449896] 000:  __arm64_sys_ioctl+0x1c/0x28
[  157.449904] 000:  el0_svc_common.constprop.0+0x90/0x188
[  157.449915] 000:  el0_svc_handler+0x28/0x78
[  157.449925] 000:  el0_svc+0x8/0xc
[  173.521497] 002: hrtimer: interrupt took 19281 ns

I will do some debug and see what I can find.

Cheers,

-- 
Julien Grall
