From: Alessio Igor Bogani <abogani@texware.it>
Subject: Someone can explain me this error?
Date: Thu, 07 Jun 2007 09:35:30 +0200
Message-ID: <1181201730.13830.8.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:47488 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbXFGHgW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 03:36:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id 93FD6608108
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Jun 2007 09:36:18 +0200 (CEST)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jxDNZ5lbcDps for <linux-rt-users@vger.kernel.org>;
	Thu,  7 Jun 2007 09:36:18 +0200 (CEST)
Received: from [192.168.100.121] (adsl203-157-083.mclink.it [213.203.157.83])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id C8B4A608102
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Jun 2007 09:36:17 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

I'm trying to compile 2.6.22 kernel with patch-2.6.21.3-rt9.

I have this error but i don't understand what type of error it is.
Someone can explain me this error? Or suggest me how can resolve it?
What mean "error: expected declaration specifiers or =E2=80=98...=E2=80=
=99 before
=E2=80=98mmu_gathers=E2=80=99" ?

Thanks in advance.

Ciao,
Alessio


In file included from include/asm/tlb.h:18,
                 from arch/i386/mm/init.c:43:
include/asm-generic/tlb.h:49: error: expected declaration specifiers or
=E2=80=98...=E2=80=99 before =E2=80=98mmu_gathers=E2=80=99
include/asm-generic/tlb.h:49: warning: data definition has no type or
storage class
include/asm-generic/tlb.h:49: warning: type defaults to =E2=80=98int=E2=
=80=99 in
declaration of =E2=80=98DECLARE_PER_CPU_LOCKED=E2=80=99
include/asm-generic/tlb.h: In function =E2=80=98tlb_gather_mmu=E2=80=99=
:
include/asm-generic/tlb.h:58: warning: implicit declaration of function
=E2=80=98__get_cpu_lock=E2=80=99
include/asm-generic/tlb.h:58: error: =E2=80=98mmu_gathers=E2=80=99 unde=
clared (first use
in this function)
include/asm-generic/tlb.h:58: error: (Each undeclared identifier is
reported only once
include/asm-generic/tlb.h:58: error: for each function it appears in.)
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: warning: type defaults to =E2=80=98int=E2=
=80=99 in
declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: warning: type defaults to =E2=80=98int=E2=
=80=99 in
declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:58: warning: implicit declaration of function
=E2=80=98__get_cpu_var_locked=E2=80=99
include/asm-generic/tlb.h:58: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h: In function =E2=80=98tlb_finish_mmu=E2=80=99=
:
include/asm-generic/tlb.h:96: error: =E2=80=98mmu_gathers=E2=80=99 unde=
clared (first use
in this function)
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:96: warning: type defaults to =E2=80=98int=E2=
=80=99 in
declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
include/asm-generic/tlb.h:96: warning: type defaults to =E2=80=98int=E2=
=80=99 in
declaration of =E2=80=98type name=E2=80=99
include/asm-generic/tlb.h:96: error: invalid lvalue in unary =E2=80=98&=
=E2=80=99
arch/i386/mm/init.c: At top level:
arch/i386/mm/init.c:50: error: expected declaration specifiers or =E2=80=
=98...=E2=80=99
before =E2=80=98mmu_gathers=E2=80=99
arch/i386/mm/init.c:50: warning: data definition has no type or storage
class
arch/i386/mm/init.c:50: warning: type defaults to =E2=80=98int=E2=80=99=
 in declaration
of =E2=80=98DEFINE_PER_CPU_LOCKED=E2=80=99
