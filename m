From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 19/23] Subject: SCHED - Optimize out cpu_clears
Date: Tue, 04 Dec 2007 15:46:01 -0500
Message-ID: <20071204204601.3567.77236.stgit@novell1.haskins.net>
References: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, ghaskins@novell.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53501
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755356AbXLDVIB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2007 16:08:01 -0500
In-Reply-To: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Steven Rostedt <srostedt@redhat.com>

This patch removes several cpumask operations by keeping track
of the first of the CPUS that is of the lowest priority. When
the search for the lowest priority runqueue is completed, all
the bits up to the first CPU with the lowest priority runqueue
is cleared.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched_rt.c |   49 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 0514b27..039be04 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -294,29 +294,36 @@ static struct task_struct *pick_next_highest_task_rt(struct rq *rq,
 }
 
 static DEFINE_PER_CPU(cpumask_t, local_cpu_mask);
-static DEFINE_PER_CPU(cpumask_t, valid_cpu_mask);
 
 static int find_lowest_cpus(struct task_struct *task, cpumask_t *lowest_mask)
 {
-	int       cpu;
-	cpumask_t *valid_mask = &__get_cpu_var(valid_cpu_mask);
 	int       lowest_prio = -1;
+	int       lowest_cpu  = -1;
 	int       count       = 0;
+	int       cpu;
 
-	cpus_clear(*lowest_mask);
-	cpus_and(*valid_mask, cpu_online_map, task->cpus_allowed);
+	cpus_and(*lowest_mask, cpu_online_map, task->cpus_allowed);
 
 	/*
 	 * Scan each rq for the lowest prio.
 	 */
-	for_each_cpu_mask(cpu, *valid_mask) {
+	for_each_cpu_mask(cpu, *lowest_mask) {
 		struct rq *rq = cpu_rq(cpu);
 
 		/* We look for lowest RT prio or non-rt CPU */
 		if (rq->rt.highest_prio >= MAX_RT_PRIO) {
-			if (count)
+			/*
+			 * if we already found a low RT queue
+			 * and now we found this non-rt queue
+			 * clear the mask and set our bit.
+			 * Otherwise just return the queue as is
+			 * and the count==1 will cause the algorithm
+			 * to use the first bit found.
+			 */
+			if (lowest_cpu != -1) {
 				cpus_clear(*lowest_mask);
-			cpu_set(rq->cpu, *lowest_mask);
+				cpu_set(rq->cpu, *lowest_mask);
+			}
 			return 1;
 		}
 
@@ -326,13 +333,29 @@ static int find_lowest_cpus(struct task_struct *task, cpumask_t *lowest_mask)
 			if (rq->rt.highest_prio > lowest_prio) {
 				/* new low - clear old data */
 				lowest_prio = rq->rt.highest_prio;
-				if (count) {
-					cpus_clear(*lowest_mask);
-					count = 0;
-				}
+				lowest_cpu = cpu;
+				count = 0;
 			}
-			cpu_set(rq->cpu, *lowest_mask);
 			count++;
+		} else
+			cpu_clear(cpu, *lowest_mask);
+	}
+
+	/*
+	 * Clear out all the set bits that represent
+	 * runqueues that were of higher prio than
+	 * the lowest_prio.
+	 */
+	if (lowest_cpu > 0) {
+		/*
+		 * Perhaps we could add another cpumask op to
+		 * zero out bits. Like cpu_zero_bits(cpumask, nrbits);
+		 * Then that could be optimized to use memset and such.
+		 */
+		for_each_cpu_mask(cpu, *lowest_mask) {
+			if (cpu >= lowest_cpu)
+				break;
+			cpu_clear(cpu, *lowest_mask);
 		}
 	}
 
