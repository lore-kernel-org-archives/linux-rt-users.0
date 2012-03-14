From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/7] net: Use cpu_chill() instead of cpu_relax()
Date: Tue, 13 Mar 2012 22:27:04 -0400
Message-ID: <20120314022945.771027206@goodmis.org>
References: <20120314022658.783312660@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-net-Use-cpu_chill-instead-of-cpu_relax.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Retry loops on RT might loop forever when the modifying side was
preempted. Use cpu_chill() instead of cpu_relax() to let the system
make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/rds/ib_rdma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/rds/ib_rdma.c b/net/rds/ib_rdma.c
index 819c35a..256ad87 100644
--- a/net/rds/ib_rdma.c
+++ b/net/rds/ib_rdma.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
+#include <linux/delay.h>
 
 #include "rds.h"
 #include "ib.h"
@@ -294,7 +295,7 @@ static inline void wait_clean_list_grace(void)
 	for_each_online_cpu(cpu) {
 		flag = &per_cpu(clean_list_grace, cpu);
 		while (test_bit(CLEAN_LIST_BUSY_BIT, flag))
-			cpu_relax();
+			cpu_chill();
 	}
 }
 
-- 
1.7.8.3
