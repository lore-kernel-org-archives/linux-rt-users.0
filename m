From: Pavel Pisa <ppisa4lists@pikron.com>
Subject: ARM 920T build problems for patch-2.6.19-rt1
Date: Fri, 1 Dec 2006 14:12:56 +0100
Message-ID: <200612011412.57777.ppisa4lists@pikron.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from av4.karneval.cz ([81.27.192.11]:40419 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S936495AbWLANML (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Dec 2006 08:12:11 -0500
To: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Thomas and others,

I have tried to build patch-2.6.19-rt1 patched 2.6.19 kernel
for MX1 (PiMX1). There seems to be some problems.
One is corrected by attached patch, there is another one
I have not solved yet

make ARCH=arm CROSS_COMPILE=arm-linux- -C /usr/src/linux-2.6.19-rt O=/usr/src/l
inux-2.6.19-rt/_build/arm
  CHK     include/linux/version.h
...
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/kernel/built-in.o(.text+0x40c0): In function `do_settimeofday':
/usr/src/linux-2.6.19-rt/include/linux/hrtimer.h:264: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0xa6bc): In function `do_sys_settimeofday':
/usr/src/linux-2.6.19-rt/kernel/time.c:138: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0xa700): In function `do_sys_settimeofday':
/usr/src/linux-2.6.19-rt/include/linux/hrtimer.h:264: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0x1dfec): In function `hrtimer_notify_resume':
/usr/src/linux-2.6.19-rt/include/linux/hrtimer.h:264: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0x1f62c): In function `second_overflow':
/usr/src/linux-2.6.19-rt/include/linux/hrtimer.h:264: undefined reference to `warp_check_clock_was_changed'
kernel/built-in.o(.text+0x1f674):/usr/src/linux-2.6.19-rt/include/linux/hrtimer.h:264: more undefined references to `warp_check_clock_was_changed' follow
kernel/built-in.o(.text+0x2745c): In function `setup_preempt_thresh':
/usr/src/linux-2.6.19-rt/kernel/latency_trace.c:1647: undefined reference to `usecs_to_cycles'

Have you idea where is a problem or should I dig deeper.

There is required next simple change for ARM architectures < 6

-----------------------------------------------------------------------------------
 include/asm-arm/atomic.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rt/include/asm-arm/atomic.h
===================================================================
--- linux-2.6.19-rt.orig/include/asm-arm/atomic.h
+++ linux-2.6.19-rt/include/asm-arm/atomic.h
@@ -188,10 +188,10 @@ static inline unsigned long __cmpxchg(vo
 	volatile unsigned long *p = ptr;
 
 	if (size == 4) {
-		local_irq_save(flags);
+		raw_local_irq_save(flags);
 		if ((prev = *p) == old)
 			*p = new;
-		local_irq_restore(flags);
+		raw_local_irq_restore(flags);
 		return(prev);
 	} else
 		return wrong_size_cmpxchg(ptr);
-----------------------------------------------------------------------------------

Best wishes

                Pavel Pisa
        e-mail: pisa@cmp.felk.cvut.cz
        www:    http://cmp.felk.cvut.cz/~pisa
        work:   http://www.pikron.com


PS: Please CC to me, I am not on the list

PS2: Thomas, have you already found time to look at my e-mails/questions/patches
     about SC520 and i.MX HRT and Profibus.
     ( The initial version of Tran's Profibus work can be loaded
     at http://sourceforge.net/projects/pbmaster )
