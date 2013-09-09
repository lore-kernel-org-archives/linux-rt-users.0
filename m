From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/16] genirq: Set irq thread to RT priority on creation
Date: Mon, 09 Sep 2013 10:35:20 -0400
Message-ID: <20130909143534.655639785@goodmis.org>
References: <20130909143517.641735717@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Ivo Sieben <meltedpianoman@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-genirq-Set-irq-thread-to-RT-priority-on-creation.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Ivo Sieben <meltedpianoman@gmail.com>

When a threaded irq handler is installed the irq thread is initially
created on normal scheduling priority. Only after the irq thread is
woken up it sets its priority to RT_FIFO MAX_USER_RT_PRIO/2 itself.

This means that interrupts that occur directly after the irq handler
is installed will be handled on a normal scheduling priority instead
of the realtime priority that one would expect.

Fix this by setting the RT priority on creation of the irq_thread.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
Cc: Sebastian Andrzej Siewior  <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/1370254322-17240-1-git-send-email-meltedpianoman@gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq/manage.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d750268..9d702cf 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -780,9 +780,6 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
  */
 static int irq_thread(void *data)
 {
-	static const struct sched_param param = {
-		.sched_priority = MAX_USER_RT_PRIO/2,
-	};
 	struct irqaction *action = data;
 	struct irq_desc *desc = irq_to_desc(action->irq);
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
@@ -795,7 +792,6 @@ static int irq_thread(void *data)
 	else
 		handler_fn = irq_thread_fn;
 
-	sched_setscheduler(current, SCHED_FIFO, &param);
 	current->irqaction = action;
 
 	while (!irq_wait_for_interrupt(action)) {
@@ -932,11 +928,17 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 */
 	if (new->thread_fn && !nested) {
 		struct task_struct *t;
+		static const struct sched_param param = {
+			.sched_priority = MAX_USER_RT_PRIO/2,
+		};
 
 		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
 				   new->name);
 		if (IS_ERR(t))
 			return PTR_ERR(t);
+
+		sched_setscheduler(t, SCHED_FIFO, &param);
+
 		/*
 		 * We keep the reference to the task struct even if
 		 * the thread dies to avoid that the interrupt code
-- 
1.7.10.4
