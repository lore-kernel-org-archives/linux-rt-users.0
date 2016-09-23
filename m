From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/7] fs/dcache: resched/chill only if we make no progress
Date: Fri, 23 Sep 2016 12:48:05 -0400
Message-ID: <20160923164809.889371802@goodmis.org>
References: <20160923164800.627094159@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760938AbcIWQsO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 12:48:14 -0400
Content-Disposition: inline; filename=0005-fs-dcache-resched-chill-only-if-we-make-no-progress.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.4.112-rt144-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Upstream commit 47be61845c77 ("fs/dcache.c: avoid soft-lockup in
dput()") changed the condition _when_ cpu_relax() / cond_resched() was
invoked. This change was adapted in -RT into mostly the same thing
except that if cond_resched() did nothing we had to do cpu_chill() to
force the task off CPU for a tiny little bit in case the task had RT
priority and did not want to leave the CPU.
This change resulted in a performance regression (in my testcase the
build time on /dev/shm increased from 19min to 24min). The reason is
that with this change cpu_chill() was invoked even dput() made progress
(dentry_kill() returned a different dentry) instead only if we were
trying this operation on the same dentry over and over again.

This patch brings back to the old behavior back to cond_resched() &
chill if we make no progress. A little improvement is to invoke
cpu_chill() only if we are a RT task (and avoid the sleep otherwise).
Otherwise the scheduler should remove us from the CPU if we make no
progress.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/dcache.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 67a137772f13..408551d483b7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -38,6 +38,8 @@
 #include <linux/prefetch.h>
 #include <linux/ratelimit.h>
 #include <linux/delay.h>
+#include <linux/sched/rt.h>
+#include <linux/sched/deadline.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -527,6 +529,8 @@ relock:
  */
 void dput(struct dentry *dentry)
 {
+	struct dentry *parent;
+
 	if (!dentry)
 		return;
 
@@ -564,9 +568,19 @@ repeat:
 	return;
 
 kill_it:
-	dentry = dentry_kill(dentry, 1);
-	if (dentry)
+	parent = dentry_kill(dentry, 1);
+	if (parent) {
+		int r;
+
+		if (parent == dentry) {
+			/* the task with the highest priority won't schedule */
+			r = cond_resched();
+			if (!r && (rt_task(current) || dl_task(current)))
+				cpu_chill();
+		} else
+			dentry = parent;
 		goto repeat;
+	}
 }
 EXPORT_SYMBOL(dput);
 
-- 
2.8.1


