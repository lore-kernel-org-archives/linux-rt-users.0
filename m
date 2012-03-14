From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/7] rt: Introduce cpu_chill()
Date: Tue, 13 Mar 2012 22:27:01 -0400
Message-ID: <20120314022945.018782675@goodmis.org>
References: <20120314022658.783312660@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-rt-Introduce-cpu_chill.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Retry loops on RT might loop forever when the modifying side was
preempted. Add cpu_chill() to replace cpu_relax(). cpu_chill()
defaults to cpu_relax() for non RT. On RT it puts the looping task to
sleep for a tick so the preempted task can make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/delay.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index a6ecb34..e23a7c0 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -52,4 +52,10 @@ static inline void ssleep(unsigned int seconds)
 	msleep(seconds * 1000);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+# define cpu_chill()	msleep(1)
+#else
+# define cpu_chill()	cpu_relax()
+#endif
+
 #endif /* defined(_LINUX_DELAY_H) */
-- 
1.7.8.3
