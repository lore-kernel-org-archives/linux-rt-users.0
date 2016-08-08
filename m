From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Mon, 8 Aug 2016 18:45:05 +0200
Message-ID: <20160808164505.GA13707@linutronix.de>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Jens Koehler <jenskxxx@googlemail.com>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44641 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbcHHQpI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Aug 2016 12:45:08 -0400
Content-Disposition: inline
In-Reply-To: <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sebastian Andrzej Siewior | 2016-07-01 12:49:26 [+0200]:

tried your testcase and it didn't trigger in KVM. To get more
informations out of this I prepared a patch to assist you.

>> [137482.258011] hrtimer: interrupt took 9434 ns

For some reason you looped 3 times through the timer code. If you enable
`timer' events then you should see the "entry" point of the hrtimer irq
followed by hrtimer_expire_entry + hrtimer_expire_exit. Once you run
into that case you can look up your trace and examine which hrtimers
were involved and which took so long.

>> [178458.961966] NOHZ: local_softirq_pending 102
>> [178458.967583] NOHZ: local_softirq_pending 102
>> [178458.973295] NOHZ: local_softirq_pending 102
>> [178458.980249] NOHZ: local_softirq_pending 102
>> [178458.984994] NOHZ: local_softirq_pending 102
>> [178458.990582] NOHZ: local_softirq_pending 102
>> [178458.996292] NOHZ: local_softirq_pending 102
>> [178459.000348] [sched_delayed] sched: RT throttling activated

For those I would recommend the `sched' events. It should show you the
task switches before the NOHZ warning. It might give you a hint why the
scheduler picks the swapper/idle task rather than a task to process
sofitrqis.
Also one thing that comes to mind after I was testing it today: If you
trigger the "RT throttling" then you might see the NOHZ warning. The
timer-softirq might want to run as a softirq thread with RT priority
which won't be scheduled due to the throttling.

One more thing: Your config was from an earlier v3.14 kernel. I
recommend using a later v3.14.73-rt77 (if v3.14 is a must). The later
version has the timers softirq split out of the general softirq thread.
That means the "general" softirq thread which does napi won't run at RT
prio which means it will be excluded from the "RT throttling". We had
also some reports regarding oom, RCU stalls on small/slow CPUs which are
hit with a lot of network traffic (like a ping flood).

>> Jens

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1543,6 +1543,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 
 	raw_spin_lock(&cpu_base->lock);
 	entry_time = now = hrtimer_update_base(cpu_base);
+	trace_printk("entry: %llu\n", now.tv64);
 retry:
 	expires_next.tv64 = KTIME_MAX;
 	/*
@@ -1666,6 +1667,8 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	tick_program_event(expires_next, 1);
 	printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
 		    ktime_to_ns(delta));
+	trace_printk("time took: %llu\n", delta.tv64);
+	tracing_off();
 out:
 	if (raise)
 		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
diff --git a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -110,6 +110,7 @@ void softirq_check_pending_idle(void)
 	if (rate_limit >= 10)
 		return;
 
+	trace_printk("check\n");
 	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		struct task_struct *tsk = sr->runner[i];
@@ -134,6 +135,8 @@ void softirq_check_pending_idle(void)
 	if (warnpending) {
 		printk(KERN_ERR "NOHZ: local_softirq_pending %02x\n",
 		       warnpending);
+		trace_printk("NOHZ: %02x\n", warnpending);
+		tracing_off();
 		rate_limit++;
 	}
 }
-- 
2.8.1


Sebastian
