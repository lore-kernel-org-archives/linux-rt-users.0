From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] rcu: update: make RCU_EXPEDITE_BOOT default
Date: Wed, 2 Nov 2016 17:30:02 +0100
Message-ID: <20161102163002.igni3zdnid535nou@linutronix.de>
References: <20161012162114.GA9362@jcartwri.amer.corp.natinst.com>
 <20161012124956.3cb5f988@redhat.com>
 <20161012171553.GA18392@jcartwri.amer.corp.natinst.com>
 <20161012203223.GK29518@linux.vnet.ibm.com>
 <20161013191332-mutt-send-email-mst@kernel.org>
 <20161014092050.GW29518@linux.vnet.ibm.com>
 <20161016044420-mutt-send-email-mst@kernel.org>
 <20161016112846.GR29518@linux.vnet.ibm.com>
 <20161031173852.a3ji7hhgjis5l3u4@linutronix.de>
 <20161031181543.GN3716@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161031181543.GN3716@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

RCU_EXPEDITE_BOOT should speed up the boot process by enforcing
synchronize_rcu_expedited() instead of synchronize_rcu() during the boot
process. There should be no reason why one does not want this and there
is no need worry about real time latency at this point.
Therefore make it default.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Checked on two boxes and synchronize_rcu() was invoked four times before
it reached rcu_end_inkernel_boot()

 init/Kconfig        | 13 -------------
 kernel/rcu/update.c |  6 ++----
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index b6c9166d878a..fe51bd3bbc61 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -771,19 +771,6 @@ config RCU_NOCB_CPU_ALL
 
 endchoice
 
-config RCU_EXPEDITE_BOOT
-	bool
-	default n
-	help
-	  This option enables expedited grace periods at boot time,
-	  as if rcu_expedite_gp() had been invoked early in boot.
-	  The corresponding rcu_unexpedite_gp() is invoked from
-	  rcu_end_inkernel_boot(), which is intended to be invoked
-	  at the end of the kernel-only boot sequence, just before
-	  init is exec'ed.
-
-	  Accept the default if unsure.
-
 endmenu # "RCU Subsystem"
 
 config BUILD_BIN2C
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b40d3468ba4e..419ca811bda9 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -130,8 +130,7 @@ bool rcu_gp_is_normal(void)
 }
 EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
 
-static atomic_t rcu_expedited_nesting =
-	ATOMIC_INIT(IS_ENABLED(CONFIG_RCU_EXPEDITE_BOOT) ? 1 : 0);
+static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
 
 /*
  * Should normal grace-period primitives be expedited?  Intended for
@@ -179,8 +178,7 @@ EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
  */
 void rcu_end_inkernel_boot(void)
 {
-	if (IS_ENABLED(CONFIG_RCU_EXPEDITE_BOOT))
-		rcu_unexpedite_gp();
+	rcu_unexpedite_gp();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
 }
-- 
2.10.2
