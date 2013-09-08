From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/19] x86/mce: fix mce timer interval
Date: Sun, 08 Sep 2013 11:13:57 -0400
Message-ID: <20130908151445.962814337@goodmis.org>
References: <20130908151355.362583092@goodmis.org>
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
 arch/x86/kernel/cpu/mcheck/mce.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index e31ea90..339bb4d0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1649,7 +1649,7 @@ static void __mcheck_cpu_init_timer(void)
 	__this_cpu_write(mce_next_interval, iv);
 	if (!iv)
 		return;
-	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(iv) * 1000),
+	hrtimer_start_range_ns(t, ns_to_ktime(jiffies_to_usecs(iv) * 1000ULL),
 			       0, HRTIMER_MODE_REL_PINNED);
 }
 
-- 
1.7.10.4
