From: Kirill Tkhai <tkhai@yandex.ru>
Subject: [PATCH]sched/rt: Simplify pick_rt_task: remove next_prio() inheritance
Date: Thu, 31 Jan 2013 18:56:17 +0400
Message-ID: <70871359644177@web16d.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Function next_prio() has been removed and pull_rt_task() is the only
user of pick_next_highest_task_rt() at the moment.

pull_rt_task is not interested in p->nr_cpus_allowed, its only interest
is the fact that cpu is allowed to execute p. If nr_cpus_allowed == 1,
cpu != task_cpu(p) and cpu is allowed then it means that task p is in
the middle of the migration techniques; the task waits until it is moved
by migration thread. So, lets pull it earlier.

Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/sched/rt.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4e8f0f4..9aa2921 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1427,8 +1427,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    (cpu < 0 || cpumask_test_cpu(cpu, tsk_cpus_allowed(p))) &&
-	    (p->nr_cpus_allowed > 1))
+	    cpumask_test_cpu(cpu, tsk_cpus_allowed(p)))
 		return 1;
 	return 0;
 }
