From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH RT 3.18] ring-buffer: Mark irq_work as HARD_IRQ to prevent
 deadlocks
Date: Thu, 16 Apr 2015 16:06:54 +0200
Message-ID: <552FC1FE.4020406@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:59675 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbbDPOTp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Apr 2015 10:19:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

ftrace may trigger rb_wakeups while holding pi_lock which will also be
requested via trace_...->...->ring_buffer_unlock_commit->...->
irq_work_queue->raise_softirq->try_to_wake_up. This quickly causes
deadlocks when trying to use ftrace under -rt.

Resolve this by marking the ring buffer's irq_work as HARD_IRQ.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I'm not yet sure if this doesn't push work into hard-irq context that
is better not done there on -rt.

I'm also not sure if there aren't more such cases, given that -rt turns
the default irq_work wakeup policy around. But maybe we are lucky.

 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f4fbbfc..6a1939e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1252,6 +1252,7 @@ rb_allocate_cpu_buffer(struct ring_buffer *buffer, int nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	cpu_buffer->irq_work.work.flags = IRQ_WORK_HARD_IRQ;
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
