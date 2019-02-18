From: Julien Grall <julien.grall@arm.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Mon, 18 Feb 2019 15:07:51 +0000
Message-ID: <32ba7e1e-37ce-c904-15e4-9c908e873479@arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
 <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
 <20190214103449.GN3567@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214103449.GN3567@e103592.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On 14/02/2019 10:34, Dave Martin wrote:
> On Wed, Feb 13, 2019 at 05:52:27PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2019-02-13 16:40:00 [+0100], Ard Biesheuvel wrote:
>>>>> This is equal what x86 is currently doing. The naming is slightly
>>>>> different, there is irq_fpu_usable().
>>>>
>>>> Yes, I think it's basically the same idea.
>>>>
>>>> It's been evolving a bit on both sides, but is quite similar now.
>>>>
>>>
>>> may_use_simd() only exists because we have a generic crypto SIMD
>>> helper, and so we needed something arch agnostic to wrap around
>>> irq_fpu_usable()
>>
>> My question was more if this is helpful and we want to keep or if
>> it would be better to remove it and always disable BH as part of SIMD
>> operations.
> 
> Wouldn't this arbitrarily increase softirq latency?  Unconditionally
> forbidding SIMD in softirq might make more sense.  It depends on how
> important the use cases are...

Looking at the commit message from cb84d11e1625 "arm64: neon: Remove support for 
nested or hardirq kernel-mode NEON", one of the use case for crypto in softirq 
is certain mac80211 drivers.

Is there any other use case for use crypto in softirqs?

Cheers,

-- 
Julien Grall
