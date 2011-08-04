From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Thu, 04 Aug 2011 11:42:45 +0200
Message-ID: <1312450965.16729.7.camel@twins>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
	 <4E3A3D7C.6050403@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57408 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1HDJnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Aug 2011 05:43:24 -0400
In-Reply-To: <4E3A3D7C.6050403@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-08-03 at 23:34 -0700, Fernando Lopez-Lezcano wrote:
> [  117.026009]  [<ffffffff814ef322>] _raw_spin_lock+0x45/0x79
> [  117.026009]  [<ffffffff8107b6f1>] ? __run_posix_cpu_timers+0x8f/0x353
> [  117.026009]  [<ffffffff8107b6f1>] __run_posix_cpu_timers+0x8f/0x353 

I think its this one, could you confirm?

---
Index: linux-2.6/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.orig/kernel/posix-cpu-timers.c
+++ linux-2.6/kernel/posix-cpu-timers.c
@@ -1288,10 +1288,11 @@ static inline int fastpath_timer_check(s
 	sig = tsk->signal;
 	if (sig->cputimer.running) {
 		struct task_cputime group_sample;
+		unsigned long flags;
 
-		raw_spin_lock(&sig->cputimer.lock);
+		raw_spin_lock_irqsave(&sig->cputimer.lock, flags);
 		group_sample = sig->cputimer.cputime;
-		raw_spin_unlock(&sig->cputimer.lock);
+		raw_spin_unlock_irqrestore(&sig->cputimer.lock, flags);
 
 		if (task_cputime_expired(&group_sample, &sig->cputime_expires))
 			return 1;

