From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 01/15] sched: Remove TASK_ALL
Date: Thu,  2 Aug 2018 17:25:16 -0500
Message-ID: <1d817df77591ec6164ee3868cc1e3c0d2b2331d5.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com,
        Peter Zijlstra <peterz@infradead.org>,
        stable-rt@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

It's unused:

$ git grep "\<TASK_ALL\>" | wc -l
1

And dangerous, kill the bugger.

Cc: stable-rt@vger.kernel.org
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit ffb940123ed607f1cba0d1f7c281ca92feac9733)
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	include/linux/sched.h
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cc7349a2c0cf..fbe198d733c2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -228,7 +228,6 @@ extern char ___assert_task_state[1 - 2*!!(
 
 /* Convenience macros for the sake of wake_up */
 #define TASK_NORMAL		(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL		(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state() */
 #define TASK_REPORT		(TASK_RUNNING | TASK_INTERRUPTIBLE | \
-- 
2.14.1
