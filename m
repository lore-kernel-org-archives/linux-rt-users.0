From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Fri, 22 May 2015 12:04:20 +0200
Message-ID: <CAKv+Gu9yX2TKxBd4VxRKq-Jt2PEQgPD6NCy6kCccQz5v_+XV2A@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
	<4053482.VK9u0kqo8W@wuerfel>
	<CAKv+Gu-bMy29BhQJb=bap_KDWTUTKOW4JVjvFOEtHuubJWhMDQ@mail.gmail.com>
	<2318126.unulghvt2b@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anders Roxell <anders.roxell@gmail.com>,
	Ayyappa Ch <ayyappa.ch.linux@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Kevin Hilman <kevin.hilman@linaro.org>
To: Arnd Bergmann <arnd@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33353 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835AbbEVKEU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 May 2015 06:04:20 -0400
Received: by iebgx4 with SMTP id gx4so27710354ieb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 22 May 2015 03:04:20 -0700 (PDT)
In-Reply-To: <2318126.unulghvt2b@wuerfel>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 22 May 2015 at 11:46, Arnd Bergmann <arnd@linaro.org> wrote:
> On Thursday 21 May 2015 18:01:27 Ard Biesheuvel wrote:
>>
>> You could but I wouldn't recommend it since it may also prevent you
>> from being able to set the boot path, but more importantly, reset and
>> poweroff may also be available only via UEFI Runtime Services on UEFI
>> systems.
>
> Right, makes sense. Another option then could be to disable fpsimd
> support with preempt-rt on real systems, and document this as a known
> source of latency.
>

Unfortunately, that could result in corruption of userland FP/SIMD
context, since the UEFI Runtime Services are allowed to use those
registers, and only need to adhere to the normal AAPCS rules that
stipulate that q8..q15 are callee-save. That would still result in a
25% latency reduction if we only need to preserve q0..q7 and q16..q31



>> So could someone comment on whether virt_efi_set_time() is present in
>> all the problematic traces? Or was it only chosen because it
>> illustrates the underlying problem the best? In the former case, there
>> is an hidden bug that I would like to know about: however, if some
>> time related facility that is used in a performance (or latency)
>> sensitive context ultimately ends up programming the wall clock time
>> in the RTC, then I would expect the same issue to occur on non-UEFI
>> systems as well.
>
> But without UEFI, updating the RTC would cause much less latency,
> because  you don't need to save/restore the fpsimd context, disable
> preemption, or call into a potentially unknown external binary
> blob, the only latency you'd get there is that of a readl/writel
> accessing the RTC register.
>

Yes, that is right. So the UEFI Runtime Service interface is
disproportionately heavy. But that still doesn't explain why it would
make sense to sync the RTC with the system clock often enough that it
violates maximum latency limits, since normally, you read it on boot
and set it on reset/poweroff.

>> One thing I should point out is that this FP/SIMD save/restore is
>> implemented differently depending on whether it is called from process
>> context or from hardirq/softirq context. In the former case,
>> kernel_neon_begin() preserves the userland FP/SIMD context only once,
>> and only restores it right before returning to userland. This way,
>> only the first kernel_neon_begin() and the last kernel_neon_end() call
>> actually induce this latency, and so the average latency could be
>> quite a bit lower than the worst case (although I understand that few
>> people may care about the average in an RT context)
>
> Just for my own interest: in what case do we save/restore the fpsimd
> state from interrupt context?
>

For instance, the IEEE802.11 crypto runs in softirq context, but
typically performs a non-trivial amount of crypto work (unless the
hardware takes care of it). Since the accelerated AES-CCM module is
20x faster than C code, it makes sense to stack/unstack 6 NEON
registers and run it on the NEON.
