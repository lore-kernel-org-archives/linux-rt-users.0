From: Julien Grall <julien.grall@arm.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Mon, 18 Feb 2019 14:07:26 +0000
Message-ID: <7671d868-9d33-dfe1-851a-b72271f12d5f@arm.com>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190212171350.GB1002@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212171350.GB1002@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 12/02/2019 17:13, Julia Cartwright wrote:
> Hello Julien-

Hello Julien,

> 
> On Fri, Feb 08, 2019 at 04:55:13PM +0000, Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
>>
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
>> When in used, softirqs usually fallback to a software method.
>>
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
>>
>> As a softirq should not rely on been able to use simd at a given time,
>> there are limited reason to keep softirq disabled when touching the
>> FPSIMD/SVE context. Instead, we can only disable preemption and tell
>> the NEON unit is currently in use.
>>
>> This patch introduces two new helpers kernel_neon_{disable, enable} to
>> mark the area using FPSIMD/SVE context and use them in replacement of
>> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
>> also re-implemented to use the new helpers.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>
>> I have been exploring this solution as an alternative approach to the RT
>> patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".
>>
>> So far, the patch has only been lightly tested.
>>
>> For RT-linux, it might be possible to use migrate_{enable, disable}. I
>> am quite new with RT and have some trouble to understand the semantics
>> of migrate_{enable, disable}. So far, I am still unsure if it is possible
>> to run another userspace task on the same CPU while getting preempted
>> when the migration is disabled.
> 
> Yes, a thread in a migrate_disable()-protected critical section can be
> preempted, and another thread on the same CPU may enter the critical
> section.
> 
> If it's necessary to prevent this from happening, then you need to also
> make use of a per-CPU mutex.  On RT, this would do the right thing
> w.r.t. priority inheritance.

Thank you for the explanation, I now understand better the concept of 
migrate_disable.

Best regards,

-- 
Julien Grall
