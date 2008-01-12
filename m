From: Sripathi Kodi <sripathik@in.ibm.com>
Subject: [PATCH PREEMPT_RT] Compilation fix for PPC
Date: Sat, 12 Jan 2008 23:39:48 +0530
Message-ID: <200801122339.48479.sripathik@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([59.145.155.4]:52215 "EHLO
	e28esmtp04.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754317AbYALSJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Jan 2008 13:09:42 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2.6.24-rc5-rt1 won't compile on PPC if CONFIG_SMP is turned off.=20

  CC      arch/powerpc/kernel/pmc.o
In file included from include/asm/tlb.h:62,
                 from arch/powerpc/mm/mem.c:44:
include/asm-generic/tlb.h: In function =E2=80=98tlb_gather_mmu=E2=80=99=
:
include/asm-generic/tlb.h:58: error: implicit declaration of function =E2=
=80=98__get_cpu_lock=E2=80=99
include/asm-generic/tlb.h:58: error: =E2=80=98mmu_gathers=E2=80=99 unde=
clared (first use in this function)
include/asm-generic/tlb.h:58: error: (Each undeclared identifier is rep=
orted only once
include/asm-generic/tlb.h:58: error: for each function it appears in.)
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: warning: type defaults to =E2=80=98int=E2=
=80=99 in declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: warning: type defaults to =E2=80=98int=E2=
=80=99 in declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: error: implicit declaration of function =E2=
=80=98__get_cpu_var_locked=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h: In function =E2=80=98tlb_finish_mmu=E2=80=99=
:
include/asm-generic/tlb.h:96: error: =E2=80=98mmu_gathers=E2=80=99 unde=
clared (first use in this function)
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:96: warning: type defaults to =E2=80=98int=E2=
=80=99 in declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:96: warning: type defaults to =E2=80=98int=E2=
=80=99 in declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99

The patch below fixes it.

Thanks,
Sripathi.

Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

diff -uprN linux-2.6.24-rc5-rt1_org/include/asm-powerpc/percpu.h linux-=
2.6.24-rc5-rt1/include/asm-powerpc/percpu.h
--- linux-2.6.24-rc5-rt1_org/include/asm-powerpc/percpu.h	2008-01-12 17=
:43:03.000000000 +0530
+++ linux-2.6.24-rc5-rt1/include/asm-powerpc/percpu.h	2008-01-12 17:43:=
58.000000000 +0530
@@ -68,6 +68,8 @@ extern void setup_per_cpu_areas(void);
=20
 #define __get_cpu_var(var)			per_cpu__##var
 #define __raw_get_cpu_var(var)			per_cpu__##var
+#define __get_cpu_lock(var, cpu)		per_cpu_lock__##var##_locked
+#define __get_cpu_var_locked(var, cpu)		per_cpu__##var##_locked
=20
 #endif	/* SMP */
=20
