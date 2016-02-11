From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
Date: Thu, 11 Feb 2016 09:29:57 -0800
Message-ID: <56BCC515.2030107@linaro.org>
References: <5671CD5B.9030907@linaro.org> <20151221104818.GF23092@arm.com>
 <alpine.DEB.2.11.1512211749180.28591@nanos> <20151221170028.GT23092@arm.com>
 <56955B3A.5010303@linaro.org> <20160113102622.GC25458@arm.com>
 <569686BA.6050703@linaro.org> <20160113172303.GH25458@arm.com>
 <56969312.7070309@linaro.org> <56B5135B.3050801@linaro.org>
 <20160211135435.GG32084@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Catalin.Marinas@arm.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160211135435.GG32084@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2/11/2016 5:54 AM, Will Deacon wrote:
> On Fri, Feb 05, 2016 at 01:25:47PM -0800, Shi, Yang wrote:
>> On 1/13/2016 10:10 AM, Shi, Yang wrote:
>>> On 1/13/2016 9:23 AM, Will Deacon wrote:
>>>> On Wed, Jan 13, 2016 at 09:17:46AM -0800, Shi, Yang wrote:
>>>>> On 1/13/2016 2:26 AM, Will Deacon wrote:
>>>>>> On Tue, Jan 12, 2016 at 11:59:54AM -0800, Shi, Yang wrote:
>>>>>>> This might be buried in email storm during the holiday. Just want
>>>>>>> to double
>>>>>>> check the status. I'm supposed there is no objection for getting it
>>>>>>> merged
>>>>>>> in upstream?
>>>>>>
>>>>>> Sorry, when you replied with:
>>>>>>
>>>>>>> I think we could just extend the "signal delay send" approach from
>>>>>>> x86-64
>>>>>>> to arm64, which is currently used by x86-64 on -rt kernel only.
>>>>>>
>>>>>> I understood that you were going to fix -rt, so I dropped this pending
>>>>>> anything more from you.
>>>>>>
>>>>>> What's the plan?
>>>>>
>>>>> Sorry for the confusion. The "signal delay send" approach used by
>>>>> x86-64 -rt
>>>>> should be not necessary for arm64 right now. Reenabling interrupt is
>>>>> still
>>>>> the preferred approach.
>>>>>
>>>>> Since x86-64 has per-CPU IST exception stack, so preemption has to be
>>>>> disabled all the time. However, it is not applicable to other
>>>>> architectures
>>>>> for now, including arm64.
>>>>
>>>> Actually, we grew support for a separate IRQ stack in the recent merge
>>>> window. Does that change things here, or are you referring to something
>>>> else?
>>>
>>> Had a quick look at the patches, it looks the irq stack is not nestable
>>> and it switches back to the original stack as long as irq handler is
>>> done before preempt happens. So, it sounds it won't change things here.
>>
>>
>> Just had a quick test on 4.5-rc1. It survives with kgdbts, ptrace and ltp.
>> So, it sounds safe with the "separate IRQ stack" change.
>
> I quite liked the sigtrap consolidation in my earlier (broken) approach.
> Does the following work for you?

Yes, sure. One minor comment below.

>
> Will
>
> --->8
>
>  From e04a28d45ff343b47a4ffc4dee3a3e279e76ddfa Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Wed, 10 Feb 2016 16:05:28 +0000
> Subject: [PATCH] arm64: debug: re-enable irqs before sending breakpoint
>   SIGTRAP
>
> force_sig_info can sleep under an -rt kernel, so attempting to send a
> breakpoint SIGTRAP with interrupts disabled yields the following BUG:
>
>    BUG: sleeping function called from invalid context at
>    /kernel-source/kernel/locking/rtmutex.c:917
>    in_atomic(): 0, irqs_disabled(): 128, pid: 551, name: test.sh
>    CPU: 5 PID: 551 Comm: test.sh Not tainted 4.1.13-rt13 #7
>    Hardware name: Freescale Layerscape 2085a RDB Board (DT)
>    Call trace:
> 	 dump_backtrace+0x0/0x128
> 	 show_stack+0x24/0x30
> 	 dump_stack+0x80/0xa0
> 	 ___might_sleep+0x128/0x1a0
> 	 rt_spin_lock+0x2c/0x40
> 	 force_sig_info+0xcc/0x210
> 	 brk_handler.part.2+0x6c/0x80
> 	 brk_handler+0xd8/0xe8
> 	 do_debug_exception+0x58/0xb8
>
> This patch fixes the problem by ensuring that interrupts are enabled
> prior to sending the SIGTRAP if they were already enabled in the user
> context.
>
> Reported-by: Yang Shi <yang.shi@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/kernel/debug-monitors.c | 48 +++++++++++++++++---------------------
>   1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 8aee3aeec3e6..c536c9e307b9 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -226,11 +226,28 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
>   	return retval;
>   }
>
> +static void send_user_sigtrap(int si_code)
> +{
> +	struct pt_regs *regs = current_pt_regs();
> +	siginfo_t info = {
> +		.si_signo	= SIGTRAP,
> +		.si_errno	= 0,
> +		.si_code	= si_code,
> +		.si_addr	= (void __user *)instruction_pointer(regs),
> +	};
> +
> +	if (WARN_ON(!user_mode(regs)))

Maybe BUG_ON should be used here? Since send_user_sigtrap is called only 
when user_mode is positive, and interrupt is disabled at this point, so 
if it is not positive, it sounds list a bug.

Thanks,
Yang

> +		return;
> +
> +	if (interrupts_enabled(regs))
> +		local_irq_enable();
> +
> +	force_sig_info(SIGTRAP, &info, current);
> +}
> +
>   static int single_step_handler(unsigned long addr, unsigned int esr,
>   			       struct pt_regs *regs)
>   {
> -	siginfo_t info;
> -
>   	/*
>   	 * If we are stepping a pending breakpoint, call the hw_breakpoint
>   	 * handler first.
> @@ -239,11 +256,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>   		return 0;
>
>   	if (user_mode(regs)) {
> -		info.si_signo = SIGTRAP;
> -		info.si_errno = 0;
> -		info.si_code  = TRAP_HWBKPT;
> -		info.si_addr  = (void __user *)instruction_pointer(regs);
> -		force_sig_info(SIGTRAP, &info, current);
> +		send_user_sigtrap(TRAP_HWBKPT);
>
>   		/*
>   		 * ptrace will disable single step unless explicitly
> @@ -307,17 +320,8 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
>   static int brk_handler(unsigned long addr, unsigned int esr,
>   		       struct pt_regs *regs)
>   {
> -	siginfo_t info;
> -
>   	if (user_mode(regs)) {
> -		info = (siginfo_t) {
> -			.si_signo = SIGTRAP,
> -			.si_errno = 0,
> -			.si_code  = TRAP_BRKPT,
> -			.si_addr  = (void __user *)instruction_pointer(regs),
> -		};
> -
> -		force_sig_info(SIGTRAP, &info, current);
> +		send_user_sigtrap(TRAP_BRKPT);
>   	} else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
>   		pr_warning("Unexpected kernel BRK exception at EL1\n");
>   		return -EFAULT;
> @@ -328,7 +332,6 @@ static int brk_handler(unsigned long addr, unsigned int esr,
>
>   int aarch32_break_handler(struct pt_regs *regs)
>   {
> -	siginfo_t info;
>   	u32 arm_instr;
>   	u16 thumb_instr;
>   	bool bp = false;
> @@ -359,14 +362,7 @@ int aarch32_break_handler(struct pt_regs *regs)
>   	if (!bp)
>   		return -EFAULT;
>
> -	info = (siginfo_t) {
> -		.si_signo = SIGTRAP,
> -		.si_errno = 0,
> -		.si_code  = TRAP_BRKPT,
> -		.si_addr  = pc,
> -	};
> -
> -	force_sig_info(SIGTRAP, &info, current);
> +	send_user_sigtrap(TRAP_BRKPT);
>   	return 0;
>   }
>
>
