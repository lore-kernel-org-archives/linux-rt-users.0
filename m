From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
Date: Mon, 21 Dec 2015 09:27:37 -0800
Message-ID: <56783689.5050308@linaro.org>
References: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
 <20151216111316.GD4308@arm.com> <5671CD5B.9030907@linaro.org>
 <20151221104818.GF23092@arm.com> <alpine.DEB.2.11.1512211749180.28591@nanos>
 <20151221170028.GT23092@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Catalin.Marinas@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35253 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbLUR1i (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2015 12:27:38 -0500
Received: by mail-pf0-f180.google.com with SMTP id 78so18848644pfw.2
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2015 09:27:38 -0800 (PST)
In-Reply-To: <20151221170028.GT23092@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/21/2015 9:00 AM, Will Deacon wrote:
> On Mon, Dec 21, 2015 at 05:51:22PM +0100, Thomas Gleixner wrote:
>> On Mon, 21 Dec 2015, Will Deacon wrote:
>>> +static void send_user_sigtrap(int si_code)
>>> +{
>>> +	struct pt_regs *regs = current_pt_regs();
>>> +	siginfo_t info = {
>>> +		.si_signo	= SIGTRAP,
>>> +		.si_errno	= 0,
>>> +		.si_code	= si_code,
>>> +		.si_addr	= (void __user *)instruction_pointer(regs),
>>> +	};
>>> +
>>> +	if (WARN_ON(!user_mode(regs)))
>>> +		return;
>>> +
>>> +	preempt_disable();
>>
>> That doesn't work on RT either. force_sig_info() takes task->sighand->siglock,
>> which is a 'sleeping' spinlock on RT.
>
> Ah, I missed that :/
>
>> Why would we need to disable preemption here at all? What's the problem of
>> being preempted or even migrated?
>
> There *might* not be a problem, I'm just really nervous about changing
> the behaviour on the debug path and subtly changing how ptrace behaves.
>
> My worry was that you could somehow get back into the tracer, and it
> could remove a software breakpoint in the knowledge that it wouldn't
> see any future (spurious) SIGTRAPs for that location.
>
> Without a concrete example, however, I guess I'll bite the bullet and
> enable irqs across the call to force_sig_info, since there is clearly a
> real issue here on RT.

Thanks for the review.

I don't have any concrete usecase for that race condition too since all 
ptrace tests from ltp passed. However, even though we need preemption 
disabled at some point in debug exception code path in the future, I 
think we could just extend the "signal delay send" approach from x86-64 
to arm64, which is currently used by x86-64 on -rt kernel only.

Regards,
Yang

>
> Will
>

