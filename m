From: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
Subject: Re: [PATCH] arch/arm64: Enable PREEMPT_RT_FULL
Date: Tue, 14 Apr 2015 11:14:21 +0530
Message-ID: <CAPyr0yJN_CQdbmDidppLpRKP-dxLdSNfk7r=iXwiotnU8yQu+w@mail.gmail.com>
References: <1428825578-12326-1-git-send-email-anders.roxell@linaro.org>
	<20150413140203.GB27894@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anders Roxell <anders.roxell@linaro.org>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33310 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbDNFoY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Apr 2015 01:44:24 -0400
Received: by qkx62 with SMTP id 62so221286160qkx.0
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Apr 2015 22:44:23 -0700 (PDT)
In-Reply-To: <20150413140203.GB27894@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello ,

I have gone through below code and i felt logic is different with
respect to arm code . please find my findings.

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -347,11 +347,16 @@ el1_irq:
 #ifdef CONFIG_PREEMPT
  get_thread_info tsk
  ldr w24, [tsk, #TI_PREEMPT] // get preempt count
- cbnz w24, 1f // preempt count != 0
+ cbnz w24, 2f // preempt count != 0
  ldr x0, [tsk, #TI_FLAGS] // get flags
- tbz x0, #TIF_NEED_RESCHED, 1f // needs rescheduling?
- bl el1_preempt
+ tbz x0, #_TIF_NEED_RESCHED, 2f // needs rescheduling?
+
+ ldr w24, [tsk, #TI_PREEMPT_LAZY] // get preempt lazy count
+ cbnz w24, 1f // preempt count != 0
+ tbz x0, #_TIF_NEED_RESCHED_LAZY, 2f // needs rescheduling?
 1:
+ bl el1_preempt
+2:
 #endif


My findings:
-----------------

 1)   + tbz x0, #_TIF_NEED_RESCHED, 2f // needs rescheduling?

  => Here we should proceed to check TI_PREEMPT_LAZY conditions if
_TIF_NEED_RESCHED is not set. . If it is set,  it should jump to
el1_preempt.

 2) fast_work_pending handler also should check TI_PREEMPT_LAZY flags
as per defined in arm.


Thanks and regards,
Ayyappa.Ch




On Mon, Apr 13, 2015 at 7:32 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Anders Roxell | 2015-04-12 09:59:38 [+0200]:
>
>>arm64 is missing support for PREEMPT_RT. The main feature which is
>>lacking is support for lazy preemption. The arch-specific entry code,
>>thread information structure definitions, and associated data tables
>>have to be extended to provide this support. Then the Kconfig file has
>>to be extended to indicate the support is available, and also to
>>indicate that support for full RT preemption is now available.
>>
>>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>---
>>
>>I tested this on an arm64 juno target, to get that to boot I had to
>>backport the dtb from v4.0-rc6 to v3.18.11-rt6.
>
> Seriously? It all works by itself? Out of curiosity, how likely is it
> that I can login on one of these machines if I send you a ssh key?
>
>> arch/arm64/Kconfig                   |  2 ++
>> arch/arm64/include/asm/thread_info.h |  3 +++
>> arch/arm64/kernel/asm-offsets.c      |  1 +
>> arch/arm64/kernel/entry.S            | 14 ++++++++++----
>> 4 files changed, 16 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>index 9532f8d..62f4e00 100644
>>--- a/arch/arm64/Kconfig
>>+++ b/arch/arm64/Kconfig
>>@@ -59,7 +59,9 @@ config ARM64
>>       select HAVE_PERF_REGS
>>       select HAVE_PERF_USER_STACK_DUMP
>>       select HAVE_RCU_TABLE_FREE
>>+      select HAVE_PREEMPT_LAZY
>>       select HAVE_SYSCALL_TRACEPOINTS
>>+      select IRQ_FORCED_THREADING
>
> Did you mark all non-threadable interrupts? Commit da0ec6f7c1e ("ARM:
> 7814/2: Allow forced irq threading") was the patch for ARM. If so you
> could take this piece and send upstream and get the kernel commandline
> "threadirqs" working without -RT :)
>
> For the lazy-preempt pieces, arch/arm64/kernel/entry.S, work_pending
> checks only for TIF_NEED_RESCHED while arm checks for both (this and
> _TIF_NEED_RESCHED_LAZY). You sure you don't need it?
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
