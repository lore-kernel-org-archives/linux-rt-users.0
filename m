From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] RESEND: fix cpus_allowed settings
Date: Fri, 07 Mar 2008 07:11:43 -0500
Message-ID: <20080307120644.7031.14474.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	ghaskins@novell.com
To: rostedt@goodmis.org, mingo@elte.he
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:58713
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751063AbYCGMmU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Mar 2008 07:42:20 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo, Steve,
  I sent this patch a few weeks ago along with the migration_disable
series.  I think the controversy with the migration_disable feature
may have resulted in this fix being overlooked.  This patch is against
-rt, but the bug theoretically affects both -rt and sched-devel/mainline.
I can also whip up a sched-devel based patch if you like, but I think it
will apply trivially to both places.

Please consider it for inclusion.

Regards,
-Greg

-------------------------------
Subject: fix cpus_allowed settings

We miss setting nr_cpus_allowed for the kthread case since the normal
set_cpus_allowed() function is not used.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/kthread.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index dcfe724..b193b47 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -170,6 +170,7 @@ void kthread_bind(struct task_struct *k, unsigned int cpu)
 	wait_task_inactive(k);
 	set_task_cpu(k, cpu);
 	k->cpus_allowed = cpumask_of_cpu(cpu);
+	k->nr_cpus_allowed = 1;
 }
 EXPORT_SYMBOL(kthread_bind);
 

