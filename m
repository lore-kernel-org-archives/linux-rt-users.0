From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/4] mips-remove-smp-reserve-lock.patch
Date: Thu, 07 Jun 2012 11:51:51 -0400
Message-ID: <20120607155221.836885041@goodmis.org>
References: <20120607155148.698959275@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-mips-remove-smp-reserve-lock.patch.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Instead of making the lock raw, remove it as it protects nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/mips/cavium-octeon/smp.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index efcfff4..86fce15 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -257,8 +257,6 @@ DEFINE_PER_CPU(int, cpu_state);
 
 extern void fixup_irqs(void);
 
-static DEFINE_SPINLOCK(smp_reserve_lock);
-
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -266,8 +264,6 @@ static int octeon_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	spin_lock(&smp_reserve_lock);
-
 	cpu_clear(cpu, cpu_online_map);
 	cpu_clear(cpu, cpu_callin_map);
 	local_irq_disable();
@@ -277,8 +273,6 @@ static int octeon_cpu_disable(void)
 	flush_cache_all();
 	local_flush_tlb_all();
 
-	spin_unlock(&smp_reserve_lock);
-
 	return 0;
 }
 
-- 
1.7.10
