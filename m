From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] v4.4.3-rt9
Date: Mon, 29 Feb 2016 15:27:40 +0100
Message-ID: <1456756060.3488.120.camel@gmail.com>
References: <alpine.DEB.2.11.1602291212180.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37621 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbcB2O1o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 09:27:44 -0500
In-Reply-To: <alpine.DEB.2.11.1602291212180.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-02-29 at 13:46 +0100, Thomas Gleixner wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v4.4.3-rt9 patch set. v4.4.2-rt7 and v4.4.3-rt8
> are non-announced updates to incorporate the linux-4.4.y stable tree.
> 
> There is one change caused by the 4.4.3 update:
> 
>   The relaxed handling of dump_stack() on RT has been dropped as there is
>   actually a potential deadlock lurking around the corner. See: commit
>   d7ce36924344 upstream. This does not effect the other facilities which
>   gather stack traces.

Hrm.  I had rolled that dropped bit forward as below.  I was given
cause to do a very large pile of ltp oom4 testing (rt kernels will
livelock due to waitqueue workers waiting for kthreadd to get memory to
spawn a kworker thread, while stuck kworker holds manager mutex, unless
workers are run as rt tasks to keep us from getting that depleted in
the first place), which gives it oodles of exercise, and all _seemed_
well.  Only seemed?

--- a/lib/dump_stack.c	2016-02-29 14:20:29.512510444 +0100
+++ b/lib/dump_stack.c	2016-02-26 13:03:15.755297038 +0100
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/atomic.h>
+#include <linux/locallock.h>
 
 static void __dump_stack(void)
 {
@@ -22,6 +23,7 @@ static void __dump_stack(void)
  */
 #ifdef CONFIG_SMP
 static atomic_t dump_lock = ATOMIC_INIT(-1);
+static DEFINE_LOCAL_IRQ_LOCK(dump_stack_irq_lock);
 
 asmlinkage __visible void dump_stack(void)
 {
@@ -35,7 +37,7 @@ asmlinkage __visible void dump_stack(voi
 	 * against other CPUs
 	 */
 retry:
-	local_irq_save(flags);
+	local_lock_irqsave(dump_stack_irq_lock, flags);
 	cpu = smp_processor_id();
 	old = atomic_cmpxchg(&dump_lock, -1, cpu);
 	if (old == -1) {
@@ -43,7 +45,7 @@ retry:
 	} else if (old == cpu) {
 		was_locked = 1;
 	} else {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(dump_stack_irq_lock, flags);
 		cpu_relax();
 		goto retry;
 	}
@@ -53,7 +55,7 @@ retry:
 	if (!was_locked)
 		atomic_set(&dump_lock, -1);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(dump_stack_irq_lock, flags);
 }
 #else
 asmlinkage __visible void dump_stack(void)
