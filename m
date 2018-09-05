From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/22] PM / suspend: Prevent might sleep splats (updated)
Date: Wed, 05 Sep 2018 08:27:58 -0400
Message-ID: <20180905122834.939477914@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit ec7ff06b919647a2fd7d2761a26f5a1d465e819c ]

This is an updated version of this patch which was merged upstream as
commit c1a957d17086d20d52d7f9c8dffaeac2ee09d6f9

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/tick-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 7f5a26c3a8ee..7a87a4488a5e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -492,6 +492,7 @@ void tick_freeze(void)
 	if (tick_freeze_depth == num_online_cpus()) {
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
+		system_state = SYSTEM_SUSPEND;
 		timekeeping_suspend();
 	} else {
 		tick_suspend_local();
@@ -515,6 +516,7 @@ void tick_unfreeze(void)
 
 	if (tick_freeze_depth == num_online_cpus()) {
 		timekeeping_resume();
+		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
 	} else {
-- 
2.18.0
