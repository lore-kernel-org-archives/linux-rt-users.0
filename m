From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 2/6] rtmutex: Make lock_killable work
Date: Mon, 7 Aug 2017 12:40:58 -0500
Message-ID: <20170807174102.5448-3-julia@ni.com>
References: <20170807174102.5448-1-julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <rt-stable@vger.kernel.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807174102.5448-1-julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.42-rt50-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
From: Thomas Gleixner <tglx@linutronix.de>

Locking an rt mutex killable does not work because signal handling is
restricted to TASK_INTERRUPTIBLE.

Use signal_pending_state() unconditionaly.

Cc: rt-stable@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 9edcb2cd71ff3684755f52129538260efa382789)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/locking/rtmutex.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index e0b0d9b419b5..3e45ceb862bd 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1511,18 +1511,13 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
 
-		/*
-		 * TASK_INTERRUPTIBLE checks for signals and
-		 * timeout. Ignored otherwise.
-		 */
-		if (unlikely(state == TASK_INTERRUPTIBLE)) {
-			/* Signal pending? */
-			if (signal_pending(current))
-				ret = -EINTR;
-			if (timeout && !timeout->task)
-				ret = -ETIMEDOUT;
-			if (ret)
-				break;
+		if (timeout && !timeout->task) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (signal_pending_state(state, current)) {
+			ret = -EINTR;
+			break;
 		}
 
 		if (ww_ctx && ww_ctx->acquired > 0) {
-- 
2.13.1
