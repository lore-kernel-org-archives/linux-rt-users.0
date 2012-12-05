From: Bernd Faust <berndfaust@gmail.com>
Subject: [PATCH] Round the calculated scale factor in set_cyc2ns_scale()
Date: Wed, 5 Dec 2012 15:16:49 +0100
Message-ID: <1354717009-2687-1-git-send-email-berndfaust@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <berndfaust@gmail.com>, <johnstul@us.ibm.com>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

During some experiments with an external clock (in a FPGA), we saw that
the TSC clock drifted approx. 2.5ms per second.

This drift was caused by the current way of calculating the scale.
In our case cpu_khz had a value of 3292725. This resulted in a scale
value of 310. But when doing the calculation by hand it shows that the
actual value is 310.9886188491, so a value of 311 would be more precise.

With this change the value is rounded.

Signed-off-by: Bernd Faust <berndfaust@gmail.com>
---
 arch/x86/kernel/tsc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cfa5d4f..8ed0857 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -617,7 +617,8 @@ static void set_cyc2ns_scale(unsigned long cpu_khz, int cpu)
 	ns_now = __cycles_2_ns(tsc_now);
 
 	if (cpu_khz) {
-		*scale = (NSEC_PER_MSEC << CYC2NS_SCALE_FACTOR)/cpu_khz;
+		*scale = ((NSEC_PER_MSEC << CYC2NS_SCALE_FACTOR) +
+				cpu_khz / 2) / cpu_khz;
 		*offset = ns_now - mult_frac(tsc_now, *scale,
 					     (1UL << CYC2NS_SCALE_FACTOR));
 	}
-- 
1.7.9.5
