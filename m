From: Julien Grall <julien.grall@arm.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Mon, 18 Feb 2019 14:33:36 +0000
Message-ID: <205c0b3a-d905-544f-31c3-1bb6ab68bb5b@arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org, Dave.Martin@arm.com,
        linux-rt-users@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Sebastian,

On 13/02/2019 14:30, Sebastian Andrzej Siewior wrote:
> On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
> 
> This is equal what x86 is currently doing. The naming is slightly
> different, there is irq_fpu_usable().
The idea behind the patch was taken from x86. On x86, softirq does not seem to 
be disabled when context switching the FPUs registers.

> 
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
>> When in used, softirqs usually fallback to a software method.
>>
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
> 
> Is this bad? This means also that your crypto code will not be
> interrupted by a softirq. Also if you would get rid of it, you could
> avoid the software fallback in case may_use_simd() says false.

There seem to have some misunderstanding about the purpose of this patch. Any 
use of crypto in the kernel is only protected by preempt_disable(). softirqs are 
only disabled when context switching the FPU register between two userspace tasks.

 From the commit log cb84d11e1625 "arm64: neon: Remove support for nested or 
hardirq kernel-mode NEON" this was done to protect against rare softirqs use 
crypto. It seems to me this is a bit overkill to increase softirq latency if 
they barely use FPSIMD/SVE. Indeed, the SVE context can be quite large, 
therefore it can take some times to save/restore it.

[...]

>> For RT-linux, it might be possible to use migrate_{enable, disable}. I
>> am quite new with RT and have some trouble to understand the semantics
>> of migrate_{enable, disable}. So far, I am still unsure if it is possible
>> to run another userspace task on the same CPU while getting preempted
>> when the migration is disabled.
> 
> In RT:
> - preemt_disable() is the same as !RT. A thread can not be suspend. An
>    interrupt may interrupt. However on RT we have threaded interrupts so
>    the interrupt is limited to the first-level handler (not the threaded
>    handler).
> 
> - migrate_disable() means that the thread can not be moved to another
>    CPU. It can be suspended.
> 
> - local_bh_disable() disables the BH: No softirq can run. In RT
>    local_bh_disable() does not inherit preempt_disable(). Two different
>    softirqs can be executed in parallel.
>    The BH is usually invoked at the end of the threaded interrupt
>    (because the threaded interrupt handler raises the softirq). It can
>    also run in the ksoftirqd.
> 
> Usually you should not get preempted in a migrate_disable() section. A
> SCHED_OTHER task should not interrupt another SCHED_OTHER task in a
> migrate_disable() section. A task with a higher priority (a RT/DL task)
> will. Since threaded interrupts run with a RT priority of 50, they will
> interrupt your task in a migrate_disable() section.

Thank you for the explanation!

Cheers,

-- 
Julien Grall
