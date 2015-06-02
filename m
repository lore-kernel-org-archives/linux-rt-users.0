From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] ARM AT91 Use IRQF_TIMER flag to prevent early boot crash
Date: Tue, 02 Jun 2015 15:29:40 +0200
Message-ID: <20150602133341.666241244@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:54796 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759158AbbFBNfF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Jun 2015 09:35:05 -0400
Content-Disposition: inline; filename=drivers-clk-at91-set-IRQF_TIMER-flags.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When threaded interrupts are configured, they may not be
requested before the khtread daemon is running. The system
crashes at an early boot stage, otherwise:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT THUMB2
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.13-rt10 #15
task: c06a92f0 ti: c069e000 task.ti: c069e000
PC is at wake_up_process+0xc/0x3c
LR is at kthread_create_on_node+0x7f/0xf4
pc : [<c002fe60>]    lr : [<c002b037>]    psr: 600001f3
sp : c069fe90  ip : c002fe5f  fp : 00100100
r10: 00000015  r9 : c003e339  r8 : ce802f40
r7 : c069fe90  r6 : c069fea4  r5 : c06b0200  r4 : 00000000
r3 : c07553e4  r2 : 00000000  r1 : c06a92f0  r0 : 00000000
Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA Thumb  Segment kernel
Control: 50c53c7d  Table: 20004059  DAC: 00000015
Process swapper (pid: 0, stack limit = 0xc069e238)
Stack: (0xc069fe90 to 0xc06a0000)
fe80:                                     c07553e4 ce802f80 00000000 c002b037
fea0: c069fea8 00000000 c069fea8 c069fea8 ce8060c0 ce8060c0 0a820000 ce802f40
fec0: 00000015 00000000 c003e71f c0567f28 00000015 c05c14e4 ce8060c0 ce802f40
fee0: ce8060c0 00000004 c02efab5 ce802f00 00000000 c003eae7 cede4768 00000015
ff00: ce802400 ce802f00 cede4980 c07eb228 ce802408 c066a6fb c05c14e4 ce802f00
ff20: ce802408 cede4980 cede42b4 cede4980 c0476b24 c069ff28 c0476601 00000001
ff40: cede4768 cede396c 00000010 c0476634 ce802400 c066926b c05c1320 ce802400
ff60: 00000001 ce802440 cede396c ce802480 00000000 c073ac68 00000001 c0669003
ff80: 00200200 c073ac30 00000000 00000000 00000000 00000000 c0754700 c06a6000
ffa0: ffffffff c0754700 c067cac0 cefffbc0 00000000 c06482a7 00000000 c06458f1
ffc0: ffffffff ffffffff c064557d 00000000 00000000 c067cac0 c07548d4 c06a6074
ffe0: c067cabc c06aa630 20004059 410fc051 00000000 20008079 00000000 00000000
[<c002fe60>] (wake_up_process) from [<c002b037>] (kthread_create_on_node+0x7f/0xf4)
[<c002b037>] (kthread_create_on_node) from [<c003e71f>] (__setup_irq+0x11f/0x408)
[<c003e71f>] (__setup_irq) from [<c003eae7>] (request_threaded_irq+0x8b/0xe4)
[<c003eae7>] (request_threaded_irq) from [<c066a6fb>] (of_at91sam9x5_clk_utmi_setup+0xd3/0x10c)
[<c066a6fb>] (of_at91sam9x5_clk_utmi_setup) from [<c066926b>] (of_at91_pmc_setup+0x10b/0x12c)
[<c066926b>] (of_at91_pmc_setup) from [<c0669003>] (of_clk_init+0xbb/0x11c)
[<c0669003>] (of_clk_init) from [<c06482a7>] (time_init+0x17/0x20)
[<c06482a7>] (time_init) from [<c06458f1>] (start_kernel+0x1dd/0x2e8)
[<c06458f1>] (start_kernel) from [<20008079>] (0x20008079)
Code: b500 f7dd f983 4604 (6803) f013 
---[ end trace 0000000000000001 ]---

Add the IRQF_TIMER flag as recommended by Sebastian Siewior
-> http://www.spinics.net/lists/linux-rt-users/msg13171.html

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 drivers/clk/at91/clk-main.c   |    6 +++---
 drivers/clk/at91/clk-master.c |    2 +-
 drivers/clk/at91/clk-pll.c    |    3 ++-
 drivers/clk/at91/clk-system.c |    2 +-
 drivers/clk/at91/clk-utmi.c   |    2 +-
 drivers/clk/at91/pmc.c        |    3 ++-
 drivers/rtc/rtc-at91rm9200.c  |    2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

Index: linux/drivers/clk/at91/clk-main.c
===================================================================
--- linux.orig/drivers/clk/at91/clk-main.c
+++ linux/drivers/clk/at91/clk-main.c
@@ -170,7 +170,7 @@ at91_clk_register_main_osc(struct at91_p
 	init_waitqueue_head(&osc->wait);
 	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
 	ret = request_irq(osc->irq, clk_main_osc_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
+			  IRQF_TRIGGER_HIGH | IRQF_TIMER, name, osc);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -324,7 +324,7 @@ at91_clk_register_main_rc_osc(struct at9
 	init_waitqueue_head(&osc->wait);
 	irq_set_status_flags(osc->irq, IRQ_NOAUTOEN);
 	ret = request_irq(osc->irq, clk_main_rc_osc_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, osc);
+			  IRQF_TRIGGER_HIGH | IRQF_TIMER, name, osc);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -591,7 +591,7 @@ at91_clk_register_sam9x5_main(struct at9
 	init_waitqueue_head(&clkmain->wait);
 	irq_set_status_flags(clkmain->irq, IRQ_NOAUTOEN);
 	ret = request_irq(clkmain->irq, clk_sam9x5_main_irq_handler,
-			  IRQF_TRIGGER_HIGH, name, clkmain);
+			  IRQF_TRIGGER_HIGH | IRQF_TIMER, name, clkmain);
 	if (ret)
 		return ERR_PTR(ret);
 
Index: linux/drivers/clk/at91/clk-master.c
===================================================================
--- linux.orig/drivers/clk/at91/clk-master.c
+++ linux/drivers/clk/at91/clk-master.c
@@ -164,7 +164,7 @@ at91_clk_register_master(struct at91_pmc
 	init_waitqueue_head(&master->wait);
 	irq_set_status_flags(master->irq, IRQ_NOAUTOEN);
 	ret = request_irq(master->irq, clk_master_irq_handler,
-			  IRQF_TRIGGER_HIGH, "clk-master", master);
+			  IRQF_TRIGGER_HIGH | IRQF_TIMER, "clk-master", master);
 	if (ret)
 		return ERR_PTR(ret);
 
Index: linux/drivers/clk/at91/clk-pll.c
===================================================================
--- linux.orig/drivers/clk/at91/clk-pll.c
+++ linux/drivers/clk/at91/clk-pll.c
@@ -336,7 +336,8 @@ at91_clk_register_pll(struct at91_pmc *p
 	pll->mul = PLL_MUL(tmp, layout);
 	init_waitqueue_head(&pll->wait);
 	irq_set_status_flags(pll->irq, IRQ_NOAUTOEN);
-	ret = request_irq(pll->irq, clk_pll_irq_handler, IRQF_TRIGGER_HIGH,
+	ret = request_irq(pll->irq, clk_pll_irq_handler,
+			  IRQF_TRIGGER_HIGH | IRQF_TIMER,
 			  id ? "clk-pllb" : "clk-plla", pll);
 	if (ret)
 		return ERR_PTR(ret);
Index: linux/drivers/clk/at91/clk-system.c
===================================================================
--- linux.orig/drivers/clk/at91/clk-system.c
+++ linux/drivers/clk/at91/clk-system.c
@@ -129,7 +129,7 @@ at91_clk_register_system(struct at91_pmc
 		init_waitqueue_head(&sys->wait);
 		irq_set_status_flags(sys->irq, IRQ_NOAUTOEN);
 		ret = request_irq(sys->irq, clk_system_irq_handler,
-				IRQF_TRIGGER_HIGH, name, sys);
+				IRQF_TRIGGER_HIGH | IRQF_TIMER, name, sys);
 		if (ret)
 			return ERR_PTR(ret);
 	}
Index: linux/drivers/clk/at91/clk-utmi.c
===================================================================
--- linux.orig/drivers/clk/at91/clk-utmi.c
+++ linux/drivers/clk/at91/clk-utmi.c
@@ -117,7 +117,7 @@ at91_clk_register_utmi(struct at91_pmc *
 	init_waitqueue_head(&utmi->wait);
 	irq_set_status_flags(utmi->irq, IRQ_NOAUTOEN);
 	ret = request_irq(utmi->irq, clk_utmi_irq_handler,
-			  IRQF_TRIGGER_HIGH, "clk-utmi", utmi);
+			  IRQF_TRIGGER_HIGH | IRQF_TIMER, "clk-utmi", utmi);
 	if (ret)
 		return ERR_PTR(ret);
 
Index: linux/drivers/clk/at91/pmc.c
===================================================================
--- linux.orig/drivers/clk/at91/pmc.c
+++ linux/drivers/clk/at91/pmc.c
@@ -242,7 +242,8 @@ static struct at91_pmc *__init at91_pmc_
 
 	pmc_write(pmc, AT91_PMC_IDR, 0xffffffff);
 	if (request_irq(pmc->virq, pmc_irq_handler,
-			IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc))
+			IRQF_SHARED | IRQF_TIMER,
+			"pmc", pmc))
 		goto out_remove_irqdomain;
 
 	return pmc;
Index: linux/drivers/rtc/rtc-at91rm9200.c
===================================================================
--- linux.orig/drivers/rtc/rtc-at91rm9200.c
+++ linux/drivers/rtc/rtc-at91rm9200.c
@@ -416,7 +416,7 @@ static int __init at91_rtc_probe(struct
 					AT91_RTC_CALEV);
 
 	ret = devm_request_irq(&pdev->dev, irq, at91_rtc_interrupt,
-			       IRQF_SHARED | IRQF_COND_SUSPEND,
+			       IRQF_SHARED | IRQF_TIMER,
 			       "at91_rtc", pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ %d already in use.\n", irq);

