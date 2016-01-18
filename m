From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Mon, 18 Jan 2016 10:08:23 +0100
Message-ID: <1453108103.4123.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38420 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbcARJI3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 04:08:29 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


pre:
preempt lazy enabled
homer:/root # taskset -c 7 pipe-test 1
2.618038 usecs/loop -- avg 2.618038 763.9 KHz
2.620658 usecs/loop -- avg 2.618300 763.9 KHz
2.618775 usecs/loop -- avg 2.618347 763.8 KHz
2.618819 usecs/loop -- avg 2.618395 763.8 KHz
2.619269 usecs/loop -- avg 2.618482 763.8 KHz

tbench
Throughput 2612.9 MB/sec 8 procs

preempt lazy disabled
homer:/root # taskset -c 7 pipe-test 1
1.771921 usecs/loop -- avg 1.771921 1128.7 KHz
1.782686 usecs/loop -- avg 1.772998 1128.0 KHz
1.785444 usecs/loop -- avg 1.774242 1127.2 KHz
1.787388 usecs/loop -- avg 1.775557 1126.4 KHz
1.770772 usecs/loop -- avg 1.775078 1126.7 KHz

tbench
Throughput 2626.91 MB/sec 8 procs

post:
preempt lazy enabled
homer:/root # taskset -c 7 pipe-test 1
1.485592 usecs/loop -- avg 1.485592 1346.3 KHz
1.489640 usecs/loop -- avg 1.485997 1345.9 KHz
1.488325 usecs/loop -- avg 1.486230 1345.7 KHz
1.484632 usecs/loop -- avg 1.486070 1345.8 KHz
1.484889 usecs/loop -- avg 1.485952 1345.9 KHz

tbench
Throughput 3091.84 MB/sec 8 procs

preempt lazy disabled
homer:/root # taskset -c 7 pipe-test 1
1.579723 usecs/loop -- avg 1.579723 1266.0 KHz
1.562026 usecs/loop -- avg 1.577953 1267.5 KHz
1.546090 usecs/loop -- avg 1.574767 1270.0 KHz
1.543852 usecs/loop -- avg 1.571675 1272.5 KHz
1.546313 usecs/loop -- avg 1.569139 1274.6 KHz

tbench
Throughput 2649.65 MB/sec 8 procs

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 arch/x86/entry/common.c |    4 ++--
 kernel/sched/core.c     |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -220,14 +220,14 @@ long syscall_trace_enter(struct pt_regs
 
 #define EXIT_TO_USERMODE_LOOP_FLAGS				\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY)
+	 _TIF_NEED_RESCHED_MASK | _TIF_USER_RETURN_NOTIFY)
 
 static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 {
 	/*
 	 * In order to return to user mode, we need to have IRQs off with
 	 * none of _TIF_SIGPENDING, _TIF_NOTIFY_RESUME, _TIF_USER_RETURN_NOTIFY,
-	 * _TIF_UPROBE, or _TIF_NEED_RESCHED set.  Several of these flags
+	 * _TIF_UPROBE, or _TIF_NEED_RESCHED_MASK set.  Several of these flags
 	 * can be set at any time on preemptable kernels if we have IRQs on,
 	 * so we need to loop.  Disabling preemption wouldn't help: doing the
 	 * work to clear some of the flags can sleep.
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3542,6 +3542,15 @@ asmlinkage __visible void __sched notrac
 	if (likely(!preemptible()))
 		return;
 
+#ifdef CONFIG_PREEMPT_LAZY
+	/*
+	 * Check for lazy preemption
+	 */
+	if (current_thread_info()->preempt_lazy_count &&
+	    !test_thread_flag(TIF_NEED_RESCHED))
+		return;
+#endif
+
 	preempt_schedule_common();
 }
 NOKPROBE_SYMBOL(preempt_schedule);
