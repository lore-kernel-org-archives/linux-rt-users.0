From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/5] sched: Init idle->on_rq in init_idle()
Date: Wed, 06 Feb 2013 17:06:11 -0500
Message-ID: <20130206220632.630508314@goodmis.org>
References: <20130206220608.862416001@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:3920 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194Ab3BFWGe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 17:06:34 -0500
Content-Disposition: inline; filename=0003-sched-Init-idle-on_rq-in-init_idle.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched.c b/kernel/sched.c
index 858f5df..53b78f0 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -6139,6 +6139,7 @@ void __cpuinit init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->curr = rq->idle = idle;
+	idle->on_rq = 1;
 #if defined(CONFIG_SMP)
 	idle->on_cpu = 1;
 #endif
-- 
1.7.10.4


