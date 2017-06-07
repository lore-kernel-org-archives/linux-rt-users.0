From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] v4.9.30-rt21
Date: Wed, 7 Jun 2017 22:28:49 +0200
Message-ID: <20170607202849.ue6x5jkgasprjtbz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.9.30-rt21 patch set. 

Changes since v4.9.30-rt20:

  - gdb. While gdb is following a task was is possible that after a
    fork() operation the task was waiting for gdb and gdb waiting for
    the task. Reported by Mathias Koehrer and David Hauck. Patched by
    Thomas Gleixner.

  - Since the change above the define TASK_ALL remains unused and got
    removed by Peter Zijlstra.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against v4.9.30-rt20 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.30-rt20-rt21.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.9.30-rt21

The RT patch against v4.9.30 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patch-4.9.30-rt21.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/patches-4.9.30-rt21.tar.xz

Sebastian

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e010fb4d640d..4d779486ad6b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -237,7 +237,6 @@ extern char ___assert_task_state[1 - 2*!!(
 
 /* Convenience macros for the sake of wake_up */
 #define TASK_NORMAL		(TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE)
-#define TASK_ALL		(TASK_NORMAL | __TASK_STOPPED | __TASK_TRACED)
 
 /* get_task_state() */
 #define TASK_REPORT		(TASK_RUNNING | TASK_INTERRUPTIBLE | \
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 30b24f774198..10e832da70b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2284,7 +2284,7 @@ EXPORT_SYMBOL(wake_up_process);
  */
 int wake_up_lock_sleeper(struct task_struct *p)
 {
-	return try_to_wake_up(p, TASK_ALL, WF_LOCK_SLEEPER);
+	return try_to_wake_up(p, TASK_UNINTERRUPTIBLE, WF_LOCK_SLEEPER);
 }
 
 int wake_up_state(struct task_struct *p, unsigned int state)
diff --git a/localversion-rt b/localversion-rt
index e095ab819714..6c6cde1c29e3 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt20
+-rt21
