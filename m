From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 2/4] workqueue: fixup rcu check for RT
Date: Fri, 10 Nov 2017 10:33:24 -0600
Message-ID: <aa7e7818304465643e7034fcfdfc93f7d6de2a8c.1510269414.git.julia@ni.com>
References: <cover.1510269414.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510269414.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.46-rt52-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
Upstream commit 5b95e1af8d17d ("workqueue: wq_pool_mutex protects the
attrs-installation") introduced an additional assertion
(assert_rcu_or_wq_mutex_or_pool_mutex) which contains a check ensuring
that the caller is in a RCU-sched read-side critical section.

However, on RT, the locking rules are lessened to only require require
_normal_ RCU.  Fix up this check.

The upstream commit was cherry-picked back into stable v4.1.19 as d3c4dd8843be.

This fixes up the bogus splat triggered on boot:

    ===============================
    [ INFO: suspicious RCU usage. ]
    4.1.42-rt50
    -------------------------------
    kernel/workqueue.c:609 sched RCU, wq->mutex or wq_pool_mutex should be held!

    other info that might help us debug this:

    rcu_scheduler_active = 1, debug_locks = 0
    2 locks held by swapper/0/1:
     #0:  ((pendingb_lock).lock){+.+...}, at: queue_work_on+0x64/0x1c0
     #1:  (rcu_read_lock){......}, at:  __queue_work+0x2a/0x880

    stack backtrace:
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.1.42-rt50 #4
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-20170228_101828-anatol 04/01/2014
    Call Trace:
     dump_stack+0x70/0x9a
     lockdep_rcu_suspicious+0xe7/0x120
     unbound_pwq_by_node+0x92/0x100
     __queue_work+0x28c/0x880
     ? __queue_work+0x2a/0x880
     queue_work_on+0xc9/0x1c0
     call_usermodehelper_exec+0x1a7/0x200
     kobject_uevent_env+0x4be/0x520
     ? initcall_blacklist+0xa2/0xa2
     kobject_uevent+0xb/0x10
     kset_register+0x34/0x50
     bus_register+0x100/0x2d0
     ? ftrace_define_fields_workqueue_work+0x29/0x29
     subsys_virtual_register+0x26/0x50
     wq_sysfs_init+0x12/0x14
     do_one_initcall+0x88/0x1b0
     ? parse_args+0x190/0x410
     kernel_init_freeable+0x204/0x299
     ? rest_init+0x140/0x140
     kernel_init+0x9/0xf0
     ret_from_fork+0x42/0x70
     ? rest_init+0x140/0x140

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6bdcab98501c..90e261c8811e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -363,7 +363,7 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 			   "RCU or wq->mutex should be held")
 
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
-	rcu_lockdep_assert(rcu_read_lock_sched_held() ||		\
+	rcu_lockdep_assert(rcu_read_lock_held() ||			\
 			   lockdep_is_held(&wq->mutex) ||		\
 			   lockdep_is_held(&wq_pool_mutex),		\
 			   "sched RCU, wq->mutex or wq_pool_mutex should be held")
-- 
2.14.2
