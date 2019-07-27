Return-Path: <SRS0=S77f=VY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA07C433FF
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98962084C
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Jul 2019 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfG0NhQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Jul 2019 09:37:16 -0400
Received: from foss.arm.com ([217.140.110.172]:53134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387559AbfG0NhP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Jul 2019 09:37:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0541628;
        Sat, 27 Jul 2019 06:37:15 -0700 (PDT)
Received: from [10.37.8.139] (unknown [10.37.8.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08FF83F71F;
        Sat, 27 Jul 2019 06:37:12 -0700 (PDT)
Subject: Re: KVM Arm64 and Linux-RT issues
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        anna-maria@linutronix.de,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <b9867c43-7fe3-5d64-9939-b1a7ab7f1061@arm.com>
 <cd310858-2c0f-6af1-bf82-ee1e01a2cfb8@arm.com>
 <alpine.DEB.2.21.1907270053360.1791@nanos.tec.linutronix.de>
 <86zhkzn319.wl-maz@kernel.org>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <960b5ed1-6d0f-3cee-da37-6061b4946c1a@arm.com>
Date:   Sat, 27 Jul 2019 14:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <86zhkzn319.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 7/27/19 12:13 PM, Marc Zyngier wrote:
> On Fri, 26 Jul 2019 23:58:38 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Wed, 24 Jul 2019, Marc Zyngier wrote:
>>> On 23/07/2019 18:58, Julien Grall wrote:
>>> It really feels like a change in hrtimer_cancel semantics. From what I
>>> understand, this is used to avoid racing against the softirq, but boy it
>>> breaks things.
>>>
>>> If this cannot be avoided, this means we can't cancel the background
>>> timer (which is used to emulate the vcpu timer while it is blocked
>>> waiting for an interrupt), then we must move this canceling to the point
>>> where the vcpu is unblocked (instead of scheduled), which may have some
>>> side effects -- I'll have a look.
>>>
>>> But that's not the only problem: We also have hrtimers used to emulate
>>> timers while the vcpu is running, and these timers are canceled in
>>> kvm_timer_vcpu_put(), which is also called from a preempt notifier.
>>> Unfortunately, I don't have a reasonable solution for that (other than
>>> putting this hrtimer_cancel in a workqueue and start chasing the
>>> resulting races).
>>
>> The fix is simple. See below. We'll add that to the next RT release. That
>> will take a while as I'm busy with posting RT stuff for upstream :)
> 
> Ah, thanks for that! And yes, looking forward to RT upstream, it's
> just about time! ;-)
> 
>>
>> Thanks,
>>
>> 	tglx
>>
>> 8<------------
>> --- a/virt/kvm/arm/arch_timer.c
>> +++ b/virt/kvm/arm/arch_timer.c
>> @@ -80,7 +80,7 @@ static inline bool userspace_irqchip(str
>>   static void soft_timer_start(struct hrtimer *hrt, u64 ns)
>>   {
>>   	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
>> -		      HRTIMER_MODE_ABS);
>> +		      HRTIMER_MODE_ABS_HARD);
>>   }
>>   
> 
> That's pretty neat, and matches the patch you already have for
> x86. Feel free to add my
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

I can confirm the warning now disappeared. Feel free to added my tested-by:

Tested-by: Julien Grall <julien.grall@arm.com>

Thank you both for the help!

Cheers,

-- 
Julien Grall
