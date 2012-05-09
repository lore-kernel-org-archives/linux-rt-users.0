From: Christophe Huriaux <c.huriaux@gmail.com>
Subject: BUG - "scheduling while atomic" on a irq handler (s3c-mci)
Date: Wed, 9 May 2012 16:07:13 +0200
Message-ID: <CAEOomG9NEoQKqp=pMx0NpzGaFpHBimALwhemnZL4F-8g7XURkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44398 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895Ab2EIOHe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 10:07:34 -0400
Received: by dady13 with SMTP id y13so350381dad.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 May 2012 07:07:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everyone,

   I am facing a problem while trying to run a rt-patched 3.2.y kernel
with PREEMPT_RT_FULL on a mini2440 board (ARM based s3c2440 SoC) :
whilst a vanilla kernel (with PREEMPT_LL) works like a charm,
PREEMPT_RTB and PREEMPT_RT_FULL makes the MMC/SD driver  (s3cmci)
hang, which result in the kernel waiting indefinitely for the root fs
to mount.

  I think that the IRQ handling of the driver is somehow disturbed by
the changes made by the RT patch. When using PREEMPT_RTB I can see the
following message in the console :

BUG: scheduling while atomic: irq/37-s3c-mci/253/0x00000102
Modules linked in:
Function entered at [<c000e90c>] from [<c029f478>]
Function entered at [<c029f478>] from [<c029fc3c>]
Function entered at [<c029fc3c>] from [<c00559c0>]
Function entered at [<c00559c0>] from [<c01dd4c8>]
Function entered at [<c01dd4c8>] from [<c0024a0c>]
Function entered at [<c0024a0c>] from [<c0024d9c>]
Function entered at [<c0024d9c>] from [<c0024fe8>]
Function entered at [<c0024fe8>] from [<c0025140>]
Function entered at [<c0025140>] from [<c00549f0>]
Function entered at [<c00549f0>] from [<c00547c4>]
Function entered at [<c00547c4>] from [<c0039954>]
Function entered at [<c0039954>] from [<c000a120>]

  When I run the kernel under Qemu, debug through gdb and put a
breakpoint on unwind_backtace the details of the previous backtrace is
:

#0  unwind_backtrace (regs=0x0, tsk=0x0) at arch/arm/kernel/unwind.c:409
#1  0xc029f478 in schedule_debug (prev=<optimized out>) at kernel/sched.c:4357
#2  __schedule () at kernel/sched.c:4537
#3  0xc029fc3c in schedule () at kernel/sched.c:4625
#4  0xc00559c0 in synchronize_irq (irq=<optimized out>) at
kernel/irq/manage.c:73
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

  I don't see the "bug" message with PREEMPT_RT_FULL, the kernel just
hang waiting for the rootfs. The problem did not occur in the 2.6.y
tree AFAIK.

  I'd like to investigate more and fix the s3cmci driver but I don't
know where to begin, could someone give me some hints on what should
be done/not be done for a rt patch compliant device driver/irq handler
?


Regards,
Christophe Huriaux
