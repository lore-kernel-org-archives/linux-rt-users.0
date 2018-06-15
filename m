Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:50323 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965931AbeFOQJV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Jun 2018 12:09:21 -0400
Date: Fri, 15 Jun 2018 18:09:19 +0200
From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: kernel_fpu_begin and spinlocks
Message-ID: <20180615160919.45pyszi2dbeboff5@linutronix.de>
References: <CAHmME9p1TZV9i6EBuFR+Pqf+8yg-sjM0f=uYzqdYKMxxUiHuRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9p1TZV9i6EBuFR+Pqf+8yg-sjM0f=uYzqdYKMxxUiHuRw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-rt-users@vger.kernel.org

On 2018-06-15 15:00:51 [+0200], Jason A. Donenfeld wrote:
> Hello,
Hi,

> On normal kernels, that's certainly okay. 

once the latencies get "big" it is also affects PREEMPT.

> But on rt kernels, spinlocks
> call schedule(), and kernel_fpu_begin() explicitly disables
> preemption, so everything explodes.
> 
> I'm wondering if -rt has any ideas about not having a strict
> preemption requirement for kernel_fpu_begin/end, so that the ordinary
> pattern can work on -rt kernels without exploding.

We can't do fast crypto on RT. We unbreak those sections:
 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/x86-crypto-reduce-preempt-disabled-regions.patch?h=linux-4.16.y-rt-patches
 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/crypto-limit-more-FPU-enabled-sections.patch?h=linux-4.16.y-rt-patches
 https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/crypto-Reduce-preempt-disabled-regions-more-algos.patch?h=linux-4.16.y-rt-patches

There are a few problems. One problem is that algorithm involving
SSE/AVX doing page_size+ operations in "one go" would affect the latency
due to the "long" preempt-disable regions.
The other thing are nested locks like you mentioned. "Simple" locks like
those protecting a list_head could be turned into raw-locks. But then
some of those implementation involve advancing the scatter-gather list
within a kernel_fpu_begin()/preempt_disable() region. Depending on the
size of list this is also bad latency wise for PREEMPT (and not only for
RT) the problem is that on RT we can't do kmalloc()/kmap() within
kernel_fpu_begin().

At some point I tried something like:

	if (tif_need_resched_now()) {
		kernel_fpu_end();
		kernel_fpu_begin();
	}

which died once the scatter-gather got into the game.

> Regards,
> Jason

Sebastian
