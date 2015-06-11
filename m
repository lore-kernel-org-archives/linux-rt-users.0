From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [OSADL QA 3.18.9-rt5 #1]
Date: Thu, 11 Jun 2015 17:27:02 +0200
Message-ID: <20150611152702.GL16115@linutronix.de>
References: <55245FC8.9090509@osadl.org>
 <5526AE86.7030708@linutronix.de>
 <20150410123634.GA3057@linutronix.de>
 <20150513123427.2ff23a9a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carsten Emde <C.Emde@osadl.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57134 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbFKP1F (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 11:27:05 -0400
Content-Disposition: inline
In-Reply-To: <20150513123427.2ff23a9a@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2015-05-13 12:34:27 [-0400]:

>Found the bug. The above actually changes the code
>for !CONFIG_PREEMPT_RT_FULL. You still need to keep that
>
>	if (in_irq())
>
>check, otherwise you can call irq_work_tick() from softirq in non RT
>configs, which talking to Peter Zijlstra, is a no no.
>
>Note, my tests were failing on CONFIG_PREEMPT_LL (low latency).

This was removed by mistake. Obviously. I am adding the chunk back:

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1450,7 +1450,8 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
 #if defined(CONFIG_IRQ_WORK) && !defined(CONFIG_PREEMPT_RT_FULL)
-	irq_work_tick();
+	if (in_irq())
+		irq_work_tick();
 #endif
 	run_posix_cpu_timers(p);
 }

Sebastian
