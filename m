From: Nathan Sullivan <nathan.sullivan@ni.com>
Subject: __HAVE_ARCH_CMPXCHG on ARM?
Date: Thu, 29 Jan 2015 12:56:18 -0600
Message-ID: <20150129185618.GA31459@nathan3500-linux-VM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: yong.zhang0@gmail.com, will.deacon@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org
To: yong.zhang@windriver.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:43625 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750744AbbA2TLS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2015 14:11:18 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


While investigating a performance issue on RT 3.14, I noticed that
__HAVE_ARCH_CMPXCHG is not defined for ARM.  This causes -rt locks to
always use the slow path and impacts performance.  ARMv6 and above
have a cmpxchg implementation already that will work just fine.

In 2012, Yong Zhang submitted a patch to fix this[1], but it mysteriously
disappeared afterwards.  I did notice that the s-o-b line has a different
email address than the windriver one.  Yong, do you mind re-submitting the
patch with a fixed s-o-b?

Thanks!
   Nathan Sullivan

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/102122.html (duplicated below)

-- 8< --
From: Yong Zhang <yong.zhang at windriver.com>

Both pi_stress and sigwaittest in rt-test show performance gain with
__HAVE_ARCH_CMPXCHG. Testing result on coretile_express_a9x4:

pi_stress -p 99 --duration=300 (on linux-3.4-rc5; bigger is better)
  vanilla:     Total inversion performed: 5493381
  patched:     Total inversion performed: 5621746

sigwaittest -p 99 -l 100000 (on linux-3.4-rc5-rt6; less is better)
  3.4-rc5-rt6: Min   24, Cur   27, Avg   30, Max   98
  patched:     Min   19, Cur   21, Avg   23, Max   96

Signed-off-by: Yong Zhang <yong.zhang0 at gmail.com>
Cc: Russell King <rmk+kernel at arm.linux.org.uk>
Cc: Nicolas Pitre <nico at linaro.org>
Cc: Will Deacon <will.deacon at arm.com>
Cc: Catalin Marinas <catalin.marinas at arm.com>
Cc: Thomas Gleixner <tglx at linutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
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

