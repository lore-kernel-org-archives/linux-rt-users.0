From: leroy christophe <christophe.leroy@c-s.fr>
Subject: Re: Compilation fails
Date: Thu, 21 Jun 2012 08:25:19 +0200
Message-ID: <4FE2BE4F.6080000@c-s.fr>
References: <4FE20F1E.3010306@albentia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, David Garcia <dgarcia@albentia.com>
To: Iratxo Pichel Ortiz <ipichel@albentia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:35220 "EHLO mailhub1.si.c-s.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378Ab2FUGZV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jun 2012 02:25:21 -0400
In-Reply-To: <4FE20F1E.3010306@albentia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I had the same problem with
* Kernel 3.4.2
* Patch 3.4.2 rt 10
* make for a mpc8xx custom board

As far as I remember I added an #include to <asm/bug.h> in=20
include/linux/spinlock.h and it worked

Regards
Christophe


Le 20/06/2012 19:57, Iratxo Pichel Ortiz a =E9crit :
> Hi all!
>
> We have detected a compilation error in the following scenario:
>
> 1. kernel linux-3.4.3
> 2. patch-3.4.3-rt11.patch
> 3. make mpc85xx_defconfig
> 4. Select full preemption.
>
> After make you get:
>
> $ make
> scripts/kconfig/conf --silentoldconfig Kconfig
> #
> # configuration written to .config
> #
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CC      arch/powerpc/kernel/asm-offsets.s
> In file included from include/linux/spinlock.h:273:0,
>                  from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/timex.h:56,
>                  from include/linux/sched.h:57,
>                  from arch/powerpc/kernel/asm-offsets.c:17:
> include/linux/spinlock_rt.h: In function 'assert_spin_locked':
> include/linux/spinlock_rt.h:161:2: error: implicit declaration of=20
> function 'BUG_ON' [-Werror=3Dimplicit-function-declaration]
> cc1: some warnings being treated as errors
>
> A quick and dirt solution is to add the line:
>
> #include <asm/bug.h>
>
> just before the definition of the function:
>
> static inline void assert_spin_locked(spinlock_t *lock)
>
> in the file: include/linux/spinlock_rt.h
>
> I assume that there is a missing include somewhere in the include=20
> path, but I cannot find it so far. I hope this information helps.
>
> Regards,
>
>     Iratxo.
>


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
