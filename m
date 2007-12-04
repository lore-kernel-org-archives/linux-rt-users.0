From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 12/23] Subject: SCHED - Allow current_cpu to be included in
	search
Date: Tue, 04 Dec 2007 15:45:26 -0500
Message-ID: <20071204204526.3567.35485.stgit@novell1.haskins.net>
References: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, ghaskins@novell.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53465
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754415AbXLDVH0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2007 16:07:26 -0500
In-Reply-To: <20071204204236.3567.65491.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It doesn't hurt if we allow the current CPU to be included in the
search.  We will just simply skip it later if the current CPU turns out
to be the lowest.

We will use this later in the series

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---

 kernel/sched_rt.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 7e26c2c..7e444f4 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -275,9 +275,6 @@ static int find_lowest_rq(struct task_struct *task)
 	for_each_cpu_mask(cpu, *cpu_mask) {
 		struct rq *rq = cpu_rq(cpu);
 
-		if (cpu == rq->cpu)
-			continue;
-
 		/* We look for lowest RT prio or non-rt CPU */
 		if (rq->rt.highest_prio >= MAX_RT_PRIO) {
 			lowest_rq = rq;
@@ -305,7 +302,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task,
 	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
 		cpu = find_lowest_rq(task);
 
-		if (cpu == -1)
+		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
 
 		lowest_rq = cpu_rq(cpu);
