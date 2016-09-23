From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/9] sched: lazy_preempt: avoid a warning in the !RT case
Date: Fri, 23 Sep 2016 11:28:29 -0400
Message-ID: <20160923152839.140106262@goodmis.org>
References: <20160923152826.308633481@goodmis.org>
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

3.12.63-rt85-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca7fd86309ed..0e348717ab05 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2757,7 +2757,7 @@ static __always_inline int preemptible_lazy(void)
 
 #else
 
-static int preemptible_lazy(void)
+static inline int preemptible_lazy(void)
 {
 	return 1;
 }
-- 
2.8.1
