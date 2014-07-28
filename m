From: minyard@acm.org
Subject: [PATCH] tracing: Always run per-cpu ring buffer resize with schedule_work_on()
Date: Mon, 28 Jul 2014 16:32:59 -0500
Message-ID: <1406583179-18257-1-git-send-email-minyard@acm.org>
Cc: linux-rt-users@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36345 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaG1VdO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Jul 2014 17:33:14 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so5086722ykq.38
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Jul 2014 14:33:14 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

The code for resizing the trace ring buffers has to run the per-cpu
resize on the CPU itself.  The code was using preempt_off() and
running the code for the current CPU directly, otherwise calling
schedule_work_on().

At least on RT this could result in the following:

|BUG: sleeping function called from invalid context at kernel/rtmutex.c:673
|in_atomic(): 1, irqs_disabled(): 0, pid: 607, name: bash
|3 locks held by bash/607:
|CPU: 0 PID: 607 Comm: bash Not tainted 3.12.15-rt25+ #124
|(rt_spin_lock+0x28/0x68)
|(free_hot_cold_page+0x84/0x3b8)
|(free_buffer_page+0x14/0x20)
|(rb_update_pages+0x280/0x338)
|(ring_buffer_resize+0x32c/0x3dc)
|(free_snapshot+0x18/0x38)
|(tracing_set_tracer+0x27c/0x2ac)

probably via
|cd /sys/kernel/debug/tracing/
|echo 1 > events/enable ; sleep 2
|echo 1024 > buffer_size_kb

If we just always use schedule_work_on(), there's no need for the
preempt_off().  So do that.

Reported-by: Stanislav Meduna <stano@meduna.org>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 kernel/trace/ring_buffer.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7c56c3d..35825a8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1693,22 +1693,14 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 			if (!cpu_buffer->nr_pages_to_update)
 				continue;
 
-			/* The update must run on the CPU that is being updated. */
-			preempt_disable();
-			if (cpu == smp_processor_id() || !cpu_online(cpu)) {
+			/* Can't run something on an offline CPU. */
+			if (!cpu_online(cpu)) {
 				rb_update_pages(cpu_buffer);
 				cpu_buffer->nr_pages_to_update = 0;
 			} else {
-				/*
-				 * Can not disable preemption for schedule_work_on()
-				 * on PREEMPT_RT.
-				 */
-				preempt_enable();
 				schedule_work_on(cpu,
 						&cpu_buffer->update_pages_work);
-				preempt_disable();
 			}
-			preempt_enable();
 		}
 
 		/* wait for all the updates to complete */
@@ -1746,22 +1738,14 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 
 		get_online_cpus();
 
-		preempt_disable();
-		/* The update must run on the CPU that is being updated. */
-		if (cpu_id == smp_processor_id() || !cpu_online(cpu_id))
+		/* Can't run something on an offline CPU. */
+		if (!cpu_online(cpu_id))
 			rb_update_pages(cpu_buffer);
 		else {
-			/*
-			 * Can not disable preemption for schedule_work_on()
-			 * on PREEMPT_RT.
-			 */
-			preempt_enable();
 			schedule_work_on(cpu_id,
 					 &cpu_buffer->update_pages_work);
 			wait_for_completion(&cpu_buffer->update_done);
-			preempt_disable();
 		}
-		preempt_enable();
 
 		cpu_buffer->nr_pages_to_update = 0;
 		put_online_cpus();
-- 
1.8.3.1

