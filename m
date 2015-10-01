From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [PATCH] arm64: replace read_lock to rcu lock in call_break_hook
Date: Thu, 01 Oct 2015 09:03:05 -0700
Message-ID: <560D5939.7080107@linaro.org>
References: <1443653944-21885-1-git-send-email-yang.shi@linaro.org> <20151001150735.GH6963@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, will.deacon@arm.com, dave.long@linaro.org,
	panand@redhat.com, linaro-kernel@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36175 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbbJAQDH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Oct 2015 12:03:07 -0400
Received: by pablk4 with SMTP id lk4so77840825pab.3
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Oct 2015 09:03:07 -0700 (PDT)
In-Reply-To: <20151001150735.GH6963@e104818-lin.cambridge.arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/1/2015 8:07 AM, Catalin Marinas wrote:
> On Wed, Sep 30, 2015 at 03:59:04PM -0700, Yang Shi wrote:
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index cebf786..eb520d0 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -292,11 +292,11 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
>>   	struct break_hook *hook;
>>   	int (*fn)(struct pt_regs *regs, unsigned int esr) = NULL;
>>
>> -	read_lock(&break_hook_lock);
>> +	rcu_read_lock();
>>   	list_for_each_entry(hook, &break_hook, node)
>>   		if ((esr & hook->esr_mask) == hook->esr_val)
>>   			fn = hook->fn;
>> -	read_unlock(&break_hook_lock);
>> +	rcu_read_unlock();
>>
>>   	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
>>   }
>
> That's not enough, you also need list_(add|del)_rcu where the list is
> modified, together with list_for_each_entry_rcu() here.

Thanks for pointing it out. I'm going to prepare v2 with list_(add|del)_rcu.

Yang

>

