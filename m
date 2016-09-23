From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 7/8] fs/dcache: incremental fixup of the retry routine
Date: Fri, 23 Sep 2016 11:30:38 -0400
Message-ID: <20160923153203.510968971@goodmis.org>
References: <20160923153031.676858930@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0007-fs-dcache-incremental-fixup-of-the-retry-routine.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.103-rt115-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

It has been pointed out by tglx that on UP the non-RT task could spin
its entire time slice because the lock owner is preempted. This won't
happen on !RT. So we back to "chill" if we can't cond_resched() did not
work.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/dcache.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 99b9a8560790..df0420c8a4cd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -38,8 +38,6 @@
 #include <linux/prefetch.h>
 #include <linux/ratelimit.h>
 #include <linux/delay.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/deadline.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -552,10 +550,11 @@ kill_it:
 		if (parent == dentry) {
 			/* the task with the highest priority won't schedule */
 			r = cond_resched();
-			if (!r && (rt_task(current) || dl_task(current)))
+			if (!r)
 				cpu_chill();
-		} else
+		} else {
 			dentry = parent;
+		}
 		goto repeat;
 	}
 }
-- 
2.8.1
