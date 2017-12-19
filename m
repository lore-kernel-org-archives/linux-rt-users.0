From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.14-rt][report] arm: run: stress-ng --class os --all 0 -t 5m
Date: Tue, 19 Dec 2017 09:27:40 +0100
Message-ID: <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
References: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758287AbdLSI1p (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Dec 2017 03:27:45 -0500
Content-Disposition: inline
In-Reply-To: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-18 20:01:05 [-0600], Grygorii Strashko wrote:
> Hi All,
Hi,

> Below results of running stress-ng --class os --all 0 -t 5m on TI am57xx-evm (SMP, 2 cpu)
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
> branch: linux-4.14.y-rt
> commit: d3d9904 v4.14.6-rt7
> - only config changes applied.
> 
> one "WARNING: possible circular locking dependency detected"
> [   85.943562] ======================================================
> [   85.943564] WARNING: possible circular locking dependency detected
> [   85.943568] 4.14.6-rt7-dirty #29 Not tainted
> [   85.943570] ------------------------------------------------------
> [   85.943573] stress-ng-cpu-o/764 is trying to acquire lock:
> [   85.943576]  (&p->pi_lock){-...}, at: [<c0169ce8>] try_to_wake_up+0x28/0x924
> [   85.943594] 
> [   85.943594] but task is already holding lock:
> [   85.943596]  (hrtimer_bases.lock){-...}, at: [<c01c12ac>] hrtimer_interrupt+0x68/0x2b0
> 
> one "WARNING: CPU: 0 PID: 3514 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x3e8/0x988"
> ^ sorry, log not very readable

This should cure it, does it?

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c2c344fda487..3971fa0c7194 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1952,6 +1952,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	BUG_ON(cpu_online(scpu));
 	tick_cancel_sched_timer(scpu);
 
+	local_bh_disable();
 	local_irq_disable();
 	old_base = &per_cpu(hrtimer_bases, scpu);
 	new_base = this_cpu_ptr(&hrtimer_bases);
@@ -1979,6 +1980,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	/* Check, if we got expired work to do */
 	__hrtimer_peek_ahead_timers();
 	local_irq_enable();
+	local_bh_enable();
 	return 0;
 }

Sebastian
