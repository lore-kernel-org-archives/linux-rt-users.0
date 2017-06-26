From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH V2 1/2] sched/debug: Inform the number of rt/dl task that can migrate
Date: Mon, 26 Jun 2017 17:07:14 +0200
Message-ID: <7896f71cada54ee7dd8507bb666063a2e051c3d4.1498482127.git.bristot@redhat.com>
References: <cover.1498482127.git.bristot@redhat.com>
Cc: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751752AbdFZPL5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 11:11:57 -0400
In-Reply-To: <cover.1498482127.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add the value of the rt_rq.rt_nr_migratory and dl_rq.dl_nr_migratory
to the sched_debug output, for instance:

rt_rq[0]:
  .rt_nr_running                 : 2
  .rt_nr_migratory               : 1     <--- Like this
  .rt_throttled                  : 0
  .rt_time                       : 828.645877
  .rt_runtime                    : 1000.000000

This is useful to debug problems related to the dl/rt schedulers.

This also fixes the format of some variables, that were unsigned, rather
than signed.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/sched/debug.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0e2af53..287615a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -552,15 +552,21 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 
 #define P(x) \
 	SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rt_rq->x))
+#define PU(x) \
+	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(rt_rq->x))
 #define PN(x) \
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rt_rq->x))
 
-	P(rt_nr_running);
+	PU(rt_nr_running);
+#ifdef CONFIG_SMP
+	PU(rt_nr_migratory);
+#endif
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
 
 #undef PN
+#undef PU
 #undef P
 }
 
@@ -569,14 +575,21 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 	struct dl_bw *dl_bw;
 
 	SEQ_printf(m, "\ndl_rq[%d]:\n", cpu);
-	SEQ_printf(m, "  .%-30s: %ld\n", "dl_nr_running", dl_rq->dl_nr_running);
+
+#define PU(x) \
+	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
+
+	PU(dl_nr_running);
 #ifdef CONFIG_SMP
+	PU(dl_nr_migratory);
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
 #else
 	dl_bw = &dl_rq->dl_bw;
 #endif
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
+
+#undef PU
 }
 
 extern __read_mostly int sched_clock_running;
-- 
2.9.4

