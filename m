From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.14.66-rt TEST PATCH 1/3] irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
Date: Fri, 31 Aug 2018 14:20:07 -0500
Message-ID: <20180831192009.17257-1-grygorii.strashko@ti.com>
References: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sekhar Nori <nsekhar@ti.com>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
To: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c564443..0b691d1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -154,7 +154,7 @@ static struct {
 } vpe_proxy;
 
 static LIST_HEAD(its_nodes);
-static DEFINE_SPINLOCK(its_lock);
+static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
 
@@ -1854,7 +1854,7 @@ static void its_cpu_init_collection(void)
 	struct its_node *its;
 	int cpu;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	cpu = smp_processor_id();
 
 	list_for_each_entry(its, &its_nodes, entry) {
@@ -1896,7 +1896,7 @@ static void its_cpu_init_collection(void)
 		its_send_invall(its, &its->collections[cpu]);
 	}
 
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
 
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
@@ -3109,9 +3109,9 @@ static int __init its_probe_one(struct resource *res,
 	if (err)
 		goto out_free_tables;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 
 	return 0;
 
-- 
2.10.5
