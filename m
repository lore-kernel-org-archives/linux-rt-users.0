From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/7] md/raid5: do not disable interrupts
Date: Thu, 23 Nov 2017 00:23:23 -0500
Message-ID: <20171123052630.481661788@goodmis.org>
References: <20171123052317.319740795@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0006-md-raid5-do-not-disable-interrupts.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.61-rt52-rc2 stable review patch.
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
index 4d8cfce1de86..4dde911925dc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -429,7 +429,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		md_wakeup_thread(conf->mddev->thread);
 	return;
 slow_path:
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
 	if (atomic_dec_and_lock(&sh->count, &conf->device_lock)) {
 		INIT_LIST_HEAD(&list);
@@ -438,7 +438,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		spin_unlock(&conf->device_lock);
 		release_inactive_stripe_list(conf, &list, hash);
 	}
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static inline void remove_hash(struct stripe_head *sh)
-- 
2.13.2
