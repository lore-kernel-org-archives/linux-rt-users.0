From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 11/20] ARM: imx: always use TWD on IMX6Q
Date: Tue, 12 Jul 2016 10:24:16 -0400
Message-ID: <20160712142419.367116752@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
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
Content-Disposition: inline; filename=0011-ARM-imx-always-use-TWD-on-IMX6Q.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
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
index 3a3d3e9d7bfd..92c0cf1276fe 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -558,7 +558,7 @@ config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
 	select ARM_ERRATA_764369 if SMP
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_TWD
 	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6Q
 	select SOC_IMX6
-- 
2.8.1
