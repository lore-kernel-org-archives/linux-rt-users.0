From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
Date: Wed, 16 Dec 2015 12:45:15 -0800
Message-ID: <5671CD5B.9030907@linaro.org>
References: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
 <20151216111316.GD4308@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Catalin.Marinas@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151216111316.GD4308@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 12/16/2015 3:13 AM, Will Deacon wrote:
> On Tue, Dec 15, 2015 at 04:18:08PM -0800, Yang Shi wrote:
>> The kernel just send out a SIGTRAP signal when handling ptrace breakpoint in
>> debug exception, so it sounds safe to have interrupt enabled if it is not
>> disabled by the parent process.
>
> Is this actually fixing an issue you're seeing, or did you just spot this?
> Given that force_sig_info disable interrupts, I don't think this is really
> worth doing.

I should made more comments at the first place, sorry for the inconvenience.

I did run into some problems on -rt kernel with CRIU restore, please see 
the below kernel bug log:

BUG: sleeping function called from invalid context at 
/kernel-source/kernel/locking/rtmutex.c:917
in_atomic(): 0, irqs_disabled(): 128, pid: 551, name: test.sh
CPU: 5 PID: 551 Comm: test.sh Not tainted 4.1.13-rt13 #7
Hardware name: Freescale Layerscape 2085a RDB Board (DT)
Call trace:
[<ffff8000000885f0>] dump_backtrace+0x0/0x128
[<ffff80000008873c>] show_stack+0x24/0x30
[<ffff800000798e84>] dump_stack+0x80/0xa0
[<ffff8000000bd858>] ___might_sleep+0x128/0x1a0
[<ffff8000007a072c>] rt_spin_lock+0x2c/0x40
[<ffff8000000a477c>] force_sig_info+0xcc/0x210
[<ffff800000085174>] brk_handler.part.2+0x6c/0x80
[<ffff800000085260>] brk_handler+0xd8/0xe8
[<ffff800000082368>] do_debug_exception+0x58/0xb8
Exception stack(0xffff80834b6e3e30 to 0xffff80834b6e3f50)
3e20:                                     00000000 00000000 004e6000 
00000000
3e40: ffffffff ffffffff 00400004 00000000 0000d280 00000000 00000007 
00000000
3e60: 00000021 00000000 ffffffff ffffffff 0000011a 00000000 000000de 
00000000
3e80: 4ab9ef50 ffff8083 00086324 ffff8000 e587f780 0000ffff 000839b0 
ffff8000
3ea0: 00000000 00000000 004e6000 00000000 ffffffff ffffffff 00400004 
00000000
3ec0: 60000000 00000000 00000015 00000000 aa3e6000 0000ffff 0000d280 
00000000
3ee0: 00000007 00000000 00000021 00000000 ffffffff ffffffff 00000000 
00000000
3f00: 00000000 00000000 00000000 00000000 000000de 00000000 00000008 
00000000
3f20: 004eff00 00000000 004e4ff0 00000000 004f0490 00000000 e587f730 
0000ffff
3f40: 0046f508 00000000 00000028 00000000

It is because force_sig_info called spin_lock_irqsave which could sleep 
on -rt kernel with irq disabled.

However, it just happens at brk_handler in my test. But, I saw 
single_step has the same code path, so I expanded it to single step too.

Since this is rt related, cc to rt mailing list too.

>
>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>> ---
>>   arch/arm64/kernel/debug-monitors.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index 8aee3ae..90d70e4 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -239,6 +239,9 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>>   		return 0;
>>
>>   	if (user_mode(regs)) {
>> +		if (interrupts_enabled(regs))
>> +			local_irq_enable();
>> +
>
> My worry here is that we take an interrupt and, on the return path,
> decide to reschedule due to CONFIG_PREEMPT. If we somehow end up back
> in the debugger, I'm concerned that it could remove the breakpoint and
> then later see an unexpected SIGTRAP from the child.
>
> Having said that, I've failed to construct a non-racy scenario in which
> that can happen, but I'm just really uncomfortable making this change
> unless there's a real problem being solved.

The patch is inspired by the similar code in other architectures, e.g. 
x86 and powerpc which have hardware debug exception to handle breakpoint 
and single step like arm64. And, they have interrupt enabled in both 
breakpoint and single step. So, I'm supposed arm64 could do the same thing.

For the preempt case, it might be possible, but it sounds like a 
exception handling problem to me. The preempt should not be allowed in 
debug exception (current arm64 kernel does it), and in interrupt return 
path the code should check if debug is on or not. If debug is on, 
preempt should be just skipped. Or we could disable preempt in debug 
exception.

I also checked the handling in x86 and powerpc, they go different way.

1. x86
Disable preempt in IST exception since it uses per CPU stack.

2. powerpc
Check if debug is on in interrupt return path. Powerpc has DBCR0_IDM 
indicate if the processor is in debug mode.

For ARM64, I don't find such bit. So, I may consider to have preempt 
disabled.

Thanks,
Yang

>
> Will
>
