From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 1/3] sched: limit "all_pinned" balance attempts to sd->span
Date: Tue, 24 Jun 2008 08:16:02 -0600
Message-ID: <20080624141602.28487.81775.stgit@lsg.lsg.lab.novell.com>
References: <20080624141527.28487.77778.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
	linux-rt-users@vger.kernel.org, ghaskins@novell.com,
	dbahi@novell.com, npiggin@suse.de
To: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760661AbYFXOQ7@vger.kernel.org>
In-Reply-To: <20080624141527.28487.77778.stgit@lsg.lsg.lab.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Load-balancing will never terminate if all cpus are "all_pinned" with
the current algorithm.  This would be pretty unlikely to occur, but we
should protect against it nonetheless.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 31f91d9..54b27b4 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -3178,7 +3178,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	struct sched_group *group;
 	unsigned long imbalance;
 	struct rq *busiest;
-	cpumask_t cpus = CPU_MASK_ALL;
+	cpumask_t cpus = sd->span;
+	int remain = cpus_weight(sd->span) - 1;
 	unsigned long flags;
 
 	/*
@@ -3237,11 +3238,10 @@ redo:
 			resched_cpu(this_cpu);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
-		if (unlikely(all_pinned)) {
+		if (unlikely(all_pinned && remain)) {
 			cpu_clear(cpu_of(busiest), cpus);
-			if (!cpus_empty(cpus))
-				goto redo;
-			goto out_balanced;
+			remain--;
+			goto redo;
 		}
 	}
 
@@ -3332,7 +3332,8 @@ load_balance_newidle(int this_cpu, struct rq *this_rq, struct sched_domain *sd)
 	int ld_moved = 0;
 	int sd_idle = 0;
 	int all_pinned = 0;
-	cpumask_t cpus = CPU_MASK_ALL;
+	cpumask_t cpus = sd->span;
+	int remain = cpus_weight(sd->span) - 1;
 
 	/*
 	 * When power savings policy is enabled for the parent domain, idle
@@ -3375,10 +3376,10 @@ redo:
 					&all_pinned);
 		spin_unlock(&busiest->lock);
 
-		if (unlikely(all_pinned)) {
+		if (unlikely(all_pinned && remain)) {
 			cpu_clear(cpu_of(busiest), cpus);
-			if (!cpus_empty(cpus))
-				goto redo;
+			remain--;
+			goto redo;
 		}
 	}
 
