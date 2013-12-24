From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: 3.12.6-rt9 build failure
Date: Tue, 24 Dec 2013 16:15:26 +0100
Message-ID: <20131224151526.GA19732@opentech.at>
References: <20131223225017.GA8623@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:51369 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab3LXPPa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Dec 2013 10:15:30 -0500
Content-Disposition: inline
In-Reply-To: <20131223225017.GA8623@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi !

in 3.12.6-rt9:
 patch timers-do-not-raise-softirq-unconditionally.patch
 fails compile test for: 
  CONFIG_PREEMPT_RT_BASE=y
  # CONFIG_PREEMPT_RT_FULL is not set
 full config with seed 0xE3A03BD0.

<snip>
  CC      kernel/timer.o
kernel/timer.c: In function 'run_local_timers':
kernel/timer.c:1463: error: implicit declaration of function 'spin_do_trylock'
kernel/timer.c:1474: error: implicit declaration of function 'rt_spin_unlock_after_trylock_in_irq'
make[1]: *** [kernel/timer.o] Error 1
make: *** [kernel] Error 2

 ... RT specific API not ifdef'ed, a brute force ifdefification "fix" below

 But what this might actually point to is that testing of patches with RT off 
 (and other configs ?) is being neglected a bit. rt6 also had a problem (seed
 was 0xBE96A834 file:kernel/rtmutex.c:__mutex_lock_check_stamp:1007)

 maybe a set of minimum test-configs should be defined to atleast catch 
 build-failurs. 

thx!
hofrat

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 kernel/timer.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 46467be..88951cb 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1452,9 +1452,13 @@ static void run_timer_softirq(struct softirq_action *h)
  */
 void run_local_timers(void)
 {
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct tvec_base *base = __this_cpu_read(tvec_bases);
+#endif
 
 	hrtimer_run_queues();
+
+#ifdef CONFIG_PREEMPT_RT_FULL
 	/*
 	 * We can access this lockless as we are in the timer
 	 * interrupt. If there are no timers queued, nothing to do in
@@ -1472,7 +1476,9 @@ void run_local_timers(void)
 		raise_softirq(TIMER_SOFTIRQ);
 out:
 	rt_spin_unlock_after_trylock_in_irq(&base->lock);
