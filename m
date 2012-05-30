From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [RFC PATCH] ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6 and later
Date: Wed, 30 May 2012 15:51:26 +0800
Message-ID: <1338364287-11614-1-git-send-email-yong.zhang0@gmail.com>
Cc: linux-rt-users@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Nicolas Pitre <nico@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53412 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2E3Hvl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 May 2012 03:51:41 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Yong Zhang <yong.zhang@windriver.com>

Both pi_stress and sigwaittest in rt-test show performance gain with
__HAVE_ARCH_CMPXCHG. Testing result on coretile_express_a9x4:

pi_stress -p 99 --duration=300 (on linux-3.4-rc5; bigger is better)
  vanilla:     Total inversion performed: 5493381
  patched:     Total inversion performed: 5621746

sigwaittest -p 99 -l 100000 (on linux-3.4-rc5-rt6; less is better)
  3.4-rc5-rt6: Min   24, Cur   27, Avg   30, Max   98
  patched:     Min   19, Cur   21, Avg   23, Max   96

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/cmpxchg.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 7eb18c1..a91b44e 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
 #else	/* min ARCH >= ARMv6 */
 
+#define __HAVE_ARCH_CMPXCHG 1
+
 extern void __bad_cmpxchg(volatile void *ptr, int size);
 
 /*
-- 
1.7.5.4

