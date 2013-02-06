From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/6] sched: Init idle->on_rq in init_idle()
Date: Wed, 06 Feb 2013 17:02:13 -0500
Message-ID: <20130206220251.112259505@goodmis.org>
References: <20130206220210.823160521@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-sched-Init-idle-on_rq-in-init_idle.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched.c b/kernel/sched.c
index b318b4a..20b228f 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -6519,6 +6519,7 @@ void __cpuinit init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->curr = rq->idle = idle;
+	idle->on_rq = 1;
 #if defined(CONFIG_SMP)
 	idle->on_cpu = 1;
 #endif
-- 
1.7.10.4
