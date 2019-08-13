Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1671EC32750
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E713620844
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 15:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfHMPo0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:44:26 -0400
Received: from foss.arm.com ([217.140.110.172]:39400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfHMPo0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 11:44:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7814128;
        Tue, 13 Aug 2019 08:44:25 -0700 (PDT)
Received: from [10.37.8.112] (unknown [10.37.8.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5297F3F706;
        Tue, 13 Aug 2019 08:44:23 -0700 (PDT)
Subject: Re: KVM Arm64 and Linux-RT issues
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <adc0b2e2-3a2e-5685-8eb5-2ce927d2139e@arm.com>
Date:   Tue, 13 Aug 2019 16:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813125835.5v26s4iuv44lw2xg@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 8/13/19 1:58 PM, bigeasy@linutronix.de wrote:
> On 2019-07-27 14:37:11 [+0100], Julien Grall wrote:
>>>> 8<------------
>>>> --- a/virt/kvm/arm/arch_timer.c
>>>> +++ b/virt/kvm/arm/arch_timer.c
>>>> @@ -80,7 +80,7 @@ static inline bool userspace_irqchip(str
>>>>    static void soft_timer_start(struct hrtimer *hrt, u64 ns)
>>>>    {
>>>>    	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
>>>> -		      HRTIMER_MODE_ABS);
>>>> +		      HRTIMER_MODE_ABS_HARD);
>>>>    }
>>>
>>> That's pretty neat, and matches the patch you already have for
>>> x86. Feel free to add my
>>>
>>> Acked-by: Marc Zyngier <maz@kernel.org>
>>
>> I can confirm the warning now disappeared. Feel free to added my tested-by:
>>
>> Tested-by: Julien Grall <julien.grall@arm.com>
>>
> 
> |kvm_hrtimer_expire()
> | kvm_timer_update_irq()
> |   kvm_vgic_inject_irq()
> |     vgic_lazy_init()
> |                if (unlikely(!vgic_initialized(kvm))) {
> |                 if (kvm->arch.vgic.vgic_model != KVM_DEV_TYPE_ARM_VGIC_V2)
> |                         return -EBUSY;
> |
> |                 mutex_lock(&kvm->lock);
> 
> Is this possible path of any concern? This should throw a warning also
> for !RT so probably not…

Hmmm, theoretically yes. In practice, it looks like the hrtimer will not 
be started before kvm_vcpu_first_run_init() is called on the first run.

The function will call kvm_vgic_map_resources() which will initialize 
the vgic if not already done.

Looking around, I think this is here to cater the case where 
KVM_IRQ_LINE is called before running.

I am not yet familiar with the vgic, so I may have missed something.

> 
> I prepared the patch below. This one could go straight to tglx's timer tree
> since he has the _HARD bits there. I *think* it requires to set the bits
> _HARD during _init() and _start() otherwise there is (or was) a warning…
> 
> Sebastian
> 8<------------
> 
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 13 Aug 2019 14:29:41 +0200
> Subject: [PATCH] KVM: arm/arm64: Let the timer expire in hardirq context on RT
> 
> The timers are canceled from an preempt-notifier which is invoked with
> disabled preemption which is not allowed on PREEMPT_RT.
> The timer callback is short so in could be invoked in hard-IRQ context
> on -RT.
> 
> Let the timer expire on hard-IRQ context even on -RT.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Julien Grall <julien.grall@arm.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   virt/kvm/arm/arch_timer.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 1be486d5d7cb4..0bfa7c5b5c890 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -80,7 +80,7 @@ static inline bool userspace_irqchip(struct kvm *kvm)
>   static void soft_timer_start(struct hrtimer *hrt, u64 ns)
>   {
>   	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
> -		      HRTIMER_MODE_ABS);
> +		      HRTIMER_MODE_ABS_HARD);
>   }
>   
>   static void soft_timer_cancel(struct hrtimer *hrt)
> @@ -697,11 +697,11 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
>   	update_vtimer_cntvoff(vcpu, kvm_phys_timer_read());
>   	ptimer->cntvoff = 0;
>   
> -	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> +	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>   	timer->bg_timer.function = kvm_bg_timer_expire;
>   
> -	hrtimer_init(&vtimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> -	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> +	hrtimer_init(&vtimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> +	hrtimer_init(&ptimer->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>   	vtimer->hrtimer.function = kvm_hrtimer_expire;
>   	ptimer->hrtimer.function = kvm_hrtimer_expire;
>   
> 

-- 
Julien Grall
