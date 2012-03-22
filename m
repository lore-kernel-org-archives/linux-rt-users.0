From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] printk: Disable migration instead of preemption
Date: Wed, 21 Mar 2012 22:33:11 -0400
Message-ID: <20120322023454.904266624@goodmis.org>
References: <20120322023309.083011587@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Richard Weinberger <rw@linutronix.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-printk-Disable-migration-instead-of-preemption.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Richard Weinberger <rw@linutronix.de>

There is no need do disable preemption in vprintk(), disable_migrate()
is sufficient. This fixes the following bug in -rt:

[   14.759233] BUG: sleeping function called from invalid context
at /home/rw/linux-rt/kernel/rtmutex.c:645
[   14.759235] in_atomic(): 1, irqs_disabled(): 0, pid: 547, name: bash
[   14.759244] Pid: 547, comm: bash Not tainted 3.0.12-rt29+ #3
[   14.759246] Call Trace:
[   14.759301]  [<ffffffff8106fade>] __might_sleep+0xeb/0xf0
[   14.759318]  [<ffffffff810ad784>] rt_spin_lock_fastlock.constprop.9+0x21/0x43
[   14.759336]  [<ffffffff8161fef0>] rt_spin_lock+0xe/0x10
[   14.759354]  [<ffffffff81347ad1>] serial8250_console_write+0x81/0x121
[   14.759366]  [<ffffffff8107ecd3>] __call_console_drivers+0x7c/0x93
[   14.759369]  [<ffffffff8107ef31>] _call_console_drivers+0x5c/0x60
[   14.759372]  [<ffffffff8107f7e5>] console_unlock+0x147/0x1a2
[   14.759374]  [<ffffffff8107fd33>] vprintk+0x3ea/0x462
[   14.759383]  [<ffffffff816160e0>] printk+0x51/0x53
[   14.759399]  [<ffffffff811974e4>] ? proc_reg_poll+0x9a/0x9a
[   14.759403]  [<ffffffff81335b42>] __handle_sysrq+0x50/0x14d
[   14.759406]  [<ffffffff81335c8a>] write_sysrq_trigger+0x4b/0x53
[   14.759408]  [<ffffffff81335c3f>] ? __handle_sysrq+0x14d/0x14d
[   14.759410]  [<ffffffff81197583>] proc_reg_write+0x9f/0xbe
[   14.759426]  [<ffffffff811497ec>] vfs_write+0xac/0xf3
[   14.759429]  [<ffffffff8114a9b3>] ? fget_light+0x3a/0x9b
[   14.759431]  [<ffffffff811499db>] sys_write+0x4a/0x6e
[   14.759438]  [<ffffffff81625d52>] system_call_fastpath+0x16/0x1b

Signed-off-by: Richard Weinberger <rw@linutronix.de>
Link: http://lkml.kernel.org/r/1323696956-11445-1-git-send-email-rw@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/printk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 30dc7f0..60f4290 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -900,7 +900,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	boot_delay_msec();
 	printk_delay();
 
-	preempt_disable();
+	migrate_disable();
 	/* This stops the holder of console_sem just where we want him */
 	raw_local_irq_save(flags);
 	this_cpu = smp_processor_id();
@@ -1031,7 +1031,7 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 out_restore_irqs:
 	raw_local_irq_restore(flags);
 
-	preempt_enable();
+	migrate_enable();
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
-- 
1.7.8.3
