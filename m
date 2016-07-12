From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/20] ARM: at91: pm: move idle functions to pm.c
Date: Tue, 12 Jul 2016 10:24:08 -0400
Message-ID: <20160712142417.749188298@goodmis.org>
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
Content-Disposition: inline; filename=0003-ARM-at91-pm-move-idle-functions-to-pm.c.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Avoid using code from clk/at91 for PM.
This also has the bonus effect of setting arm_pm_idle for sama5 platforms.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/mach-at91/at91rm9200.c |  2 --
 arch/arm/mach-at91/at91sam9.c   |  2 --
 arch/arm/mach-at91/generic.h    |  6 ++----
 arch/arm/mach-at91/pm.c         | 37 ++++++++++++++++++++++++++++++++-----
 arch/arm/mach-at91/sama5.c      |  2 +-
 drivers/clk/at91/pmc.c          | 15 ---------------
 6 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index eaf58f88ef5d..8d3cb458a99c 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -13,7 +13,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
-#include <asm/system_misc.h>
 
 #include "generic.h"
 #include "soc.h"
@@ -34,7 +33,6 @@ static void __init at91rm9200_dt_device_init(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
 
-	arm_pm_idle = at91rm9200_idle;
 	at91rm9200_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index e47a2093a0e7..d2bede665a1b 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -62,8 +62,6 @@ static void __init at91sam9_common_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
-
-	arm_pm_idle = at91sam9_idle;
 }
 
 static void __init at91sam9_dt_device_init(void)
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index b0fa7dc7286d..d224e195706a 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -18,20 +18,18 @@
 extern void __init at91_map_io(void);
 extern void __init at91_alt_map_io(void);
 
-/* idle */
-extern void at91rm9200_idle(void);
-extern void at91sam9_idle(void);
-
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9260_pm_init(void);
 extern void __init at91sam9g45_pm_init(void);
 extern void __init at91sam9x5_pm_init(void);
+extern void __init sama5_pm_init(void);
 #else
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9260_pm_init(void) { }
 static inline void __init at91sam9g45_pm_init(void) { }
 static inline void __init at91sam9x5_pm_init(void) { }
+static inline void __init sama5_pm_init(void) { }
 #endif
 
 #endif /* _AT91_GENERIC_H */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 1aebb2e9b258..3be82cf983dd 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -31,6 +31,7 @@
 #include <asm/mach/irq.h>
 #include <asm/fncpy.h>
 #include <asm/cacheflush.h>
+#include <asm/system_misc.h>
 
 #include "generic.h"
 #include "pm.h"
@@ -349,6 +350,21 @@ static __init void at91_dt_ramc(void)
 	at91_pm_set_standby(standby);
 }
 
+void at91rm9200_idle(void)
+{
+	/*
+	 * Disable the processor clock.  The processor will be automatically
+	 * re-enabled by an interrupt or by a reset.
+	 */
+	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+}
+
+void at91sam9_idle(void)
+{
+	writel(AT91_PMC_PCK, pmc + AT91_PMC_SCDR);
+	cpu_do_idle();
+}
+
 static void __init at91_pm_sram_init(void)
 {
 	struct gen_pool *sram_pool;
@@ -406,7 +422,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ /* sentinel */ },
 };
 
-static void __init at91_pm_init(void)
+static void __init at91_pm_init(void (*pm_idle)(void))
 {
 	struct device_node *pmc_np;
 
@@ -420,6 +436,9 @@ static void __init at91_pm_init(void)
 		return;
 	}
 
+	if (pm_idle)
+		arm_pm_idle = pm_idle;
+
 	at91_pm_sram_init();
 
 	if (at91_suspend_sram_fn)
@@ -440,7 +459,7 @@ void __init at91rm9200_pm_init(void)
 	at91_pm_data.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_MC;
 
-	at91_pm_init();
+	at91_pm_init(at91rm9200_idle);
 }
 
 void __init at91sam9260_pm_init(void)
@@ -448,7 +467,7 @@ void __init at91sam9260_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.memctrl = AT91_MEMCTRL_SDRAMC;
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	at91_pm_init();
+	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9g45_pm_init(void)
@@ -456,7 +475,7 @@ void __init at91sam9g45_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	at91_pm_init();
+	at91_pm_init(at91sam9_idle);
 }
 
 void __init at91sam9x5_pm_init(void)
@@ -464,5 +483,13 @@ void __init at91sam9x5_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	at91_pm_init();
+	at91_pm_init(at91sam9_idle);
+}
+
+void __init sama5_pm_init(void)
+{
+	at91_dt_ramc();
+	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
+	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
+	at91_pm_init(NULL);
 }
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 41d829d8e7d5..3755da6decf5 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -49,7 +49,7 @@ static void __init sama5_dt_device_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
-	at91sam9x5_pm_init();
+	sama5_pm_init();
 }
 
 static const char *sama5_dt_board_compat[] __initconst = {
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 3f27d21fb729..b83480f599ce 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -27,21 +27,6 @@
 void __iomem *at91_pmc_base;
 EXPORT_SYMBOL_GPL(at91_pmc_base);
 
-void at91rm9200_idle(void)
-{
-	/*
-	 * Disable the processor clock.  The processor will be automatically
-	 * re-enabled by an interrupt or by a reset.
-	 */
-	at91_pmc_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-}
-
-void at91sam9_idle(void)
-{
-	at91_pmc_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range)
 {
-- 
2.8.1
