From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Thu, 21 May 2015 18:01:27 +0200
Message-ID: <CAKv+Gu-bMy29BhQJb=bap_KDWTUTKOW4JVjvFOEtHuubJWhMDQ@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
	<20150521135007.GC3983@localhost.localdomain>
	<CAKv+Gu_u+iYL4niHip9nzUd9p7tEt6XEvhZ4fQLJK_gVaw+FSA@mail.gmail.com>
	<4053482.VK9u0kqo8W@wuerfel>
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
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33215 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbbEUQBa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 May 2015 12:01:30 -0400
Received: by igbpi8 with SMTP id pi8so14018353igb.0
        for <linux-rt-users@vger.kernel.org>; Thu, 21 May 2015 09:01:30 -0700 (PDT)
In-Reply-To: <4053482.VK9u0kqo8W@wuerfel>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 21 May 2015 at 17:35, Arnd Bergmann <arnd@linaro.org> wrote:
> On Thursday 21 May 2015 17:23:43 Ard Biesheuvel wrote:
>> On 21 May 2015 at 15:50, Anders Roxell <anders.roxell@gmail.com> wrote:
>> > On 2015-05-01 20:59, Ayyappa Ch wrote:
>> >> Floating point operations in arm64 should not disable preempt .
>> >> Activating realtime features with below code.
>> >
>> > I've talked with an engineer who worked on fpsimd and I was told that
>> > replacing preempt_disable with migrate_disable would leave fpsimd open
>> > to corruption.
>> >
>> > The kernel won't save the state of the simd registers when it is
>> > preempted so if another task runs on the same CPU and also uses simd, it
>> > clobbers the registers of the first task, and migrate_disable() does not
>> > prevent that.
>> >
>> > If we want to use SIMD with preemption enabled, we need to update the
>> > context switch code to do a full SIMD register state save&restore if
>> > necessary. However, this can have a noticeable cost in all task switch
>> > latencies.
>> >
>>
>> I noticed somewhere in this thread that the culprit was ultimately a
>> call to virt_efi_set_time(), which is the UEFI Runtime Service that
>> programs the RTC. If this is a hot spot, then there is something very
>> wrong with the system which is entirely unrelated to preempt_rt.
>
> Ah, that explains a lot!
>
>> But let's assume this is a valid UEFI Runtime Services call: since
>> UEFI Runtime Services are allowed to use the FP/SIMD register file, we
>> need the kernel_neon_begin()/kernel_neon_end() pair even though it is
>> highly unlikely that such a runtime service call would actually need
>> to use the NEON or floating point. It is simply imposed by the
>> kernel<->firmware ABI. Also, on this particular code path, preemption
>> will be disabled regardless, since the UEFI Runtime Services are
>> invoked with a UEFI specific TTBR0 mapping, which rules out preemption
>> for reasons unrelated to the FP/SIMD register file.
>
> Can we disable support for UEFI runtime services with preempt-rt
> kernels? A 'depends on !PREEMPT_RT' would seem sufficient there.
>

You could but I wouldn't recommend it since it may also prevent you
from being able to set the boot path, but more importantly, reset and
poweroff may also be available only via UEFI Runtime Services on UEFI
systems.

So could someone comment on whether virt_efi_set_time() is present in
all the problematic traces? Or was it only chosen because it
illustrates the underlying problem the best? In the former case, there
is an hidden bug that I would like to know about: however, if some
time related facility that is used in a performance (or latency)
sensitive context ultimately ends up programming the wall clock time
in the RTC, then I would expect the same issue to occur on non-UEFI
systems as well.

If virt_efi_set_time() is merely a false positive (i.e., all
invocations are justifiable), then we are dealing with a general
latency issue caused by saving/restoring the FP/SIMD register file.
Unfortunately, there's really no way around it, since the FP/SIMD
registers are only preserved/restored on a task switch (as Anders has
also pointed out).

One thing I should point out is that this FP/SIMD save/restore is
implemented differently depending on whether it is called from process
context or from hardirq/softirq context. In the former case,
kernel_neon_begin() preserves the userland FP/SIMD context only once,
and only restores it right before returning to userland. This way,
only the first kernel_neon_begin() and the last kernel_neon_end() call
actually induce this latency, and so the average latency could be
quite a bit lower than the worst case (although I understand that few
people may care about the average in an RT context)

In non-process context, the stack/unstack is done on every call to
kernel_neon_begin/end, alyhough in that case, the
kernel_neon_begin_partial() that I implemented specifically for this
case may be used to only preserve a subset of the register file. For
example, AES-CCM uses 6 registers, and the core AES transform only 4.
Currently, this is ignored by the ordinary process context
stack/unstack routines, since the cost is amortized over more
invocations, but for the RT world, I could imagine how having a lower
latency stack/unstack also in process context could be useful.
