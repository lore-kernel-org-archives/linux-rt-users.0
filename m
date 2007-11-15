From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] RT: convert cpupri spinlock_t to raw_spinlock_t
Date: Wed, 14 Nov 2007 23:43:23 -0500
Message-ID: <20071115043830.8362.31302.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu, ghaskins@novell.com
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:34669
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750707AbXKOFBw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2007 00:01:52 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steven,
   This patch should fix the hang you were seeing in 24-rc2-rt1-pre9 with "#8"
applied.  I meant to bring this required -rt specific change up when we spoke
on IRC earlier, but it slipped through the cracks. :(  Sorry 'bout that.

Regards,
-Greg


--------------------

RT: convert cpupri spinlock_t to raw_spinlock_t

We recently started preparing some of the scheduler changes for upstream
merginging.  Part of this work involved changing the original raw_spinlock
used in cpupri to a spinlock since this is proper use for a mainline change.
However, in order to continue to use this patch back in -rt, we need to
restore the lock back to raw or the kernel will hang during bootup.

So this patch does the conversion, but should not go upstream with the rest
of the scheduler enhancements until the -rt spinlock work is also merged.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched_cpupri.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched_cpupri.c b/kernel/sched_cpupri.c
index 09e27eb..91cc9c8 100644
--- a/kernel/sched_cpupri.c
+++ b/kernel/sched_cpupri.c
@@ -39,8 +39,8 @@
 
 struct pri_vec
 {
-	spinlock_t lock;
-	cpumask_t  mask;
+	raw_spinlock_t lock;
+	cpumask_t      mask;
 };
 
 struct cpu_priority {
