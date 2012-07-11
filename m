From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch RT 3/7] Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
Date: Wed, 11 Jul 2012 22:05:18 -0000
Message-ID: <20120711215611.837510935@linutronix.de>
References: <20120711214552.036760674@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=disable-rt_group_sched-in-preempt_rt_full.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Strange CPU stalls have been observed in RT when RT_GROUP_SCHED
was configured.

Disable it for now.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-3.4.4-rt13-64+/init/Kconfig
===================================================================
--- linux-3.4.4-rt13-64+.orig/init/Kconfig
+++ linux-3.4.4-rt13-64+/init/Kconfig
@@ -746,6 +746,7 @@ config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
 	depends on EXPERIMENTAL
 	depends on CGROUP_SCHED
+	depends on !PREEMPT_RT_FULL
 	default n
 	help
 	  This feature lets you explicitly allocate real CPU bandwidth
