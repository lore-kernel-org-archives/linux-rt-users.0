From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/5] block: Use cpu_chill() for retry loops
Date: Fri, 21 Dec 2012 23:25:19 -0500
Message-ID: <20121222042554.207940346@goodmis.org>
References: <20121222042515.867823077@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-block-Use-cpu_chill-for-retry-loops.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Retry loops on RT might loop forever when the modifying side was
preempted. Steven also observed a live lock when there was a
concurrent priority boosting going on.

Use cpu_chill() instead of cpu_relax() to let the system
make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
---
 block/blk-ioc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index fb95dd2..6b54201 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/bootmem.h>	/* for max_pfn/max_low_pfn */
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include "blk.h"
 
@@ -110,7 +111,7 @@ static void ioc_release_fn(struct work_struct *work)
 			spin_unlock(q->queue_lock);
 		} else {
 			spin_unlock_irqrestore(&ioc->lock, flags);
-			cpu_relax();
+			cpu_chill();
 			spin_lock_irqsave_nested(&ioc->lock, flags, 1);
 		}
 	}
@@ -188,7 +189,7 @@ retry:
 			spin_unlock(icq->q->queue_lock);
 		} else {
 			spin_unlock_irqrestore(&ioc->lock, flags);
-			cpu_relax();
+			cpu_chill();
 			goto retry;
 		}
 	}
-- 
1.7.10.4
