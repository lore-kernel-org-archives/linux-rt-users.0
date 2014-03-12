From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH]sched/rt: Do not try to push tasks if pinned task
 switches to RT
Date: Wed, 12 Mar 2014 06:18:33 -0400
Message-ID: <20140312061833.3a43aa64@gandalf.local.home>
References: <4451359470707@web16g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Kirill Tkhai <tkhai@yandex.ru>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4451359470707@web16g.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Peter,

I'm going through my inbox (over a year old), and found this patch from
Kirill. It looks fine to me. You can apply it with my

  Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

[PATCH]sched/rt: Do not try to push tasks if pinned task switches to RT

Just switched pinned task is not able to be pushed. If the rq had had
several RT tasks before they have already been considered as candidates
to be pushed (or pulled).

Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-rt-users <linux-rt-users@vger.kernel.org>
---
 kernel/sched/rt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4e8f0f4..5aab032 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1925,9 +1925,9 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (p->on_rq && rq->curr != p) {
 #ifdef CONFIG_SMP
-		if (rq->rt.overloaded && push_rt_task(rq) &&
+		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded &&
 		    /* Don't resched if we changed runqueues */
-		    rq != task_rq(p))
+		    push_rt_task(rq) && rq != task_rq(p))
 			check_resched = 0;
 #endif /* CONFIG_SMP */
 		if (check_resched && p->prio < rq->curr->prio)
