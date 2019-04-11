Return-Path: <SRS0=sXU0=SN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A6C10F14
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Apr 2019 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815C12083E
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Apr 2019 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDKPMQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:12:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44602 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfDKPMP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Apr 2019 11:12:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B2CC15AD;
        Thu, 11 Apr 2019 08:12:15 -0700 (PDT)
Received: from [10.37.12.69] (unknown [10.37.12.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0007F3F68F;
        Thu, 11 Apr 2019 08:12:12 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190404105233.GD3567@e103592.cambridge.arm.com>
 <a46f9fd4-dd31-c892-aec1-ae69072be92d@arm.com>
 <20190405143942.xtpq5443qbc4gziy@linutronix.de>
 <dabf5b36-d22e-e8a3-c01f-6b0f5b3be710@arm.com>
 <20190405154259.3g3fv72miizm64hc@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <1af20802-7e3f-6f93-bec0-0d625533ce4a@arm.com>
Date:   Thu, 11 Apr 2019 16:12:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405154259.3g3fv72miizm64hc@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On 4/5/19 4:42 PM, Sebastian Andrzej Siewior wrote:
> On 2019-04-05 16:17:50 [+0100], Julien Grall wrote:
>> Hi,
> Hi,
> 
>>> A per-CPU lock? It has to be a raw_spinlock_t because a normal
>>> spin_lock() / local_lock() would allow scheduling and might be taken as
>>> part of the context switch or soon after.
>> raw_spinlock_t would not work here without disabling preemption. Otherwise
>> you may end up to recurse on the lock and therefore deadlock. But then it
>> raise the question of the usefulness of the lock here.
>>
>> However, I don't really understand why allowing the scheduling would be a
>> problem here. Is it a concern because we will waste cycle trying to
>> restore/save a context that will be scratched as soon as we release the
>> lock?
> 
> If you hold the lock within the kernel thread and every kernel thread
> acquires it before doing any SIMD operations then you are good. It could
> be a sleeping lock. What happens if you hold the lock, are scheduled out
> and a user task is about to be scheduled? How do you force the kernel
> thread out / give up the FPU registers?

You would need the thread out to finish running the critical section 
before the next thread to run. I was under the impression with sleeping 
lock, the priority of the thread out would get bumped to finish quickly 
the critical section.

I agree it means that you will waste time restoring registers that will 
get trashed right after you leave the critical sections. This is 
probably not really efficient.

Anyway, that was only a suggestion I haven't fully thought through. I 
have no plan to do more work than this patch in the fpsimd context switch.

> 
> That preempt_disable() + local_bh_disable() might not be the pretties
> thing but how bad is it actually?

 From the measurement I did on non-RT, it is beneficial to keep the 
softirq enabled (see [1]).

I don't have platform where FPSIMD is used in softirqs (or at least not 
by default). So for testing purpose, I wrote a tasklet (based on 
hrtimer) using the FPSIMD registers every 1ms if it is allowed (i.e 
may_use_simd() returns true). I let it run for a while and notice that 
the tasklet will be executed only 0.15% of the time when !may_use_simd().

Furthermore, from what I understood in this thread, there are few 
limited use cases where FPSIMD will be used in softirqs. So it seems 
better to me to avoid disabling softirqs at least in non-RT.

For the RT, aren't all the softirqs handled in a thread? So what would 
be the benefits to disable softirqs if we already disable preemption?

In any case, this patch introduces new helpers (get_cpu_fpsimd_context 
and put_cpu_fpsimd_context) to delimit regions using the HW FPSIMD. So 
it would be easy to modify the behavior if we wanted too.

> Latency wise you can't schedule(). From RT point of view you need to
> enable preemption while going from page to page because of the possible
> kmap() or kmalloc() (on baldy aligned src/dst) with the crypto's
> page-walk code.

Make sense. However I don't think we can keep enable the preemption with 
the current implementation of FPSIMD context switch. I noticed you 
disabled crypto for Arm64 because of allocations, I have a todo to look 
at what we can do.

Cheers,

[1] https://marc.info/?l=linux-rt-users&m=155499183812211&w=2

> 
> Sebastian
> 

-- 
Julien Grall
