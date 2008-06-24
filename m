From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 3/3] sched: terminate newidle balancing once at least one task
	has moved over
Date: Tue, 24 Jun 2008 08:16:12 -0600
Message-ID: <20080624141612.28487.18128.stgit@lsg.lsg.lab.novell.com>
References: <20080624141527.28487.77778.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
	linux-rt-users@vger.kernel.org, ghaskins@novell.com,
	dbahi@novell.com, npiggin@suse.de
To: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760125AbYFXOQ0@vger.kernel.org>
In-Reply-To: <20080624141527.28487.77778.stgit@lsg.lsg.lab.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Inspired by Peter Zijlstra.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index e40c575..094a84b 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2774,6 +2774,10 @@ static int move_tasks(struct rq *this_rq, int this_cpu, struct rq *busiest,
 				max_load_move - total_load_moved,
 				sd, idle, all_pinned, &this_best_prio);
 		class = class->next;
+
+		if (idle == CPU_NEWLY_IDLE && this_rq->nr_running)
+			break;
+
 	} while (class && max_load_move > total_load_moved);
 
 	return total_load_moved > 0;
