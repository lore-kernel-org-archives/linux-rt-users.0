From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/15] posixtimer: init timer only with CONFIG_POSIX_TIMERS enabled
Date: Fri, 01 Dec 2017 10:48:41 -0500
Message-ID: <20171201154912.020530885@goodmis.org>
References: <20171201154837.379265211@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-posixtimer-init-timer-only-with-CONFIG_POSIX_TIMERS-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In v4.11 it is possible to disable the posix timers and so we must not
attempt to initialize the task_struct on RT with !POSIX_TIMERS.
This patch does so.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/init_task.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index a56e263f5005..526ecfc58909 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -150,7 +150,7 @@ extern struct task_group root_task_group;
 # define INIT_PERF_EVENTS(tsk)
 #endif
 
-#ifdef CONFIG_PREEMPT_RT_BASE
+#if defined(CONFIG_POSIX_TIMERS) && defined(CONFIG_PREEMPT_RT_BASE)
 # define INIT_TIMER_LIST		.posix_timer_list = NULL,
 #else
 # define INIT_TIMER_LIST
-- 
2.13.2
