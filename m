From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v4.1.10-rt10][PATCH 1/2] genirq: introduce new generic_handle_irq_rt_wa() api
Date: Mon, 2 Nov 2015 21:30:25 +0200
Message-ID: <1446492626-24396-2-git-send-email-grygorii.strashko@ti.com>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44228 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbbKBTam (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Nov 2015 14:30:42 -0500
In-Reply-To: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Now in kernel below code pattern is used by many drivers:
static irqreturn_t driver_xx_hw_irq_handler(int irq, void *arg)
{
	<read IRQ status register>
  	<perform HW specific operations>

	for (<each set bit in IRQ status register>) {
		<get Linux IRQ number>
		generic_handle_irq(<Linux IRQ number>);
		|- handle_simple_irq()
		|-or- handle_level_irq()
		|-or- handle_edge_irq()
		   |-handle_irq_event()
		     |-handle_irq_event_percpu()
===
"WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
 irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts"
===
	}
}

On -RT above code will generate warnings, because driver_xx_hw_irq_handler()
will be forced threaded (by default) and, as result, generic_handle_irq()
will be called with IRQs enabled. To W/A this issue generic_handle_irq() can
be surrounded by raw_spin_lock_irqsave/irqrestore(wa_lock).

Instead of spreading this W/A directly in many drivers this patch
introduces -RT specific version of generic_handle_irq() API -
generic_handle_irq_rt_wa(). This new generic_handle_irq_rt_wa() just calls
generic_handle_irq() surrounded by raw_spin_lock_irqsave/irqrestore().
If -RT is disabled It will fallback to generic_handle_irq().

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/irqdesc.h |  5 +++++
 kernel/irq/irqdesc.c    | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 9d97cd5..beea9a5 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -131,6 +131,11 @@ static inline void generic_handle_irq_desc(unsigned int irq, struct irq_desc *de
 }
 
 int generic_handle_irq(unsigned int irq);
+#ifdef CONFIG_PREEMPT_RT_FULL
+int generic_handle_irq_rt_wa(unsigned int irq);
+#else
+#define generic_handle_irq_rt_wa generic_handle_irq
+#endif
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /*
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 99793b9..b77e01b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -353,6 +353,25 @@ int generic_handle_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+int generic_handle_irq_rt_wa(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	DEFINE_RAW_SPINLOCK(wa_lock);
+	unsigned long wa_lock_flags;
+
+	if (!desc)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&wa_lock, wa_lock_flags);
+	generic_handle_irq_desc(irq, desc);
+	raw_spin_unlock_irqrestore(&wa_lock, wa_lock_flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(generic_handle_irq_rt_wa);
+#endif
+
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
  * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain
-- 
2.6.2

