From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 07/13] rcu: make RCU_BOOST default on RT without EXPERT
Date: Mon, 07 Jan 2019 14:52:59 -0500
Message-ID: <20190107195332.915976523@goodmis.org>
References: <20190107195252.599921907@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 78cab7cb632b6a4c84e78e4f12bb9e83c09b8885 ]

Paul E. McKenney suggested to allow enabling RCU_BOOST on RT without the
need to go through the EXPERT option first.

Suggeted-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/rcu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 0be2c96fb640..a243a78ff38c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -36,7 +36,7 @@ config TINY_RCU
 
 config RCU_EXPERT
 	bool "Make expert-level adjustments to RCU configuration"
-	default y if PREEMPT_RT_FULL
+	default n
 	help
 	  This option needs to be enabled if you wish to make
 	  expert-level adjustments to RCU configuration.  By default,
@@ -190,7 +190,7 @@ config RCU_FAST_NO_HZ
 
 config RCU_BOOST
 	bool "Enable RCU priority boosting"
-	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
+	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT_FULL
 	default y if PREEMPT_RT_FULL
 	help
 	  This option boosts the priority of preempted RCU readers that
-- 
2.19.2
