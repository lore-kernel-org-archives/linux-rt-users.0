From: David L <idht4n@gmail.com>
Subject: 2.6.29-rc4-rt2 ppc compile error
Date: Fri, 20 Feb 2009 08:55:48 -0800
Message-ID: <b79371120902200855u40900fe4r954ff26fed0f328c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:15755 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbZBTQzu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2009 11:55:50 -0500
Received: by yw-out-2324.google.com with SMTP id 5so382678ywh.1
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Feb 2009 08:55:49 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I tried the patch-2.6.29-rc4-rt2 real-time patch yesterday and it failed
to compile for the power pc.  Here is what I tried and the error I got.
I can send the config file I used if requested.

cd /tmp/
tar -xvjf /tmp/dlsvn/trunk/linux-2.6.29-rc4.tar.bz2
cd /tmp/linux-2.6.29-rc4
patch -p1 < ~/Download/patch-2.6.29-rc4-rt2
cp /tmp/dlsvn/trunk/linux-2.6.29-rc4/.config .
setenv CROSS_COMPILE powerpc-linux-gnu-
setenv ARCH powerpc
setenv PATH /opt/freescale/usr/local/gcc-4.3.50-eglibc-2.8.50/powerpc-linux-gnu/bin:$PATH
make
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  CC      arch/powerpc/kernel/asm-offsets.s
In file included from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rwsem.h:112:1: warning: "DECLARE_RWSEM" redefined
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/tmp/dlsvn/trunk/ag/sw/platform/timaru/build/linux-2.6.29-rc4/arch/powerpc/include/asm/rwsem.h:50:1:
warning: this is the location of the previous definition
In file included from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rwsem.h:119:1: warning: "init_rwsem" redefined
In file included from include/linux/rwsem.h:37,
                 from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
/tmp/dlsvn/trunk/ag/sw/platform/timaru/build/linux-2.6.29-rc4/arch/powerpc/include/asm/rwsem.h:61:1:
warning: this is the location of the previous definition
In file included from include/linux/mm_types.h:11,
                 from include/linux/sched.h:61,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/rwsem.h:149: error: redefinition of 'rwsem_is_locked'
/tmp/dlsvn/trunk/ag/sw/platform/timaru/build/linux-2.6.29-rc4/arch/powerpc/include/asm/rwsem.h:168:
error: previous definition of 'rwsem_is_locked' was here
include/linux/rwsem.h: In function 'rwsem_is_locked':
include/linux/rwsem.h:151: error: implicit declaration of function
'compat_rwsem_is_locked'
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2


Thanks,

                              David
