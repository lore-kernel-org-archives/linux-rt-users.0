Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVng (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:36 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 11/15] powerpc/vdso64: Use double word compare on pointers
Date: Tue, 14 Aug 2018 13:54:04 -0500
Message-Id: <3b8ae839112996fd70ddba60b9a201be256dd892.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Anton Blanchard <anton@samba.org>

[ Upstream stable commit 0edffe75fc811fa5181ea202a1ad26bf17fd58f5 ]

commit 5045ea37377ce8cca6890d32b127ad6770e6dce5 upstream.

__kernel_get_syscall_map() and __kernel_clock_getres() use cmpli to
check if the passed in pointer is non zero. cmpli maps to a 32 bit
compare on binutils, so we ignore the top 32 bits.

A simple test case can be created by passing in a bogus pointer with
the bottom 32 bits clear. Using a clk_id that is handled by the VDSO,
then one that is handled by the kernel shows the problem:

  printf("%d\n", clock_getres(CLOCK_REALTIME, (void *)0x100000000));
  printf("%d\n", clock_getres(CLOCK_BOOTTIME, (void *)0x100000000));

And we get:

  0
  -1

The bigger issue is if we pass a valid pointer with the bottom 32 bits
clear, in this case we will return success but won't write any data
to the pointer.

I stumbled across this issue because the LLVM integrated assembler
doesn't accept cmpli with 3 arguments. Fix this by converting them to
cmpldi.

Fixes: a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support to 32 bits kernel")
Cc: stable@vger.kernel.org # v2.6.15+
Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/powerpc/kernel/vdso64/datapage.S     | 2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 79796de11737..3263ee23170d 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -57,7 +57,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	bl	V_LOCAL_FUNC(__get_datapage)
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	li	r0,__NR_syscalls
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a76b4af37ef2..382021324883 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -145,7 +145,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	bne	cr0,99f
 
 	li	r3,0
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	lis	r5,CLOCK_REALTIME_RES@h
-- 
2.14.1
