From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/10] sched: lazy_preempt: avoid a warning in the !RT case
Date: Thu, 22 Sep 2016 19:17:31 -0400
Message-ID: <20160922231741.619682140@goodmis.org>
References: <20160922231728.394180695@goodmis.org>
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
Content-Disposition: inline; filename=0003-sched-lazy_preempt-avoid-a-warning-in-the-RT-case.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.42-rt45-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 371fa38784e0..ce6d5c6ba8f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3171,7 +3171,7 @@ static __always_inline int preemptible_lazy(void)
 
 #else
 
-static int preemptible_lazy(void)
+static inline int preemptible_lazy(void)
 {
 	return 1;
 }
-- 
2.8.1
