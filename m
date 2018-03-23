From: joe.korty@concurrent-rt.com
Subject: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Date: Fri, 23 Mar 2018 11:09:59 -0400
Message-ID: <20180323150959.GA16131@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@redhat.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I see the below kernel splat in 4.9-rt when I run a test program that
continually changes the affinity of some set of running pids:

   do not call blocking ops when !TASK_RUNNING; state=2 set at ...
      ...
      stop_one_cpu+0x60/0x80
      migrate_enable+0x21f/0x3e0
      rt_spin_unlock+0x2f/0x40
      prepare_to_wait+0x5c/0x80
      ...

The reason is that spin_unlock, write_unlock, and read_unlock call
migrate_enable, and since 4.4-rt, migrate_enable will sleep if it discovers
that a migration is in order.  But sleeping in the unlock services is not
expected by most kernel developers, and where that counts most is in code
sequences like the following:

  set_current_state(TASK_UNINTERRUPIBLE);
  spin_unlock(&s);
  schedule();

Rather than try to fix up such expectations, this patch merely restores
the non-sleeping nature of unlocking by the simple expediate of deferring,
to a future migrate_enable, and actual migration-with-sleep operation,
for as long as migrate_enable sees task state != TASK_RUNNING.  This works
well as the kernel is littered with lock/unlock sequences, so if the
current unlock cannot migrate, another unlock will come along shortly
and it will do the deferred migration for us.

With this patch and a debug harness applied to 4.9.84-rt62, I get the
following results when a set of stress(1) threads have their affinities
randomly changes as fast as possible:

   [  111.331805] 6229(stress): migrate_enable() deferred.
   [  111.332112] 6229(stress): migrate_enable() deferral APPLIED.
   [  111.977399] 6231(stress): migrate_enable() deferred.
   [  111.977833] 6231(stress): migrate_enable() deferral APPLIED.
   [  135.240704] 6231(stress): migrate_enable() deferred.
   [  135.241164] 6231(stress): migrate_enable() deferral APPLIED.
   [  139.734616] 6229(stress): migrate_enable() deferred.
   [  139.736553] 6229(stress): migrate_enable() deferral APPLIED.
   [  156.441660] 6229(stress): migrate_enable() deferred.
   [  156.441709] 6229(stress): migrate_enable() deferral APPLIED.
   [  163.600191] 6231(stress): migrate_enable() deferred.
   [  163.600561] 6231(stress): migrate_enable() deferral APPLIED.
   [  181.593035] 6231(stress): migrate_enable() deferred.
   [  181.593136] 6231(stress): migrate_enable() deferral APPLIED.
   [  198.376387] 6229(stress): migrate_enable() deferred.
   [  198.376591] 6229(stress): migrate_enable() deferral APPLIED.
   [  202.355940] 6231(stress): migrate_enable() deferred.
   [  202.356939] 6231(stress): migrate_enable() deferral APPLIED.
   [  203.773164] 6229(stress): migrate_enable() deferred.
   [  203.773243] 6229(stress): migrate_enable() deferral APPLIED.
   ...

The test sequence used:

   stress --cpu 8 --io 1 --vm 2 &
   ./rotate $(ps -eLotid,comm | fgrep stress | awk '{print $1}')

The test program used:

cat <<EOF >rotate.c
/*
 * rotate.c
 * Randomly and rapidly change the affinity of some set of processes.
 * Does not return.
 * Limitations: Hard coded to use cpus 0-7.  May not work on systems
 * with more than 64 cpus.
 *
 * Usage: rotate pid pid ...
 *
 * Algorithm: In a loop, for each pid given, randomly select 2 of
 * the 8 cpus 37.5% of the time; otherwise, randomly select a
 * single cpu from that same set.
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sched.h>
#include <errno.h>

int pids[100000];
int npids;
int ncpus = 8;

int main(int argc, char **argv)
{
	int pid, cpu, status;
	unsigned long mask = 0;
	int i;

	setbuf(stdout, NULL);

	argc--,argv++;
	npids = argc;
	for(i=0; i<npids; i++) {
		pids[i] = atoi(argv[i]);
		if (!pids[i]) {
			fprintf(stderr, "tid #%d is bad\n", i);
			return 1;
		}
	}

	for(;;) {
		for(i=0; i<npids; i++) {
			cpu = (unsigned long long)rand() * ncpus / RAND_MAX;
			mask = 1U << cpu;
			if (rand() & 0x400) {
				cpu = (unsigned long long)rand() * ncpus / RAND_MAX;
				mask |= 1U << cpu;
			}
			pid = pids[i];
			status = sched_setaffinity(pid, sizeof(mask), (cpu_set_t *)&mask);
			if (status == -1) {
				fprintf(stderr, "sched_setaffinity(%d, 8, %016lx) failed\n", pid, mask);
				perror("sched_setaffinity");
				return 1;
			}
		}
	}
	return 0;
}
EOF

The debug patch used:

cat patches/debug <<EOF
    1	XXXXXXXX--- a/include/linux/sched.h
    2	XXXXXXXX+++ b/include/linux/sched.h
    3	XXXXXXXX@@ -1558,6 +1558,7 @@ struct task_struct {
    4	XXXXXXXX #ifdef CONFIG_PREEMPT_RT_FULL
    5	XXXXXXXX	int migrate_disable;
    6	XXXXXXXX	int migrate_disable_update;
    7	XXXXXXXX+	int migrate_enable_deferred;
    8	XXXXXXXX # ifdef CONFIG_SCHED_DEBUG
    9	XXXXXXXX	int migrate_disable_atomic;
   10	XXXXXXXX # endif
   11	XXXXXXXX--- a/kernel/sched/core.c
   12	XXXXXXXX+++ b/kernel/sched/core.c
   13	XXXXXXXX@@ -3468,6 +3468,12 @@ void migrate_enable(void)
   14	XXXXXXXX		struct rq *rq;
   15	XXXXXXXX		struct rq_flags rf;
   16	XXXXXXXX 
   17	XXXXXXXX+		if (p->migrate_enable_deferred) {
   18	XXXXXXXX+			p->migrate_enable_deferred = 0;
   19	XXXXXXXX+			pr_info("%d(%s): migrate_enable() deferral APPLIED.\n",
   20	XXXXXXXX+				p->pid, p->comm);
   21	XXXXXXXX+		}
   22	XXXXXXXX+
   23	XXXXXXXX		rq = task_rq_lock(p, &rf);
   24	XXXXXXXX		update_rq_clock(rq);
   25	XXXXXXXX 
   26	XXXXXXXX@@ -3499,6 +3505,15 @@ void migrate_enable(void)
   27	XXXXXXXX			tlb_migrate_finish(p->mm);
   28	XXXXXXXX			return;
   29	XXXXXXXX		}
   30	XXXXXXXX+	} else if (p->migrate_disable_update && p->state != TASK_RUNNING) {
   31	XXXXXXXX+		if (p->migrate_enable_deferred)
   32	XXXXXXXX+			pr_info("%d(%s): migrate_enable() deferred (again).\n",
   33	XXXXXXXX+				p->pid, p->comm);
   34	XXXXXXXX+		else {
   35	XXXXXXXX+			pr_info("%d(%s): migrate_enable() deferred.\n",
   36	XXXXXXXX+				p->pid, p->comm);
   37	XXXXXXXX+			p->migrate_enable_deferred = 1;
   38	XXXXXXXX+		}
   39	XXXXXXXX	}
   40	XXXXXXXX 
   41	XXXXXXXX	unpin_current_cpu();
EOF

The rt patch sched-migrate-disable-handle-updated-task-mask-mg-di.patch
appears to have introduced this issue, around the 4.4-rt timeframe.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/kernel/sched/core.c
===================================================================
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3457,7 +3457,14 @@ void migrate_enable(void)
 	 */
 	p->migrate_disable = 0;
 
-	if (p->migrate_disable_update) {
+	/*
+	 * Do not apply affinity update on this migrate_enable if task
+	 * is preparing to go to sleep for some other reason (eg, task
+	 * state == TASK_INTERRUPTIBLE).  Instead defer update to a
+	 * future migate_enable that is called when task state is again
+	 * == TASK_RUNNING.
+	 */
+	if (p->migrate_disable_update && p->state == TASK_RUNNING) {
 		struct rq *rq;
 		struct rq_flags rf;
 
