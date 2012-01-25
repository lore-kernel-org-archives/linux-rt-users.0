From: Mike Galbraith <efault@gmx.de>
Subject: Re: timerfd functions hang on both x86 and ARM with RT patch and
 RT scheduling policies
Date: Wed, 25 Jan 2012 09:03:38 +0100
Message-ID: <1327478618.6973.2.camel@marge.simson.net>
References: <CAFQPvXdTb-=oo8OC6MAa++X6u4ZoWM2XXmKog-WK6DPookJyvg@mail.gmail.com>
	 <CAFQPvXd13=B+mJGtoGLGuw4PXhBUgWVsxd7sS9PAN2oz+3HUcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:49569 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751104Ab2AYIDn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 03:03:43 -0500
In-Reply-To: <CAFQPvXd13=B+mJGtoGLGuw4PXhBUgWVsxd7sS9PAN2oz+3HUcQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-01-24 at 10:04 -0600, Sankara Muthukrishnan wrote:
> Hi,
> 
> I am trying to use timerfd feature with RT patch but the thread hangs
> (seems to busy-wait in the kernel) on a board with dual-core Cortex-A9
> ARM processor. Below is a table of the test results:
> 
> ------------------------------------------------------------------------------
> SCHED_FIFO, SCHED_RR   |  Priority = 1 | Fully Preemptible RT kernel | Works**
> SCHED_FIFO, SCHED_RR   |  Priority > 1 | Fully Preemptible RT kernel | Hangs*
> SCHED_FIFO, SCHED_RR   |  Any priority | Fully Preemptible RT kernel |
> Works when the test program is "strace"ed.
> SCHED_OTHER            |               | Fully Preemptible RT kernel | Works
> Any of the 3 policies  |  Any Priority | Low-latency Desktop kernel  | Works
> -----------------------------------------------------------------------------
> Works** : Ran around 50000 iterations and did not see a hang.
> Hangs* : Thread is busy running inside the kernel and cannot be
> killed. Most of the times "timerfd_settime" or the "read" that follows
> hangs. Very rarely, timerfd_create itself hangs. Hangs happen when the
> thread's CPU affinity is set to either core or affinity is not set at
> all. I have tried single core kernel also and that locks-up the entire
> system as well. Tried with and without high-resolution timers and both
> hang.
> 
> I have tried slightly older kernels with RT patch and also the latest
> stable 3.0.14-rt32 and the test program hangs on every kernel. I
> enabled several debug related options (PROVE_LOCKING, PROVE_RCU,
> DEBUG_LOCKDEP, RCU_CPU_STALL_VERBOSE, etc) and there is no extra splat
> except the one-line error "[  295.924804] INFO: rcu_preempt_state
> detected stall on CPU 1 (t=1920 jiffies)". Then, I tried "SysReq+t"
> and attached the output file "OutputOfSysReq_t.txt". Call-stack of the
> hanging thread:
> 
> [  312.152954] testTimerfd     R running      0  1359   1343 0x00000000
> [  312.159637] Backtrace:
> [  312.162231] [<c04fd1b0>] (__schedule+0x0/0x820) from [<c04fda14>]
> (preempt_schedule+0x44/0x64)
> [  312.171295] [<c04fd9d0>] (preempt_schedule+0x0/0x64) from
> [<c0500b7c>] (_raw_spin_unlock_irqrestore+0x68/0x78)
> [  312.181793]  r5:a0000113 r4:c129a728
> [  312.185577] [<c0500b14>] (_raw_spin_unlock_irqrestore+0x0/0x78)
> from [<c00c9558>] (hrtimer_try_to_cancel+0x54/0x1c0)
> [  312.196624]  r5:00000000 r4:00000003
> [  312.200408] [<c00c9504>] (hrtimer_try_to_cancel+0x0/0x1c0) from
> [<c01c6a08>] (sys_timerfd_settime+0x134/0x394)
> [  312.210906]  r7:00000161 r6:40048000 r5:00000000 r4:00000003
> [  312.216918] [<c01c68d4>] (sys_timerfd_settime+0x0/0x394) from
> [<c0063800>] (ret_fast_syscall+0x0/0x48)
> 
> I have also attached the source code of the test "testTimerfd.c" that
> can be used to reproduce this issue as below:
> 
> ./testTimerfd -n5 -p2 -t500 -sF -a1
>  strace -f -tt ./testTimerfd -n5 -p99 -t500 -sF -a1 2>strace.log
> 
> PS:I tried an x86 system (Nehalem/Arrandale processor) that has the RT
> kernel  3.0.1-rt11 SMP PREEMPT RT and I see the same behavior
> mentioned in the table above for ARM.
> 
> Any help to debug/fix this is highly appreciated.

We get stuck here.  The patch below (against 3.3-rt10) works for me.

(gdb) list *sys_timerfd_settime+0xe9
0xffffffff81161f89 is in sys_timerfd_settime (fs/timerfd.c:313).
308              * We need to stop the existing timer before reprogramming
309              * it to the new values.
310              */
311             for (;;) {
312                     spin_lock_irq(&ctx->wqh.lock);
313                     if (hrtimer_try_to_cancel(&ctx->tmr) >= 0)
314                             break;
315                     spin_unlock_irq(&ctx->wqh.lock);
316                     cpu_relax();
317             }
(gdb)

rt, timerfd: fix timerfd_settime() livelock

The caller of timerfd_settime() may be an RT task capable of starving
the kernel thread trying to execute the timer callback function.  Don't
spin, sleep instead.

Signed-off-by: Mike Galbraith <efault@gmx.de>

---
 fs/timerfd.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -23,6 +23,7 @@
 #include <linux/timerfd.h>
 #include <linux/syscalls.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 
 struct timerfd_ctx {
 	struct hrtimer tmr;
@@ -313,7 +314,16 @@ SYSCALL_DEFINE4(timerfd_settime, int, uf
 		if (hrtimer_try_to_cancel(&ctx->tmr) >= 0)
 			break;
 		spin_unlock_irq(&ctx->wqh.lock);
+#ifndef CONFIG_PREEMPT_RT_BASE
 		cpu_relax();
+#else
+		/*
+		 * Current may be an RT task with priority high enough
+		 * to prevent the thread currently _wanting_ to execute
+		 * the timer callback function from receiving the CPU.
+		 */
+		usleep_range(1, 10);
+#endif
 	}
 
 	/*


