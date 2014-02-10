From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH RT 4/5] allow preemption in
	mem_cgroup_move_account_page_stat
Date: Mon, 10 Feb 2014 16:39:33 +0100
Message-ID: <20140210153933.GE20017@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


allow preemption in mem_cgroup_move_account_page_stat

as the call sites of mem_cgroup_move_account_page_stat are under 
move_lock_mem_cgroup move_unlock_mem_cgroup (spin_lock_irqsave/
spin_unlock_irqrestore respectively) the move operations 
preempt_disable/enable seem to be purely for migration protection so 
a migrate_disable/enable should be fine here.

patch on top of 3.12.10-rt15

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 mm/memcontrol.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a67e630f..e7cc35a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3784,10 +3784,10 @@ void mem_cgroup_move_account_page_stat(struct mem_cgroup *from,
 					enum mem_cgroup_stat_index idx)
 {
 	/* Update stat data for mem_cgroup */
-	preempt_disable();
+	migrate_disable();
 	__this_cpu_sub(from->stat->count[idx], nr_pages);
 	__this_cpu_add(to->stat->count[idx], nr_pages);
-	preempt_enable();
+	migrate_enable();
 }
 
 /**
-- 
1.7.2.5
