From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/20] ARM: at91: pm: simply call at91_pm_init
Date: Tue, 12 Jul 2016 10:24:06 -0400
Message-ID: <20160712142417.221251950@goodmis.org>
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
Content-Disposition: inline; filename=0001-ARM-at91-pm-simply-call-at91_pm_init.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

at91_pm_init() doesn't return a value, as is the case for its callers,
simply call it instead of returning its non-existent return value.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/mach-at91/pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5062699cbb12..460181caf51e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -427,7 +427,7 @@ void __init at91sam9260_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.memctrl = AT91_MEMCTRL_SDRAMC;
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	return at91_pm_init();
+	at91_pm_init();
 }
 
 void __init at91sam9g45_pm_init(void)
@@ -435,7 +435,7 @@ void __init at91sam9g45_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	return at91_pm_init();
+	at91_pm_init();
 }
 
 void __init at91sam9x5_pm_init(void)
@@ -443,5 +443,5 @@ void __init at91sam9x5_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	return at91_pm_init();
+	at91_pm_init();
 }
-- 
2.8.1
