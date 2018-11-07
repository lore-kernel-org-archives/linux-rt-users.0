From: Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to check_dl_overrun
Date: Wed,  7 Nov 2018 12:10:32 +0100
Message-ID: <20181107111032.32291-1-juri.lelli@redhat.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, bristot@redhat.com,
        linux-rt-users@vger.kernel.org, mtk.manpages@gmail.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org, mingo@redhat.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

check_dl_overrun is used to send a SIGXCPU to users that asked to be
informed when SCHED_DEADLINE runtime overruns occur.

The function is called by check_thread_timers already, so the call in
check_process_timers is redundant/wrong (even though harmless).

Remove it.

Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 kernel/time/posix-cpu-timers.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ce32cf741b25..8f0644af40be 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
 	struct task_cputime cputime;
 	unsigned long soft;
 
-	if (dl_task(tsk))
-		check_dl_overrun(tsk);
-
 	/*
 	 * If cputimer is not running, then there are no active
 	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
-- 
2.17.2
