From: Iratxo Pichel Ortiz <ipichel@albentia.com>
Subject: Compilation fails
Date: Wed, 20 Jun 2012 19:57:50 +0200
Message-ID: <4FE20F1E.3010306@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Garcia <dgarcia@albentia.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from llsf238-a04.servidoresdns.net ([82.223.190.49]:36095 "EHLO
	llsf238-a04.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754153Ab2FTSFp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jun 2012 14:05:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all!

We have detected a compilation error in the following scenario:

1. kernel linux-3.4.3
2. patch-3.4.3-rt11.patch
3. make mpc85xx_defconfig
4. Select full preemption.

After make you get:

$ make
scripts/kconfig/conf --silentoldconfig Kconfig
#
# configuration written to .config
#
   CHK     include/linux/version.h
   CHK     include/generated/utsrelease.h
   CC      arch/powerpc/kernel/asm-offsets.s
In file included from include/linux/spinlock.h:273:0,
                  from include/linux/seqlock.h:29,
                  from include/linux/time.h:8,
                  from include/linux/timex.h:56,
                  from include/linux/sched.h:57,
                  from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/spinlock_rt.h: In function 'assert_spin_locked':
include/linux/spinlock_rt.h:161:2: error: implicit declaration of=20
function 'BUG_ON' [-Werror=3Dimplicit-function-declaration]
cc1: some warnings being treated as errors

A quick and dirt solution is to add the line:

#include <asm/bug.h>

just before the definition of the function:

static inline void assert_spin_locked(spinlock_t *lock)

in the file: include/linux/spinlock_rt.h

I assume that there is a missing include somewhere in the include path,=
=20
but I cannot find it so far. I hope this information helps.

Regards,

     Iratxo.

--=20
Iratxo Pichel Ortiz
CTO

Albentia Systems S.A.
http://www.albentia.com

Mobile: +34 658588745
C\Margarita Salas 22
Parque Tecnol=F3gico de Legan=E9s
Legan=E9s (28918)
Madrid
Spain

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
