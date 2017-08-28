From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.1.42-rt50
Date: Mon, 28 Aug 2017 18:59:47 +0200
Message-ID: <20170828165947.j6lwd5c6quchi2th@linutronix.de>
References: <20170816204228.GE8384@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdH1Q7w (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Aug 2017 12:59:52 -0400
Content-Disposition: inline
In-Reply-To: <20170816204228.GE8384@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-16 15:42:28 [-0500], Julia Cartwright wrote:
> Hello RT Folks!
> 
> I'm pleased to announce the 4.1.42-rt50 stable release.

Okay. So this seemed to happen around v4.1.19 RT where this chunk got
in:
+#define assert_rcu_or_wq_mutex_or_pool_mutex(wq)                       \
+       rcu_lockdep_assert(rcu_read_lock_sched_held() ||                \
+                          lockdep_is_held(&wq->mutex) ||               \
+                          lockdep_is_held(&wq_pool_mutex),             \
+                          "sched RCU, wq->mutex or wq_pool_mutex should be held")
+

to kernel/workqueue.c. The rcu_read_lock_sched_held() is not correct for
RT because we push everything into "normal" RCU. However with lockdep I
get this:
|===============================
|[ INFO: suspicious RCU usage. ]
|4.1.40-rt48+ #17 Not tainted
|-------------------------------
|kernel/workqueue.c:608 sched RCU, wq->mutex or wq_pool_mutex should be held!
|
|other info that might help us debug this:
|
|rcu_scheduler_active = 1, debug_locks = 0
|2 locks held by cryptomgr_test/58:
| #0:  ((pendingb_lock).lock){+.+...}, at: [<c106842b>] queue_work_on+0x4b/0x160
| #1:  (rcu_read_lock){......}, at: [<c1067c80>] __queue_work+0x20/0x780
|
|stack backtrace:
|CPU: 1 PID: 58 Comm: cryptomgr_test Not tainted 4.1.40-rt48+ #17
|Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
| 00000286 00000286 f509bc24 c16d6bb1 00000001 00000000 f509bc40 c1096f9b
| c187b572 f5092280 f5914400 f5927ae0 f5914400 f509bc4c c1067397 c1a6c260
| f509bc70 c1067e77 f509bc70 00000056 00000001 00000008 c1a6c260 00000001
|Call Trace:
| [<c16d6bb1>] dump_stack+0x7d/0xb1
| [<c1096f9b>] lockdep_rcu_suspicious+0xbb/0xf0
| [<c1067397>] unbound_pwq_by_node.constprop.47+0x77/0xd0
| [<c1067e77>] __queue_work+0x217/0x780
| [<c1068474>] queue_work_on+0x94/0x160
| [<c1063f69>] call_usermodehelper_exec+0xf9/0x180
| [<c10645a9>] __request_module+0x139/0x410
| [<c139e8c3>] crypto_larval_lookup.part.8+0x53/0x120
| [<c139e9e4>] crypto_alg_mod_lookup+0x34/0xb0
| [<c139e3f1>] crypto_alloc_tfm+0x41/0xf0
| [<c13a5270>] crypto_alloc_shash+0x10/0x20
| [<c13b4f36>] drbg_init_hash_kernel+0x16/0x90
| [<c13b5328>] drbg_instantiate+0x108/0x2c0
| [<c13b56af>] drbg_kcapi_init+0x3f/0xd0
| [<c139eb35>] __crypto_alloc_tfm+0x85/0x130
| [<c139ec1a>] crypto_alloc_base+0x3a/0xb0
| [<c13a7ac3>] drbg_cavs_test+0x43/0x250
| [<c13a7d19>] alg_test_drbg+0x49/0x90
| [<c13a6d10>] alg_test+0x100/0x220

After looking at the Code it seems that all we need is just:
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb994a4e0fe2..11815663a56d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -362,10 +362,10 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 			   "RCU or wq->mutex should be held")
 
 #define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
-	rcu_lockdep_assert(rcu_read_lock_sched_held() ||		\
+	rcu_lockdep_assert(rcu_read_lock_held() ||		\
 			   lockdep_is_held(&wq->mutex) ||		\
 			   lockdep_is_held(&wq_pool_mutex),		\
-			   "sched RCU, wq->mutex or wq_pool_mutex should be held")
+			   "RCU, wq->mutex or wq_pool_mutex should be held")
 
 #define for_each_cpu_worker_pool(pool, cpu)				\
 	for ((pool) = &per_cpu(cpu_worker_pools, cpu)[0];		\

Sebastian
