From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] sched: Do not clear PF_NO_SETAFFINITY flag in select_fallback_rq()
Date: Mon, 14 Jul 2014 16:06:35 -0400
Message-ID: <20140714200652.028318611@goodmis.org>
References: <20140714200634.590977709@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org, Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:5824 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757302AbaGNUGz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jul 2014 16:06:55 -0400
Content-Disposition: inline; filename=0001-sched-Do-not-clear-PF_NO_SETAFFINITY-flag-in-select_.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.2.60-rt89-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

I talked with Peter Zijlstra about this, and he told me that the clearing
of the PF_NO_SETAFFINITY flag was to deal with the optimization of
migrate_disable/enable() that ignores tasks that have that flag set. But
that optimization was removed when I did a rework of the cpu hotplug code.

I found that ignoring tasks that had that flag set would cause those tasks
to not sync with the hotplug code and cause the kernel to crash. Thus it
needed to not treat them special and those tasks had to go though the same
work as tasks without that flag set.

Now that those tasks are not treated special, there's no reason to clear the
flag.

May still need to be tested as the migrate_me() code does not ignore those
flags.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <williams@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20140701111444.0cfebaa1@gandalf.local.home
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 9942f012908d..b0e67590ba62 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2572,12 +2572,6 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 		printk(KERN_INFO "process %d (%s) no longer affine to cpu%d\n",
 				task_pid_nr(p), p->comm, cpu);
 	}
-	/*
-	 * Clear PF_THREAD_BOUND, otherwise we wreckage
-	 * migrate_disable/enable. See optimization for
-	 * PF_THREAD_BOUND tasks there.
-	 */
-	p->flags &= ~PF_THREAD_BOUND;
 	return dest_cpu;
 }
 
-- 
2.0.0


