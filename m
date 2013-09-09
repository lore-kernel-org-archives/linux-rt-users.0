From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/16] x86/mce: fix mce timer interval
Date: Mon, 09 Sep 2013 10:35:19 -0400
Message-ID: <20130909143534.516910911@goodmis.org>
References: <20130909143517.641735717@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Mike Galbraith <bitbucket@online.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-x86-mce-fix-mce-timer-interval.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Mike Galbraith <bitbucket@online.de>

Seems mce timer fire at the wrong frequency in -rt kernels since roughly
forever due to 32 bit overflow.  3.8-rt is also missing a multiplier.

Add missing us -> ns conversion and 32 bit overflow prevention.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[bigeasy: use ULL instead of u64 cast]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/mcheck/mce.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index c859bb4..e51191f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1171,7 +1171,7 @@ static enum hrtimer_restart mce_start_timer(struct hrtimer *timer)
 		*n = min(*n*2, round_jiffies_relative(check_interval*HZ));
 
 	hrtimer_forward(timer, timer->base->get_time(),
-			ns_to_ktime(jiffies_to_usecs(*n) * 1000));
+			ns_to_ktime(jiffies_to_usecs(*n) * 1000ULL));
 	return HRTIMER_RESTART;
 }
 
@@ -1452,7 +1452,7 @@ static void __mcheck_cpu_init_timer(void)
 	if (!*n)
 		return;
 
-	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(*n) * 1000),
+	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(*n) * 1000ULL),
 			       0 , HRTIMER_MODE_REL_PINNED);
 }
 
-- 
1.7.10.4
