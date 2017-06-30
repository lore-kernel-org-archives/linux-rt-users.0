From: tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Subject: [tip:sched/core] sched/debug: Expose the number of RT/DL tasks that
 can migrate
Date: Fri, 30 Jun 2017 06:09:42 -0700
Message-ID: <tip-48365b38849fdb1ee6dc65beac044ca59f669683@git.kernel.org>
References: <7896f71cada54ee7dd8507bb666063a2e051c3d4.1498482127.git.bristot@redhat.com>
Reply-To: hpa@zytor.com, lgoncalv@redhat.com, peterz@infradead.org,
          lcapitulino@redhat.com, linux-kernel@vger.kernel.org,
          linux-rt-users@vger.kernel.org, bristot@redhat.com,
          torvalds@linux-foundation.org, rostedt@goodmis.org,
          mingo@kernel.org, tglx@linutronix.de, bigeasy@linutronix.de,
          williams@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: rostedt@goodmis.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, williams@redhat.com, hpa@zytor.com,
        lgoncalv@redhat.com, lcapitulino@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-rt-users@vger.kernel.org, torvalds@linux-foundation.org,
        bristot@redhat.com
To: linux-tip-commits@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7896f71cada54ee7dd8507bb666063a2e051c3d4.1498482127.git.bristot@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Commit-ID:  48365b38849fdb1ee6dc65beac044ca59f669683
Gitweb:     http://git.kernel.org/tip/48365b38849fdb1ee6dc65beac044ca59f669683
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Mon, 26 Jun 2017 17:07:14 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Jun 2017 09:32:07 +0200

sched/debug: Expose the number of RT/DL tasks that can migrate

Add the value of the rt_rq.rt_nr_migratory and dl_rq.dl_nr_migratory
to the sched_debug output, for instance:

 rt_rq[0]:
   .rt_nr_running                 : 2
   .rt_nr_migratory               : 1     <--- Like this
   .rt_throttled                  : 0
   .rt_time                       : 828.645877
   .rt_runtime                    : 1000.000000

This is useful to debug problems related to the RT/DL schedulers.

This also fixes the format of some variables, that were unsigned, rather
than signed.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Link: http://lkml.kernel.org/r/7896f71cada54ee7dd8507bb666063a2e051c3d4.1498482127.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/debug.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 38f0193..4fa66de 100644
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
