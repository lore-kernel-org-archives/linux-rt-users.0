Return-Path: <SRS0=sXU0=SN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547FEC10F14
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Apr 2019 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2342133D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Apr 2019 15:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKP6p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:58:45 -0400
Received: from foss.arm.com ([217.140.101.70]:45446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKP6p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Apr 2019 11:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6843D80D;
        Thu, 11 Apr 2019 08:58:44 -0700 (PDT)
Received: from [10.37.12.69] (unknown [10.37.12.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A94DE3F68F;
        Thu, 11 Apr 2019 08:58:42 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190404105233.GD3567@e103592.cambridge.arm.com>
 <a46f9fd4-dd31-c892-aec1-ae69072be92d@arm.com>
 <20190405150722.GE3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <899713e0-2d32-04a0-b2f2-3493f7299033@arm.com>
Date:   Thu, 11 Apr 2019 16:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405150722.GE3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Dave,

On 4/5/19 4:07 PM, Dave Martin wrote:
> On Fri, Apr 05, 2019 at 10:02:45AM +0100, Julien Grall wrote:
>>>> +#ifdef CONFIG_KERNEL_MODE_NEON
>>>> +
>>>>   /*
>>>>    * may_use_simd - whether it is allowable at this time to issue SIMD
>>>>    *                instructions or access the SIMD register file
>>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>>> index 5ebe73b69961..b7e5dac26190 100644
>>>> --- a/arch/arm64/kernel/fpsimd.c
>>>> +++ b/arch/arm64/kernel/fpsimd.c
>>>> @@ -90,7 +90,8 @@
>>>>    * To prevent this from racing with the manipulation of the task's FPSIMD state
>>>>    * from task context and thereby corrupting the state, it is necessary to
>>>>    * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
>>>> - * flag with local_bh_disable() unless softirqs are already masked.
>>>> + * flag with kernel_neon_{disable, enable}. This will still allow softirqs to
>>>> + * run but prevent them to use FPSIMD.
>>>>    *
>>>>    * For a certain task, the sequence may look something like this:
>>>>    * - the task gets scheduled in; if both the task's fpsimd_cpu field
>>>> @@ -142,6 +143,9 @@ extern void __percpu *efi_sve_state;
>>>>   #endif /* ! CONFIG_ARM64_SVE */
>>>> +static void kernel_neon_disable(void);
>>>> +static void kernel_neon_enable(void);
>>>
>>> I find these names a bit confusing: _disable() actualy enables FPSIMD/SVE
>>> context access for the current context (i.e., makes it safe).
>>>
>>> Since these also disable/enable preemption, perhaps we can align them
>>> with the existing get_cpu()/put_cpu(), something like:
>>>
>>> void get_cpu_fpsimd_context();
>>> vold put_cpu_fpsimd_context();
>>>
>>> If you consider it's worth adding the checking helper I alluded to
>>> above, it could then be called something like:
>>>
>>> bool have_cpu_fpsimd_context();
>>
>> I am not sure where you suggested a checking helper above. Do you refer to
>> exposing kernel_neon_busy even for !CONFIG_KERNEL_MODE_NEON?
> 
> Hmmm, looks like I got my reply out of order here.
> 
> I meant the helper (if any) to check
> !preemptible() && !__this_cpu_read(kernel_neon_busy).

I guess you are using && instead of || because some of the caller may 
not call get_cpu_fpsimd_context() before but still disable preemption, 
right?

Wouldn't it be better to have all the user calling 
get_cpu_fpsimd_context() and put_cpu_fpsimd_context()?

This has the advantage to uniformize how the way FPSIMD is protected and 
also...

> 
> Looks like you inferred what I meant later on anyway.
> 
>>
>>>
>>>> +
>>>>   /*
>>>>    * Call __sve_free() directly only if you know task can't be scheduled
>>>>    * or preempted.
>>>> @@ -213,11 +217,11 @@ static void sve_free(struct task_struct *task)
>>>>    * thread_struct is known to be up to date, when preparing to enter
>>>>    * userspace.
>>>>    *
>>>> - * Softirqs (and preemption) must be disabled.
>>>> + * Preemption must be disabled.
>>>
>>> [*] That's not enough: we need to be in kernel_neon_disable()...
>>> _enable() (i.e., kernel_neon_busy needs to be true to prevent softirqs
>>> messing with the FPSIMD state).
>>
>> How about not mentioning preemption at all and just say:
>>
>> "The fpsimd context should be acquired before hand".
>>
>> This would help if we ever decide to protect critical section differently.
> 
> Yes, or even better, name the function used to do this (i.e.,
> kernel_neon_disable() or get_cpu_fpsimd_context() or whatever it's
> called).

... would make the comments simpler because we would have only one 
possible case to care.

Cheers,

-- 
Julien Grall
