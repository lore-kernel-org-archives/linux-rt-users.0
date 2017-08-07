From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 4/6] sched: Remove TASK_ALL
Date: Mon, 7 Aug 2017 12:41:00 -0500
Message-ID: <20170807174102.5448-5-julia@ni.com>
References: <20170807174102.5448-1-julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        <stable-rt@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807174102.5448-1-julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.42-rt50-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
From: Peter Zijlstra <peterz@infradead.org>

It's unused:

$ git grep "\<TASK_ALL\>" | wc -l
1

And dangerous, kill the bugger.

Cc: stable-rt@vger.kernel.org
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit a1762267d95649bddf6e94e7e3305e0207d0fff0)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d51525ce2c41..7587d6181cd2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -227,7 +227,6 @@ extern char ___assert_task_state[1 - 2*!!(
 
 /* Convenience macros for the sake of wake_up */
 #define TASK_NORMAL		(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL		(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state() */
 #define TASK_REPORT		(TASK_RUNNING | TASK_INTERRUPTIBLE | \
-- 
2.13.1
