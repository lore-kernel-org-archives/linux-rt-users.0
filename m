Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156B9C10F0F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 09:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B1321872
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfDEJCu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:02:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbfDEJCt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 05:02:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B572168F;
        Fri,  5 Apr 2019 02:02:49 -0700 (PDT)
Received: from [10.37.12.206] (unknown [10.37.12.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4193F721;
        Fri,  5 Apr 2019 02:02:46 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190404105233.GD3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <a46f9fd4-dd31-c892-aec1-ae69072be92d@arm.com>
Date:   Fri, 5 Apr 2019 10:02:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404105233.GD3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Dave,

Thank you for the review.

On 4/4/19 11:52 AM, Dave Martin wrote:
> On Fri, Feb 08, 2019 at 04:55:13PM +0000, Julien Grall wrote:
>> For RT-linux, it might be possible to use migrate_{enable, disable}. I
>> am quite new with RT and have some trouble to understand the semantics
>> of migrate_{enable, disable}. So far, I am still unsure if it is possible
>> to run another userspace task on the same CPU while getting preempted
>> when the migration is disabled.
> 
> (Leaving aside the RT aspects for now, but if migrate_{enable,disable}
> is costly it might not be the best thing to use deep in context switch
> paths, even if is technically correct...)

Based on the discussion in this thread, migrate_enable/migrate_disable 
is not suitable in this context.

The goal of those helpers is to pin the task to the current CPU. On RT, 
it will not disable the preemption. So the current task can be preempted 
by a task with higher priority.

The next task may require to use the FPSIMD and will potentially result 
to corrupt the state.

RT folks already saw this corruption because local_bh_disable() does not 
preempt on RT. They are carrying a patch (see "arm64: fpsimd: use 
preemp_disable in addition to local_bh_disable()") to disable preemption 
along with local_bh_disable().

Alternatively, Julia suggested to introduce a per-cpu lock to protect 
the state. I am thinking to defer this for a follow-up patch. The 
changes in this patch should make it easier because we now have helper 
to mark the critical section.

> 
>> ---
>>   arch/arm64/include/asm/simd.h |  4 +--
>>   arch/arm64/kernel/fpsimd.c    | 76 +++++++++++++++++++++++++------------------
>>   2 files changed, 46 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
>> index 6495cc51246f..94c0dac508aa 100644
>> --- a/arch/arm64/include/asm/simd.h
>> +++ b/arch/arm64/include/asm/simd.h
>> @@ -15,10 +15,10 @@
>>   #include <linux/preempt.h>
>>   #include <linux/types.h>
>>   
>> -#ifdef CONFIG_KERNEL_MODE_NEON
>> -
>>   DECLARE_PER_CPU(bool, kernel_neon_busy);
> 
> Why make this unconditional?  This declaration is only here for
> may_use_simd() to use.  The stub version of may_use_simd() for the
> !CONFIG_KERNEL_MODE_NEON case doesn't touch it.

kernel_neon_busy will be used in fpsimd.c even when with 
!CONFIG_KERNEL_MODE_NEON. So it makes sense to also declare it in the 
header even if not used.

Another solution is to avoid expose kernel_neon_busy outside of fpsimd.c 
and use an helper.

> 
>>   
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +
>>   /*
>>    * may_use_simd - whether it is allowable at this time to issue SIMD
>>    *                instructions or access the SIMD register file
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 5ebe73b69961..b7e5dac26190 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -90,7 +90,8 @@
>>    * To prevent this from racing with the manipulation of the task's FPSIMD state
>>    * from task context and thereby corrupting the state, it is necessary to
>>    * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
>> - * flag with local_bh_disable() unless softirqs are already masked.
>> + * flag with kernel_neon_{disable, enable}. This will still allow softirqs to
>> + * run but prevent them to use FPSIMD.
>>    *
>>    * For a certain task, the sequence may look something like this:
>>    * - the task gets scheduled in; if both the task's fpsimd_cpu field
>> @@ -142,6 +143,9 @@ extern void __percpu *efi_sve_state;
>>   
>>   #endif /* ! CONFIG_ARM64_SVE */
>>   
>> +static void kernel_neon_disable(void);
>> +static void kernel_neon_enable(void);
> 
> I find these names a bit confusing: _disable() actualy enables FPSIMD/SVE
> context access for the current context (i.e., makes it safe).
> 
> Since these also disable/enable preemption, perhaps we can align them
> with the existing get_cpu()/put_cpu(), something like:
> 
> void get_cpu_fpsimd_context();
> vold put_cpu_fpsimd_context();
> 
> If you consider it's worth adding the checking helper I alluded to
> above, it could then be called something like:
> 
> bool have_cpu_fpsimd_context();

I am not sure where you suggested a checking helper above. Do you refer 
to exposing kernel_neon_busy even for !CONFIG_KERNEL_MODE_NEON?

> 
>> +
>>   /*
>>    * Call __sve_free() directly only if you know task can't be scheduled
>>    * or preempted.
>> @@ -213,11 +217,11 @@ static void sve_free(struct task_struct *task)
>>    * thread_struct is known to be up to date, when preparing to enter
>>    * userspace.
>>    *
>> - * Softirqs (and preemption) must be disabled.
>> + * Preemption must be disabled.
> 
> [*] That's not enough: we need to be in kernel_neon_disable()...
> _enable() (i.e., kernel_neon_busy needs to be true to prevent softirqs
> messing with the FPSIMD state).

How about not mentioning preemption at all and just say:

"The fpsimd context should be acquired before hand".

This would help if we ever decide to protect critical section differently.

> 
>>    */
>>   static void task_fpsimd_load(void)
>>   {
>> -	WARN_ON(!in_softirq() && !irqs_disabled());
>> +	WARN_ON(!preempt_count() && !irqs_disabled());
> 
> Hmmm, looks like we can rewrite this is preemptible().  See
> include/linux/preempt.h.
> 
> Since we are checking that nothing can mess with the FPSIMD regs and
> associated task metadata, we should also be checking kernel_neon_busy
> here.
> 
> For readability, we could wrap all that up in a single helper.

With what I said above, we could replace this check 
WARN_ON(!have_cpu_fpsimd_context()).

[...]

>> +static void kernel_neon_disable(void)
>> +{
>> +	preempt_disable();
>> +	WARN_ON(__this_cpu_read(kernel_neon_busy));
>> +	__this_cpu_write(kernel_neon_busy, true);
> 
> Can we do this with one __this_cpu_xchg()?

I think so.

> 
>> +}
>> +
>> +static void kernel_neon_enable(void)
>> +{
>> +	bool busy;
>> +
>> +	busy = __this_cpu_xchg(kernel_neon_busy, false);
>> +	WARN_ON(!busy); /* No matching kernel_neon_disable()? */
>> +
>> +	preempt_enable();
>> +}
>> +
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +
>>   /*
>>    * Kernel-side NEON support functions
>>    */
>> @@ -1084,9 +1105,7 @@ void kernel_neon_begin(void)
>>   
>>   	BUG_ON(!may_use_simd());
>>   
>> -	local_bh_disable();
>> -
>> -	__this_cpu_write(kernel_neon_busy, true);
>> +	kernel_neon_disable();
>>   
>>   	/* Save unsaved fpsimd state, if any: */
>>   	fpsimd_save();
>> @@ -1094,9 +1113,7 @@ void kernel_neon_begin(void)
>>   	/* Invalidate any task state remaining in the fpsimd regs: */
>>   	fpsimd_flush_cpu_state();
>>   
>> -	preempt_disable();
>> -
>> -	local_bh_enable();
>> +	kernel_neon_enable();
> 
> As you commented in your reply elsewhere, we don't want to call
> kernel_neon_enable() here.  We need to keep exclusive ownership of the
> CPU regs to continue until kernel_neon_end() is called.

I already fixed it in my tree. Thank you for the reminder.

> 
> Otherwise, this looks reasonable overall.
> 
> One nice feature of this is that is makes it clearer that the code is
> grabbing exclusive access to a particular thing (the FPSIMD regs and
> context metadata), which is not very obvious from the bare
> local_bh_{disable,enable} that was there previously.
> 
> When reposting, you should probably rebase on kvmarm/next [1], since
> there is a minor conflict from the SVE KVM series.  It looks
> straightforward to fix up though.

I will have a look.

> 
> [...]
> 
> For testing, can we have a test irritator module that does something
> like hooking the timer softirq with a kprobe and trashing the regs
> inside kernel_neon_begin()/_end()?

I will see what I can do.

> 
> It would be nice to have such a thing upstream, but it's OK to test
> with local hacks for now.
> 
> 
> I'm not sure how this patch will affect context switch overhead, so it
> would be good to see hackbench numbers (or similar).

I will give a try with hackbench/kernbench.

Cheers,

> [1] git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
> next
> 

-- 
Julien Grall
