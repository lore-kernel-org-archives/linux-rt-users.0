From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [PATCH 3.14-rt] sched/numa: Fix task_numa_free() lockdep splat
Date: Sat, 17 May 2014 05:36:59 +0200
Message-ID: <1400297819.9493.11.camel@marge.simpson.net>
References: <20140509181214.GK29014@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:57047 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbaEQDhE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 May 2014 23:37:04 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so1992765eei.0
        for <linux-rt-users@vger.kernel.org>; Fri, 16 May 2014 20:37:02 -0700 (PDT)
In-Reply-To: <20140509181214.GK29014@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14-rt being build with a non-rt config is unlikely, but..

>From 60e69eed85bb7b5198ef70643b5895c26ad76ef7 Mon Sep 17 00:00:00 2001
From: Mike Galbraith <bitbucket@online.de>
Date: Mon, 7 Apr 2014 10:55:15 +0200
Subject: [PATCH] sched/numa: Fix task_numa_free() lockdep splat

Sasha reported that lockdep claims that the following commit:
made numa_group.lock interrupt unsafe:

  156654f491dd ("sched/numa: Move task_numa_free() to __put_task_struct()")

While I don't see how that could be, given the commit in question moved
task_numa_free() from one irq enabled region to another, the below does
make both gripes and lockups upon gripe with numa=fake=4 go away.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Fixes: 156654f491dd ("sched/numa: Move task_numa_free() to __put_task_struct()")
Signed-off-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org
Cc: mgorman@suse.com
Cc: akpm@linux-foundation.org
Cc: Dave Jones <davej@redhat.com>
Link: http://lkml.kernel.org/r/1396860915.5170.5.camel@marge.simpson.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>

---
 kernel/sched/fair.c  |   13 +++++++------
 kernel/sched/sched.h |    9 +++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1371,7 +1371,7 @@ static void task_numa_placement(struct t
 	/* If the task is part of a group prevent parallel updates to group stats */
 	if (p->numa_group) {
 		group_lock = &p->numa_group->lock;
-		spin_lock(group_lock);
+		spin_lock_irq(group_lock);
 	}
 
 	/* Find the node with the highest number of faults */
@@ -1432,7 +1432,7 @@ static void task_numa_placement(struct t
 			}
 		}
 
-		spin_unlock(group_lock);
+		spin_unlock_irq(group_lock);
 	}
 
 	/* Preferred node as the node with the most faults */
@@ -1532,7 +1532,8 @@ static void task_numa_group(struct task_
 	if (!join)
 		return;
 
-	double_lock(&my_grp->lock, &grp->lock);
+	BUG_ON(irqs_disabled());
+	double_lock_irq(&my_grp->lock, &grp->lock);
 
 	for (i = 0; i < 2*nr_node_ids; i++) {
 		my_grp->faults[i] -= p->numa_faults[i];
@@ -1546,7 +1547,7 @@ static void task_numa_group(struct task_
 	grp->nr_tasks++;
 
 	spin_unlock(&my_grp->lock);
-	spin_unlock(&grp->lock);
+	spin_unlock_irq(&grp->lock);
 
 	rcu_assign_pointer(p->numa_group, grp);
 
@@ -1565,14 +1566,14 @@ void task_numa_free(struct task_struct *
 	void *numa_faults = p->numa_faults;
 
 	if (grp) {
-		spin_lock(&grp->lock);
+		spin_lock_irq(&grp->lock);
 		for (i = 0; i < 2*nr_node_ids; i++)
 			grp->faults[i] -= p->numa_faults[i];
 		grp->total_faults -= p->total_numa_faults;
 
 		list_del(&p->numa_entry);
 		grp->nr_tasks--;
-		spin_unlock(&grp->lock);
+		spin_unlock_irq(&grp->lock);
 		rcu_assign_pointer(p->numa_group, NULL);
 		put_numa_group(grp);
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1392,6 +1392,15 @@ static inline void double_lock(spinlock_
 	spin_lock_nested(l2, SINGLE_DEPTH_NESTING);
 }
 
+static inline void double_lock_irq(spinlock_t *l1, spinlock_t *l2)
+{
+	if (l1 > l2)
+		swap(l1, l2);
+
+	spin_lock_irq(l1);
+	spin_lock_nested(l2, SINGLE_DEPTH_NESTING);
+}
+
 static inline void double_raw_lock(raw_spinlock_t *l1, raw_spinlock_t *l2)
 {
 	if (l1 > l2)


