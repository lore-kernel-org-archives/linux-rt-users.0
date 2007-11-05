From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 4/8] RT: Allow current_cpu to be included in search
Date: Mon, 05 Nov 2007 16:45:38 -0700
Message-ID: <20071105234538.25384.88240.stgit@lsg>
References: <20071105234517.25384.5143.stgit@lsg>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, dvhltc@us.ibm.com, zijlstra@redhat.com,
	"linux-kernel@vger"@kernel.org, linux-rt-users@vger.kernel.org,
	ghaskins@novell.com
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nds154-200.nds.lab.novell.com ([151.155.154.200]:9640 "EHLO
	lsg.lab.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755270AbXKFARN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Nov 2007 19:17:13 -0500
In-Reply-To: <20071105234517.25384.5143.stgit@lsg>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

It doesn't hurt if we allow the current CPU to be included in the
search.  We will just simply skip it later if the current CPU turns out
to be the lowest.

We will use this later in the series

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched_rt.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index fbe7b8a..7dd67db 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -326,9 +326,6 @@ static int find_lowest_rq(struct task_struct *task)
 	for_each_cpu_mask(cpu, cpu_mask) {
 		struct rq *rq = cpu_rq(cpu);
 
-		if (cpu == rq->cpu)
-			continue;
-
 		/* We look for lowest RT prio or non-rt CPU */
 		if (rq->rt.highest_prio >= MAX_RT_PRIO) {
 			lowest_rq = rq;
@@ -356,7 +353,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task,
 	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
 		cpu = find_lowest_rq(task);
 
-		if (cpu == -1)
+		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
 
 		lowest_rq = cpu_rq(cpu);
