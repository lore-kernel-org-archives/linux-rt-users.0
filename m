From: Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Fri, 22 May 2015 12:31:06 +0200
Message-ID: <3538272.9TRSDPmMrl@wuerfel>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com> <2318126.unulghvt2b@wuerfel> <CAKv+Gu9yX2TKxBd4VxRKq-Jt2PEQgPD6NCy6kCccQz5v_+XV2A@mail.gmail.com>
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
Received: from mout.kundenserver.de ([212.227.126.130]:51692 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945991AbbEVKbR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 May 2015 06:31:17 -0400
In-Reply-To: <CAKv+Gu9yX2TKxBd4VxRKq-Jt2PEQgPD6NCy6kCccQz5v_+XV2A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Friday 22 May 2015 12:04:20 Ard Biesheuvel wrote:
> On 22 May 2015 at 11:46, Arnd Bergmann <arnd@linaro.org> wrote:
> > On Thursday 21 May 2015 18:01:27 Ard Biesheuvel wrote:
> >>
> >> You could but I wouldn't recommend it since it may also prevent you
> >> from being able to set the boot path, but more importantly, reset and
> >> poweroff may also be available only via UEFI Runtime Services on UEFI
> >> systems.
> >
> > Right, makes sense. Another option then could be to disable fpsimd
> > support with preempt-rt on real systems, and document this as a known
> > source of latency.
> >
> 
> Unfortunately, that could result in corruption of userland FP/SIMD
> context, since the UEFI Runtime Services are allowed to use those
> registers, and only need to adhere to the normal AAPCS rules that
> stipulate that q8..q15 are callee-save. That would still result in a
> 25% latency reduction if we only need to preserve q0..q7 and q16..q31

Ah, of course. In some cases, one could probably build the entire
user space without fpsimd support as well, but that obviously
wouldn't be a general recommendation.

> >> One thing I should point out is that this FP/SIMD save/restore is
> >> implemented differently depending on whether it is called from process
> >> context or from hardirq/softirq context. In the former case,
> >> kernel_neon_begin() preserves the userland FP/SIMD context only once,
> >> and only restores it right before returning to userland. This way,
> >> only the first kernel_neon_begin() and the last kernel_neon_end() call
> >> actually induce this latency, and so the average latency could be
> >> quite a bit lower than the worst case (although I understand that few
> >> people may care about the average in an RT context)
> >
> > Just for my own interest: in what case do we save/restore the fpsimd
> > state from interrupt context?
> >
> 
> For instance, the IEEE802.11 crypto runs in softirq context, but
> typically performs a non-trivial amount of crypto work (unless the
> hardware takes care of it). Since the accelerated AES-CCM module is
> 20x faster than C code, it makes sense to stack/unstack 6 NEON
> registers and run it on the NEON.

I see, thanks!

	Arnd
