Return-Path: <SRS0=0hJj=WQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60073C3A589
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A52A214DA
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 14:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfHTOSq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:18:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbfHTOSq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Aug 2019 10:18:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8488E28;
        Tue, 20 Aug 2019 07:18:45 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 493033F246;
        Tue, 20 Aug 2019 07:18:44 -0700 (PDT)
Subject: Re: KVM Arm64 and Linux-RT issues
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        anna-maria@linutronix.de,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <cd310858-2c0f-6af1-bf82-ee1e01a2cfb8@arm.com>
 <alpine.DEB.2.21.1907270053360.1791@nanos.tec.linutronix.de>
 <86zhkzn319.wl-maz@kernel.org> <960b5ed1-6d0f-3cee-da37-6061b4946c1a@arm.com>
 <20190813125835.5v26s4iuv44lw2xg@linutronix.de>
 <adc0b2e2-3a2e-5685-8eb5-2ce927d2139e@arm.com> <865zn1nidx.wl-maz@kernel.org>
 <1f76c277-665a-e962-8cbe-b3c4ecad41b0@arm.com>
 <20190816152317.pbhctfiyurjrepju@linutronix.de>
 <e9a77a95-ce0e-27a4-acb0-e997eb656e14@arm.com>
 <20190819073321.b3q2bxnslwwmdssn@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <35fd274a-08ae-8bfd-3484-83676af00328@arm.com>
Date:   Tue, 20 Aug 2019 15:18:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819073321.b3q2bxnslwwmdssn@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 19/08/2019 08:33, Sebastian Andrzej Siewior wrote:
> On 2019-08-16 17:32:38 [+0100], Julien Grall wrote:
>> Hi Sebastian,
> Hi Julien,
> 
>> hrtimer_callback_running() will be returning true as the callback is
>> running somewhere else. This means hrtimer_try_to_cancel()
>> would return -1. Therefore hrtimer_grab_expiry_lock() would
>> be called.
>>
>> Did I miss anything?
> 
> nope, you are right. I assumed that we had code to deal with this but
> didn't find it…
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 7d7db88021311..40d83c709503e 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -934,7 +934,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
>   {
>   	struct hrtimer_clock_base *base = timer->base;
>   
> -	if (base && base->cpu_base) {
> +	if (base && base->cpu_base && base->index < MASK_SHIFT) {

Lower indexes are used for hard interrupt. So this would need to be base->index 
 >= MASK_SHIFT.

But I was wondering whether checking timer->is_soft would make the code more 
readable?

While investigation how this is meant to work, I noticed a few others things.

timer->base could potentially change under our feet at any point of time (we 
don't hold any lock). So it would be valid to have base == migration_base.

migration_cpu_base does not have softirq_expiry_lock initialized. So we would 
end up to use an uninitialized lock. Note that migration_base->index is always 
0, so the check base->index > MASK_SHIFT would hide it.

Alternatively, we could initialize the spin lock for migration_cpu_base avoiding 
to rely on side effect of the check.

Another potential issue is the compiler is free to reload timer->base at any 
time. So I think we want an ACCESS_ONCE(...).

Lastly timer->base cannot be NULL. From the comment on top of 
migration_cpu_base, timer->base->cpu_base will as well not be NULL.

So I think the function can be reworked as:

void hrtimer_grab_expirty_lock(const struct hrtimer *timer)
{
         struct hrtimer_clock_base *base = ACCESS_ONCE(timer->base);

         if (!timer->is_soft && base != migration_base ) {
           spin_lock();
           spin_unlock();
         }
}


>   		spin_lock(&base->cpu_base->softirq_expiry_lock);
>   		spin_unlock(&base->cpu_base->softirq_expiry_lock);
>   	}
> 
> This should deal with it.
> 
>> Cheers,
> 
> Sebastian
> 

-- 
Julien Grall
