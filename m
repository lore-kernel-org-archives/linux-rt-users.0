From: Brian Silverman <brian@peloton-tech.com>
Subject: [PATCH] Force processes to non-realtime before mm_exit
Date: Tue, 10 May 2016 14:04:24 -0400
Message-ID: <1462903464-11448-1-git-send-email-brian@peloton-tech.com>
Cc: Brian Silverman <brian@peloton-tech.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32852 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcEJSGr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 May 2016 14:06:47 -0400
Received: by mail-pf0-f176.google.com with SMTP id 206so8478654pfu.0
        for <linux-rt-users@vger.kernel.org>; Tue, 10 May 2016 11:06:47 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

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

