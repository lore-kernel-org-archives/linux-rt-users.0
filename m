From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 19:20:18 +0000
Message-ID: <CAKv+Gu9Ljw5fuvxZVFVY+rpBnh_cbUijF76H7Ve54hpENsq9ZA@mail.gmail.com>
References: <20171130142216.GB12606@linutronix.de> <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de> <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de> <24FDBFF1-8351-46FC-885A-6B6F972F4C6C@linaro.org>
 <20171201175844.GT22781@e103592.cambridge.arm.com> <20171201180828.GN10595@n2100.armlinux.org.uk>
 <20171201182410.GU22781@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Dave Martin <Dave.Martin@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34915 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdLATUT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Dec 2017 14:20:19 -0500
Received: by mail-io0-f195.google.com with SMTP id q15so12378737ioh.2
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Dec 2017 11:20:19 -0800 (PST)
In-Reply-To: <20171201182410.GU22781@e103592.cambridge.arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 1 December 2017 at 18:24, Dave Martin <Dave.Martin@arm.com> wrote:
> On Fri, Dec 01, 2017 at 06:08:28PM +0000, Russell King - ARM Linux wrote:
>> On Fri, Dec 01, 2017 at 05:58:45PM +0000, Dave Martin wrote:
>> > +1, at least for arm64.  I don't see a really compelling reason for
>> > holding kernel-mode NEON around memory management now that we have a
>> > strict save-once-restore-lazily model.
>> >
>> > This may not work so well for arm though -- I haven't looked at that
>> > code for a while.
>> >
>> >
>> > If there is memory manamement in any core loop, you already lost
>> > the performance battle, and an extra
>> > kernel_neon_end()+kernel_neon_begin() may not be that catastrophic.
>>
>> Remember that we don't permit context switches while kernel neon is
>> in use on ARM - if there's any possibility of scheduling to occur,
>> the get_cpu() in kernel_neon_begin() should trigger a schedule-while-
>> atomic warning.
>
> Agreed, and an arm64 the same is true.  (Actually softirq is disabled
> too, for tortuous reasons involving SVE.)
>
> On 2017-12-01 11:43:32 [+0100], To linux-rt-users@vger.kernel.org wrote:
>> NEON in kernel mode is used by the crypto algorithms and raid6 code.
>> While the raid6 code looks okay, the crypto algorithms do not: NEON
>> is enabled on first invocation and may allocate/free/map memory before
>> the NEON mode is disabled again.
>> This needs to be changed until it can be enabled.
>> On ARM NEON in kernel mode can be simply disabled. on ARM64 it needs to
>> stay on due to possible EFI callbacks so here I disable each algorithm.
>
> [...]
>
>> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
>> index 70c517aa4501..2a5f05b5a19a 100644
>> --- a/arch/arm64/crypto/Kconfig
>> +++ b/arch/arm64/crypto/Kconfig
>> @@ -19,19 +19,19 @@ config CRYPTO_SHA512_ARM64
>>
>>  config CRYPTO_SHA1_ARM64_CE
>>     tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
>> -   depends on KERNEL_MODE_NEON
>> +   depends on KERNEL_MODE_NEON && !PREEMPT_RT_BASE
>>     select CRYPTO_HASH
>>     select CRYPTO_SHA1
>
> Sebastian, can you piont to where sha1 (say) hits this issue?
> I wonder whether this is really a sign that some refactoring is needed.
>

I don't think the SHA code is affected. It is primarily the block
ciphers, where the scatterwalk API offers some guarantees to the API
client (the NEON crypto driver) that data is presented in suitable
blocks. This may involve copying data from the scatterlist to a temp
buffer if any of the chunks are not blocksize aligned.
