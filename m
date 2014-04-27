From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] rcu: make RCU_BOOST default on RT
Date: Sun, 27 Apr 2014 10:39:27 -0400
Message-ID: <20140427143941.009834783@goodmis.org>
References: <20140427143925.177486597@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-rcu-make-RCU_BOOST-default-on-RT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.2.57-rt84-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Since it is no longer invoked from the softirq people run into OOM more
often if the priority of the RCU thread is too low. Making boosting
default on RT should help in those case and it can be switched off if
someone knows better.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index aa6545f..c16e1f3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -494,7 +494,7 @@ config TREE_RCU_TRACE
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
 	depends on RT_MUTEXES && PREEMPT_RCU
-	default n
+	default y if PREEMPT_RT_FULL
 	help
 	  This option boosts the priority of preempted RCU readers that
 	  block the current preemptible RCU grace period for too long.
-- 
1.8.5.3
