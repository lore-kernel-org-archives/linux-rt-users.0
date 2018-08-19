From: Mike Galbraith <efault@gmx.de>
Subject: Re: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
Date: Sun, 19 Aug 2018 08:28:35 +0200
Message-ID: <1534660115.6187.4.camel@gmx.de>
References: <20180817162340.6e8482fd@gandalf.local.home>
         <1534588142.2516.10.camel@gmx.de> <1534597992.15909.17.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534597992.15909.17.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2018-08-18 at 15:13 +0200, Mike Galbraith wrote:
> seems it has be something from the 4.17 cycle that went back to 4.14-
> stable after 4.1[56]-stable trees went extinct.

See ("sched/core: Require cpu_active() in select_task_rq(), for user tasks")

Fix it like so?

sched: Allow pinned user tasks to be awakened to the CPU they pinned

Since 7af443ee16976, select_fallback_rq() will BUG() if the CPU to
which a task has pinned itself and pinned becomes !cpu_active()
while it slept.  Serving a 10 megaton eviction notice is neither
helpful nor required, the task will migrate when it can do so.

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,7 +980,7 @@ static inline bool is_cpu_allowed(struct
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
