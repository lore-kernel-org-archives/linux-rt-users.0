From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH-v2] Set irq thread to RT priority on creation
Date: Mon, 3 Jun 2013 12:12:02 +0200
Message-ID: <1370254322-17240-1-git-send-email-meltedpianoman@gmail.com>
References: <alpine.LFD.2.02.1305302147290.2905@ionos>
Mime-Version: 1.0
Content-Type: text/plain
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ivo Sieben <meltedpianoman@gmail.com>
To: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:50313
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728Ab3FCKML (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Jun 2013 06:12:11 -0400
In-Reply-To: <alpine.LFD.2.02.1305302147290.2905@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When a threaded irq handler is installed the irq thread is initially created
on normal scheduling priority. Only after the the irq thread is woken up it
immediately sets its priority to RT_FIFO MAX_USER_RT_PRIO/2.

This means that interrupts that occur directly after the irq handler is
installed will be handled on a normal scheduling priority instead of the
realtime priority that you would expect. Fixed this by setting the RT
priority on creation of the irq_thread.

This solves the following issue with a UART device driver:
On start of the application there is already data present in the uart RX
fifo buffer. On opening the uart device the hard & threaded interrupt
handlers are installed and the interrupts are enabled. Immediately a hard
irq occurs because there is still data in the RX fifo. Because the threaded
irq handler is still on normal scheduling, my application is not immediatly
interrupted by the threaded handler and continues to run: it tries to flush
the uart input buffer and writes data to the uart device. After this the
threaded handler finally gets scheduled in and fills the buffer with the
"old" received data. When my application reads data from the uart port it
receives the "old" data and gives an error.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---

v2:
 * Removed the sched_setscheduler() call in irq_thread() function
 * Updated commit log why this solves an issue for me with a UART driver

 kernel/irq/manage.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fa17855..e16caa8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -840,9 +840,6 @@ static void irq_thread_dtor(struct callback_head *unused)
 static int irq_thread(void *data)
 {
 	struct callback_head on_exit_work;
-	static const struct sched_param param = {
-		.sched_priority = MAX_USER_RT_PRIO/2,
-	};
 	struct irqaction *action = data;
 	struct irq_desc *desc = irq_to_desc(action->irq);
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
@@ -854,8 +851,6 @@ static int irq_thread(void *data)
 	else
 		handler_fn = irq_thread_fn;
 
-	sched_setscheduler(current, SCHED_FIFO, &param);
-
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, false);
 
@@ -950,6 +945,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 */
 	if (new->thread_fn && !nested) {
 		struct task_struct *t;
+		static const struct sched_param param = {
+			.sched_priority = MAX_USER_RT_PRIO/2,
+		};
 
 		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
 				   new->name);
@@ -957,6 +955,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
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


