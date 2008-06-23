From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 3/3] sched: terminate newidle balancing once at least one task
	has moved over
Date: Mon, 23 Jun 2008 17:04:50 -0600
Message-ID: <20080623230450.31515.75112.stgit@lsg.lsg.lab.novell.com>
References: <20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
	linux-rt-users@vger.kernel.org, ghaskins@novell.com,
	dbahi@novell.com
To: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lsg.lsg.lab.novell.com ([151.155.230.1]:8687 "EHLO
	lsg.lsg.lab.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbYFWXEu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jun 2008 19:04:50 -0400
In-Reply-To: <20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Inspired by Peter Zijlstra.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 3efbbc5..c8e8520 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2775,6 +2775,10 @@ static int move_tasks(struct rq *this_rq, int this_cpu, struct rq *busiest,
 				max_load_move - total_load_moved,
 				sd, idle, all_pinned, &this_best_prio);
 		class = class->next;
+
+		if (idle == CPU_NEWLY_IDLE && this_rq->nr_running)
+			break;
+
 	} while (class && max_load_move > total_load_moved);
 
 	return total_load_moved > 0;

