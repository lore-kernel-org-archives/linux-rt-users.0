From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/13] md/raid5: do not disable interrupts
Date: Wed, 17 Jan 2018 10:14:09 -0500
Message-ID: <20180117151431.274748142@goodmis.org>
References: <20180117151404.093229667@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752975AbeAQPOc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jan 2018 10:14:32 -0500
Content-Disposition: inline; filename=0005-md-raid5-do-not-disable-interrupts.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.91-rt98-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

|BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
|in_atomic(): 0, irqs_disabled(): 1, pid: 2992, name: lvm
|CPU: 2 PID: 2992 Comm: lvm Not tainted 4.13.10-rt3+ #54
|Call Trace:
| dump_stack+0x4f/0x65
| ___might_sleep+0xfc/0x150
| atomic_dec_and_spin_lock+0x3c/0x80
| raid5_release_stripe+0x73/0x110
| grow_one_stripe+0xce/0xf0
| setup_conf+0x841/0xaa0
| raid5_run+0x7e7/0xa40
| md_run+0x515/0xaf0
| raid_ctr+0x147d/0x25e0
| dm_table_add_target+0x155/0x320
| table_load+0x103/0x320
| ctl_ioctl+0x1d9/0x510
| dm_ctl_ioctl+0x9/0x10
| do_vfs_ioctl+0x8e/0x670
| SyS_ioctl+0x3c/0x70
| entry_SYSCALL_64_fastpath+0x17/0x98

The interrupts were disabled because ->device_lock is taken with
interrupts disabled.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/md/raid5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 6a97d9e930c8..c206ed033542 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -433,7 +433,7 @@ static void release_stripe(struct stripe_head *sh)
 		md_wakeup_thread(conf->mddev->thread);
 	return;
 slow_path:
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
 	if (atomic_dec_and_lock(&sh->count, &conf->device_lock)) {
 		INIT_LIST_HEAD(&list);
@@ -442,7 +442,7 @@ slow_path:
 		spin_unlock(&conf->device_lock);
 		release_inactive_stripe_list(conf, &list, hash);
 	}
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static inline void remove_hash(struct stripe_head *sh)
-- 
2.13.2


