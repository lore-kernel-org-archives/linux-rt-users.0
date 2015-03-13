From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 21/27] ARM: cmpxchg: define __HAVE_ARCH_CMPXCHG for armv6 and later
Date: Fri, 13 Mar 2015 11:18:02 -0400
Message-ID: <20150313151758.565724156@goodmis.org>
References: <20150313151741.132137234@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0021-ARM-cmpxchg-define-__HAVE_ARCH_CMPXCHG-for-armv6-and.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.4.106-rt132-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

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
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/include/asm/cmpxchg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index d41d7cbf0ada..249dfc34a36f 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
 #else	/* min ARCH >= ARMv6 */
 
+#define __HAVE_ARCH_CMPXCHG 1
+
 extern void __bad_cmpxchg(volatile void *ptr, int size);
 
 /*
-- 
2.1.4
