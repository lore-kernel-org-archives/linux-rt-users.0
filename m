From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/20] ARM: at91: pm: find and remap the pmc
Date: Tue, 12 Jul 2016 10:24:07 -0400
Message-ID: <20160712142417.395538934@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-ARM-at91-pm-find-and-remap-the-pmc.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

To avoid relying on at91_pmc_read(), find the pmc node and remap it
locally.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/mach-at91/pm.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 460181caf51e..1aebb2e9b258 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -35,6 +35,8 @@
 #include "generic.h"
 #include "pm.h"
 
+static void __iomem *pmc;
+
 /*
  * FIXME: this is needed to communicate between the pinctrl driver and
  * the PM implementation in the machine. Possibly part of the PM
@@ -85,7 +87,7 @@ static int at91_pm_verify_clocks(void)
 	unsigned long scsr;
 	int i;
 
-	scsr = at91_pmc_read(AT91_PMC_SCSR);
+	scsr = readl(pmc + AT91_PMC_SCSR);
 
 	/* USB must not be using PLLB */
 	if ((scsr & at91_pm_data.uhp_udp_mask) != 0) {
@@ -99,8 +101,7 @@ static int at91_pm_verify_clocks(void)
 
 		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
 			continue;
-
-		css = at91_pmc_read(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		css = readl(pmc + AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
 		if (css != AT91_PMC_CSS_SLOW) {
 			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
 			return 0;
@@ -143,8 +144,8 @@ static void at91_pm_suspend(suspend_state_t state)
 	flush_cache_all();
 	outer_disable();
 
-	at91_suspend_sram_fn(at91_pmc_base, at91_ramc_base[0],
-				at91_ramc_base[1], pm_data);
+	at91_suspend_sram_fn(pmc, at91_ramc_base[0],
+			     at91_ramc_base[1], pm_data);
 
 	outer_resume();
 }
@@ -394,13 +395,33 @@ static void __init at91_pm_sram_init(void)
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 }
 
+static const struct of_device_id atmel_pmc_ids[] __initconst = {
+	{ .compatible = "atmel,at91rm9200-pmc"  },
+	{ .compatible = "atmel,at91sam9260-pmc" },
+	{ .compatible = "atmel,at91sam9g45-pmc" },
+	{ .compatible = "atmel,at91sam9n12-pmc" },
+	{ .compatible = "atmel,at91sam9x5-pmc" },
+	{ .compatible = "atmel,sama5d3-pmc" },
+	{ .compatible = "atmel,sama5d2-pmc" },
+	{ /* sentinel */ },
+};
+
 static void __init at91_pm_init(void)
 {
-	at91_pm_sram_init();
+	struct device_node *pmc_np;
 
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
+	pmc_np = of_find_matching_node(NULL, atmel_pmc_ids);
+	pmc = of_iomap(pmc_np, 0);
+	if (!pmc) {
+		pr_err("AT91: PM not supported, PMC not found\n");
+		return;
+	}
+
+	at91_pm_sram_init();
+
 	if (at91_suspend_sram_fn)
 		suspend_set_ops(&at91_pm_ops);
 	else
-- 
2.8.1
