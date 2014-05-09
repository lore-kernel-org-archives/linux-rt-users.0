From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: tracing: BUG: sleeping function called from invalid context
Date: Fri, 9 May 2014 11:37:00 +0200
Message-ID: <20140509093700.GA29014@linutronix.de>
References: <53518CD8.4020706@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33617 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbaEIJhF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 05:37:05 -0400
Content-Disposition: inline
In-Reply-To: <53518CD8.4020706@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Stanislav Meduna | 2014-04-18 22:36:40 [+0200]:

>Hi,
Hi,

>BUG: sleeping function called from invalid context at /home/stano/Kernels/linux-3.12-rt/kernel/rtmutex.c:673
>in_atomic(): 1, irqs_disabled(): 0, pid: 607, name: bash
>3 locks held by bash/607:
> #0:  (sb_writers#8){......}, at: [<c00de6f4>] vfs_write+0x1cc/0x1d0
> #1:  (trace_types_lock){......}, at: [<c0087764>] tracing_set_tracer+0x1c/0x2ac
> #2:  (&buffer->mutex#2){......}, at: [<c0080220>] ring_buffer_resize+0xac/0x3dc
>Preemption disabled at:[<  (null)>]   (null)
>
>CPU: 0 PID: 607 Comm: bash Not tainted 3.12.15-rt25+ #124
>[<c02f7010>] (rt_spin_lock+0x28/0x68) from [<c00aa468>] (free_hot_cold_page+0x84/0x3b8)
>[<c00aa468>] (free_hot_cold_page+0x84/0x3b8) from [<c007cb2c>] (free_buffer_page+0x14/0x20)
>[<c007cb2c>] (free_buffer_page+0x14/0x20) from [<c00800bc>] (rb_update_pages+0x280/0x338)
>[<c00800bc>] (rb_update_pages+0x280/0x338) from [<c00804a0>] (ring_buffer_resize+0x32c/0x3dc)
>[<c00804a0>] (ring_buffer_resize+0x32c/0x3dc) from [<c0087530>] (free_snapshot+0x18/0x38)
>[<c0087530>] (free_snapshot+0x18/0x38) from [<c00879c4>] (tracing_set_tracer+0x27c/0x2ac)
>[<c00879c4>] (tracing_set_tracer+0x27c/0x2ac) from [<c0087a4c>] (tracing_set_trace_write+0x58/0x114)

Can be triggered by:
| cd /sys/kernel/debug/tracing/
| echo 1 > events/enable
| sleep 2 # fill the buffer
| echo 1024 > buffer_size_kb # shrink the buffer

the shrinking of the buffer does this.
Steven, are you comfortable with this change:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fc4da2d..112d4a5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1682,28 +1682,22 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 		 * We can't schedule on offline CPUs, but it's not necessary
 		 * since we can change their buffer sizes without any race.
 		 */
+		migrate_disable();
 		for_each_buffer_cpu(buffer, cpu) {
 			cpu_buffer = buffer->buffers[cpu];
 			if (!cpu_buffer->nr_pages_to_update)
 				continue;
 
 			/* The update must run on the CPU that is being updated. */
-			preempt_disable();
 			if (cpu == smp_processor_id() || !cpu_online(cpu)) {
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
+		migrate_enable();
 
 		/* wait for all the updates to complete */
 		for_each_buffer_cpu(buffer, cpu) {
@@ -1740,22 +1734,16 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 
 		get_online_cpus();
 
-		preempt_disable();
+		migrate_disable();
 		/* The update must run on the CPU that is being updated. */
 		if (cpu_id == smp_processor_id() || !cpu_online(cpu_id))
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
+		migrate_enable();
 
 		cpu_buffer->nr_pages_to_update = 0;
 		put_online_cpus();
-- 
2.0.0.rc0

>Thanks

Sebastian
