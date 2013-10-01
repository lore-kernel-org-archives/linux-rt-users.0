From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] Revert "powerpc: 52xx: provide a default in mpc52xx_irqhost_map()"
Date: Tue,  1 Oct 2013 09:26:06 +0200
Message-ID: <1380612366-13504-1-git-send-email-wsa@the-dreams.de>
Cc: linux-rt-users@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58852 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab3JAH0U (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Oct 2013 03:26:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This reverts commit 6391f697d4892a6f233501beea553e13f7745a23. The
compiler warning it wants to fix does not appear with my gcc 4.6.2. IMO
we don't need superfluous (and here even misleading) code to make old
compilers happy. Fixing the printout was bogus, too. We want to know
WHICH critical irq failed, not which level it had.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
---

Have I been on CC when the original patch was sent?

 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index b69221b..b89ef65 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
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

