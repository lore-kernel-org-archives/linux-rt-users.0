From: Gregory Haskins <ghaskins@novell.com>
Subject: [(RESEND) PATCH] sched: fix RT task-wakeup logic
Date: Mon, 28 Apr 2008 12:30:29 -0400
Message-ID: <20080428162747.5784.82343.stgit@novell1.haskins.net>
References: <48103D18.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Gregory Haskins <ghaskins@novell.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:51979
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932088AbYD1RDe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Apr 2008 13:03:34 -0400
In-Reply-To: <48103D18.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo,
  Im not sure if this patch fell through the cracks, or if you didn't like it
  for some reason.  If you can, please ACK/NACK it so I know if you have
  reviewed it or not.  Thanks!

(This applies to sched-devel, and should be considered a bug fix for 25.y and
the 26 merge window)

-Greg

------------------------------
sched: fix RT task-wakeup logic

Dmitry Adamushko pointed out a logic error in task_wake_up_rt() where we
will always evaluate to "true".  You can find the thread here:

http://lkml.org/lkml/2008/4/22/296

In reality, we only want to try to push tasks away when a wake up request is
not going to preempt the current task.  So lets fix it.

Note: We introduce test_tsk_need_resched() instead of open-coding the flag
check so that the merge-conflict with -rt should help remind us that we
may need to support NEEDS_RESCHED_DELAYED in the future, too.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Dmitry Adamushko <dmitry.adamushko@gmail.com>
CC: Ingo Molnar <mingo@elte.hu>
---

 include/linux/sched.h |    7 ++++++-
 kernel/sched_rt.c     |    7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 949bd54..55d4bd4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1966,6 +1966,11 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
 	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
 }
 
+static inline int test_tsk_need_resched(struct task_struct *tsk)
+{
+	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
+}
+
 static inline int signal_pending(struct task_struct *p)
 {
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
@@ -1980,7 +1985,7 @@ static inline int fatal_signal_pending(struct task_struct *p)
 
 static inline int need_resched(void)
 {
-	return unlikely(test_thread_flag(TIF_NEED_RESCHED));
+	return unlikely(test_tsk_need_resched(current));
 }
 
 /*
diff --git a/kernel/sched_rt.c b/kernel/sched_rt.c
index 79e5ad5..ae6b0e6 100644
--- a/kernel/sched_rt.c
+++ b/kernel/sched_rt.c
@@ -1058,11 +1058,14 @@ static void post_schedule_rt(struct rq *rq)
 	}
 }
 
