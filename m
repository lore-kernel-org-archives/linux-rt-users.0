From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt] Fix races in ptrace
Date: Thu, 29 Aug 2013 18:33:00 +0200
Message-ID: <20130829163300.GC15360@linutronix.de>
References: <102271374683007@web8f.yandex.ru>
 <20130812164145.GJ23040@linutronix.de>
 <393831376342036@web15d.yandex.ru>
 <20130821172431.GD16913@linutronix.de>
 <96171377181398@web13h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Alexander Fyodorov <halcy@yandex.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51347 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab3H2QdB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Aug 2013 12:33:01 -0400
Content-Disposition: inline
In-Reply-To: <96171377181398@web13h.yandex.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Alexander Fyodorov | 2013-08-22 18:23:18 [+0400]:

>This was the first thing I tried but it did not work. ptrace_check_attach() passes TASK_TRACED to wait_task_inactive() which tests for equality:
>
>unsigned long wait_task_inactive(struct task_struct *p, long match_state)
>< ... >
>                        if (match_state && unlikely(p->state != match_state)
>                            && unlikely(p->saved_state != match_state)) {
>
>But this test will fail because we've added TASK_UNINTERRUPTIBLE and possibly removed some other bits from p->state. So I decided to add pi_lock locking instead - it is slower but it works with 100% guarantee.
>
>Also adding __TASK_TRACED does not help with all the other places where saved_state is checked and more races might still be hidden.

I'm tempted to add this:

---
 include/linux/sched.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e0a05de..bd60b9d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -175,7 +175,6 @@ extern char ___assert_task_state[1 - 2*!!(
 				 TASK_UNINTERRUPTIBLE | __TASK_STOPPED | \
 				 __TASK_TRACED)
 
-#define task_is_traced(task)	((task->state & __TASK_TRACED) != 0)
 #define task_is_stopped(task)	((task->state & __TASK_STOPPED) != 0)
 #define task_is_dead(task)	((task)->exit_state != 0)
 #define task_is_stopped_or_traced(task)	\
@@ -2532,6 +2531,24 @@ static inline int signal_pending_state(long state, struct task_struct *p)
 	return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
 }
 
+static inline bool task_is_traced(struct task_struct *task)
+{
+	bool traced = false;
+
+	if (task->state & __TASK_TRACED)
+		return true;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	/* in case the task is sleeping on tasklist_lock */
+	raw_spin_lock_irq(&task->pi_lock);
+	if (task->state & __TASK_TRACED)
+		traced = true;
+	else if (task->saved_state & __TASK_TRACED)
+		traced = true;
+	raw_spin_unlock_irq(&task->pi_lock);
+#endif
+	return traced;
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return

to the next v3.10-rt release. I tested this with:

--- cat ptrace-test.c ---

#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <sys/time.h>
#include <sys/resource.h>

#define NUM_CHILD       5
#define LOCK_CHILD      3

static pid_t pids[NUM_CHILD];

static void play(void)
{
	pid_t pid;
	int ret;

	pid = getpid();
	fprintf(stderr, "%s(%d) ready\n", __func__, pid);
	ret = ptrace(PTRACE_TRACEME, 0, NULL, 0);
	if (ret) {
		fprintf(stderr, "ERR %d: %m\n", pid);
		return;
	}
	do {
		kill(pid, SIGUSR1);
	} while (1);
}

static void kill_kids(void)
{
	int i;

	for (i = 0; i < NUM_CHILD; i++)  {
		if (pids[i])
			kill(pids[i], SIGKILL);
	}
}

static void get_prio_fork(void)
{
	pid_t pid;
	int i;

	pid = fork();
	if (pid < 0) {
		fprintf(stderr, "fork(): %m\n");
		exit(1);
	}
	if (pid)
		return;
	do  {
		for (i = 0; i < NUM_CHILD; i++) {
			int ret;

			ret = getpriority(PRIO_PROCESS, pids[i]);
			if (ret < 0) {
				printf("=> %m %d\n", pids[i]);
				exit(1);
			}
		}
	} while(1);
	exit(0);
}

int main(void)
{
	int i;


	for (i = 0; i < NUM_CHILD; i++) {
		pid_t pid;

		pid = fork();
		if (pid < 0) {
			fprintf(stderr, "Fork error: %m\n");
			kill_kids();
			exit(1);
		}
		if (pid == 0) {
			play();
			exit(0);
		}
		pids[i] = pid;
	}

	for (i = 0; i < LOCK_CHILD; i++)
		get_prio_fork();

	do {
		for (i = 0; i < NUM_CHILD; i++) {
			int ret;

			ret = waitpid(pids[i], NULL, 0);
			if (ret < 0) {
				fprintf(stderr, "%s(2) %d / %d %m\n", __func__,
						pids[i], ret);
				exit(1);
			}
			ret = ptrace(PTRACE_CONT, pids[i], NULL, 0);
			if (ret) {
				fprintf(stderr, "%s(3) %d / %d %m\n", __func__,
						pids[i], ret);
				ret = kill(pids[i], 0);
				if (!ret)
					fprintf(stderr, "process is available\n");
				exit(1);
			}
		}
	} while(1);
	return 0;
}

--- cat end ---

and it seems to work. Any comments?

Sebastian
