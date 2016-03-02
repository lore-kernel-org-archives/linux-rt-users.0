From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 13/20] sched,rt: __always_inline preemptible_lazy()
Date: Wed, 02 Mar 2016 10:37:11 -0500
Message-ID: <20160302153716.726732574@goodmis.org>
References: <20160302153658.995489487@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Hillf Danton <hillf.zj@alibaba-inc.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0013-sched-rt-__always_inline-preemptible_lazy.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.27-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

homer: # nm kernel/sched/core.o|grep preemptible_lazy
00000000000000b5 t preemptible_lazy

echo wakeup_rt > current_tracer ==> Welcome to infinity.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Link: http://lkml.kernel.org/r/1456067490.3771.2.camel@gmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 24c7ced53555..ae3694ede40a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3170,7 +3170,7 @@ void __sched schedule_preempt_disabled(void)
  * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
  * preempt_lazy_count counter >0.
  */
-static int preemptible_lazy(void)
+static __always_inline int preemptible_lazy(void)
 {
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		return 1;
-- 
2.7.0
