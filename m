From: Qiang Huang <h.huangqiang@huawei.com>
Subject: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
Date: Thu, 25 Apr 2013 17:01:18 +0800
Message-ID: <5178F0DE.8030808@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:17978 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3DYJBv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 05:01:51 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is revert of "sched-clear-pf-thread-bound-on-fallback-rq.patch"
(commit 0d939066acdcb in v3.4-rt),.

Select_fallback_rq() can be easilly called during system boot, because
select_task_rq_fair() just return task_cpu(p) for bounded kernel threads,
which is 0 during system boot and not in tsk_cpus_allowed, so
select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In my
box, 1/3 bounded kernel threads will clear that flag after boot.

And it will cause problems, for example:
# for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
this command will cause system hung.

What's more, I don't see why we need to clear this flag any more,
because "cpu/rt: Rework cpu down for PREEMPT_RT" already remove the
optimization for PF_THREAD_BOUND on migrate_disable/enable.

Signed-off-by: Qiang Huang <h.huangqiang@huawei.com>
---
 kernel/sched/core.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 751ec60..8db6e3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1327,12 +1327,6 @@ out:
 		}
 	}

-	/*
-	 * Clear PF_THREAD_BOUND, otherwise we wreckage
-	 * migrate_disable/enable. See optimization for
-	 * PF_THREAD_BOUND tasks there.
-	 */
-	p->flags &= ~PF_THREAD_BOUND;
 	return dest_cpu;
 }

-- 1.7.1

