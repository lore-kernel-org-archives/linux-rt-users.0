From: Brian Silverman <brian@peloton-tech.com>
Subject: [PATCH] Force processes to non-realtime before mm_exit
Date: Fri,  3 Jun 2016 16:18:44 -0700
Message-ID: <1464995924-16367-1-git-send-email-brian@peloton-tech.com>
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
	Brian Silverman <brian@peloton-tech.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Without this, a realtime process which has called mlockall exiting
causes large latencies for other realtime processes at the same or
lower priorities. This seems like a fairly common use case too, because
realtime processes generally want their memory locked into RAM.

Signed-off-by: Brian Silverman <brian@peloton-tech.com>
---
 kernel/exit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index a0cf72b..68a97df 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -730,6 +730,12 @@ void do_exit(long code)
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
+	if (tsk->policy == SCHED_FIFO || tsk->policy == SCHED_RR) {
+		struct sched_param param = { .sched_priority = 0 };
+
+		sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+	}
+
 	exit_mm(tsk);
 
 	if (group_dead)
-- 
2.1.4
