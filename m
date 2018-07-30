From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] rcu: mark rcu_iw_handler() as IRQ_WORK_HARD_IRQ
Date: Mon, 30 Jul 2018 21:28:25 +0200
Message-ID: <20180730192824.viqzgvdnwz6pfe2m@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

RCU's rcu_iw irq-work (rcu_iw_handler()) acquires the raw spinlock
rnp->lock without disabling interrupts. The lock is held normally with
disabled interrupts for a short time.
Mark irq-work as IRQ_WORK_HARD_IRQ so it is invoked in IRQ context like
on !RT.

Reported-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5a9c5abb17da..4fb983f4b9fd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1294,6 +1294,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gpnum != rnp->gpnum &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
+			rdp->rcu_iw.flags = IRQ_WORK_HARD_IRQ;
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gpnum = rnp->gpnum;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
-- 
2.18.0
