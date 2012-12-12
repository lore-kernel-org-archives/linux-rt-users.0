From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][PATCH RT 3/4 v2] sched/rt: Initiate a pull when the priority of a task is lowered
Date: Wed, 12 Dec 2012 14:27:36 -0500
Message-ID: <20121212193920.669763727@goodmis.org>
References: <20121212192733.221810086@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Mike Galbraith <bitbucket@online.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=rt-migrate-redo.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

If a task lowers its priority (say by losing priority inheritance)
if a higher priority task is waiting on another CPU, initiate a pull.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-rt.git/kernel/sched/rt.c
===================================================================
--- linux-rt.git.orig/kernel/sched/rt.c
+++ linux-rt.git/kernel/sched/rt.c
@@ -997,6 +997,8 @@ inc_rt_prio(struct rt_rq *rt_rq, int pri
 	inc_rt_prio_smp(rt_rq, prio, prev_prio);
 }
 
+static int pull_rt_task(struct rq *this_rq);
+
 static void
 dec_rt_prio(struct rt_rq *rt_rq, int prio)
 {
@@ -1021,6 +1023,10 @@ dec_rt_prio(struct rt_rq *rt_rq, int pri
 		rt_rq->highest_prio.curr = MAX_RT_PRIO;
 
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
+
+	/* Try to pull RT tasks here if we lower this rq's prio */
+	if (prev_prio < rt_rq->highest_prio.curr)
+		pull_rt_task(rq_of_rt_rq(rt_rq));
 }
 
 #else
