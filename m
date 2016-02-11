From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH -rt 1/2] genirq: update irq_set_irqchip_state documentation
Date: Thu, 11 Feb 2016 11:54:00 -0600
Message-ID: <d08185b69f64d90e4dc458eb5051b3186c7d25a8.1455213062.git.joshc@ni.com>
References: <20160211161025.GB28994@linutronix.de>
Cc: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoffer Dall <christoffer.dall@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:56994 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751478AbcBKRyM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 12:54:12 -0500
In-Reply-To: <20160211161025.GB28994@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On -rt kernels, the use of migrate_disable()/migrate_enable() is
sufficient to guarantee a task isn't moved to another CPU.  Update the
irq_set_irqchip_state() documentation to reflect this.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ba2a42a..8e89554 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2060,7 +2060,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  *	This call sets the internal irqchip state of an interrupt,
  *	depending on the value of @which.
  *
- *	This function should be called with preemption disabled if the
+ *	This function should be called with migration disabled if the
  *	interrupt controller has per-cpu registers.
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
-- 
2.7.0

