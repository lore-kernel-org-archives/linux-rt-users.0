From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH] RFC: Set irq thread to RT priority on creation
Date: Thu, 30 May 2013 14:12:55 +0200
Message-ID: <1369915975-28797-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ivo Sieben <meltedpianoman@gmail.com>
To: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:7763 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753753Ab3E3MNP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 May 2013 08:13:15 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When a threaded irq handler is installed the irq thread is initially created
on normal scheduling priority. Only after the the irq thread is woken up it
sets its priority to RT_FIFO MAX_USER_RT_PRIO/2.

This means that interrupts that occur directly after the irq handler is
installed will be handled on a normal scheduling priority instead of the
realtime priority that you would expect. Fixed this by setting the RT
priority on creation of the irq_thread.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---

RFC:
Whas there a specific reason for the irq_thread to be created on normal
scheduling and only set to RT priority when woken up?
This patch solves an issue for me where a device driver is expected to handle an
interrupt immediatly after irq handlers are installed and interrupts enabled.

(If this does make sense: I guess the sched_setscheduler() call in the irq_thread
function can be removed?)

 kernel/irq/manage.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fa17855..0ffe37b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -950,6 +950,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 */
 	if (new->thread_fn && !nested) {
 		struct task_struct *t;
+		static const struct sched_param param = {
+			.sched_priority = MAX_USER_RT_PRIO/2,
+		};
 
 		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
 				   new->name);
@@ -957,6 +960,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			ret = PTR_ERR(t);
 			goto out_mput;
 		}
+
+		sched_setscheduler(t, SCHED_FIFO, &param);
+
 		/*
 		 * We keep the reference to the task struct even if
 		 * the thread dies to avoid that the interrupt code
-- 
1.7.9.5


