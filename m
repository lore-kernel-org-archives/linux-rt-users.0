From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/12] Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
Date: Tue, 17 Jul 2012 11:31:18 -0400
Message-ID: <20120717153243.155128585@goodmis.org>
References: <20120717153115.606116459@goodmis.org>
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
index 7c0b369..c06208b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -746,6 +746,7 @@ config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
 	depends on EXPERIMENTAL
 	depends on CGROUP_SCHED
+	depends on !PREEMPT_RT_FULL
 	default n
 	help
 	  This feature lets you explicitly allocate real CPU bandwidth
-- 
1.7.10.4
