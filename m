From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 19/25][RFC 3.0.23-rt39-rc1] timer: Fix hotplug for -rt
Date: Tue, 06 Mar 2012 11:16:55 -0500
Message-ID: <20120306161950.996376388@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14866 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab2CFQTx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 11:19:53 -0500
Content-Disposition: inline; filename=0019-timer-Fix-hotplug-for-rt.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Steven Rostedt <rostedt@goodmis.org>

Revert the RT patch:
    Author: Ingo Molnar <mingo@elte.hu>
    Date:   Fri Jul 3 08:30:32 2009 -0500
    timers: fix timer hotplug on -rt

    Here we are in the CPU_DEAD notifier, and we must not sleep nor
    enable interrupts.

There's no problem with sleeping in this notifier.

But the get_cpu_var() had to be converted to a get_local_var().

Replace the previous fix with the get_local_var() convert.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clark Williams <clark.williams@gmail.com>
Cc: stable-rt@vger.kernel.org
Link: http://lkml.kernel.org/r/20120301190344.948157137@goodmis.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/timer.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 937799f..a319c6a 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1743,21 +1743,17 @@ static void __cpuinit migrate_timers(int cpu)
 {
 	struct tvec_base *old_base;
 	struct tvec_base *new_base;
-	unsigned long flags;
 	int i;
 
 	BUG_ON(cpu_online(cpu));
 	old_base = per_cpu(tvec_bases, cpu);
-	new_base = get_cpu_var(tvec_bases);
+	new_base = get_local_var(tvec_bases);
 	/*
 	 * The caller is globally serialized and nobody else
 	 * takes two locks at once, deadlock is not possible.
 	 */
-	local_irq_save(flags);
-	while (!spin_trylock(&new_base->lock))
-		cpu_relax();
-	while (!spin_trylock(&old_base->lock))
-		cpu_relax();
+	spin_lock_irq(&new_base->lock);
+	spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 	BUG_ON(old_base->running_timer);
 
@@ -1771,10 +1767,8 @@ static void __cpuinit migrate_timers(int cpu)
 	}
 
 	spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
-	local_irq_restore(flags);
