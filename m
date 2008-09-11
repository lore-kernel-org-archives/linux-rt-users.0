From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: [PATCH RT] tasklets: fix __tasklet_hi_schedule()
Date: Thu, 11 Sep 2008 14:00:08 +0200
Message-ID: <20080911140008.05addc59@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	Gilles Carry <Gilles.Carry@ext.bull.net>,
	Tim Chavez <tinytim@us.ibm.com>
To: Linux-rt <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:49960 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbYIKMAX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Sep 2008 08:00:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From b5ae1d4954394b05c17a87403e7584c7f90e457a Mon Sep 17 00:00:00 2001
From: Sebastien Dugue <sebastien.dugue@bull.net>
Date: Thu, 11 Sep 2008 13:47:40 +0200
Subject: [PATCH 1/1] tasklets: fix __tasklet_hi_schedule()

  fix __tasklet_hi_schedule() which incorrectly puts the tasklet to be
scheduled on the wrong list (tasklet_vec instead of tasklet_hi_vec).

  This broke rebooting a box with the ehea driver.

Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
---
 kernel/softirq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 3ee1ae7..2198970 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -536,7 +536,7 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_vec), HI_SOFTIRQ);
+	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_hi_vec), HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
-- 
1.6.0.1.308.gede4c

