From: Gregory Haskins <ghaskins@novell.com>
Subject: [RT PATCH v2 1/2] RT: Remove comment that is no longer true
Date: Fri, 03 Oct 2008 13:26:13 -0400
Message-ID: <20081003172612.23714.4547.stgit@dev.haskins.net>
References: <20081003172221.23714.71575.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, dvhltc@us.ibm.com, dino@in.ibm.com,
	Gilles.Carry@bull.net
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754649AbYJCRWZ@vger.kernel.org>
In-Reply-To: <20081003172221.23714.71575.stgit@dev.haskins.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We fixed the condition noted in the comment with the "pushable_tasks"
logic, but forgot to remove this comment.  Lets clean it up.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched_rt.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 57a0c0d..59ead84 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -1125,16 +1125,6 @@ out:
 	return 1;
 }
 
-/*
- * TODO: Currently we just use the second highest prio task on
- *       the queue, and stop when it can't migrate (or there's
- *       no more RT tasks).  There may be a case where a lower
- *       priority RT task has a different affinity than the
- *       higher RT task. In this case the lower RT task could
- *       possibly be able to migrate where as the higher priority
- *       RT task could not.  We currently ignore this issue.
- *       Enhancements are welcome!
- */
 static void push_rt_tasks(struct rq *rq)
 {
 	/* push_rt_task will return true if it moved an RT */
