From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/11] ARM: imx: always use TWD on IMX6Q
Date: Tue, 12 Jul 2016 12:49:54 -0400
Message-ID: <20160712165020.420235092@goodmis.org>
References: <20160712164950.490572026@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-ARM-imx-always-use-TWD-on-IMX6Q.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.61-rt82-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

There is no reason to limit the TWD to be used on SMP kernels only if the
hardware has it available.
On Wandboard i.MX6SOLO, running PREEMPT-RT and cyclictest I see as max
immediately after start in idle:
UP : ~90us
SMP: ~50us
UP + TWD: ~20us.
Based on this numbers I prefer the TWD over the slightly slower MXC
timer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a8af6922a8..79671485618a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -794,7 +794,7 @@ config SOC_IMX6Q
 	select COMMON_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_TWD
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
-- 
2.8.1
