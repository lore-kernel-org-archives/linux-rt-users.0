From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: iMX6 compilation fails with RT patch
Date: Thu, 25 Apr 2013 18:04:23 +0200
Message-ID: <20130425160423.GD5561@linutronix.de>
References: <CANRA68LNCUUJGoYtntem-D8R3abcM-RmFRHjz+e002DtXVM4qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Arpit Goel <arpitgoel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44958 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049Ab3DYQEY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 12:04:24 -0400
Content-Disposition: inline
In-Reply-To: <CANRA68LNCUUJGoYtntem-D8R3abcM-RmFRHjz+e002DtXVM4qA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Arpit Goel | 2013-04-03 11:36:10 [+0530]:

>Hi,
Hi,

>Compilation for ARM architecture fails for iMX6 using
>imx_v6_v7_defconfig fails after following configuration flags are
>enabled.
>
>CONFIG_PREEMPT_RT_BASE
builds

>CONFIG_PREEMPT_RT_FULL
does not

>Compilation Error:
>
>arch/arm/mach-imx/clk.c:3:1: error: expected '=', ',', ';', 'asm' or
>'__attribute__' before '__cacheline_aligned_in_smp'

I think to add

diff --git a/include/linux/spinlock_types_rt.h b/include/linux/spinlock_types_rt.h
index 1fe8fc0..9fd4319 100644
--- a/include/linux/spinlock_types_rt.h
+++ b/include/linux/spinlock_types_rt.h
@@ -5,6 +5,8 @@
 #error "Do not include directly. Include spinlock_types.h instead"
 #endif
 
+#include <linux/cache.h>
+
 /*
  * PREEMPT_RT: spinlocks - an RT mutex plus lock-break field:
  */


does it boot with this change?

>Regards
>Arpit Goel

Sebastian
