From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/8] sched: Remove TASK_ALL
Date: Tue, 21 Nov 2017 11:06:59 -0500
Message-ID: <20171121160706.405135518@goodmis.org>
References: <20171121160654.493640386@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-sched-Remove-TASK_ALL.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.4.97-rt111-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

It's unused:

$ git grep "\<TASK_ALL\>" | wc -l
1

And dangerous, kill the bugger.

Cc: stable-rt@vger.kernel.org
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b7b001e26509..56ccd0a3dd49 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -234,7 +234,6 @@ extern char ___assert_task_state[1 - 2*!!(
 
 /* Convenience macros for the sake of wake_up */
 #define TASK_NORMAL		(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL		(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state() */
 #define TASK_REPORT		(TASK_RUNNING | TASK_INTERRUPTIBLE | \
-- 
2.13.2
