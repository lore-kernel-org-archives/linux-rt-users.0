From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: [PATCH 2/2] raid5: Use local_irq_save_nort() in raid5_release_stripe().
Date: Mon, 24 Apr 2017 16:33:36 +0300
Message-ID: <1493040816-24038-2-git-send-email-gq@cs.msu.su>
References: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
Cc: Alexander GQ Gerasiov <gq@redlab-i.ru>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:50508 "EHLO
        mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1171241AbdDXNkk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Apr 2017 09:40:40 -0400
In-Reply-To: <1493040816-24038-1-git-send-email-gq@cs.msu.su>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Alexander GQ Gerasiov <gq@redlab-i.ru>

This will fix the following warning:

[ ] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:993
[ ] in_atomic(): 0, irqs_disabled(): 1, pid: 1482, name: mdadm
[ ] CPU: 0 PID: 1482 Comm: mdadm Not tainted 4.9.20-rt16-stand6-686 #1
[ ] Hardware name: Supermicro SYS-5027R-WRF/X9SRW-F, BIOS 3.2a 10/28/2015
[ ]  ec6c1bcc c12cdc6f c1078f0a eca41880 ec6c1bfc c10787c1 c1668778 00000000
[ ]  00000001 000005ca eca41d84 00000000 80000000 ecce02c0 ecce0000 ecce02c0
[ ]  ec6c1c08 c1584587 ecce1c30 ec6c1c1c c1093ee0 ecce02c0 ecce1c00 ecce0000
[ ] Call Trace:
[ ]  [<c12cdc6f>] dump_stack+0x47/0x68
[ ]  [<c1078f0a>] ? migrate_enable+0x4a/0xf0
[ ]  [<c10787c1>] ___might_sleep+0x101/0x180
[ ]  [<c1584587>] rt_spin_lock+0x17/0x40
[ ]  [<c1093ee0>] atomic_dec_and_spin_lock+0x50/0x70
[ ]  [<f88eda95>] raid5_release_stripe+0x95/0x100 [raid456]
[ ]  [<f88efabd>] grow_one_stripe+0xcd/0xf0 [raid456]
[ ]  [<f88f0274>] setup_conf+0x794/0x900 [raid456]
[ ]  [<f88f11e5>] raid5_run+0xa85/0xcc0 [raid456]

Signed-off-by: Alexander GQ Gerasiov <gq@redlab-i.ru>
---
 drivers/md/raid5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e69525b5db7d..f879c1b94dba 100644
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
2.11.0

