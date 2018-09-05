From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 10/22] irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
Date: Wed, 05 Sep 2018 08:28:04 -0400
Message-ID: <20180905122835.952828400@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c7a3334c762a9b1dd2e39cb2ded00ce66e8a06d1 ]

The its_lock lock is held while a new device is added to the list and
during setup while the CPU is booted. Even on -RT the CPU-bootup is
performed with disabled interrupts.

Make its_lock a raw_spin_lock_t.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2ea39a83737f..e8217ebe8c1e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -148,7 +148,7 @@ static struct {
 } vpe_proxy;
 
 static LIST_HEAD(its_nodes);
-static DEFINE_SPINLOCK(its_lock);
+static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
 
@@ -1850,7 +1850,7 @@ static void its_cpu_init_collection(void)
 	struct its_node *its;
 	int cpu;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	cpu = smp_processor_id();
 
 	list_for_each_entry(its, &its_nodes, entry) {
@@ -1892,7 +1892,7 @@ static void its_cpu_init_collection(void)
 		its_send_invall(its, &its->collections[cpu]);
 	}
 
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
 
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
@@ -3041,9 +3041,9 @@ static int __init its_probe_one(struct resource *res,
 	if (err)
 		goto out_free_tables;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 
 	return 0;
 
-- 
2.18.0
