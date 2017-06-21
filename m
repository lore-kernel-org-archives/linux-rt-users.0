From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 1/2] sched/debug: Inform the number of rt/dl task that can migrate
Date: Wed, 21 Jun 2017 21:29:00 +0200
Message-ID: <9d7f19113ac410735707e0f179853100e9918c0d.1498068819.git.bristot@redhat.com>
References: <cover.1498068819.git.bristot@redhat.com>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498068819.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

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

[ I am sending this patch to be able to demonstrate       ]
[ the problem in the kernel-rt, however, this patch can   ]
[ be merged in the vanilla kernel, if people decide it    ]
[ is worth having it.                                     ]

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
 kernel/sched/debug.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0e2af53..2bdeda8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -552,15 +552,19 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 
 #define P(x) \
 	SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rt_rq->x))
+#define PU(x) \
+	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(rt_rq->x))
 #define PN(x) \
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rt_rq->x))
 
-	P(rt_nr_running);
+	PU(rt_nr_running);
+	PU(rt_nr_migratory);
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
 
 #undef PN
+#undef PU
 #undef P
 }
 
@@ -569,7 +573,12 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 	struct dl_bw *dl_bw;
 
 	SEQ_printf(m, "\ndl_rq[%d]:\n", cpu);
-	SEQ_printf(m, "  .%-30s: %ld\n", "dl_nr_running", dl_rq->dl_nr_running);
+
+#define PU(x) \
+	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
+
+	PU(dl_nr_running);
+	PU(dl_nr_migratory);
 #ifdef CONFIG_SMP
 	dl_bw = &cpu_rq(cpu)->rd->dl_bw;
 #else
@@ -577,6 +586,8 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 #endif
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
 	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
+
+#undef PU
 }
 
 extern __read_mostly int sched_clock_running;
-- 
2.9.4
