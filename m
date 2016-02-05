From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
Date: Fri, 5 Feb 2016 13:25:47 -0800
Message-ID: <56B5135B.3050801@linaro.org>
References: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
 <20151216111316.GD4308@arm.com> <5671CD5B.9030907@linaro.org>
 <20151221104818.GF23092@arm.com> <alpine.DEB.2.11.1512211749180.28591@nanos>
 <20151221170028.GT23092@arm.com> <56955B3A.5010303@linaro.org>
 <20160113102622.GC25458@arm.com> <569686BA.6050703@linaro.org>
 <20160113172303.GH25458@arm.com> <56969312.7070309@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, Catalin.Marinas@arm.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56969312.7070309@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 1/13/2016 10:10 AM, Shi, Yang wrote:
> On 1/13/2016 9:23 AM, Will Deacon wrote:
>> On Wed, Jan 13, 2016 at 09:17:46AM -0800, Shi, Yang wrote:
>>> On 1/13/2016 2:26 AM, Will Deacon wrote:
>>>> On Tue, Jan 12, 2016 at 11:59:54AM -0800, Shi, Yang wrote:
>>>>> This might be buried in email storm during the holiday. Just want
>>>>> to double
>>>>> check the status. I'm supposed there is no objection for getting it
>>>>> merged
>>>>> in upstream?
>>>>
>>>> Sorry, when you replied with:
>>>>
>>>>> I think we could just extend the "signal delay send" approach from
>>>>> x86-64
>>>>> to arm64, which is currently used by x86-64 on -rt kernel only.
>>>>
>>>> I understood that you were going to fix -rt, so I dropped this pending
>>>> anything more from you.
>>>>
>>>> What's the plan?
>>>
>>> Sorry for the confusion. The "signal delay send" approach used by
>>> x86-64 -rt
>>> should be not necessary for arm64 right now. Reenabling interrupt is
>>> still
>>> the preferred approach.
>>>
>>> Since x86-64 has per-CPU IST exception stack, so preemption has to be
>>> disabled all the time. However, it is not applicable to other
>>> architectures
>>> for now, including arm64.
>>
>> Actually, we grew support for a separate IRQ stack in the recent merge
>> window. Does that change things here, or are you referring to something
>> else?
>
> Had a quick look at the patches, it looks the irq stack is not nestable
> and it switches back to the original stack as long as irq handler is
> done before preempt happens. So, it sounds it won't change things here.


Just had a quick test on 4.5-rc1. It survives with kgdbts, ptrace and 
ltp. So, it sounds safe with the "separate IRQ stack" change.

Thanks,
Yang

>
> Thanks.,
> Yang
>
>>
>> Will
>>
>
