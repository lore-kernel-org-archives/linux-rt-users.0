From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/4] rcu: Disable RCU_FAST_NO_HZ on RT
Date: Tue, 30 Oct 2012 20:29:12 -0400
Message-ID: <20121031002942.754450721@goodmis.org>
References: <20121031002910.195421780@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-rcu-Disable-RCU_FAST_NO_HZ-on-RT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

This uses a timer_list timer from the irq disabled guts of the idle
code. Disable it for now to prevent wreckage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable-rt@vger.kernel.org
---
 init/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index c06208b..87afda5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -474,7 +474,7 @@ config RCU_FANOUT_EXACT
 
 config RCU_FAST_NO_HZ
 	bool "Accelerate last non-dyntick-idle CPU's grace periods"
-	depends on NO_HZ && SMP
+	depends on NO_HZ && SMP && !PREEMPT_RT_FULL
 	default n
 	help
 	  This option causes RCU to attempt to accelerate grace periods
-- 
1.7.10.4
