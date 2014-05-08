From: minyard@acm.org
Subject: [PATCH] ftrace: Simplify ring buffer resizing, make work with RT
Date: Thu,  8 May 2014 15:03:22 -0500
Message-ID: <1399579402-27034-1-git-send-email-minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:59514 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbaEHUDa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 May 2014 16:03:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

ring_buffer_resize() would call rb_update_pages() with preempt
disabled.  It did this with preempt disabled, bu rb_update_pages
would eventually claim the zone semaphore, which is a mutex in PREEMPT_RT,
thus resulting in a "scheduling while atomic" BUG.

When doing this, all other CPUs except the running one did the operation
in a work queue.  So just do the current CPU operation in a work queue,
too.  This simplifies the code, gets rid of the need for preempt_disable(),
and solves the RT issue.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 kernel/trace/ring_buffer.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

This isn't well tested, but fixes an obvious PREEMPT_RT problem and seems
like a good simplification.  You can see the PREEMPT_RT bug if you enable
ftrace and all the self tests; it will fail running selftests when it tries
to resize the buffers.

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fc4da2d..972125e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1688,21 +1688,13 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				continue;
 
 			/* The update must run on the CPU that is being updated. */
-			preempt_disable();
-			if (cpu == smp_processor_id() || !cpu_online(cpu)) {
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
-- 
1.8.3.1

