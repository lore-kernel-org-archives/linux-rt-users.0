From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] arch/arm64: Enable PREEMPT_RT_FULL
Date: Mon, 13 Apr 2015 16:02:03 +0200
Message-ID: <20150413140203.GB27894@linutronix.de>
References: <1428825578-12326-1-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60223 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbbDMOCF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Apr 2015 10:02:05 -0400
Content-Disposition: inline
In-Reply-To: <1428825578-12326-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Anders Roxell | 2015-04-12 09:59:38 [+0200]:

>arm64 is missing support for PREEMPT_RT. The main feature which is
>lacking is support for lazy preemption. The arch-specific entry code,
>thread information structure definitions, and associated data tables
>have to be extended to provide this support. Then the Kconfig file has
>to be extended to indicate the support is available, and also to
>indicate that support for full RT preemption is now available.
>
>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>---
>
>I tested this on an arm64 juno target, to get that to boot I had to
>backport the dtb from v4.0-rc6 to v3.18.11-rt6.

Seriously? It all works by itself? Out of curiosity, how likely is it
that I can login on one of these machines if I send you a ssh key?

> arch/arm64/Kconfig                   |  2 ++
> arch/arm64/include/asm/thread_info.h |  3 +++
> arch/arm64/kernel/asm-offsets.c      |  1 +
> arch/arm64/kernel/entry.S            | 14 ++++++++++----
> 4 files changed, 16 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>index 9532f8d..62f4e00 100644
>--- a/arch/arm64/Kconfig
>+++ b/arch/arm64/Kconfig
>@@ -59,7 +59,9 @@ config ARM64
> 	select HAVE_PERF_REGS
> 	select HAVE_PERF_USER_STACK_DUMP
> 	select HAVE_RCU_TABLE_FREE
>+	select HAVE_PREEMPT_LAZY
> 	select HAVE_SYSCALL_TRACEPOINTS
>+	select IRQ_FORCED_THREADING

Did you mark all non-threadable interrupts? Commit da0ec6f7c1e ("ARM:
7814/2: Allow forced irq threading") was the patch for ARM. If so you
could take this piece and send upstream and get the kernel commandline
"threadirqs" working without -RT :)

For the lazy-preempt pieces, arch/arm64/kernel/entry.S, work_pending
checks only for TIF_NEED_RESCHED while arm checks for both (this and
_TIF_NEED_RESCHED_LAZY). You sure you don't need it?

Sebastian
