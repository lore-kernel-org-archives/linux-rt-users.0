From: Darren Hart <dvhltc@us.ibm.com>
Subject: [PATCH] futex: Fix handling of bad requeue syscall pairing
Date: Fri, 07 Aug 2009 14:45:18 -0700
Message-ID: <4A7CA06E.1090904@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>, John Kacur <jkacur@redhat.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	John Stultz <johnstul@linux.vnet.ibm.com>
To: "lkml, " <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:51805 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbZHGVpZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Aug 2009 17:45:25 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Darren Hart <dvhltc@us.ibm.com>

If futex_requeue(requeue_pi=1) finds a futex_q that was created by a call
other than futex_wait_requeue_pi(), the q.rt_waiter will be null.  If so,
this will result in an oops from the following call graph:

futex_requeue()
  rt_mutex_start_proxy_lock()
    task_blocks_on_rt_mutex()
      waiter->task dereference
        OOPS

We currently WARN_ON() if this is detected, clearly this is inadequate.
If we detect a mis-pairing in futex_requeue(), bail out, sending -EINVAL
to user-space.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>
CC: Eric Dumazet <eric.dumazet@gmail.com>
CC: John Kacur <jkacur@redhat.com>
CC: Dinakar Guniguntala <dino@in.ibm.com>
CC: John Stultz <johnstul@us.ibm.com>
---

 kernel/futex.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)


diff --git a/kernel/futex.c b/kernel/futex.c
index 578c7b7..d806d6c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1306,8 +1306,15 @@ retry_private:
 		if (!match_futex(&this->key, &key1))
 			continue;
 
-		WARN_ON(!requeue_pi && this->rt_waiter);
-		WARN_ON(requeue_pi && !this->rt_waiter);
+		/*
+		 * FUTEX_WAIT_REQEUE_PI and FUTEX_CMP_REQUEUE_PI should always
+		 * be paired with each other and no other futex ops.
+		 */
+		if (requeue_pi && !this->rt_waiter ||
+		    !requeue_pi && this->rt_waiter) {
+			ret = -EINVAL;
+			break;
+		}
 
 		/*
 		 * Wake nr_wake waiters.  For requeue_pi, if we acquired the
-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
