From: joe.korty@concurrent-rt.com
Subject: [PATCH RT] sample fix for splat in futex_[un]lock_pi for !rt
Date: Wed, 4 Jul 2018 13:35:19 -0400
Message-ID: <20180704173519.GA24614@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Balance atomic/!atomic migrate_enable calls in futex_[un]lock_pi.

The clever use of migrate_disable/enable in rt patch

  "futex: workaround migrate_disable/enable in different"

has balanced atomic/!atomic context only for the rt kernel.
This workaround makes it balanced for both rt and !rt.

The 'solution' presented here is for reference only.
A better solution might be for !rt to go back to using
migrate_enable/disable == preempt_enable/disable.
This patch passes the futex selftests for rt and !rt.

Sample kernel splat, edited for brevity.  This happens
near the end of boot on a CentOS 7 installation.

   WARNING: CPU: 1 PID: 5966 at kernel/sched/core.c:6994 migrate_enable+0x24e/0x2f0
   CPU: 1 PID: 5966 Comm: threaded-ml Not tainted 4.14.40-rt31 #1
   Hardware name: Supermicro X9DRL-3F/iF/X9DRL-3F/iF, BIOS 3.2 09/22/2015
   task: ffff88046b67a6c0 task.stack: ffffc900053a0000
   RIP: 0010:migrate_enable+0x24e/0x2f0
   RSP: 0018:ffffc900053a3df8 EFLAGS: 00010246

   Call Trace:
    futex_unlock_pi+0x134/0x210
    do_futex+0x13f/0x190
    SyS_futex+0x6e/0x150
    do_syscall_64+0x6f/0x190
    entry_SYSCALL_64_after_hwframe+0x42/0xb7


   WARNING: CPU: 1 PID: 5966 at kernel/sched/core.c:6998 migrate_enable+0x75/0x2f0
   CPU: 1 PID: 5966 Comm: threaded-ml Tainted: G        W       4.14.40-rt31 #1
   Hardware name: Supermicro X9DRL-3F/iF/X9DRL-3F/iF, BIOS 3.2 09/22/2015
   task: ffff88046b67a6c0 task.stack: ffffc900053a0000
   RIP: 0010:migrate_enable+0x75/0x2f0
   RSP: 0018:ffffc900053a3df8 EFLAGS: 00010246

   Call Trace:
    futex_unlock_pi+0x134/0x210
    do_futex+0x13f/0x190
    SyS_futex+0x6e/0x150
    do_syscall_64+0x6f/0x190
    entry_SYSCALL_64_after_hwframe+0x42/0xb7

This patch was developed against 4.14.40-rt31.  Should be
applicatible to all rt releases in which migrate_enable !=
preempt_enable for !rt kernels.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/kernel/futex.c
===================================================================
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2838,7 +2838,14 @@ retry_private:
 	spin_unlock(q.lock_ptr);
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+#ifdef CONFIG_PREEMPT_RT_FULL
 	migrate_enable();
+#else
+	/* !rt has to force balanced atomic/!atomic migrate_enable/disable uses */
+	preempt_disable();
+	migrate_enable();
+	preempt_enable();
+#endif
 
 	if (ret) {
 		if (ret == 1)
@@ -2998,7 +3005,14 @@ retry:
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		migrate_enable();
+#else
+		/* !rt has to force balanced atomic/!atomic uses */
+		preempt_disable();
 		migrate_enable();
+		preempt_enable();
+#endif
 
 		put_pi_state(pi_state);
 
