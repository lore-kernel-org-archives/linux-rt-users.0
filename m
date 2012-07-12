From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/8] Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
Date: Thu, 12 Jul 2012 19:18:30 -0400
Message-ID: <20120712231956.179265047@goodmis.org>
References: <20120712231827.084920483@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-Disable-RT_GROUP_SCHED-in-PREEMPT_RT_FULL.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Carsten Emde <C.Emde@osadl.org>

Strange CPU stalls have been observed in RT when RT_GROUP_SCHED
was configured.

Disable it for now.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index dbc82d0..720c182 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -731,6 +731,7 @@ config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
 	depends on EXPERIMENTAL
 	depends on CGROUP_SCHED
+	depends on !PREEMPT_RT_FULL
 	default n
 	help
 	  This feature lets you explicitly allocate real CPU bandwidth
-- 
1.7.10.4
