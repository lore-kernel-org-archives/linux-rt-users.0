From: Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Thu, 21 May 2015 17:35:11 +0200
Message-ID: <4053482.VK9u0kqo8W@wuerfel>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com> <20150521135007.GC3983@localhost.localdomain> <CAKv+Gu_u+iYL4niHip9nzUd9p7tEt6XEvhZ4fQLJK_gVaw+FSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Anders Roxell <anders.roxell@gmail.com>,
	Ayyappa Ch <ayyappa.ch.linux@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Kevin Hilman <kevin.hilman@linaro.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51622 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbbEUPfP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 May 2015 11:35:15 -0400
In-Reply-To: <CAKv+Gu_u+iYL4niHip9nzUd9p7tEt6XEvhZ4fQLJK_gVaw+FSA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thursday 21 May 2015 17:23:43 Ard Biesheuvel wrote:
> On 21 May 2015 at 15:50, Anders Roxell <anders.roxell@gmail.com> wrote:
> > On 2015-05-01 20:59, Ayyappa Ch wrote:
> >> Floating point operations in arm64 should not disable preempt .
> >> Activating realtime features with below code.
> >
> > I've talked with an engineer who worked on fpsimd and I was told that
> > replacing preempt_disable with migrate_disable would leave fpsimd open
> > to corruption.
> >
> > The kernel won't save the state of the simd registers when it is
> > preempted so if another task runs on the same CPU and also uses simd, it
> > clobbers the registers of the first task, and migrate_disable() does not
> > prevent that.
> >
> > If we want to use SIMD with preemption enabled, we need to update the
> > context switch code to do a full SIMD register state save&restore if
> > necessary. However, this can have a noticeable cost in all task switch
> > latencies.
> >
> 
> I noticed somewhere in this thread that the culprit was ultimately a
> call to virt_efi_set_time(), which is the UEFI Runtime Service that
> programs the RTC. If this is a hot spot, then there is something very
> wrong with the system which is entirely unrelated to preempt_rt.

Ah, that explains a lot!

> But let's assume this is a valid UEFI Runtime Services call: since
> UEFI Runtime Services are allowed to use the FP/SIMD register file, we
> need the kernel_neon_begin()/kernel_neon_end() pair even though it is
> highly unlikely that such a runtime service call would actually need
> to use the NEON or floating point. It is simply imposed by the
> kernel<->firmware ABI. Also, on this particular code path, preemption
> will be disabled regardless, since the UEFI Runtime Services are
> invoked with a UEFI specific TTBR0 mapping, which rules out preemption
> for reasons unrelated to the FP/SIMD register file.

Can we disable support for UEFI runtime services with preempt-rt
kernels? A 'depends on !PREEMPT_RT' would seem sufficient there.

	Arnd
