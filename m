From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/6] rcutiny: Fix typo of using swake_up() instead of swait_wake()
Date: Fri, 03 May 2013 20:59:56 -0400
Message-ID: <20130504010016.425969845@goodmis.org>
References: <20130504005955.061874443@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-rcutiny-Fix-typo-of-using-swake_up-instead-of-swait_.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Converting the rcutiny wake up queues to use the simple wait queues
there was a typo in one of the functions.

Reported-by: Dmitry Lysenko <dvl36.ripe.nick@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/rcutiny_plugin.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcutiny_plugin.h b/kernel/rcutiny_plugin.h
index f0a6606..6242ccd 100644
--- a/kernel/rcutiny_plugin.h
+++ b/kernel/rcutiny_plugin.h
@@ -883,7 +883,7 @@ static void rcu_preempt_process_callbacks(void)
 static void invoke_rcu_callbacks(void)
 {
 	have_rcu_kthread_work = 1;
-	swake_up(&rcu_kthread_wq);
+	swait_wake(&rcu_kthread_wq);
 }
 
 /*
-- 
1.7.10.4
