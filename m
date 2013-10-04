From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] Kind of revert "powerpc: 52xx: provide a default in mpc52xx_irqhost_map()"
Date: Fri,  4 Oct 2013 17:37:09 +0200
Message-ID: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
Cc: linux-rt-users@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57710 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab3JDPhP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 11:37:15 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This more or less reverts commit 6391f697d4892a6f233501beea553e13f7745a23.
Instead of adding an unneeded 'default', mark the variable to prevent
the false positive 'uninitialized var'. The other change (fixing the
printout) needs revert, too. We want to know WHICH critical irq failed,
not which level it had.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index b69221b..2898b73 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -340,7 +340,7 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int virq,
 {
 	int l1irq;
 	int l2irq;
-	struct irq_chip *irqchip;
+	struct irq_chip *uninitialized_var(irqchip);
 	void *hndlr;
 	int type;
 	u32 reg;
@@ -373,9 +373,8 @@ static int mpc52xx_irqhost_map(struct irq_domain *h, unsigned int virq,
 	case MPC52xx_IRQ_L1_PERP: irqchip = &mpc52xx_periph_irqchip; break;
 	case MPC52xx_IRQ_L1_SDMA: irqchip = &mpc52xx_sdma_irqchip; break;
 	case MPC52xx_IRQ_L1_CRIT:
-	default:
 		pr_warn("%s: Critical IRQ #%d is unsupported! Nopping it.\n",
-			__func__, l1irq);
+			__func__, l2irq);
 		irq_set_chip(virq, &no_irq_chip);
 		return 0;
 	}
-- 
1.7.10.4

