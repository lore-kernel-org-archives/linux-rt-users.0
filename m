From: GeunSik Lim <leemgs1@gmail.com>
Subject: [PATCH]cyclictest: CFLAGS to support static compiliation with ARM
	Crosscompiler
Date: Thu, 21 Jan 2010 09:09:30 +0900
Message-ID: <1264032570.2121.4.camel@centos51>
References: <1246593855.2153.55.camel@centos51>
Reply-To: leemgs1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47188 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab0AUAJj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2010 19:09:39 -0500
Received: by pwj9 with SMTP id 9so3543573pwj.21
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2010 16:09:38 -0800 (PST)
In-Reply-To: <1246593855.2153.55.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear williams,

This patch is for support static building using cross-compiler for
embedded targetboard like ARM. 
When we use -static option for static binary on embedded board after
patch.
I tested various toolchain.(e.g: codesourcery toolchain , my self
toolchain , cross-tool project's toolchain)
Ref) Don't forget "-static" configuration(CFLAGS  += -O2 -static) in
Makefile When you need static linking.  

Before patch) 
/usr/local/arm_v7_vfp_le/bin/../target/usr/lib/librt.a(timer_create.o):
In function `timer_create':
/home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/timer_create.c:174: undefined reference to `pthread_attr_init'
/home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/timer_create.c:192: undefined reference to `pthread_attr_setdetachstate'
/usr/local/arm_v7_vfp_le/bin/../target/usr/lib/librt.a(timer_routines.o): In function `__start_helper_thread':
/home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/timer_routines.c:144: undefined reference to `pthread_attr_init'
/home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/timer_routines.c:145: undefined reference to `pthread_attr_setstacksize'
/home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/timer_routines.c:171: undefined reference to `pthread_attr_destroy'
/home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/timer_routines.c:175: undefined reference to `pthread_atfork'
/usr/local/arm_v7_vfp_le/bin/../target/usr/lib/librt.a(timer_routines.o): In function `timer_helper_thread':
/home/build/BUILD/glibc-2.5.90/rt/../nptl/sysdeps/unix/sysv/linux/timer_routines.c:114: undefined reference to `pthread_exit'
collect2: ld returned 1 exit status
make: *** [cyclictest] Error 1


After patch) Success...
Fedora11$> file ./cyclictest
./cyclictest: ELF 32-bit LSB executable, ARM, version 1 (SYSV),
statically linked, for GNU/Linux 2.6.18, not stripped

====================================================================

>From 45e4dbeb8e7723cefa9117736b0ece5ea188ce6a Mon Sep 17 00:00:00 2001
From: Geunsik Lim <geunsik.lim@samsung.com>
Date: Thu, 21 Jan 2010 09:00:24 +0900
Subject: [PATCH 2/2] bugfix: Support static linking(-static) with
Crosscompiler on ARM targetboard.

This patch is for support static building using cross-compiler for
embedded targetboard like ARM.
When we use -static option for static binary on embedded board after
patch.
I tested various toolchain.(e.g: codesourcery toolchain , my self
toolchain , cross-tool project's toolchain)
Ref) Don't forget "-static" configuration(CFLAGS  += -O2 -static) in
Makefile When you need static linking.

Signed-off-by: Geunsik Lim <geunsik.lim@samsung.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e14d957..65f506a 100644
--- a/Makefile
+++ b/Makefile
@@ -3,7 +3,7 @@ VERSION_STRING = 0.61
 TARGETS	= cyclictest signaltest pi_stress \
 	  hwlatdetect rt-migrate-test ptsematest sigwaittest svsematest \
 	  sendme pip
-LIBS 	= -lpthread -lrt
+LIBS 	= -lrt -lpthread
 EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
 prefix  ?= /usr/local
-- 
1.6.2.5


-- 
-----------------------------------------------
To unsubscribe from this list: send the line "unsubscribe linux-***" 
in the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

GeunSik Lim ( Samsung Electronics )
e-Mail  :1) geunsik.lim@samsung.com
         2) leemgs@gmail.com , leemgs1@gmail.com
HomePage: http://blog.naver.com/invain/
-----------------------------------------------

