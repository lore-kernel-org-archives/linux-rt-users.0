From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 1/4] rtmutex: Make lock_killable work
Date: Sat, 01 Apr 2017 12:50:59 +0200
Message-ID: <20170401112758.051867031@linutronix.de>
References: <20170401105058.958246042@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: RT-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Wargreen <wargreen@lebib.org>,
        rt-stable@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44104 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbdDALcE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 1 Apr 2017 07:32:04 -0400
Content-Disposition: inline; filename=rtmutex-Make-lock_killable-work.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Locking an rt mutex killable does not work because signal handling is
restricted to TASK_INTERRUPTIBLE.

Use signal_pending_state() unconditionaly.

Cc: rt-stable@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1633,18 +1633,13 @@ static int __sched
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


