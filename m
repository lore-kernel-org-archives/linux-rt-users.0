From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] hrtimer: Raise softirq if hrtimer irq stalled
Date: Tue, 30 Oct 2012 20:29:11 -0400
Message-ID: <20121031002942.598393114@goodmis.org>
References: <20121031002910.195421780@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-hrtimer-Raise-softirq-if-hrtimer-irq-stalled.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Watanabe <shunsuke.watanabe@tel.com>

When the hrtimer stall detection hits the softirq is not raised.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
---
 kernel/hrtimer.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 8b3d423..9114899 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1527,11 +1527,7 @@ retry:
 	if (expires_next.tv64 == KTIME_MAX ||
 	    !tick_program_event(expires_next, 0)) {
 		cpu_base->hang_detected = 0;
-
-		if (raise)
-			raise_softirq_irqoff(HRTIMER_SOFTIRQ);
-
-		return;
+		goto out;
 	}
 
 	/*
@@ -1575,6 +1571,9 @@ retry:
 	tick_program_event(expires_next, 1);
 	printk_once(KERN_WARNING "hrtimer: interrupt took %llu ns\n",
 		    ktime_to_ns(delta));
+out:
+	if (raise)
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
 
 /*
-- 
1.7.10.4
