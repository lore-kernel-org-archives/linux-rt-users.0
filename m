From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/2] list_bl: make list head lock a raw lock
Date: Mon, 10 Jun 2013 17:36:49 -0400
Message-ID: <1370900209-40769-3-git-send-email-paul.gortmaker@windriver.com>
References: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: <rostedt@goodmis.org>, <tglx@linutronix.de>,
	<bigeasy@linutronix.de>, <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46031 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab3FJVh1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Jun 2013 17:37:27 -0400
In-Reply-To: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

As a bit spinlock, we had no lockdep visibility into the usage
of the list head locking.  Now, as a separate lock, we see:

[    3.613354] BUG: sleeping function called from invalid context at kernel/rtmutex.c:658
[    3.613356] in_atomic(): 1, irqs_disabled(): 0, pid: 122, name: udevd
[    3.613357] 5 locks held by udevd/122:
[    3.613358]  #0:  (&sb->s_type->i_mutex_key#7/1){+.+.+.}, at: [<ffffffff811967e8>] lock_rename+0xe8/0xf0
[    3.613363]  #1:  (rename_lock){+.+...}, at: [<ffffffff811a277c>] d_move+0x2c/0x60
[    3.613367]  #2:  (&dentry->d_lock){+.+...}, at: [<ffffffff811a0763>] dentry_lock_for_move+0xf3/0x130
[    3.613370]  #3:  (&dentry->d_lock/2){+.+...}, at: [<ffffffff811a0734>] dentry_lock_for_move+0xc4/0x130
[    3.613373]  #4:  (&dentry->d_lock/3){+.+...}, at: [<ffffffff811a0747>] dentry_lock_for_move+0xd7/0x130
[    3.613377] Pid: 122, comm: udevd Not tainted 3.4.47-rt62-00002-gfedcea8 #7
[    3.613378] Call Trace:
[    3.613382]  [<ffffffff810b9624>] __might_sleep+0x134/0x1f0
[    3.613385]  [<ffffffff817a24d4>] rt_spin_lock+0x24/0x60
[    3.613387]  [<ffffffff811a0c4c>] __d_shrink+0x5c/0xa0
[    3.613389]  [<ffffffff811a1b2d>] __d_drop+0x1d/0x40
[    3.613391]  [<ffffffff811a24be>] __d_move+0x8e/0x320
[    3.613393]  [<ffffffff811a278e>] d_move+0x3e/0x60
[    3.613394]  [<ffffffff81199598>] vfs_rename+0x198/0x4c0
[    3.613396]  [<ffffffff8119b093>] sys_renameat+0x213/0x240
[    3.613398]  [<ffffffff817a2de5>] ? _raw_spin_unlock+0x35/0x60
[    3.613401]  [<ffffffff8107781c>] ? do_page_fault+0x1ec/0x4b0
[    3.613403]  [<ffffffff817a32ca>] ? retint_swapgs+0xe/0x13
[    3.613406]  [<ffffffff813eb0e6>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[    3.613408]  [<ffffffff8119b0db>] sys_rename+0x1b/0x20
[    3.613410]  [<ffffffff817a3b96>] system_call_fastpath+0x1a/0x1f

For now, lets assume that the list head lock isn't held for big
stretches, and hence it being raw won't be a significant latency
concern.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/list_bl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 9c46fea..64ba33b 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -34,7 +34,7 @@
 struct hlist_bl_head {
 	struct hlist_bl_node *first;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	spinlock_t lock;
+	raw_spinlock_t lock;
 #endif
 };
 
@@ -46,7 +46,7 @@ static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
 {
 	h->first = NULL;
 #ifdef CONFIG_PREEMPT_RT_BASE
-	spin_lock_init(&h->lock);
+	raw_spin_lock_init(&h->lock);
 #endif
 }
 
@@ -130,7 +130,7 @@ static inline void hlist_bl_lock(struct hlist_bl_head *b)
 #ifndef CONFIG_PREEMPT_RT_BASE
 	bit_spin_lock(0, (unsigned long *)b);
 #else
-	spin_lock(&b->lock);
+	raw_spin_lock(&b->lock);
 #endif
 }
 
@@ -139,7 +139,7 @@ static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 #ifndef CONFIG_PREEMPT_RT_BASE
 	__bit_spin_unlock(0, (unsigned long *)b);
 #else
-	spin_unlock(&b->lock);
+	raw_spin_unlock(&b->lock);
 #endif
 }
 
-- 
1.8.1.2

